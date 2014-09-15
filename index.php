<!DOCTYPE html>
<html>
  <head>
    <title>Northcode</title>
    <link href="bs/css/bootstrap.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="css/main.css" media="screen" title="no title" charset="utf-8" />
    <style>
    body {
      background-color: #f9f9f9 !important;
    }
    </style>
  </head>
  <body>
    <div style="margin-top: 150px;"></div>
    <div class="container">
      <img src="northcode<?php /* pick random logo */ $r = rand(0,2); echo ($r > 0.5 ? "_red" : ""); ?>.png" alt="logo" class="img-center" />
    </div>
    <div class="pad-2"></div>
    <header class="navbar navbar-default" style="width: 70%; margin-left: auto; margin-right: auto; //box-shadow: 0px 0px 10px 2px #888;">
      <div class="container-fluid">
        <a class="navbar-brand">Northcode</a>
        <div class="navbar-header">
          <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#nav-main-nav">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <div class="collapse navbar-collapse" id="nav-main-nav">
            <ul class="nav navbar-nav">
              <li class="active"><a href="#">Home</a></li>
              <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown">Projects <span class="caret"></span></a>
                <ul class="dropdown-menu" role="menu">
                  <li><a href="http://www.cobaltvault.no">Cobalt Vault</a>
                </ul>
              </li>
              <li><a href="#">Link</a></li>
              <li><a href="#">Link</a></li>
              <li><a href="#">Link</a></li>
              <li><a href="#">Link</a></li>
            </ul>
          </div>
        </div>
      </div>
    </header>

    <div class="pad-4"> </div>

    <div class="container">
      <div class="col-md-8">
        <h1>SOME STUFF HERE</h1>
        <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer nec odio. Praesent libero. Sed cursus ante dapibus diam. Sed nisi. Nulla quis sem at nibh elementum imperdiet. Duis sagittis ipsum. Praesent mauris. Fusce nec tellus sed augue semper porta. Mauris massa. Vestibulum lacinia arcu eget nulla. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. </p>
        <p>Curabitur sodales ligula in libero. Sed dignissim lacinia nunc. Curabitur tortor. Pellentesque nibh. Aenean quam. In scelerisque sem at dolor. Maecenas mattis. Sed convallis tristique sem. Proin ut ligula vel nunc egestas porttitor. Morbi lectus risus, iaculis vel, suscipit quis, luctus non, massa. Fusce ac turpis quis ligula lacinia aliquet. </p>
        <p>Mauris ipsum. Nulla metus metus, ullamcorper vel, tincidunt sed, euismod in, nibh. Quisque volutpat condimentum velit. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Nam nec ante. Sed lacinia, urna non tincidunt mattis, tortor neque adipiscing diam, a cursus ipsum ante quis turpis. Nulla facilisi. Ut fringilla. Suspendisse potenti. Nunc feugiat mi a tellus consequat imperdiet. Vestibulum sapien. Proin quam. Etiam ultrices. Suspendisse in justo eu magna luctus suscipit. </p>
      </div>
      <div class="col-md-4">
        <h2>SMALLER STUFF HERE!</h2>
        <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer nec odio. Praesent libero. Sed cursus ante dapibus diam. Sed nisi. Nulla quis sem at nibh elementum imperdiet. Duis sagittis ipsum. Praesent mauris. Fusce nec tellus sed augue semper porta. Mauris massa. Vestibulum lacinia arcu eget nulla. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. </p>
        <p>Curabitur sodales ligula in libero. Sed dignissim lacinia nunc. Curabitur tortor. Pellentesque nibh. Aenean quam. In scelerisque sem at dolor. Maecenas mattis. Sed convallis tristique sem. Proin ut ligula vel nunc egestas porttitor. Morbi lectus risus, iaculis vel, suscipit quis, luctus non, massa. Fusce ac turpis quis ligula lacinia aliquet. </p>
        <p>Mauris ipsum. Nulla metus metus, ullamcorper vel, tincidunt sed, euismod in, nibh. Quisque volutpat condimentum velit. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Nam nec ante. Sed lacinia, urna non tincidunt mattis, tortor neque adipiscing diam, a cursus ipsum ante quis turpis. Nulla facilisi. Ut fringilla. Suspendisse potenti. Nunc feugiat mi a tellus consequat imperdiet. Vestibulum sapien. Proin quam. Etiam ultrices. Suspendisse in justo eu magna luctus suscipit. </p>
      </div>
    </div>

    <!-- LOAD SCRIPTS -->
    <script src="js/jq.js"></script>
    <script src="bs/js/bootstrap.min.js"></script>
  </body>
</html>
