<%
    // Supports icon, iconProvider, iconOverlay
	// Supports useEditOverlay, useViewOverlay
	// Supports tooltip

	config.require("iconProvider")
	config.require("icon")

	def iconOverlay = config.iconOverlay

	if (config.useEditOverlay)
		iconOverlay = "buttons/_overlay_edit.png"
	else if (config.useViewOverlay)
		iconOverlay = "buttons/_overlay_view.png"

	def tooltip = config.tooltip ?: ""
%>
<div class="ke-icon">
	<div style="position: relative; width: 32px; height: 32px">
		<img src="${ ui.resourceLink(config.iconProvider, "images/" + config.icon) }" style="position: absolute; top: 0; right: 0; width: 32px; height: 32px; z-index: 0" alt="${ tooltip }" />
		<% if (iconOverlay) { %>
		<img src="${ ui.resourceLink(config.iconProvider, "images/" + iconOverlay) }" style="position: absolute; top: 0; right: 0; width: 32px; height: 32px; z-index: 1" alt="${ tooltip }" />
		<% } %>
	</div>
</div>