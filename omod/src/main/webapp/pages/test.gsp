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

<h3>appButton</h3>
<div class="holder">
	${ ui.includeFragment("kenyaui", "widget/appButton", [ label: "My App", iconProvider: "kenyaui", icon: "apps/admin.png", onClick: defaultOnClick ]) }
	${ ui.includeFragment("kenyaui", "widget/appButton", [ iconProvider: "kenyaui", icon: "apps/clinician.png", onClick: defaultOnClick ]) }
</div>

<h3>button</h3>
<div class="holder">
	${ ui.includeFragment("kenyaui", "widget/button", [ label: "OK", onClick: defaultOnClick ]) }
	${ ui.includeFragment("kenyaui", "widget/button", [ label: "Long label here", onClick: defaultOnClick ]) }
	${ ui.includeFragment("kenyaui", "widget/button", [ label: "Label", extra: "Extra text here", onClick: defaultOnClick ]) }
	${ ui.includeFragment("kenyaui", "widget/button", [ label: "Label", iconProvider: "kenyaui", icon: "buttons/patient_add.png", onClick: defaultOnClick ]) }
	${ ui.includeFragment("kenyaui", "widget/button", [ label: "Label", extra: "Extra text here", iconProvider: "kenyaui", icon: "buttons/patient_search.png", onClick: defaultOnClick ]) }
	${ ui.includeFragment("kenyaui", "widget/button", [ label: "Label", extra: "Icon has an overlay ", iconProvider: "kenyaui", icon: "buttons/patient_search.png", iconOverlayProvider: "kenyaui", iconOverlay: "buttons/_overlay_edit.png", onClick: defaultOnClick ]) }
</div>

<h3>buttonlet</h3>
<div class="holder">
	${ ui.includeFragment("kenyaui", "widget/buttonlet", [ type: "add", onClick: defaultOnClick ]) }
	${ ui.includeFragment("kenyaui", "widget/buttonlet", [ type: "edit", onClick: defaultOnClick ]) }
	${ ui.includeFragment("kenyaui", "widget/buttonlet", [ type: "void", onClick: defaultOnClick ]) }
	${ ui.includeFragment("kenyaui", "widget/buttonlet", [ type: "add", label: "Add", onClick: defaultOnClick ]) }
</div>

<h3>dataPoint</h3>
<div class="holder">
	${ ui.includeFragment("kenyaui", "widget/dataPoint", [ label: "Date value with interval", value: new Date(), showDateInterval: true ]) }
	${ ui.includeFragment("kenyaui", "widget/dataPoint", [ label: "Regular value with extra date", value: "Value", extra: new Date() ]) }
</div>

<h3>panelMenu</h3>
<div class="holder" style="width: 400px">
	${ ui.includeFragment("kenyaui", "widget/panelMenu", [
			heading: "Header",
			items: [
					[ iconProvider: "kenyaui", icon: "buttons/users_manage.png", label: "Menu Item #1 (Active)", active: true, href: ui.pageLink("kenyaui", "test") ],
					[ iconProvider: "kenyaui", icon: "buttons/admin_setup.png", label: "Menu Item #2", href: ui.pageLink("kenyaui", "test") ]
			]
	]) }
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

<h2>Fields</h2>

<h3>java.util.Date</h3>
<div class="holder">
	Date only ${ ui.includeFragment("kenyaui", "field/java.util.Date", [ initialValue: new Date() ]) }<br />
	Date and time ${ ui.includeFragment("kenyaui", "field/java.util.Date", [ initialValue: new Date(), showTime: true ]) }
</div>

<h2>Decorators</h2>

<h3>panel</h3>
<div class="holder">
	${ ui.decorate("kenyaui", "panel", [ heading: "Simple Panel" ], """Panel content""") }
	${ ui.decorate("kenyaui", "panel", [ heading: "Panel with footer", frameOnly: true ],
			"""<div class="ke-panel-content">Panel content</div><div class="ke-panel-footer">Panel footer</div>""") }
</div>

<h2>Styles</h2>

<h3>error</h3>
<div class="holder">
	<div class="error">Error message</div>
</div>

<h3>flagtag</h3>
<div class="holder">
	<div class="ke-flagtag">Tag message</div>
</div>

<h3>form-footer</h3>
<div class="holder">
	Form content
	<div class="ke-form-footer"><input type="submit" value="Save Changes" /><input type="button" value="Discard Changes" /></div>
</div>

<h3>form-globalerrors</h3>
<div class="holder">
	<div class="ke-form-globalerrors">
		<div>Error message #1</div>
		<div>Error message #2</div>
	</div>
</div>

<h3>form-header</h3>
<div class="holder">
	<div class="ke-form-header">Form header <select><option>Something</option></select></div>
	Form content
</div>

<h3>stack-item</h3>
<div class="holder">
	<div class="ke-stack-item">Stack item #1</div>
	<div class="ke-stack-item">Stack item #2</div>
	<div class="ke-stack-item">
		${ ui.includeFragment("kenyaui", "widget/buttonlet", [ type: "void", onClick: defaultOnClick ]) }
		${ ui.includeFragment("kenyaui", "widget/buttonlet", [ type: "edit", onClick: defaultOnClick ]) }
		Stack item #3 with buttonlets
	</div>
</div>

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

<h3>HTML overrides</h3>
<div class="holder">
	This is text and <a href="#">this is a link</a>
	<input type="submit" value="submit" />
	<input type="button" value="button" />
	<input type="text" value="text" />
	<select><option>Option #1</option><option>Option #2</option><option>Option #3</option></select>
</div>

<h2>Javascript</h2>

<h3>modal dialogs</h3>
<div class="holder">
	<input type="button" value="openPanelDialog" onclick="kenyaui.openPanelDialog({ heading: 'Dialog', content: 'Dialog content' })" />
	<input type="button" value="openLoadingDialog" onclick="kenyaui.openLoadingDialog({})" />
	<input type="button" value="openAlertDialog" onclick="kenyaui.openAlertDialog({ heading: 'Alert', message: 'Dialog content' })" />
	<input type="button" value="openConfirmDialog" onclick="kenyaui.openConfirmDialog({ heading: 'Confirm', message: 'Dialog content' })" />
</div>

<h2>Icons</h2>

<h3>apps</h3>
<div class="holder">
	<% [ "registration", "intake", "clinician", "chart", "reports", "admin" ].each { name -> %>
	<img src="${ ui.resourceLink("kenyaui", "images/apps/" + name + ".png") }" title="${ name }" />
	<% } %>
</div>

<h3>buttons</h3>
<div class="holder">
	<%
	[
			"account", "account_add", "admin_content", "admin_modules", "admin_overview", "admin_setup", "admin_update",
			"back", "close", "patient_add", "patient_f", "patient_m", "patient_overview", "patient_search",
			"person_f", "person_m", "profile_password", "profile_secret_question",
			"program_complete", "program_enroll", "provider", "regimen", "regimen_change", "regimen_restart",
			"regimen_start", "regimen_stop", "registration", "report_configure", "report_download_excel", "report_generate",
			"undo", "user_disable", "user_enable", "users_manage", "visit_end", "visit_retrospective", "visit_void"
	].each { name -> %>
	<img src="${ ui.resourceLink("kenyaui", "images/buttons/" + name + ".png") }" title="${ name }" />
	<% } %>
</div>

<h3>forms</h3>
<div class="holder">
	<% [ "generic", "completion", "family_history", "labresults", "moh257", "obstetric" ].each { name -> %>
	<img src="${ ui.resourceLink("kenyaui", "images/forms/" + name + ".png") }" title="${ name }" />
	<% } %>
</div>

<h3>glyphs</h3>
<div class="holder">
	<% [ "add", "edit", "void", "email", "phone", "patient_f", "patient_m", "person_f", "person_m" ].each { name -> %>
	<img src="${ ui.resourceLink("kenyaui", "images/glyphs/" + name + ".png") }" title="${ name }" />
	<% } %>
</div>

<h3>toolbar</h3>
<div class="holder">
	<div class="ke-toolbar">
	<% [ "home", "help" ].each { name -> %>
	<img src="${ ui.resourceLink("kenyaui", "images/toolbar/" + name + ".png") }" title="${ name }" />
	<% } %>
	</div>
</div>