<%
	config.require("dialogConfig")
	
	config.id = config.id ?: ui.randomId("dialogForm")

	config.cancelFunction = "kenyaui.closeDialog"

	def closeCallback = "kenyaui.closeDialog();"

	if (config.successCallbacks) {
		config.successCallbacks << closeCallback
	}
	else {
		config.successCallbacks = [ closeCallback ]
	}

	def dialogHeading = config.dialogConfig.heading
	def dialogWidth = config.dialogConfig.width ?: 80
	def dialogHeight = config.dialogConfig.height ?: 80

	def onOpenCallback = config.onOpenCallback ?: ''
%>

<%
	if (config.buttonConfig) {
		config.buttonConfig.onClick = """
			kenyaui.openPanelDialog({ templateId: '${ config.id }_form', width: ${ dialogWidth }, height: ${ dialogHeight } });
			ui.confirmBeforeNavigating('#${ config.id }_form');
			${ onOpenCallback }
		"""

		print ui.includeFragment("kenyaui", "widget/button", config.buttonConfig)
	}
%>

<div id="${ config.id }_form" title="${ ui.escapeAttribute(dialogHeading) }" style="display: none">
	${ ui.includeFragment("kenyaui", "widget/panelForm", config) }
</div>