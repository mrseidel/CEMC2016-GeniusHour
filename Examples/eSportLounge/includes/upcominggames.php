<!-- This file is the backbone for the Upcoming Matches webpage.  It shows all matches that are not yet in progress. -->

<?php require_once("functions.php"); ?>
<?php //require_once("gameconnection.php"); ?>
<html>
	<head>
		<title>Upcoming Matches</title>
		<script src="http://code.jquery.com/jquery-1.10.1.min.js"></script>
		
	</head>
	<body>

	<div> <!--class="events"-->
		<div id="content">
		<?php
	
		$counter = 0;
		$result = connectGames();
		while($row = mysqli_fetch_array($result)) { // assign each row to the array $row using mysqli_fetch_array
			// assign the values from mysql in $result (array) to variables
			$id = $row['ID'];
			$timelive = $row['Live']; //we get the name of the tournaments in an array
			$team1 = $row['Team1'];
			$team2 = $row['Team2'];
			$team1votes = $row['team1votes'];
			$team2votes = $row['team2votes'];
			$winner = $row['winner'];
			$gameTime = strtotime($timelive);
			$currentTime = strtotime("now");
			
			//if the match has not passed, display it on the webpage
			if($gameTime > $currentTime){
				$timeleft = checkTime($gameTime);
				$votes = currentVotes($team1votes, $team2votes);
				//echo "<p>" . $timeleft . " " . </br> . $votes[0] . "%" . " " . $team1 . " " . vs . " " . $votes[1] . "%" . " " . $team2 . "</p>";
				echo "<div class=\"indiv_games_timeleft\"> $timeleft </div>";
				echo "<div class=\"indiv_games\">";				
				echo "<span style=\"font-size: 16px;\"><strong><u>$team1 vs. $team2 </u></strong></span></br>";
				echo "Vote for who will win. </br>";
				?>
				 <span class='vote_buttons' id='vote_buttons<?php echo $id; ?>'>
				  <a href='javascript:;' class='vote_up' id='<?php echo $id; ?>'></a>
				  <a href='javascript:;' class='vote_down' id='<?php echo $id; ?>'></a>
				 </span>
				 <?php
				//if there is no winner, display the votes for both teams
				if($winner == 0) {
						echo $team1 . " (currently " . $votes[0] . "%): </br>";
						echo $team2 . " (currently " . $votes[1] . "%): </br>";
				}
				//team one won the match
				if($winner == 1) {
					$winnerTeam = $team1;
					echo "The game is over... " . $winnerTeam . " won </br>";
				}
				//team one won the match
				if($winner == 2) {
					$winnerTeam = $team2;
					echo "The game is over... " . $winnerTeam . " won </br>";
				}
				echo "</div>";
				
				++$counter;
			}
			else {continue;}
			
			//display up to 10 matches
			if($counter == 10) {break;}
			
		}
		?>		
		</div>
	</div>
	
			<script> $(function(){
				$("a.vote_up").click(function(){
				 //get the id
				 the_id = $(this).attr('id');
				 
				 // show the spinner
				 $(this).parent().html("<img src='images/spinner.gif'/>");
				 
				 //fadeout the vote-count 
				 $("span#votes_count"+the_id).fadeOut("fast");
				 
				 //the main ajax request
				  $.ajax({
				   type: "POST",
				   data: "action=vote_up&id="+$(this).attr("id"),
				   url: "votes.php",
				   success: function(msg)
				   {
				    $("span#votes_count"+the_id).html(msg);
				    //fadein the vote count
				    $("span#votes_count"+the_id).fadeIn();
				    //remove the spinner
				    $("span#vote_buttons"+the_id).remove();
				   }
				  });
				 });
				});
		</script>

		<script>
		$("a.vote_down").click(function(){
			 //get the id
			 the_id = $(this).attr('id');
			 
			 // show the spinner
			 $(this).parent().html("<img src='images/spinner.gif'/>");
			 
			 //the main ajax request
			  $.ajax({
			   type: "POST",
			   data: "action=vote_down&id="+$(this).attr("id"),
			   url: "votes.php",
			   success: function(msg)
			   {
			    $("span#votes_count"+the_id).fadeOut();
			    $("span#votes_count"+the_id).html(msg);
			    $("span#votes_count"+the_id).fadeIn();
			    $("span#vote_buttons"+the_id).remove();
			   }
			  });
			 });
	
		
		</script>
		
	</body>
</html>