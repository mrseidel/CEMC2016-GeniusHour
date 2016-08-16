<?php ob_start(); ?>
<?php require_once("session.php"); ?>
<?php require_once("connection.php"); ?>
<?php require_once("functions.php"); ?>
<?php confirm_logged_in(); ?>
<?php

//The code required to send a game to the database

include('hostvar.php');

$insert= mysqli_connect($hostname,$username, $password, $dbname);
	if (!$insert)
	  {
	  die('Could not connect: ' . mysqli_error());
	  }
	  //saving the information from the form in inserttourn.php
	$team1 = $_POST['team1'];
	$team2 = $_POST['team2'];
	$tournment = $_POST['tournment']; // get tournament ID and insert ID of the tournament
	$live = $_POST['live'];


echo $tournment . ' ' . $team1 . ' ' . $team2 . ' ' . $live . "<br>";
	
//selecting DB
	$db_selected =  mysqli_select_db($insert, $dbname);
	  if (!db_selected){
			die('Can\'t use ' . eagle576_tournment. ': ' . mysqli_error());
			}

		  $sql2 = "INSERT INTO Games (IDTourn, Team1, Team2, Live) VALUES ('$tournment', '$team1', '$team2', '$live')";
 // inserting tournment information to tournments table

//quering sql2 into the database
if (mysqli_query($insert, $sql2))
		  {
		  echo "Info Inserted";
		  header('Location: http://www.esportlounge.com/staff.php');    
		  }
	else
		  {
		  echo "errorr bro: " . mysqli_error($insert);
		  }
		  		  
		 

mysqli_close($insert);//close connection 




?>