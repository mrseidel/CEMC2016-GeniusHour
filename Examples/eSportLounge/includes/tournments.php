<!-- This file is the backbone for the Tournaments webpage. -->

<?php
//attempt to connect the database
$con= mysqli_connect("sqldatabase.esportlounge.com", "eagle576_match", "abdulhadi123");
if (!$con) //if connection fails, display an error
  {
  die('Could not connect: ' . mysqli_error()); 
  }
  //select db
mysqli_select_db($con, "eagle576_tournment"); //otherwise select the tournaments to be displayed

//select the whole table
$sql = "SELECT * FROM Tournments";
$result = mysqli_query($con, $sql);

?>