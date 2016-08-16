<!-- Code to connect to mySQL -->

<?php
// <?php require_once("includes/connection.php") 
require("constants.php");
// connect to the USERS table
// establish connection
$connection = mysql_connect(DB_SERVER,DB_USER,DB_PASS);
if (!$connection) {
	die("Database connection failed: " . mysql_error());
}

// connecting to the databaase name
$db_select = mysql_select_db(DB_NAME,$connection);
if (!$db_select) {
	die("Database selection failed: " . mysql_error());
}
?>
