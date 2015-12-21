<?php 
header("Content-Type: application/json");

include("../lib/northcode.php");

function test_username($name) {
	return preg_match("/^([a-zA-Z0-9]*)$/",$name);
}

if(isset($_GET['username'])) {

	if(!test_username($_GET['username']))
	{
		echo json_encode(array("error" => "Invalid Username"));
	} else {


		$uinfo = nc_api::get_user_info_by_uname($_GET['username']);

		if(isset($uinfo['error']) && $uinfo['error']['idm'] == 'invalid-user') {
			echo json_encode(array("result" => "ok"));
		
		} else {
			echo json_encode(array("error" => "Username has already been taken"));
		}
	}
} else {
	echo json_encode(array("error" => "missing data"));
}

 ?>