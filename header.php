<?php

error_reporting(E_ALL);
ini_set('display_errors', '1');

?>

<div id="header" class="container">
  <div style="text-align:center; margin-bottom: 30px;">
    <img src="northcode.png" style="width:55%" />
  </div>
  <nav class="navbar navbar-default">
    <a class="navbar-toggle" data-target=".navbar-collapse" data-toggle="collapse">
      <span class="icon-bar"></span>
      <span class="icon-bar"></span>
      <span class="icon-bar"></span>
    </a>
    <div class="collapse navbar-collapse">
      <ul class="nav navbar-nav">
        <li><a href="index.php">home</a></li>
        <li class="dropdown">
          <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">things we make <span class="caret"></span></a>
          <ul class="dropdown-menu" role="menu">
            <?php

            include_once("connect.php");

            $sql = $con->prepare("select id,name from projects");

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
        <li class="dropdown">
          <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">servers <span class="caret"></span></a>
          <ul class="dropdown-menu" role="menu">
            <li><a href="server.php">northcode server</a></li>
          </ul>
        </li>
        <li>
          <a href="about.php">about us</a>
        </li>
      </ul>
      <button type="button" class="btn btn-primary navbar-btn navbar-right">login</button>
    </div>
  </nav>
</div>
