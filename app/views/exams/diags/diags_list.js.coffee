$('#patient_diags_list_div').html '<%= j(render partial: "exams/diags/diags_list", locals: {exam: @exam}) %>'
$('tr#new_created').addClass('warning').hide().fadeIn()