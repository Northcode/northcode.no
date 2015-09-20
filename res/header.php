<?php

error_reporting(E_ALL);
ini_set('display_errors', '1');
include_once($_SERVER['DOCUMENT_ROOT'] . "/res/mysql_connect.php");
?>

<div id="header">
  <div class="logo" style="text-align:center;">
    <img src="img/northcode.png" style="width:55%" />
  </div>
  <nav class="navbar navbar-default">
    <div class="container">
      <a class="navbar-toggle" data-target=".navbar-collapse" data-toggle="collapse">
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
      </a>
      <div class="collapse navbar-collapse">
        <ul class="nav navbar-nav">
          <li><a href="index.php">Home</a></li>
          <li class="dropdown">
            <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">Projects <span class="caret"></span></a>
            <ul class="dropdown-menu" role="menu">
              <?php



              $sql = $mysql->prepare("select id,name from projects");

              $sql->execute();
              $sql->bind_result($id,$name);

              while($sql->fetch()) {
                ?>
                <li><a href="showcase.php?id=<?php echo $id; ?>"><?php echo $name; ?></a></li>
                <?php
              }

              $sql->close();

              ?>
            </ul>
          </li>
          <!--<li class="dropdown">
            <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">servers <span class="caret"></span></a>
            <ul class="dropdown-menu" role="menu">
              <li><a href="server.php">northcode server</a></li>
            </ul>
          </li>-->
          <li>
            <a href="about.php">About Us</a>
          </li>
        </ul>
        <ul class="nav navbar-nav navbar-right">
          <li style="margin-right: 5px;"><button type="button" class="btn btn-primary navbar-btn">Login</button></li>
          <li><button href="register.php" type="button" class="btn btn-success navbar-btn" onclick="location.href='register.php';">Register</button></li>
        </ul>
      </div>
    </div>
  </nav>
</div>
