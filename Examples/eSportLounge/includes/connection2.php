<?php
require("constants.php");
// connect to the USERS table
// establish connection
$connection = mysql_connect(DB_SERVER,DB_USER,DB_PASS);
if (!$connection) {
	die("Database connection failed: " . mysql_error());
}

// connecting to the databaase name
$db_select = mysql_select_db(DB_NAME2,$connection);
if (!$db_select) {
	die("Database selection failed: " . mysql_error());
}

$con= mysqli_connect(DB_SERVER,DB_USER,DB_PASS);
if (!$con)
  {
  die('Could not connect: ' . mysqli_error());
  }
  //select db
mysqli_select_db($con, DB_NAME2);

//select the whole table
$sql = "SELECT * FROM Games
ORDER BY Live ASC";
$result = mysqli_query($con, $sql);


?>
