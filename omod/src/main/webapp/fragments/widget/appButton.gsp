<%
	// Convenience widget for an app button
%>
${ ui.includeFragment("kenyaui", "widget/button", [
		iconProvider: config.iconProvider,
		icon: config.icon,
		cssClass: "ke-appbutton",
		label: config.label,
		href: config.href,
		onClick: config.onClick
])}