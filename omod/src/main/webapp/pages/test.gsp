<%
	ui.decorateWith("kenyaui", "standardPage")

	def defaultOnClick = "alert('Clicked');"
%>
<h1>Kenya UI Library</h1>

<h2>Widgets</h2>

<h3>button</h3>

${ ui.includeFragment("kenyaui", "widget/button", [ label: "OK", onClick: defaultOnClick ]) }

${ ui.includeFragment("kenyaui", "widget/button", [ label: "Long label here", onClick: defaultOnClick ]) }

${ ui.includeFragment("kenyaui", "widget/button", [ label: "Label", extra: "Extra text here", onClick: defaultOnClick ]) }

${ ui.includeFragment("kenyaui", "widget/button", [ label: "Label", iconProvider: "kenyaui", icon: "buttons/patient_add.png", onClick: defaultOnClick ]) }

${ ui.includeFragment("kenyaui", "widget/button", [ label: "Label", extra: "Extra text here", iconProvider: "kenyaui", icon: "buttons/patient_search.png", onClick: defaultOnClick ]) }

${ ui.includeFragment("kenyaui", "widget/button", [ label: "Label", extra: "Icon has an overlay ", iconProvider: "kenyaui", icon: "buttons/patient_search.png", iconOverlayProvider: "kenyaui", iconOverlay: "buttons/_overlay_edit.png", onClick: defaultOnClick ]) }

<h3>editButton</h3>

${ ui.includeFragment("kenyaui", "widget/editButton", [ onClick: defaultOnClick ]) }

<h3>appButton</h3>

${ ui.includeFragment("kenyaui", "widget/appButton", [ label: "My App", iconProvider: "kenyaui", icon: "apps/admin.png", onClick: defaultOnClick ]) }