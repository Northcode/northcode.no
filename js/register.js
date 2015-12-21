
var patterns = { 
	username: /^[A-Za-z0-9]*$/,
	email: /^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/,
	password: /^.{8,}$/
}

function delay(label,callback){
    if(typeof window.delayed_methods=="undefined"){window.delayed_methods={};}  
    delayed_methods[label]=Date.now();
    var t=delayed_methods[label];
    setTimeout(function(){ if(delayed_methods[label]!=t){return;}else{  callback();}}, 500);
  }

function validate(inputs) {
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
			validate(inputs);
			
		});
	});

	inputs[$('#register-username').attr('name')] = false;

	$('#register-username').keyup(function () {
		delay("username", function() {
			console.log("Action");
			$.get('ajax/user_exists.php', {username: $('#register-username').val() })
				.done(function (data) {
					console.log(data);
					var fg = $('#register-username').parent().parent();

					if(data["result"] == "ok") {
						inputs[$('#register-username').attr('name')] = true;
						$("#username-addtext").html("OK");
						fg.attr('class','form-group has-success');
					} else {
						inputs[$('#register-username').attr('name')] = false;
						$("#username-addtext").html(data["error"]);
						fg.attr('class','form-group has-error');
					}
					validate(inputs);
				});
		});
	});
});