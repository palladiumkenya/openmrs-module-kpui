<%
	config.require("label")

	def valueHtml = null
	def extraHtml = null

	if (config.value instanceof java.util.Date) {
		if (config.showTime) {
			valueHtml = ui.format(config.value)
		} else {
			valueHtml = kenyaUi.formatDate(config.value)
		}

		if (config.showDateInterval) {
			extraHtml = kenyaUi.formatInterval(config.value)
		}
	}
	else if (config.value instanceof org.openmrs.ui.framework.Link) {
		valueHtml = """<a href="${ config.value.link }">${ config.value.label }</a>"""
	}
	else {
		valueHtml = ui.format(config.value)
	}

	if (config.extra instanceof java.util.Date) {
		extraHtml = kenyaUi.formatDate(config.extra)
	}
%>
<div class="ke-datapoint"><span class="ke-label">${ config.label }</span>: <span class="ke-value">${ valueHtml }</span><% if (extraHtml) { %> <span class="ke-extra">(${ extraHtml })</span><% } %></div>