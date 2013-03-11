<% ui.includeCss("kenyaui", "jquery-ui.css") %>
<% ui.includeCss("kenyaui", "uilibrary.css") %>
<% ui.includeCss("kenyaui", "tipTip.css") %>
<% ui.includeCss("kenyaui", "toastmessage/css/jquery.toastmessage.css") %>
<% ui.includeJavascript("kenyaui", "jquery.js") %>
<% ui.includeJavascript("kenyaui", "jquery-ui.js") %>
<% ui.includeJavascript("kenyaui", "jquery.tipTip.minified.js") %>
<% ui.includeJavascript("kenyaui", "jquery.toastmessage.js") %>
<% ui.includeJavascript("kenyaui", "pagebus/simple/pagebus.js") %>
<% ui.includeJavascript("kenyaui", "uiframework.js") %>
<% ui.includeJavascript("kenyaui", "ui.js") %>

${ ui.includeFragment("kenyaui", "maybeRequireLogin") }

<script>
    var jq = jQuery;
    var CONTEXT_PATH = '${ contextPath }';
</script>