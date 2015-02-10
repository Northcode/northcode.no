<?php

if(!isset($_GET['id'])) {
  header("Location: errornoproject.php");
}

include_once("connect.php");

?>
<html>
<head>
  <title>Project</title>
  <link href="css/bootstrap.min.css" rel="stylesheet" />
  <link href="css/main.css" rel="stylesheet" />
</head>
<body>
  <div id="wrapper">
    <?php include("header.php"); ?>

    <div class="container" id="content">
      <?php
      $sql = $con->prepare("select * from projects where id = ?");
      $sql->bind_param('i',$_GET['id']);
      $sql->execute();
      $sql->bind_result($id,$name,$about,$lastupdate,$gitlink);
      $sql->fetch();
      ?>
      <div class="col-md-8">
        <span style="color: #888;"><?php echo $lastupdate; ?></span>
        <?php echo $about; ?>
      </div>
      <div class="col-md-4">
        <h3>Actions</h3>
        <a class="btn btn-default" href="<?php echo $gitlink; ?>">View</a><br/><br/>
      </div>
    </div>

    <?php include("footer.php"); ?>
  </div>
  <script src="js/jq.js"></script>
  <script src="js/bootstrap.min.js"></script>
</body>
</html>
