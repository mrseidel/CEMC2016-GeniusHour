<?php
require("constants.php");
// connect to the USERS table
// establish connection
$connection = mysqli_connect(DB_SERVER,DB_USER,DB_PASS);
if (!$connection) {
	die("Database connection failed: " . mysql_error());
}

// connecting to the databaase name

$db_select = mysqli_select_db($connection, DB_NAME2);
if (!$db_select) {
	die("Database selection failed: 2" . mysql_error());
}
?>
