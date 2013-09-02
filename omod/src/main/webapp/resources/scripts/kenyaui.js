/**
 * KenyaUI main javascript library
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
	 * Disable autocomplete on all text inputs
	 */
	jq('input[type=text]').attr('autocomplete', 'off');

	/**
	 * Initialize all tabs
	 */
	jq('.ke-tabmenu').each(function() {
		// Make first tab mean item active
		var first = jq(this).find('.ke-tabmenu-item:first');
		first.addClass('ke-tabmenu-item-active');

		// And make it's tab visible
		jq('.ke-tab[data-tabid=' + first.data('tabid') + ']').show();

		// Configure click handlers for each tab button
		jq(this).find('.ke-tabmenu-item').click(function() {
			// Get tabid from data attribute
			var tabid = jq(this).data('tabid');

			// Make only this tab active
			jq('.ke-tabmenu-item-active').removeClass('ke-tabmenu-item-active');
			jq(this).addClass('ke-tabmenu-item-active');

			// Make only this tab's content visible
			jq('.ke-tab').each(function() {
				if (jq(this).data('tabid') == tabid) {
					jq(this).show();
				} else {
					jq(this).hide();
				}
			});
		});
	});

	/**
	 * Initialize search widgets
	 */
	jq('.ke-search').each(function() {
		var searchType = jq(this).data('searchtype');
		var searchParams = jq(this).data('searchparams');
		var searchConfig = kenyaui.getSearchConfig(searchType);

		if (searchParams) {
			searchParams = kenyaui.deparam(searchParams.replace('&amp;', '&'));
		}

		if (searchConfig) {
			jq(this).select2({
				placeholder: 'Search for a ' + searchType,
				minimumInputLength: 3,
				ajax: {
					url: ui.fragmentActionLink(searchConfig.searchProvider, searchConfig.searchFragment, searchType + 's'),
					dataType: 'json',
					data: function (term, page) { return jq.extend({}, { q: term }, searchParams); },
					results: function (data, page) { return { results: data }; }
				},
				formatResult: function(object, container, query) { return searchConfig.format(object); },
				formatSelection: function(object, container) { return searchConfig.format(object); },
				initSelection: function(element, callback) {
					var id = jq(element).val();
					if (id !== '') {
						jq.ajax(ui.fragmentActionLink(searchConfig.searchProvider, searchConfig.searchFragment, searchType), { data: { id: id }, dataType: 'json'
						}).done(function(data) { callback(data); });
					}
				},
				escapeMarkup: function (m) { return m; }, // don't escape
				dropdownCssClass: 'ui-dialog' // https://github.com/ivaynberg/select2/issues/940
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

	var _public = {};

	/**
	 * Opens a generic modal dialog
	 * @param html the content
	 */
	function openModalContent(html, width, height) {
		if (jq('.ke-modal-overlay').length == 0) {
			var top = height ? (50 - height / 2) : 25;
			var side = width ? (50 - width / 2) : 25;
			jq('body').append('<div class="ke-modal-overlay"></div>');
			jq('body').append('<div class="ke-modal-content" style="top: ' + top + '%; left: ' + side + '%; right: ' + side + '%;">' + html + '</div>');
		}
	}

	/**
	 * Closes any modal dialog
	 * @param html the content
	 */
	function closeModalContent() {
		// Clear any modal content
		jq('.ke-modal-overlay').remove();
		jq('.ke-modal-content').remove();
	}

	/**
	 * Creates a button control
	 * @param id the button id
	 * @param label the label
	 */
	function createButton(id, label) {
		return '<div class="ke-button" id="' + id + '"><div class="ke-button-text"><div class="ke-label">' + label + '</div></div></div>';
	}

	/**
	 * Takes an existing form and sets it up to submit via AJAX and get a json response.
	 * @param fieldId the field id
	 * @param options:
	 * - onSuccess (required) should should be a one-arg function that called with a parsed json object
	 */
	_public.setupAjaxPost = function(formId, options) {
		if (typeof options.onSuccess !== 'function') {
			throw "onSuccess is required";
		}

		jq('#' + formId).submit(function(event) {
			event.preventDefault();
			var form = jq(this);

			// Clear any existing errors
			_public.clearFormErrors(formId);

			// POST and get back the result as JSON
			jq.post(form.attr('action'), form.serialize(), options.onSuccess, "json").error(function(xhr) {
				_public.showFormErrors(formId, xhr.responseText);
			});
		});
	};

	/**
	 * Opens a modal loading dialog
	 * @param options the options
	 */
	_public.openLoadingDialog = function(options) {
		var defaults = { heading: null, message: null };
		var options = options ? jq.extend(defaults, options) : defaults;

		var html = '<div class="ke-panel-content" style="text-align: center; padding: 10px"><img src="' + ui.resourceLink('kenyaui', 'images/loading.gif') + '"/>';
		if (options.message) {
			html += '<br /><br />' + options.message;
		}
		html += '</div>';

		_public.openPanelDialog({ heading: options.heading, content: html, width: 40, height: 20 });
	};

	/**
	 * Opens a modal confirm (OK/Cancel) dialog
	 * @param options the options
	 */
	_public.openConfirmDialog = function(options) {
		var defaults = { heading: null, message: '', okLabel: 'OK', cancelLabel: 'Cancel', okCallback: function(){}, cancelCallback: function(){} };
		var options = options ? jq.extend(defaults, options) : defaults;

		var okButtonId = kenyaui.generateId();
		var cancelButtonId = kenyaui.generateId();

		var html = '<div class="ke-panel-content" style="padding: 10px">' + options.message + '</div>';
		html += '<div class="ke-panel-footer">' + createButton(okButtonId, options.okLabel) + '&nbsp;' + createButton(cancelButtonId, options.cancelLabel) + '</div>';

		_public.openPanelDialog({ heading: options.heading, content: html, width: 40, height: 20 });

		jq('#' + okButtonId).click(function() { options.okCallback(); _public.closeDialog(); });
		jq('#' + cancelButtonId).click(function() { options.cancelCallback(); _public.closeDialog(); });
	};

	/**
	 * Opens a modal alert (OK) dialog
	 * @param options the options
	 */
	_public.openAlertDialog = function(options) {
		var defaults = { heading: null, message: '', okLabel: 'OK', okCallback: function(){} };
		var options = options ? jq.extend(defaults, options) : defaults;

		var okButtonId = kenyaui.generateId();

		var html = '<div class="ke-panel-content" style="padding: 10px">' + options.message + '</div>';
		html += '<div class="ke-panel-footer">' + createButton(okButtonId, options.okLabel) + '</div>';

		_public.openPanelDialog({ heading: options.heading, content: html, width: 40, height: 20 });

		jq('#' + okButtonId).click(function() { options.okCallback(); _public.closeDialog(); });
	};

	/**
	 * Opens a modal panel style dialog
	 * @param options the options
	 */
	_public.openPanelDialog = function(options) {
		var defaults = { heading: null, width: null, height: null };
		var options = options ? jq.extend(defaults, options) : defaults;

		var html = '<div class="ke-panel-frame">';
		if (options.heading) {
			html += '<div class="ke-panel-heading">' + options.heading + '</div>';
		}
		html += options.content + '</div>';
		openModalContent(html, options.width, options.height);
	};

	/**
	 * Closes any visible dialog
	 */
	_public.closeDialog = function() {
		closeModalContent();
	};

	/**
	 * Updates a datetime control after any of its child controls have been changed
	 * @param fieldId the datetime field id
	 * @param hasTime whether field uses time
	 */
	_public.updateDateTimeFromDisplay = function(fieldId, hasTime) {
		kenyaui.clearFieldErrors(fieldId); // clear field errors
		jq('#' + fieldId).val(''); // clear field value

		try {
			var date = $.datepicker.parseDate('dd-M-yy', jq('#' + fieldId + '_date').val(), null);
			var hours = hasTime ? jq('#' + fieldId + '_hour').val() : '00';
			var minutes = hasTime ? jq('#' + fieldId + '_minute').val() : '00';

			if (date) {
				// Format date with time fields
				var timestamp = jq.datepicker.formatDate(jq.datepicker.W3C, date) + ' ' + hours + ':' + minutes + ':00.000';
				jq('#' + fieldId).val(timestamp);
			}
		}
		catch (err) {
			_public.showFieldError(fieldId, 'Invalid date');
		}
	};

	/**
	 * Updates a search field value
	 * @param fieldId
	 * @param value
	 */
	_public.setSearchFieldValue = function(fieldId, value) {
		jq('#' + fieldId).select2('val', value);
	};

	/**
	 * Generates a unique id suitable for a DOM element
	 * @returns the id
	 */
	_public.generateId = function() {
		return 'ke-element-' + (++next_generated_id);
	};

	/**
	 * Stores a search configuration
	 * @param searchType the search type, e.g. 'location'
	 * @param config the configuration
	 */
	_public.configureSearch = function(searchType, config) {
		searchConfigs[searchType] = config;
	};

	/**
	 * Gets a search configuration
	 * @param searchType the search type, e.g. 'location'
	 * @returns {*}
	 */
	_public.getSearchConfig = function(searchType) {
		return searchConfigs[searchType];
	};

	/**
	 * Shows errors on a form
	 * @param formId the form id
	 * @param xhr the request object
	 */
	_public.showFormErrors = function(formId, response) {
		var form = jq('#' + formId);
		var globalError = form.find('.ke-form-globalerrors');
		try {
			var err = jq.parseJSON(response);

			globalError.html('Please fix all errors...').show();

			for (var i = 0; i < err.globalErrors.length; ++i) {
				globalError.append('<div>' + err.globalErrors[i] + '</div>');
			}

			for (key in err.fieldErrors) {
				var fieldId = form.find('[name="' + key + '"]').attr('id');
				var errorMsg =  err.fieldErrors[key].join(', ');

				if (fieldId && kenyaui.hasErrorField(fieldId)) {
					_public.showFieldError(fieldId, errorMsg);
				}
				else {
					globalError.append('<div>' + errorMsg + '</div>');
				}
			}
		} catch (ex) {
			ui.notifyError("Failed " + ex + " (" + response + ")");
		}
	};

	/**
	 * Clears any errors being shown for the given form
	 * @param formId the form id
	 */
	_public.clearFormErrors = function(formId) {
		jq('#' + formId + ' .ke-form-globalerrors').html('').hide();
		jq('#' + formId + ' .error').html('').hide();
	};

	/**
	 * Checks if the given field has an associated error field
	 * @param fieldId the field id
	 */
	_public.hasErrorField = function(fieldId) {
		return jq('#' + fieldId + '-error').length > 0;
	};

	/**
	 * Shows an error message for a field (assumes the field has an associated error field)
	 * @param fieldId the field id
	 * @param message the error message
	 */
	_public.showFieldError = function(fieldId, message) {
		jq('#' + fieldId + '-error').append(message + '<br />').show();
	};

	/**
	 * Clears any errors being shown for the given field
	 * @param fieldId the field id
	 */
	_public.clearFieldErrors = function(fieldId) {
		jq('#' + fieldId + '-error').html('').hide();
	};

	/**
	 * Reverse of jQuery.param()
	 * @param query the query
	 */
	_public.deparam = function(query) {
		if (!query) {
			return {};
		}

		var params = {};
		var pairs = query.split('&');

		for (var i = 0; i < pairs.length; i++) {
			var pair = pairs[i].split("=");
			pair[0] = decodeURIComponent(pair[0]);
			pair[1] = decodeURIComponent(pair[1]);

			if (typeof params[pair[0]] === 'undefined') {  // first entry with this name
				params[pair[0]] = pair[1];
			} else if (typeof params[pair[0]] === 'string') { // second entry with this name
				var arr = [ params[pair[0]], pair[1] ];
				params[pair[0]] = arr;
			} else { // third or later entry with this name
				params[pair[0]].push(pair[1]);
			}
		}
		return params;
	};

	return _public;

})(jQuery);


/************************************************************************************************
 * Everything below here needs tidied up and migrated elsewhere
 */

//// Validation ///////////////////

function validateRequired(val, errorDivId) {
	if ((val + '').length == 0) {
		kenyaui.showFieldError(errorDivId, 'Required');
	}
}

function validateNumber(val, errorDivId) {
	if (!isValidNumber(val)) {
		kenyaui.showFieldError(errorDivId, 'Error');
	}
}

function validateInteger(val, errorDivId) {
	if (!isValidInteger(val)) {
		kenyaui.showFieldError(errorDivId, 'Error');
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