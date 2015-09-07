<?php

/***
 * Connects to mysql database
 * Global variable $mysql is the connection
 ***/


require_once($_SERVER['DOCUMENT_ROOT'] . "/sec/mysql_authdata.php");

$mysql = new mysqli(
	$mysql_auth['server'],
	$mysql_auth['username'],
	$mysql_auth['password'],
	$mysql_auth['database']
);

