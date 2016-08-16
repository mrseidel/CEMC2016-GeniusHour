<?php require_once("session.php"); ?>
<?php #require_once("connection.php"); ?>
<?php require_once("functions.php"); ?>
<?php confirm_logged_in(); ?>

<!-- This page is called when a game is inserted. -->

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">

<head>

<meta http-equiv="content-type" content="text/html; charset=utf-8" />

<meta name="description" content="" />

<meta name="keywords" content="" />

<meta name="author" content="" />

<link rel="stylesheet" type="text/css" href="style.css" media="screen" />

<title>Send Event</title>
<?php
$dbname = 'eagle576_tournment';
$connection = mysql_connect("sqldatabase.esportlounge.com", "eagle576_match", "abdulhadi123");
if (!$connection) {
	die("Database connection failed: " . mysql_error());
}

// 2. Select a database to use 
$db_select = mysql_select_db("eagle576_tournment",$connection);
if (!$db_select) {
	die("Database selection failed: " . mysql_error());
}
/*
	if (!mysql_connect("sqldatabase.esportlounge.com", "eagle576_match", "abdulhadi123")) {
			echo 'Could not connect to mysql';
			exit;
		}

	#$db_select = mysql_select_db("eagle576_tournment",$connection);*/
	$sql = "SELECT * FROM Tournments";
	$result = mysql_query($sql);

	if (!$result) {
		echo "DB Error, could not list tables\n" . $db_select;
		echo 'MySQL Error: ' . mysql_error();
		exit;
	}
?>

</head>

	<body>

		<div id = "wrapper">
			Send Event
				<ul>			
					<form method="post" action="sendgame.php">
					<li>Team 1: <input type ="text" size="12" maxlength="36" name="team1" /></li>
					<li>Team 2: <input type ="text" size="12" maxlength="36" name="team2" /></li>				
    				<li>Live(YY-MM-DD HR:MM:SS): <input type ="text" size="12" maxlength="36" name="live" /></li>					

				<li>
					<select name="tournment"></li>
					<?PHP
					while ($row = mysql_fetch_row($result)) {
							echo "<option value=\"$row[0]\">$row[0]-$row[2]</option>";

							}
					?>	
					</li>
						<li><input type="submit" value="submit" name="submit"></li>
					</form>
				</ul>
		</div>
		
	</body>

</html>
