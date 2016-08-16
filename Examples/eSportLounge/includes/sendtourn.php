<!-- This file contains the code required to save tournaments sent from the website into the database -->

<?php ob_start(); ?>
<?php require_once("session.php"); ?>
<?php require_once("connection.php"); ?>
<?php require_once("functions.php"); ?>
<?php confirm_logged_in(); ?>
<?php

//This file sends tournaments to the database

include('hostvar.php');
// connecting to the database
$insert= mysqli_connect($hostname, $username, $password, $dbname);
	if (!$insert)
	  {
	  die('Could not connect: ' . mysqli_error());
	  }
 
 // saving the info from the form in inserttourn.php
 	$game= $_POST['game'];
	$name= $_POST['name'];
	$description = $_POST['description'];
	$prize = $_POST['prize'];
	$url = $_POST['url'];

	

	
// selecting DB
	$db_selected =  mysqli_select_db($insert, $dbname);
	  if (!db_selected){
			die('Can\'t use ' . eagle576_tournment. ': ' . mysqli_error());
			}
		  // saving the Query of the information in an variable
		  $sql = "INSERT INTO Tournaments (Game, Name, Description, Prize, URL) VALUES ('$game', '$name', '$description', '$prize', '$url')";
 // inserting tournament information to tournaments table
if (mysqli_query($insert, $sql))
		  {
		  echo "Info Inserted";
		  create_tournament_pages($game, $name, $description, $prize, $url);
		  }
	else
		  {
		  echo "errorr bro: " . mysqli_error($insert);
		  }

mysqli_close($insert);
 

header('Location: http://www.esportlounge.com/staff.php');      

?>