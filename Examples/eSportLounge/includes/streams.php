<!-- This file contains the function, classes, and code required to display live streams from twith.tv -->

<?php

class Streams{
	
	//creates a Streams object
	function __construct($name, $game, $url, $status, $viewers, $preview){
		$this->name = $name;
		$this->game = $game;
		$this->url = $url;
		$this->status = $status;
		$this->viewers = $viewers;
		$this->preview = $preview;
		
	}
	
	
}

/*
$streamdota = file_get_contents('https://api.twitch.tv/kraken/streams?game=Dota+2&limit=5&emeddable=true');
$streamlol = file_get_contents('https://api.twitch.tv/kraken/streams?game=League+of+Legends&limit=5&emeddable=true');
$streamsc2 = file_get_contents('https://api.twitch.tv/kraken/streams?game=StarCraft+II:+Heart+of+the+Swarm&limit=5&emeddable=true');
*/
//print_r($streamdota);

//echo $streamdota['streams'][0]['viewers'];





function DotaStreams($streamdota){ // JSON DECODED 

$streamdotaarr = Array();
	
	foreach($streamdota['streams'] as $stream){
		//print_r($stream);
		
		$stream = new Streams($stream['channel']['display_name'], $stream['game'], $stream['channel']['url'], $stream['channel']['status'], $stream['viewers'], $stream['preview']['small']);
		array_push($streamdotaarr, $stream);
		
	}
	
	Return $streamdotaarr;
	
}


function StarcraftStreams($streamsc2){

$streamsc2arr = Array();
	foreach($streamsc2['streams'] as $stream){
		//print_r($stream);
		
		$stream = new Streams($stream['channel']['display_name'], $stream['game'], $stream['channel']['url'], $stream['channel']['status'], $stream['viewers'], $stream['preview']['small']);
		array_push($streamsc2arr, $stream);
		
	}
	Return $streamsc2arr;
}

function LeagueStreams($streamlol){
	
$streamlolarr = Array();
	
	foreach($streamlol['streams'] as $stream){
		//print_r($stream);
		
		$stream = new Streams($stream['channel']['display_name'], $stream['game'], $stream['channel']['url'], $stream['channel']['status'], $stream['viewers'], $stream['preview']['small']);
		array_push($streamlolarr, $stream);
		
	}
	Return $streamlolarr;
}


?>