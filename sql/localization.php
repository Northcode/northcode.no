<?php
include_once("connect.php");

function format_date($date, $format) {
  $tq = $mysql->prepare("SELECT DATE_FORMAT(?,?);");
  $tq->bind_param($date,$format);
  $tq->execute();
  $tq->bind_result($formated);
  $tq->fetch();
  $tq->close();
  return $formated;
}

?>
