<?php 
include_once($_SERVER['DOCUMENT_ROOT'] . "/res/mysql_connect.php");
include_once($_SERVER['DOCUMENT_ROOT'] . "/sec/password_hash.php");
include_once($_SERVER['DOCUMENT_ROOT'] . "/lib/mail.php");


//define functions

function activate() {
	global $mysql;
	$id;
	if(isset($_GET['id'])) {
		$id = $_GET['id'];
	} else {
		die("no id given");
	}

	$activate_q = $mysql->prepare("SELECT username,password,email from preuser where register_code = ?");
	$activate_q->bind_param("s",$id);
	$activate_q->execute();
	$activate_q->bind_result($qusername,$qpassword,$qemail);
	$activate_q->fetch();

	if($qusername != "") {
		$activate_q->close();

		$insert_q = $mysql->prepare("INSERT into users (username,password,email) VALUES (?,?,?)");
		$insert_q->bind_param('sss',$qusername,$qpassword,$qemail);
		$insert_q->execute();
		$insert_q->close();

		$q = $mysql->prepare("DELETE FROM preuser WHERE register_code = ?");
		$q->bind_param("s",$id);
		$q->execute();
		$q->close();

		header("Location: ../index.php");
	} else {
		$activate_q->close();
		die("No match for activation id: ".$id);
	}
}

function test_username($name) {
	return preg_match("/^([a-zA-Z0-9\s]*)$/",$name);
}

function test_email($email) {
	return preg_match("/^([\w\-]+\@[\w\-]+\.[\w\-]+)$/",$email);
}

//IF $activate GOTO ACTIVATE
if(isset($_GET['activate'])) {
	activate();
	header("Location: ../index.php");
}


//Get vars

$username;
$email;
$password;


if (isset($_POST['username'])) {
	//code...
	$username = $_POST['username'];
}

if (isset($_POST['email'])) {
	//code...
	$email = $_POST['email'];
}

if (isset($_POST['password'])) {
	//code...
	$password = $_POST['password'];
}

//generate password hash
$password = hashpass($password);

//check email & username
if($email and $username) {
	if(test_username($username) and test_email($email)) {
		//generate register code
		$code = hash('sha1',rand(1,1000000));
		//set death time
		$ttl = 30 * 24 * 60 * 60; // 30 days
		$death_time = date('Y-m-d H:i:s',time() + $ttl);

		//insert
		$puser_q = $mysql->prepare("INSERT into preuser (username,password,email,register_code,TTL) VALUES (?,?,?,?,?)");
		$puser_q->bind_param("sssss",$username,$password,$email,$code,$death_time);
		$puser_q->execute();

		//Send mail
		$subject = "Northcode.no registration";
		$message = '
		<!DOCTYPE html>
		<html>
		<head>
			<title>Registration at northcode</title>
		</head>
		<body>
				<h1>Dear, '.$username.'</h1>
				<p>Thank you for registering at northcode.no!</p>
				<p>You will now be able to login to our services</p>
				<p>In order to use your account it must be activated, or it will be deleted after 30 days and you will have to register again</p>
				<p>To activate your account, follow this link: <a href="http://northcode.no/scr/register.php?activate&id='.$code.'">http://northcode.no/scr/register.php?activate&id='.$code.'</a></p>
				<p>If you encounter any problems with activation contact us via: <a href="mailto:contact@northcode.no">contact@northcode.no</a></p>
		</body>
		</html>
		';
		
		$plainMessage = 'Dear '.$username.'\n\rThank you for registering at northcode.no!\n\rIn order to activate your account copy this link into your browser:\n\rhttp://northcode.no/scr/register.php?activate&id='.$code;

		send_mail($subject,$message,$plainMessage,$email,$username);
	}
}

header("Location: ../index.php");

/**/

?>