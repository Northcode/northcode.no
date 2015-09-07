<html>
	<head>
		<title>Northcode</title>
		<link href="css/bootstrap.min.css" rel="stylesheet" />
		<link href="css/main.css" rel="stylesheet" />
	</head>
	<body>
		<div id="wrapper">
			<?php include("header.php"); ?>
			<div id="content" class="container">
				<div class="col-md-8">
					<h5 class="graytext"><span class="red">user</span>@<span class="blue">northcode</span> $ <span class="green">cat</span> /dev/northcode | <span class="green">webpage</span></h5>
					<?php
					
					include_once("connect.php");
					
					$sql = $con->prepare("select *,date_format(posttime,'%d.%m.%Y') from blogposts order by posttime desc");
					$sql->execute();
					$sql->bind_result($id,$title,$post,$time,$timef);
					
					while($sql->fetch()) {
					?>
						
						<h3><?php echo $title; ?></h3>
						<p>
							<?php echo $post; ?>
						</p>
						<span style="color: #888;"><?php echo $timef; ?></span>
						<hr/>
					<?php }  ?>
				</div>
				<div class="col-md-4">
					
				</div>
			</div>

			<?php include("footer.php"); ?><
		</div>
		<script src="js/jq.js"></script>
		<script src="js/bootstrap.min.js"></script>
	</body>
</html>
