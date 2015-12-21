
var patterns = { 
	username: /^[A-Za-z0-9]*$/,
	email: /^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/,
	password: /^.{8,}$/
}



$(function(ready) {
	var inputs = {};
	$("#reg-form-submit").addClass('disabled');
	$("input.form-control[data-check='true']").each(function() {
		var fg = $(this).parent().parent();
		var input = $(this);
		inputs[input.attr('name')] = false;
		input.on('input',function() {

			if(input.val() == "")
			{
				fg.attr('class','form-group has-warning');
			}
			else
			{
				var equal = input.attr('equal');
				if(typeof equal !== typeof undefined && equal !== false)
				{
					var equal_val = $("input[name='" + input.attr('equal') + "']").val();
					if(input.val() == equal_val) {
						fg.attr('class','form-group has-success');
						inputs[input.attr('name')] = true;
					} else {
						fg.attr('class','form-group has-error');
						inputs[input.attr('name')] = false;
					}
					
				} else {
					var regex = new RegExp(patterns[input.attr('name')]);
					if(regex.test(input.val())) {
						fg.attr('class','form-group has-success');
						inputs[input.attr('name')] = true;
					} else {
						fg.attr('class','form-group has-error');
						inputs[input.attr('name')] = false;
					}
				}
			}

			var valid = true;
			for(item in inputs) {
				if(inputs[item] == false) {
					valid = false;
					break;
				}
			}

			if(valid) {
				$("#reg-form-submit").removeClass('disabled');
			} else {
				if(! $("#reg-form-submit").hasClass('disabled')) {
					$("#reg-form-submit").addClass('disabled');
				}
			}
		});
	});
});