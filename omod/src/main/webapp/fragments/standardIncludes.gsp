<% ui.includeCss("kenyaui", "jquery-ui.css") %>
<% ui.includeCss("kenyaui", "kenyaui.css") %>
<% ui.includeCss("kenyaui", "toastmessage/css/jquery.toastmessage.css") %>
<% ui.includeJavascript("kenyaui", "jquery.js") %>
<% ui.includeJavascript("kenyaui", "jquery-ui.js") %>
<% ui.includeJavascript("kenyaui", "jquery.toastmessage.js") %>
<% ui.includeJavascript("kenyaui", "pagebus/simple/pagebus.js") %>
<% ui.includeJavascript("kenyaui", "kenyaui.js") %>
<% ui.includeJavascript("kenyaui", "ui.js") %>

${ ui.includeFragment("kenyaui", "maybeRequireLogin") }

<script type="text/javascript">
    var jq = jQuery;
    var CONTEXT_PATH = '${ contextPath }';
</script>