<?php

if(!isset($_GET['id'])) {
	header("Location: errornoproject.php");
}

include_once("res/mysql_connect.php");

?>
<html>
	<head>
		<title>Project</title>
		<?php include($_SERVER['DOCUMENT_ROOT'] . "/res/meta.php"); ?>
	</head>
	<body>
		<div id="wrapper" style="margin-top: -120px;">
			<?php include("res/header.php"); ?>

			<div class="container" id="content">
				<?php
				$sql = $mysql->prepare("select id,`name`,`desc`,created,git_repo from projects where id = ?");
				$sql->bind_param('i',$_GET['id']);
				$sql->execute();
				$sql->bind_result($id,$name,$desc,$created,$gitlink);
				$sql->fetch();
				?>
				<div class="col-md-8">
					
				</div>
				<div class="col-md-4 right-sidebar">
					<p><?php echo $desc; ?></p>
					<a href="<?php echo $gitlink ?>">github link</a>
				</div>
			</div>
			
			<?php include("res/footer.php"); ?>
		</div>
	</body>
</html>
