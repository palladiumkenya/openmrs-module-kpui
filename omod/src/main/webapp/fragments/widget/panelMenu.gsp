<%
	// Supports items, heading

	config.require("items")
%>
<div class="ke-panel-frame">
	<% if (config.heading) { %>
	<div class="ke-panel-heading">${ config.heading }</div>
	<%
	}
	for (def itemConfig : config.items) { %>
   		${ ui.includeFragment("kenyaui", "widget/panelMenuItem", itemConfig) }
	<% } %>
</div>



