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

<h2>Decorators</h2>

<h3>panel</h3>
<div class="holder">
	${ ui.decorate("kenyaui", "panel", [ heading: "Heading" ], "Panel content") }
</div>

<h2>Styling</h2>

<h3>table-vertical</h3>
<div class="holder">
	<table class="ke-table-vertical">
		<thead>
			<tr>
				<th>Header #1</th>
				<th>Header #2</th>
				<th>Header #3</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td>Cell #1</td>
				<td>Cell #2</td>
				<td>Cell #3</td>
			</tr>
			<tr>
				<td>Cell #4</td>
				<td>Cell #5</td>
				<td>Cell #6</td>
			</tr>
		</tbody>
	</table>
</div>

<h3>warning</h3>
<div class="holder">
	<div class="ke-warning">Warning content</div>
</div>

<h2>Icons</h2>

<h3>Apps</h3>
<div class="holder">
	<% [ "registration", "intake", "clinician", "chart", "reports", "admin" ].each { name -> %>
	<img src="${ ui.resourceLink("kenyaui", "images/apps/" + name + ".png") }" title="${ name }" />
	<% } %>
</div>

<h3>Buttons</h3>
<div class="holder">
	<%
	[
			"account", "account_add", "admin_content", "admin_modules", "admin_overview", "admin_setup", "admin_update",
			"back", "close", "patient_add", "patient_overview", "patient_search", "profile_password", "profile_secret_question",
			"program_complete", "program_enroll", "provider", "regimen", "regimen_change", "regimen_restart",
			"regimen_start", "regimen_stop", "registration", "report_configure", "report_download_excel", "report_generate",
			"undo", "user_disable", "user_enable", "users_manage", "visit_end", "visit_retrospective", "visit_void"
	].each { name -> %>
	<img src="${ ui.resourceLink("kenyaui", "images/buttons/" + name + ".png") }" title="${ name }" />
	<% } %>
</div>

<h3>Forms</h3>
<div class="holder">
	<% [ "generic", "completion", "family_history", "labresults", "moh257", "obstetric" ].each { name -> %>
	<img src="${ ui.resourceLink("kenyaui", "images/forms/" + name + ".png") }" title="${ name }" />
	<% } %>
</div>

<h3>Glyphs</h3>
<div class="holder">
	<% [ "email", "phone" ].each { name -> %>
	<img src="${ ui.resourceLink("kenyaui", "images/glyphs/" + name + ".png") }" title="${ name }" />
	<% } %>
</div>

<h3>Toolbar</h3>
<div class="holder">
	<div class="ke-toolbar">
	<% [ "home", "help" ].each { name -> %>
	<img src="${ ui.resourceLink("kenyaui", "images/toolbar/" + name + ".png") }" title="${ name }" />
	<% } %>
	</div>
</div>