<%
	ui.decorateWith("kenyaui", "standardPage")

	def defaultOnClick = "alert('Clicked');"
%>
<style type="text/css">
	h1 {
		display: block;
		background-color: #464640;
		padding: 10px;
		margin: 0;
		color: white;
	}
	h2 {
		display: block;
		background-color: #7f7b72;
		padding: 5px 10px 5px 10px;
		margin: 0;
		color: white;
	}
	h3 {
		display: block;
		background-color: #D1D0C9;
		padding: 5px 7px 5px 7px;
		margin: 0;
		color: #333;
	}
	.holder {
		padding: 10px;
	}
</style>

<h1>KenyaUI Library</h1>

<h2>Widgets</h2>

<h3>button</h3>
<div class="holder">
	${ ui.includeFragment("kenyaui", "widget/button", [ label: "OK", onClick: defaultOnClick ]) }
	${ ui.includeFragment("kenyaui", "widget/button", [ label: "Long label here", onClick: defaultOnClick ]) }
	${ ui.includeFragment("kenyaui", "widget/button", [ label: "Label", extra: "Extra text here", onClick: defaultOnClick ]) }
	${ ui.includeFragment("kenyaui", "widget/button", [ label: "Label", iconProvider: "kenyaui", icon: "buttons/patient_add.png", onClick: defaultOnClick ]) }
	${ ui.includeFragment("kenyaui", "widget/button", [ label: "Label", extra: "Extra text here", iconProvider: "kenyaui", icon: "buttons/patient_search.png", onClick: defaultOnClick ]) }
	${ ui.includeFragment("kenyaui", "widget/button", [ label: "Label", extra: "Icon has an overlay ", iconProvider: "kenyaui", icon: "buttons/patient_search.png", iconOverlayProvider: "kenyaui", iconOverlay: "buttons/_overlay_edit.png", onClick: defaultOnClick ]) }
</div>

<h3>editButton</h3>
<div class="holder">
	${ ui.includeFragment("kenyaui", "widget/editButton", [ onClick: defaultOnClick ]) }
</div>

<h3>appButton</h3>
<div class="holder">
	${ ui.includeFragment("kenyaui", "widget/appButton", [ label: "My App", iconProvider: "kenyaui", icon: "apps/admin.png", onClick: defaultOnClick ]) }
</div>

<h3>tabMenu</h3>
<div class="holder">
	${ ui.includeFragment("kenyaui", "widget/tabMenu", [ items: [
			[ label: "Tab #1", tabid: "tab1" ],
			[ label: "Tab #2", tabid: "tab2" ],
			[ label: "Tab #3", tabid: "tab3" ],
			[ label: "Tab #4", tabid: "tab4" ]
	] ]) }

	<div class="ke-tab" data-tabid="tab1">First tab content</div>
	<div class="ke-tab" data-tabid="tab2">Second tab content</div>
	<div class="ke-tab" data-tabid="tab3">Third tab content</div>
	<div class="ke-tab" data-tabid="tab4">Fourth tab content</div>
</div>

<h2>Icons</h2>

<h3>Apps</h3>
<div class="holder">
	<img src="${ ui.resourceLink("kenyaui", "images/apps/registration.png") }" />
	<img src="${ ui.resourceLink("kenyaui", "images/apps/intake.png") }" />
	<img src="${ ui.resourceLink("kenyaui", "images/apps/clinician.png") }" />
	<img src="${ ui.resourceLink("kenyaui", "images/apps/chart.png") }" />
	<img src="${ ui.resourceLink("kenyaui", "images/apps/reports.png") }" />
	<img src="${ ui.resourceLink("kenyaui", "images/apps/admin.png") }" />
</div>