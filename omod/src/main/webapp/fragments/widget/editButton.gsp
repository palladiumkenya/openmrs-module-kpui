<%
	// Convenience widget for a simple edit button

	/* Deprecated */
%>
${ ui.includeFragment("kenyaui", "widget/buttonlet", [
		type: "edit",
		href: config.href,
		onClick: config.onClick
])}