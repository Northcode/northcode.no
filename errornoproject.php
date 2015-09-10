<html>
<head>
  <title>Server</title>
  <link href="/css/bootstrap.min.css" rel="stylesheet" />
  <link href="/css/main.css" rel="stylesheet" />
</head>
<body>
  <div id="wrapper">
    <?php include("res/header.php"); ?>

    <div id="content" class="container">
      <h1>Project not found</h1>
      <p style="color: #D00;">The requested project was not found!</p>
    </div>

    <?php include($_SERVER['DOCUMENT_ROOT'] . "/res/footer.php"); ?>
  </div>
  <script src="/js/jq.js"></script>
  <script src="/js/bootstrap.min.js"></script>
</body>
</html>
