<?php require_once("session.php"); ?>
<?php require_once("connection.php"); ?>
<?php require_once("functions.php"); ?>
<?php confirm_logged_in(); ?>

<!-- This page is called when a tournament is inserted. -->

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">

<head>

<meta http-equiv="content-type" content="text/html; charset=utf-8" />

<meta name="description" content="" />

<meta name="keywords" content="" />

<meta name="author" content="" />

<link rel="stylesheet" type="text/css" href="style.css" media="screen" />

<title>Send Event</title>

</head>

	<body>

		<div id = "wrapper">
			Send Event
		
			<form method="post" action="sendtourn.php"> 
				<ul>	
						<li>Tournment Name: <input type ="text" name="name" /></li>
						<li> Game: <input type ="text" name="game" /></li>
						<li>Description of the tournament: </li></br>
						<textarea rows="15" cols="60" name="description"></textarea></br>						
						<li> Prize pool: <input type ="text" name="prize" /></li>
						<li> URL of picture: <input type ="text" size="12" maxlength="300" name="url" /></li>
						<li><input type="submit" value="submit" name="submit"></li>
				</ul>			
			</form>
	
		</div>
	</body>

</html>
