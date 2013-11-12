/**
 * UI Utils
 *
 * This class mirrors the functionality of UiUtils.java and adds a few extras such as reloadPage() and navigate()
 */
var ui = (function(jQuery) {

	var _public = {};

	/**
	 * Helper method to convert a list of parameters to a query string
	 * @param options
	 * @returns {string}
	 */
	function toQueryString(params) {
		var ret = "?";
		if (params) {
			for (key in params) {
				var val = params[key];
				if (val != null) {
					ret += key + '=' + encodeURIComponent(params[key]) + '&';
				}
			}
		}
		return ret;
	}
	
	var confirmBeforeNavigationSetup = {
		configured: false,
		enabled: false
	};

	/**
	 * Returns a link to UI framework managed page
	 * @param providerName the page provider
	 * @param pageName the page path
	 * @param params the query string parameters
	 * @returns {string}
	 */
	_public.pageLink = function(providerName, pageName, params) {
		var ret = '/' + OPENMRS_CONTEXT_PATH + '/' + providerName + '/' + pageName + '.page';
		return ret + toQueryString(params);
	};

	/**
	 * Returns a link to a UI framework managed resource
	 * @param providerName the resource provider
	 * @param resourcePath the resource path
	 * @returns {string} the link
	 */
	_public.resourceLink = function(providerName, resourcePath) {
		if (providerName == null) {
			providerName = '*';
		}
		return '/' + OPENMRS_CONTEXT_PATH + '/ms/uiframework/resource/' + providerName + '/' + resourcePath;
	};

	_public.fragmentActionLink = function(providerName, fragmentName, actionName, params) {
		var ret = '/' + OPENMRS_CONTEXT_PATH + '/' + providerName + '/' + fragmentName + '/' + actionName + '.action';
		if (params) {
			ret += toQueryString(params);
		}
		return ret;
	};

	_public.getFragmentActionAsJson = function(providerName, fragmentName, actionName, params, callback) {
		var url = this.fragmentActionLink(providerName, fragmentName, actionName, null);

		jq.getJSON(url, params, function(result) {
			if (callback) {
				callback(result);
			}
		});
	};

	/**
	 * Reloads the current page
	 */
	_public.reloadPage = function() {
		location.reload();
	};

	/**
	 * Navigates to a new page
	 * @param providerName the page provider or complete URL if no other args are provided
	 * @param pageName the page name
	 * @param options the page options
	 */
	_public.navigate = function(providerName, pageName, options) {
		// If a single argument, interpret as a complete URL
		location.href = (arguments.length == 1) ? providerName : this.pageLink(providerName, pageName, options);
	};

	_public.escapeHtmlAttribute = function(string) {
		// TODO actually implement this
		string = string.replace("'", "\'");
		string = string.replace('"', '\\"');
		return string;
	};

	_public.confirmBeforeNavigating = function(formSelector) {
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
	};

	_public.cancelConfirmBeforeNavigating = function(formSelector) {
		var form = jq(formSelector);
		form.find(':input').off('change.confirm-before-navigating');
		form.data('confirmBeforeNavigating', null);
		form.removeClass('confirm-before-navigating');
	};

	_public.disableConfirmBeforeNavigating = function() {
		confirmBeforeNavigationSetup.enabled = false;
	};

	_public.enableConfirmBeforeNavigating = function() {
		confirmBeforeNavigationSetup.enabled = true;
	};

	return _public;

})(jQuery);