/**
 * Kenya EMR UI Library main javascript
 */

/**
 * Page initialization tasks
 */
$(function() {
	/**
	 * Clicking anywhere on a menu item should direct you to the target of it's <a> tag
	 */
	$('.ke-menuitem').click(function() {
		var a = $(this).find('a').first();
		var href = (a.length > 0) ? a.attr('href') : null;
		if (href)
			location.href = href;
	});

	/**
	 * Clicking on a stack-item should direct you to the URL specified in the clickUrl hidden input
	 */
	$('.ke-stack-item').click(function(evt) {
		var clickUrl = $(this).find('input[name=clickUrl]').first();
		var url = (clickUrl.length > 0) ? clickUrl.val() : null;
		if (url) {
			location.href = url;
		}
	});

	/**
	 * Add icons to edit buttons
	 */
	$('.ke-editbutton .ke-label').each(function() {
		$(this).prepend('<img src="/' + CONTEXT_PATH + '/ms/uiframework/resource/kenyaui/images/edit.png" /> ');
	});

	/**
	 * Give html buttons same styles as kenyaui controls
	 */
	$('input[type="button"], input[type="submit"], input[type="reset"]')
		.addClass('ke-control')
		.addClass('ke-button')
		.css('font-weight', 'bold');
});


/**
 * Everything below here needs tidied up and migrated elsewhere
 */


// checks whether a javascript object (e.g. a json response) is empty
function isEmpty(obj) {
	for (var i in obj) {
		return false;
	}
	return true;
}

// utility methods for handling error messages
function fragmentActionError(jqXHR, defaultMessage) {
	try {
		var err = $.parseJSON(jqXHR.responseText);
		for (var i = 0; i < err.globalErrors.length; ++i)
			notifyError(err.globalErrors[i]);
		for (key in err.fieldErrors) {
			for (var i = 0; i < err.fieldErrors[key].size(); ++i)
				notifyError(key + ": " + err.fieldErrors[key][i]);
		}
		return;
	} catch (ex) { }
	notifyError(defaultMessage);
}

function isTrueHelper(test) {
	if (!test)
		return false;
	if (typeof(test) == 'string')
		return test.charAt(0) == 't';
	else
		return test == true;
}

function isFalseHelper(test) {
	if (!test)
		return true;
	if (typeof(test) == 'string')
		return test.charAt(0) == 'f';
	else
		return test == false;
}

// validation for fields
function clearErrors(errorDivId) {
	if (errorDivId)
		$('#' + errorDivId).html('').hide('fast');
}

function showError(errorDivId, message) {
	$('#' + errorDivId).append(message).show('fast');
}

function validateRequired(val, errorDivId) {
	if ((val + '').length == 0)
		showError(errorDivId, 'Required');
}

function validateNumber(val, errorDivId) {
	if (!isValidNumber(val)) {
		showError(errorDivId, 'Error');
	}
}

function validateInteger(val, errorDivId) {
	if (!isValidInteger(val)) {
		showError(errorDivId, 'Error');
	}
}

function isValidNumber(val) {
	var asNum = Number(val);
	return !isNaN(asNum);
}

function isValidInteger(val) {
	var asNum = Number(val);
	return !isNaN(asNum) && (asNum == Math.round(asNum));
}

//// Event Bus support //////////////////

function publish(message, payload) {
	window.PageBus.publish(message, payload);
}

function subscribe(message, callback) {
	return window.PageBus.subscribe(message, null, callback, null);
}

//// Messaging //////////////////

function patientChanged(patientId, property) {
	jQuery.getJSON(OPENMRS_CONTEXT_PATH + '/data/getPatient.action?returnFormat=json&patientId=' + patientId, function(patient) {
		var message = "patient/" + patientId;
		if (property)
			message += "/" + property;
		message += ".changed"
		publish(message, patient);
	});
}

function getJsonAsEvent(url, eventTitle) {
	jQuery.getJSON(url, function(data) {
		publish(eventTitle, data);
	});
}

//// Dialog support (shared modal dialog for all pages/fragments) //////////////////

var openmrsDialogCurrentlyShown = null;
var openmrsDialogIFrame = null;
var openmrsDialogSuccessCallback = null;

function showDivAsDialog(selector, title, opts) {
	// There is (what I consider) a bug in jquery-ui dialog, where displaying a dialog that
	// has scripts in it re-executes the scripts. We introduce a hack to get around this, by
	// removing all scripts before we display the dialog, and then reattaching them. But we
	// have to reattach them with normal DOM, not jquery's append, since the latter would also
	// reexecute them
	// TODO determine if we can rid of the hack. If not, refactor the hack, because it currently assumes the selector matches a single dialog 
	var dialogContainer = $(selector);
	var dialogScripts = dialogContainer.find("script");
	dialogScripts.remove();
	var optsToUse = {
			draggable: false,
			resizable: false,
			width: '90%',
			height: $(window).height()-50,
			modal: true,
			title: title
		};
	if (opts) {
		optsToUse = $.extend(optsToUse, opts);
	}
	openmrsDialogSuccessCallback = optsToUse.successCallback; // TODO attach this to the close button
	openmrsDialogCurrentlyShown = $(selector).dialog(optsToUse);
	dialogScripts.each(function() {
		dialogContainer.get(0).appendChild(this);
	});
}

/**
 * opts must define url or fragment, and may define title and successCallback.
 */
function showDialog(opts) {
	var url = opts.url;
	if (opts.fragment) {
		url = '/' + OPENMRS_CONTEXT_PATH + '/pages/fragment.page?fragment=' + opts.fragment;
		if (opts.config) {
			for (var param in opts.config) {
				url += "&" + param + "=" + opts.config[param];
			}
		}
	}
	if (!openmrsDialogIFrame) {
		openmrsDialogIFrame = document.createElement('iframe');
		openmrsDialogIFrame.width = '100%';
		openmrsDialogIFrame.height = '100%';
		openmrsDialogIFrame.marginWidth = 0;
		openmrsDialogIFrame.marginHeight = 0;
		openmrsDialogIFrame.frameBorder = 0;
		openmrsDialogIFrame.scrolling = 'auto';
		$('#openmrsDialog').append(openmrsDialogIFrame);
	}
	$("#openmrsDialog > iframe").attr("src", url);

	if (!opts.title)
		opts.title = "";
	
	openmrsDialogSuccessCallback = opts.successCallback; // TODO attach this to the close button
	$('#openmrsDialog')
		.dialog('option', 'title', opts.title)
		.dialog('option', 'height',$(window).height()-50) // TODO resize dialog on window resize?
		.dialog('open');
	openmrsDialogCurrentlyShown = $('#openmrsDialog');
}

function closeDialog(doCallback) {
	if (openmrsDialogCurrentlyShown && openmrsDialogCurrentlyShown.length > 0) {
		openmrsDialogCurrentlyShown.dialog('close');
		var callMe = openmrsDialogSuccessCallback;
		openmrsDialogSuccessCallback = null;
		if (doCallback && callMe) {
			callMe.call();
		}
	} else if (window.parent && window.parent != window) {
		window.parent.closeDialog(doCallback);
	}
}

function escapeJs(string) {
	string = string.replace(/'/g, "\\'");
	string = string.replace(/"/g, '\\"');
	return string;
}

function escapeHtml(string) {
	string = string.replace(/</g, "&lt;");
	string = string.replace(/>/g, "&gt;");
	return string;
}