<?php

include "slideshow.php";

for ( $i=0; $i<3; $i++ ){
	$slideshow[ 'slide' ][ $i ] = array ( 'url' => "images/plant$i.jpg" );
}




$slideshow [ 'control' ][ 'bar_visible' ] = "on";
$slideshow[ 'slide' ][ 0 ] = array ( 'url' => "http://esportlounge.com/images/slideshow/blue.jpg" );
$slideshow[ 'slide' ][ 1 ] = array ( 'url' => "http://esportlounge.com/images/slideshow/ftp.png" );
$slideshow[ 'slide' ][ 2 ] = array ( 'url' => "http://esportlounge.com/images/slideshow/ftp-click.jpg" );
Send_Slideshow_Data ( $slideshow );

?>