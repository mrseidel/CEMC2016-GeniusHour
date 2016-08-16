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

	


		
		<section class="games">
			<div class="left-games">
				<h1>Upcoming Games</h1>
			<?php include('includes/upcominggames.php'); ?>
			</div>
			
			<div class="right-tournaments">
				<h1>Current Tournaments</h1>
				
			<?php
			//listing games from the database
			// connects to the db
			include('includes/tournments.php');
			//display games
			$counter = 0;
				while($row = mysqli_fetch_array($result)) { // mysqli_fetch_array is a built in function that fetches an array of each row 
					++$counter;
						$id = $row['ID'];
						$name = $row['Name']; //we get the name of the tournaments in an array
						$game = $row['Game']; // we get the name of the game of each tournament
						$url = $row['URL']; // url to use the picture for the tournament

						echo "<div class=\"events\". >"; // echoing the contents of the arrray
						echo"<div id=\"content\". >";
						echo"<a href=\"http://esportlounge.com/Templates/tournament.php?id=$id\"><img src=\"$url\" border=\"0\" alt=\"$name\" width=\"100%\" height\"100%\" ></a> ";
						echo"<p> $name </p>";
						echo"</div>";
						echo"</div>";
						
						if($counter == 15){
						break;
							}
						
						}
					?>
			 </div>
			</section>


		<section class="streams">
			<h1><span style="color: #B0B0B0">Live Streams</span></hi>
			<?php include('includes/streams.php'); ?>
			<div class="dota-streams">
					<h4>Dota Streams</h4>
				<?php 
					$streamdota = file_get_contents('https://api.twitch.tv/kraken/streams?game=Dota+2&limit=3&emeddable=true'); 
					$streamdota = json_decode($streamdota, true);
					$streamdota = DotaStreams($streamdota);
					
					foreach($streamdota as $stream){
						$stream = get_object_vars($stream);
						echo"<div class=\"streams_horiz_line\"";
						//echo"<div id=\"live\">"; 
						
							echo "<span id=\"stream\">";
								echo "<a href=" . $stream['url'] . ">";
								echo "<img style=\"border: 2px solid #282828\" src=" . $stream['preview'] . "</img>";
								echo "<p>" . $stream['name'] . "</p>";
								echo "<p>" . "<img src=\"images/icon_eye_16.png\"> " . $stream['viewers'] . "</img></p>";
								echo "</a>";
							echo "</span>";
						
						//echo "</div>";
						echo"</div>";
					
					}
				?>
			</div>
			<div class="league-streams">
				<h4>LoL Streams</h4>
				<?php 
					$streamlol = file_get_contents('https://api.twitch.tv/kraken/streams?game=League+of+Legends&limit=3&emeddable=true'); 
					$streamlol = json_decode($streamlol, true);
					$streamlol  = LeagueStreams($streamlol);
					//print_r($streamlol);
					
					foreach($streamlol as $stream){
						$stream = get_object_vars($stream);
						echo"<div class=\"streams_horiz_line\"";
						//echo"<div id=\"live\">"; 
						
							echo "<span id=\"stream\">";
								echo "<a href=" . $stream['url'] . ">";
								echo "<img style=\"border: 2px solid #282828\" src=" . $stream['preview'] . "</img>";
								echo "<p>" . $stream['name'] . "</p>";
								echo "<p>" . "<img src=\"images/icon_eye_16.png\"> " . $stream['viewers'] . "</img></p>";
								echo "</a>";
							echo "</span>";
						//echo "</div>";
						echo "</div>";
					}
					
				?>
			</div>
			<div class="starcraft-streams">
				<h4>SC II Streams</h4>
				<?php 
					$streamsc2 = file_get_contents('https://api.twitch.tv/kraken/streams?game=StarCraft+II:+Heart+of+the+Swarm&limit=3&emeddable=true'); 
					$streamsc2 = json_decode($streamsc2, true);
					$streamsc2 = StarcraftStreams($streamsc2);
					//print_r($streamsc2);
					
					foreach($streamsc2 as $stream){
						$stream = get_object_vars($stream);
						echo"<div class=\"streams_horiz_line\"";
						//echo"<div id=\"live\">"; 
						
							echo "<span id=\"stream\">";
								echo "<a href=" . $stream['url'] . ">";
								echo "<img style=\"border: 2px solid #282828\" src=" . $stream['preview'] . "</img>";
								echo "<p>" . $stream['name'] . "</p>";
								echo "<p>" . "<img src=\"images/icon_eye_16.png\"> " . $stream['viewers'] . "</img></p>";
								echo "</a>";
							echo "</span>";
						
						//echo "</div>";
						echo "</div>";
					}
				
				?>
			</div>
		</section>

	<!--		<section class="games"> -->
	<!--	</section> -->

			
	<?php include('includes/footer.php'); ?>
<?// TWITCH TV INFOOOO
/*

 * Redirect url = http://www.esportlounge.com/authorization
 * Client ID = p7wg9ossdthunu7ymx6dimfattwon49
 *
 * 
 */
?>
 	</body>

</html>