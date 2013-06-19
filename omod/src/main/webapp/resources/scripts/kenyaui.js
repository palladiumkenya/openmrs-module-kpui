/**
 * Kenya EMR UI Library main javascript
 */

jq = jQuery;

/**
 * Page initialization tasks
 */
jq(function() {
	/**
	 * Clicking anywhere on a menu item should direct you to the target of it's <a> tag
	 */
	jq('.ke-menu-item').click(function() {
		var a = jq(this).find('a').first();
		var href = (a.length > 0) ? a.attr('href') : null;
		if (href)
			location.href = href;
	});

	/**
	 * Clicking on a stack-item should direct you to the URL specified in the clickUrl hidden input
	 */
	jq('.ke-stack-item').click(function(evt) {
		var clickUrl = jq(this).find('input[name=clickUrl]').first();
		var url = (clickUrl.length > 0) ? clickUrl.val() : null;
		if (url) {
			location.href = url;
		}
	});

	/**
	 * Give html buttons same styles as kenyaui controls
	 */
	jq('input[type="button"], input[type="submit"], input[type="reset"]')
		.addClass('ke-control')
		.addClass('ke-button')
		.css('font-weight', 'bold');

	/**
	 * Disable autocomplete on all text inputs
	 */
	jq('input[type=text]').attr('autocomplete', 'off');

	/**
	 * Initialize search widgets
	 */
	jq('.ke-search').each(function() {
		var searchType = jq(this).data('searchtype');
		var searchConfig = kenyaui.getSearchConfig(searchType);

		if (searchConfig) {
			jq(this).select2({
				placeholder: 'Search for a ' + searchType,
				minimumInputLength: 3,
				ajax: {
					url: searchConfig.search,
					dataType: 'json',
					data: function (term, page) { return { term: term }; },
					results: function (data, page) { return { results: data }; }
				},
				formatResult: function(object, container, query) { return searchConfig.format(object); },
				formatSelection: function(object, container) { return searchConfig.format(object); },
				initSelection: function(element, callback) {
					var id = jq(element).val();
					if (id !== '') {
						jq.ajax(searchConfig.fetch, { data: { id: id }, dataType: 'json'
						}).done(function(data) { callback(data); });
					}
				},
				escapeMarkup: function (m) { return m; } // don't escape
			});
		}
		else {
			alert('Search type "' + searchType + '" not configured');
		}
	});
});

/**
 * Utility methods
 */
var kenyaui = (function(jq) {

	// For generating unique element ids
	var next_generated_id = 0;

	var searchConfigs = new Object();

	return {
		/**
		 * Opens a modal loading dialog
		 * @param message the loading message
		 */
		openLoadingDialog: function(message) {
			var html = '<div style="text-align: center; padding: 10px"><img src="' + ui.resourceLink('kenyaui', 'images/loading.gif') + '"/>';
			if (message) {
				html += '<br /><br />' + message;
			}
			html += '</div>';
			this.openPanelDialog(null, html, 40, 20);
		},

		/**
		 * Opens a modal panel style dialog
		 * @param heading the panel heading
		 * @param content the panel content
		 */
		openPanelDialog: function(heading, content, width, height) {
			var html = '<div class="ke-panel-frame">';
			if (heading) {
				html += '<div class="ke-panel-heading">' + heading + '</div>';
			}
			html += '<div class="ke-panel-content">' + content + '</div></div>';
			this.openModalContent(html, width, height);
		},

		/**
		 * Opens a generic modal dialog
		 * @param html the content
		 */
		openModalContent: function(html, width, height) {
			if (jq('.ke-modal-overlay').length == 0) {
				var top = height ? (50 - height / 2) : 25;
				var side = width ? (50 - width / 2) : 25;
				jq('body').append('<div class="ke-modal-overlay"></div>');
				jq('body').append('<div class="ke-modal-content" style="top: ' + top + '%; left: ' + side + '%; right: ' + side + '%;">' + html + '</div>');
			}
		},

		/**
		 * Closes any visible modal dialog
		 */
		closeModalDialog: function() {
			// Clear any modal content
			jq('.ke-modal-overlay').remove();
			jq('.ke-modal-content').remove();
		},

		/**
		 * Updates a datetime control after any of its child controls have been changed
		 * @param fieldId the datetime field id
		 * @param hasTime whether field uses time
		 */
		updateDateTimeFromDisplay: function(fieldId, hasTime) {
			var date = jq('#' + fieldId + '_date').datepicker('getDate');
			var hours = hasTime ? jq('#' + fieldId + '_hour').val() : '00';
			var minutes = hasTime ? jq('#' + fieldId + '_minute').val() : '00';

			if (date) {
				// Format date with time fields
				var timestamp = jq.datepicker.formatDate(jq.datepicker.W3C, date) + ' ' + hours + ':' + minutes + ':00.000';
				jq('#' + fieldId).val(timestamp);
			} else {
				// Empty date means empty datetime
				jq('#' + fieldId).val('');
			}
		},

		/**
		 * Updates a search field value
		 * @param fieldId
		 * @param value
		 */
		updateSearchDisplay: function(fieldId, value) {
			jq('#' + fieldId).select2('val', value);
		},

		/**
		 * Generates a unique id suitable for a DOM element
		 * @returns the id
		 */
		generateId: function() {
			return 'ke-element-' + (++next_generated_id);
		},

		/**
		 * Stores a search configuration
		 * @param searchType the search type, e.g. 'location'
		 * @param configCallback the callback function which returns the configuration
		 */
		configureSearch: function(searchType, configCallback) {
			searchConfigs[searchType] = configCallback;
		},

		/**
		 * Gets a search configuration
		 * @param searchType the search type, e.g. 'location'
		 * @returns {*}
		 */
		getSearchConfig: function(searchType) {
			var fn = searchConfigs[searchType];
			return fn ? fn() : null;
		}
	};

})(jQuery);


/************************************************************************************************
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
		var err = jq.parseJSON(jqXHR.responseText);
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
		jq('#' + errorDivId).html('').hide('fast');
}

function showError(errorDivId, message) {
	jq('#' + errorDivId).append(message).show('fast');
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
	var dialogContainer = jq(selector);
	var dialogScripts = dialogContainer.find("script");
	dialogScripts.remove();
	var optsToUse = {
			draggable: false,
			resizable: false,
			width: '90%',
			height: jq(window).height()-50,
			modal: true,
			title: title
		};
	if (opts) {
		optsToUse = jq.extend(optsToUse, opts);
	}
	openmrsDialogSuccessCallback = optsToUse.successCallback; // TODO attach this to the close button
	openmrsDialogCurrentlyShown = jq(selector).dialog(optsToUse);
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
		jq('#openmrsDialog').append(openmrsDialogIFrame);
	}
	jq("#openmrsDialog > iframe").attr("src", url);

	if (!opts.title)
		opts.title = "";
	
	openmrsDialogSuccessCallback = opts.successCallback; // TODO attach this to the close button
	jq('#openmrsDialog')
		.dialog('option', 'title', opts.title)
		.dialog('option', 'height', jq(window).height()-50) // TODO resize dialog on window resize?
		.dialog('open');
	openmrsDialogCurrentlyShown = jq('#openmrsDialog');
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