<!-- This page displays tournament info when coming from the home page. -->

<?php

//get the id sent from the url
$id = $_GET["id"];

include("../includes/constants.php");
$con= mysqli_connect(DB_SERVER, DB_USER, DB_PASS);
if (!$con)
  {
  die('Could not connect: ' . mysqli_error());
  }
  //select db
mysqli_select_db($con, DB_NAME2);
$sql = "SELECT * FROM Tournments WHERE ID = $id";
$sql2 = "SELECT * FROM Games WHERE IDTourn = $id";
$tournament = mysqli_query($con, $sql);


$row = mysqli_fetch_array($tournament);




$games = mysqli_query($con, $sql2);
//echo mysqli_fetch_array($games);



//header(Location: http://esportlounge.com/Templates/tournament.php?id=$id)\"
?>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">

<head>

<meta http-equiv="content-type" content="text/html; charset=utf-8" />

<meta name="description" content="" />

<meta name="keywords" content="" />

<meta name="author" content="" />
<script src="http://code.jquery.com/jquery-1.10.1.min.js" type="text/javascript"></script>

<link rel="stylesheet" type="text/css" href="style.css" media="screen" />

<title>eSportLounge</title>

</head>

	<body>
		<div id="wrapper">
		

			<div id="header">
			
			<!-- Login section -->
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
					<img src="http://esportlounge.com/images/test.png" alt="Logo" style="float:left;"/>
				</a>
			
			</div>
		</div>
		
		<?php include('../includes/nav.php'); //including the navigation bar ?>

	


		<!-- Information associated with the tournament -->
		<section class="games">
			<?php $url = $row['URL'];// url to use the picture for the tournament
			$name = $row['Name']; //we get the name of the tournaments in an array ?>
			<div id="tournament-banner">
			<img src="<?php echo $url; ?>"> </img>
			</div>
			<div class="left-games">
				<h1> <?php echo $name;?> </h1>
				<?php
				$description = $row['Description'];

				$game = $row['Game']; // we get the name of the game of each tournament
				$prizepool = $row['Prize']
				?>
				
				<div id="description">
					<p> Game: <?php echo $game; ?></p>
					<p> Prize Pool: <?php echo $prizepool; ?></p>
					<p> Description: <?php echo $description; ?> </p>
					
					
					
				</div>
						
			</div>
			
			<!-- The upcoming matches associated with the tournament -->
			<div class="right-tournaments">
				<h1>Matches</h1>
				
			<?php
			//listing games from the database
			// connects to the db
			//display games
		

		
				while($gamerow = mysqli_fetch_array($games)) {
						$gameid = $gamerow['ID'];
						$team1 = $gamerow['Team1']; //we get the name of the tournaments in an array
						$team2 = $gamerow['Team2']; // we get the name of the game of each tournament
						$live = $gamerow['Live']; // url to use the picture for the tournament
					echo"<ul> <li>"	. $gameid . "</li>"	. "<li>"	. $team1 . "</li>" . "<li>"	. $team2 . "</li>" . "<li>"	. $live . "</li>" . "</ul>";
							
				}
				
				
				
				mysqli_close($con);
					?>
			 </div>
			</section>


	<!--		<section class="games"> -->
	<!--	</section> -->

			
	<?php include('../includes/footer.php'); ?>
 	</body>

</html>