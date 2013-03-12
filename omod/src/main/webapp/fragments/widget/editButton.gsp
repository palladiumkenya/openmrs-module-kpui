<%
	// Convenience widget for a simple edit button

	// Supports href
%>
${ ui.includeFragment("kenyaui", "widget/button", [ classes: [ "ke-editbutton" ], label: "Edit", href: config.href ])}