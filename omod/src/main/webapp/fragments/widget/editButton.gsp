<%
	// Convenience widget for a simple edit button
%>
${ ui.includeFragment("kenyaui", "widget/button", [
		iconProvider: "kenyaui",
		icon: "edit.png",
		classes: [ "ke-editbutton" ],
		label: "Edit",
		href: config.href,
		onClick: config.onClick
])}