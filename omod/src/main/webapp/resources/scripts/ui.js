/**
 * UI Utils
 *
 * Eventually this will only contain methods that mirror UiUtils in the uiframework module
 */
var ui = (function(jq) {
	
	var toQueryString = function(options) {
		var ret = "?";
		if (options) {
			for (key in options) {
				var val = options[key];
				if (val != null) {
					ret += key + '=' + encodeURIComponent(options[key]) + '&';
				}
			}
		}
		return ret;
	}
	
	var confirmBeforeNavigationSetup = {
		configured: false,
		enabled: false
	};
	
	return {
		pageLink: function(providerName, pageName, options) {
			var ret = '/' + OPENMRS_CONTEXT_PATH + '/' + providerName + '/' + pageName + '.page';
			return ret + toQueryString(options);
		},
		
		resourceLink: function(providerName, resourceName) {
			if (providerName == null)
				providerName = '*';
			return '/' + OPENMRS_CONTEXT_PATH + '/ms/uiframework/resource/' + providerName + '/' + resourceName; 
		},
		
		fragmentActionLink: function(providerName, fragmentName, actionName, options) {
			var ret = '/' + OPENMRS_CONTEXT_PATH + '/' + providerName + '/' + fragmentName + '/' + actionName + '.action';
			if (options) {
				ret += toQueryString(options);
			}
			return ret;
		},

		getFragmentActionAsJson: function(providerName, fragmentName, actionName, params, callback) {
			var url = this.fragmentActionLink(providerName, fragmentName, actionName, null);
			jQuery.getJSON(url, params, function(result) {
				if (callback) {
					callback(result);
				}
			});
		},

		/**
		 * Reloads the current page
		 */
		reloadPage: function() {
			location.reload();
		},

		/**
		 * Navigates to a new page
		 * @param providerName the page provider or complete URL if no other args are provided
		 * @param pageName the page name
		 * @param options the page options
		 */
		navigate: function(providerName, pageName, options) {
			// If a single argument, interpret as a complete URL
			location.href = (arguments.length == 1) ? providerName : this.pageLink(providerName, pageName, options);
		},
		
		confirmBeforeNavigating: function(formSelector) {
			if (!confirmBeforeNavigationSetup.configured) {
				window.onbeforeunload = function() {
					if (confirmBeforeNavigationSetup.enabled) {
						var blockers = jq('.confirm-before-navigating').filter(function() {
								return (jq(this).data('confirmBeforeNavigating') === 'dirty');
							}).length > 0;
	
						if (blockers) {
							return "If you leave this page you will lose unsaved changes";
						}
					}
				}
				confirmBeforeNavigationSetup.configured = true;
				confirmBeforeNavigationSetup.enabled = true;
			}

			var form = jq(formSelector);

			form.addClass('confirm-before-navigating');
			form.data('confirmBeforeNavigating', 'clean');
			form.find(':input').on('change.confirm-before-navigating', function() {
				jq(this).parents('.confirm-before-navigating').data('confirmBeforeNavigating', 'dirty');
			});
		},
		
		cancelConfirmBeforeNavigating: function(formSelector) {
			var form = jq(formSelector);
			form.find(':input').off('change.confirm-before-navigating');
			form.data('confirmBeforeNavigating', null);
			form.removeClass('confirm-before-navigating');
		},
		
		disableConfirmBeforeNavigating: function() {
			confirmBeforeNavigationSetup.enabled = false;
		},
		
		enableConfirmBeforeNavigating: function() {
			confirmBeforeNavigationSetup.enabled = true;
		},

		escapeHtmlAttribute: function(string) {
			// TODO actually implement this
			string = string.replace("'", "\'");
			string = string.replace('"', '\\"');
			return string;
		},

		/**
		 * Deprecated
		 */
		notifySuccess: function(html) {
			kenyaui.notifySuccess(html);
		},

		/**
		 * Deprecated
		 */
	 	notifyError: function(html) {
			kenyaui.notifyError(html);
		}
	};

})(jQuery);