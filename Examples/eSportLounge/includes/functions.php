<?php
require_once("constants.php");
	// This file is the place to store all basic functions

	function mysql_prep( $value ) {
		$magic_quotes_active = get_magic_quotes_gpc();
		$new_enough_php = function_exists( "mysql_real_escape_string" ); // i.e. PHP >= v4.3.0
		if( $new_enough_php ) { // PHP v4.3.0 or higher
			// undo any magic quote effects so mysql_real_escape_string can do the work
			if( $magic_quotes_active ) { $value = stripslashes( $value ); }
			$value = mysql_real_escape_string( $value );
		} else { // before PHP v4.3.0
			// if magic quotes aren't already on then add slashes manually
			if( !$magic_quotes_active ) { $value = addslashes( $value ); }
			// if magic quotes are active, then the slashes already exist
		}
		return $value;
	}
	
	/**
	* This function creates the individual pages needed for the tournaments
	*/
	function create_tournament_pages($game, $name, $description, $prize, $url){
		
		$tempstring = "<body>\n
			<p>This is a template for tournaments</p>\n
			<p>&nbsp;</p>\n
			<p>Game: $game</p>\n
			<p>Name: $name</p>\n
			<p>Description: $description</p>\n
			<p>Prize:$prize</p>\n
			<p>URL:$url</p>\n
			</body>\n
			</html>
			";
		$file = fopen("tournaments/$name-$game.html","w");
		fwrite($file,$tempstring);
		fclose($file);
		
	}

	//redirects the page to another location (used for redirecting to staff and login pages)
	function redirect_to($location = NULL) {
		if ($location != NULL) {
			header("Location: {$location}");
			exit;
		}
	}

	function confirm_query($result_set) {
		if (!$result_set) {
			die("Database query failed: " . mysql_error());
		}
	}
	
	//sorts games based on their live time
	function sortGamesByTime(Array $live){
		
		$currentTime = new DateTime(); //save current time
		foreach ($live as $countDown){
			  		$interval = $currentTime->diff($countDown); // use diff function to get the difference
					echo $interval->format('%d days %h hours %i minutes'); //format the time into a readable format
			  } 

	}
	
	//takes in $gametime (unix timestamp) and returns a countdown of when the game will be live
	function checkTime($gameTime){
			$currentTime = strtotime("now");
			$interval = round(($gameTime - $currentTime)/3600);
			if ($interval >= 1 and $interval <= 24) {
				return $interval . "Hours away";
			}
			elseif ($interval < 1) {
				$interval = $interval * 60;
				return $interval . "Minutes away";
			}
			elseif ($interval > 24){
				$interval = round($interval / 24);
				return $interval . " days away";
			}
	}
	
	//connects to games database
	function connectGames(){
		
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
		
		return $result;
	}
	
	//returns the vote for both teams for a match ($votes is an array)
	function currentVotes($team1votes, $team2votes) {
		$total = $team1votes + $team2votes;
		if($total !=0) {
			$team1percent = round((($team1votes / $total) * 100));
			$team2percent = round((($team2votes / $total) * 100));
			$votes[0] = $team1percent;
			$votes[1] = $team2percent;
			return $votes;
		}
		
		else {
			$votes[0] = 0;
			$votes[1] = 0;
			return $votes;
		}
	}
	
	//converts a unix timestamp to a formatted date defined by $dateString
	function unix_to_date($timestamp, $dateString) {
		$formattedDate = date($dateString, $timestamp);
		return $formattedDate;
	}
	
	

?>