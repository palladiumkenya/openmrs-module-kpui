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

<h2>Layout</h2>

<h3>Tabs</h3>
<div class="holder">
	<div class="ke-page-tabs">
		<div class="ke-page-tab" data-tabid="tab1">Tab #1</div>
		<div class="ke-page-tab" data-tabid="tab2">Tab #2</div>
		<div class="ke-page-tab" data-tabid="tab3">Tab #3</div>
		<div class="ke-page-tab" data-tabid="tab4">Tab #4</div>
	</div>

	<div class="ke-page-tabcontents">
		<div class="ke-page-tabcontent" data-tabid="tab1">Lorem ipsum...</div>
		<div class="ke-page-tabcontent" data-tabid="tab2">Lorem ipsum...</div>
		<div class="ke-page-tabcontent" data-tabid="tab3">Lorem ipsum...</div>
		<div class="ke-page-tabcontent" data-tabid="tab4">Lorem ipsum...</div>
	</div>
</div>