<?php

ini_set('display_errors',1);
ini_set('display_startup_errors',1);
error_reporting(-1);

//require_once("lib/northcode.php");
require_once("res/mysql_connect.php");
require_once("lib/project.php");

echo '<pre>';

$p = new Project(1);

var_dump($p);



echo '</pre>';