<!--<?php require_once("includes/session.php"); ?>
<?php require_once("includes/functions.php"); ?>
<?php confirm_logged_in(); ?>
<?php include("includes/header.php"); ?>
<head>
<link rel="stylesheet" type="text/css" href="style.css">
</head>
<div id = "wrapper">
	<div><?php include('includes/nav.php');?></div>
	<tr>
		<td id="navigation">
			&nbsp;
		</td>
		<td id="page">
			<h2>Staff Menu</h2>
			<p>ADMIN AREA, <?php echo $_SESSION['username']; //displays the username of the user connected?>.</p>
			<ul>
				<li><a href="includes/inserttourn.php">Insert Tournment</a></li>
				<li><a href="includes/insertgame.php">Insert Game</a></li>
				<li><a href="logout.php">Logout</a></li>
			</ul>
		</td>
	</tr>
</table> -->
<?php //include("includes/footer.php"); ?>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">

<head>

<meta http-equiv="content-type" content="text/html; charset=utf-8" />

<meta name="description" content="" />

<meta name="keywords" content="" />

<meta name="author" content="" />
<script src="http://code.jquery.com/jquery-1.10.1.min.js" type="text/javascript"></script>

<link rel="stylesheet" type="text/css" href="style.css" media="screen" />

<title>E-Sport Lounge</title>

</head>

	<body>
		<div id="wrapper">
		

			<div id="header">
			
			<div id="form">	
			<h2>Staff Login</h2>
			<?php if (!empty($message)) {echo "<p class=\"message\">" . $message . "</p>";} ?>
			<?php if (!empty($errors)) { display_errors($errors); } ?>
				<form action="login.php" method="post">
					<table>
						<tr>
									<td>Username:</td>
									<td><input type="text" name="username" maxlength="30" style="float:right;" value="<?php echo htmlentities($username); ?>" /></td>
						</tr>
						<tr>
									<td>Password:</td>
									<td><input type="password" name="password" maxlength="30" style="float:right;" value="<?php  echo htmlentities($password); ?>" /></td>
						</tr>
						<tr>
									<td colspan="2"><input type="submit" name="submit" style="float:right;" value="Login" /></td>
						</tr>
					</table>
							
				</form>
			</div>	

			<div id="logo">
				<a href="index.php">
					<img src="images/test.png" alt="Logo" style="float:left;"/>
				</a>
			
			</div>
		</div>
		
		<?php include('includes/nav.php'); //including the navigation bar ?>
		
		<div id="navigation">
			&nbsp;
		</div>
		<div id="page">
			<h2>Staff Menu</h2>
			<p>Welcome to the staff area, <?php echo $_SESSION['username']; //displays the username of the user connected?>, here you are able to add tournaments and matches to eSportLounge. What would you like to do?</p>
			<ul id="stafflist">
				<li><a href="includes/inserttourn.php">Insert Tournment</a></li>
				<!--<li>  |  </li> -->
				<li><a href="includes/insertgame.php">Insert Game</a></li>
				<!--<li>  |  </li> -->
				<li><a href="logout.php">Logout</a></li>
			</ul>
		</div>
</table>

<?php include("includes/footer.php"); ?>