<%
// supports icon, iconProvider, label, extra
// supports onClick (javascript snippet)
// supports href (link url)
// supports classes (applied to button)

def id = config.id ?: ui.randomId("button")

def classes = [ "ke-control", "ke-button" ];
if (config.classes) {
	classes.addAll(config.classes)
}
%>
<button id="${ id }" class="${ classes.join(' ') }" style="min-width: 160px">
	<% if (config.icon && config.iconProvider) { %>
		${ ui.includeFragment("kenyaui", "widget/icon", [ iconProvider: config.iconProvider, icon: config.icon ]) }
	<% } %>
	<div>
	<% if (config.label) { %>
		<span class="ke-label">${ config.label }</span>
	<% } %>
	<% if (config.extra) { %>
		<br/>
		<span class="ke-extra">${ config.extra }</span>
	<% } %>
	</div>
</button>

<% if (config.href || config.onClick) { %>
<script type="text/javascript">
jq(function() {
	jq('#${ id }').click(function() {
		<% if (config.onClick) { %>
			${ config.onClick }
		<% } %>
		<% if (config.href) { %>
			location.href = '${ ui.escapeJs(config.href) }'
		<% } %>
	});
});
</script>
<% } %>