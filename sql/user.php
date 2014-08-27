<?php

include_once("connect.php");

class user
{
  public $id;
  public $name;

  public $bio;
  public $img;

  public $groups;
  public $titles;

  public $date_format;
  public $cur_format;

  public function _construct($id) {

    $uq = $mysql->prepare("CALL select_user(?);");
    $uq->bind_param($id);
    $uq->execute();
    $uq->bind_result($this->name,$this->bio,$this->img,$this->cur_format,$this->date_format,$titles_s,$groups_s);
    if($uq->num_rows > 0) {
      $uq->fetch();
      $uq->close();
    } else {
      $uq->close();
      throw new Exception("No user found for id: ".$id);
    }
  }
}

?>
