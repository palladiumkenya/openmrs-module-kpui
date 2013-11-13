<%
	ui.decorateWith("kenyaui", "standardPage")

	def defaultOnClick = "defaultOnClick();"
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
<script type="text/javascript">
	function defaultOnClick() { alert('Clicked'); }
</script>

<h1>KenyaUI Library</h1>

<h2>Widgets</h2>

<h3>appButton</h3>
<div class="holder">
	${ ui.includeFragment("kenyaui", "widget/appButton", [ label: "My App", iconProvider: "kenyaui", icon: "apps/admin.png", onClick: defaultOnClick ]) }
	${ ui.includeFragment("kenyaui", "widget/appButton", [ iconProvider: "kenyaui", icon: "apps/clinician.png", onClick: defaultOnClick ]) }
</div>

<h3>dataPoint</h3>
<div class="holder">
	${ ui.includeFragment("kenyaui", "widget/dataPoint", [ label: "Date value with interval", value: new Date(), showDateInterval: true ]) }
	${ ui.includeFragment("kenyaui", "widget/dataPoint", [ label: "Regular value with extra date", value: "Value", extra: new Date() ]) }
	${ ui.includeFragment("kenyaui", "widget/dataPoint", [ label: "Collections of values", value: [ "abc", 123, new Date() ] ]) }
</div>

<h3>panelMenu</h3>
<div class="holder" style="width: 400px">
	${ ui.includeFragment("kenyaui", "widget/panelMenu", [
			heading: "Header",
			items: [
					[ iconProvider: "kenyaui", icon: "buttons/users_manage.png", label: "Menu Item #1 (active)", active: true, href: ui.pageLink("kenyaui", "test") ],
					[ iconProvider: "kenyaui", label: "Menu Item #2 (no icon)", onClick: defaultOnClick ],
					[ iconProvider: "kenyaui", icon: "buttons/admin_setup.png", label: "Menu Item #3 (extra text)", extra: "Extra text", href: ui.pageLink("kenyaui", "test") ]
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

<h3>Text</h3>
<div class="holder">
	This is text and <a href="#">this is a link</a>.
</div>

<h3>input / select</h3>
<div class="holder">
	<input type="text" value="text" />
	<select><option>Option #1</option><option>Option #2</option><option>Option #3</option></select>

	<input type="submit" value="submit" />
	<input type="button" value="button" />
	<input type="button" value="reset" />
</div>

<h3>button</h3>
<div class="holder">
	<button type="button">button</button>
	<button type="button"><img src="${ ui.resourceLink("kenyaui", "images/glyphs/view.png") }" /> button with glyph</button>
	<button type="button"><img src="${ ui.resourceLink("kenyaui", "images/buttons/undo.png") }" /> button with icon</button>
	<button type="button" class="ke-compact"><img src="${ ui.resourceLink("kenyaui", "images/glyphs/edit.png") }" /> compact</button>
	<button type="button" class="ke-compact"><img src="${ ui.resourceLink("kenyaui", "images/glyphs/edit.png") }" /></button>
</div>

<h2>Classes</h2>

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
	<div class="ke-form-footer"><button type="submit">Save Changes</button><button type="button">Discard Changes</button></div>
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
		<button type="button" class="ke-compact" onclick="defaultOnClick()">
			<img src="${ ui.resourceLink("kenyaui", "images/glyphs/edit.png") }" />
		</button>
		<button type="button" class="ke-compact" onclick="defaultOnClick()">
			<img src="${ ui.resourceLink("kenyaui", "images/glyphs/void.png") }" />
		</button>
		Stack item #3 with buttons
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

<h2>Javascript</h2>

<h3>modal dialogs</h3>
<div class="holder">

	<!-- Template for dialog loaded from existing template -->
	<div id="dialog-template" title="Heading" style="display: none">
		<div class="ke-panel-content">
			Content from an existing template
			<br/>
			${ ui.includeFragment("kenyaui", "field/java.util.Date", [ initialValue: new Date() ]) }
		</div>
		<div class="ke-panel-controls">
			<button type="button" onclick="kenyaui.closeDialog()">Close</button>
		</div>
	</div>

	<button type="button" onclick="kenyaui.openPanelDialog({ heading: 'Dialog', content: '<div class=&quot;ke-panel-content&quot;>Dialog content</div>' })">Panel</button>
	<button type="button" onclick="kenyaui.openPanelDialog({ templateId: 'dialog-template' })">Panel (from template)</button>
	<button type="button" onclick="kenyaui.openLoadingDialog({})">Loading</button>
	<button type="button" onclick="kenyaui.openAlertDialog({ heading: 'Alert', message: 'Dialog content' })">Alert</button>
	<button type="button" onclick="kenyaui.openConfirmDialog({ heading: 'Confirm', message: 'Dialog content' })">Confirm</button>
	<button type="button" onclick="kenyaui.openDynamicDialog({ heading: 'Dynamic', url: ui.pageLink('kenyaui', 'test') })">Dynamic</button>
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
			"provider", "regimen", "regimen_change", "regimen_restart",
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
	<% [
			"add", "cancel", "close", "csv", "disable", "discontinue", "edit", "email", "enable", "enroll", "excel", "login",
			"monitor", "ok", "patient_f", "patient_m", "person_f", "person_m", "phone", "start", "switch", "trash", "view", "void"
	].each { name -> %>
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