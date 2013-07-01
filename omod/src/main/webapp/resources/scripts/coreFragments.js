var FieldUtils = {
	defaultSubscriptions: function(formId, formFieldName, fieldId) {

		// Save default field value
		$('#' + fieldId).data('default-value', $('#' + fieldId).val());

		// On form reset, set field to it's default value
		subscribe(formId + '.reset', function() {
		    $('#' + fieldId).val($('#' + fieldId).data('default-value'));
		    $('#' + fieldId + '-error').html("").hide();
		});
	}
}