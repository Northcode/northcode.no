<?php

require_once($_SERVER['DOCUMENT_ROOT'] . "/lib/PHPMailer/PHPMailerAutoload.php");
require_once($_SERVER['DOCUMENT_ROOT'] . "/sec/mail_authdata.php");


function send_mail($subject, $message, $plainText, $toAddress, $toName, $fromName = "Contact@Northcode")
{
	$mail = new PHPMailer();

	$mail->IsSMTP();
	$mail->CharSet = "UTF-8";
	$mail->Host = MailAuth::$host;
	$mail->SMTPAuth = true;
	$mail->Username = MailAuth::$username;
	$mail->Password = MailAuth::$password;
	$mail->SMTPDebug = 0;

	$mail->From = "contact@northcode.no";
	$mail->FromName = $fromName;
	$mail->addAddress($toAddress,$toName);
	$mail->addReplyTo("contact@northcode.no");

	$mail->IsHTML(true);

	$mail->Subject = $subject;
	$mail->Body = $message;
	$mail->AltBody = $plainText;

	$mail->send();
}