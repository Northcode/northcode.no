<?php

ini_set('display_errors',1);
ini_set('display_startup_errors',1);
error_reporting(-1);

if(!isset($_GET['id'])) {
	header("Location: errornoproject.php");
}

require_once($_SERVER['DOCUMENT_ROOT'] . "/res/mysql_connect.php");
require_once($_SERVER['DOCUMENT_ROOT'] . "/lib/project.php");

$P = new Project($_GET['id']);


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
				<div class="col-md-9">
					<h1><?php echo $P->name; ?><br><small><?php echo $P->desc; ?></small></h1>
					<?php 
					if(sizeof($P->tabs) == 1) {
						echo $P->tabs[0]->content;
					} else { ?>
					<ul class="nav nav-tabs" role="tablist">
						<?php $firsttab = 1; foreach ($P->tabs as $tab) { ?>
						<li role="presentation" <?php if($firsttab) { echo 'class="active"'; $firsttab = 0; } ?>><a href="#<?php echo $tab->id; ?>" aria-controls="<?php echo $tab->title; ?>" role="tab" data-toggle="tab"><?php echo $tab->title; ?></a></li>
						<?php } ?>
					</ul>

					<div class="tab-content">
						<?php $firstpane = 1; foreach($P->tabs as $tab) { ?>
							<div role="tabpanel" class="tab-pane <?php if($firstpane) { echo 'active'; $firstpane = 0; } ?>" id="echo $tab->id"><?php echo $tab->content; ?></div>
						<?php } ?>
					</div>
					<?php } ?>
				</div>
				<div class="col-md-3 right-sidebar">
					<h1>Info</h1>
					<a class="btn btn-primary btn-block" href="<?php echo $P->git_repo; ?>">GitHub</a>
					<h2>Contributors</h2>
					<ul class="list-group">
						<?php foreach($P->users as $user) { ?>
						<li class="list-group-item"><?php echo $user->user["username"]; ?></li>
						<?php } ?>
					</ul>
				</div>
			</div>
			
			<?php include("res/footer.php"); ?>
		</div>
	</body>
</html>
