<?php

//This file deals with voting

$id = $_POST['id'];
$action = $_POST['action'];



	if($action=='vote_up') //voting up
		{
		 $votes_up = $cur_votes[0]+1;
		 $q = "UPDATE entries SET votes_up = $votes_up WHERE id = $id";
		}
	elseif($action=='vote_down') //voting down
		{
		 $votes_down = $cur_votes[1]+1;
		 $q = "UPDATE entries SET votes_down = $votes_down WHERE id = $id";
		}
		
	$r = mysql_query($q);
	if($r) //voting done
		 {
		 $effectiveVote = getEffectiveVotes($id);
		 echo $effectiveVote." votes";
		 }
	elseif(!$r) //voting failed
		 {
		 echo "Failed!";
		 }
	 
 ?>