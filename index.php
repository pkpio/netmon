<?php
/**
* Author  : Praven Kumar Pendyala
* Created : Aug 01 2014*
* Comments: Well just a very basic script to let you check the internet
*           monitoring log from any device on the network. I use a router
*           so, this comes handy for me as I run my logging on a Raspberry Pi
*           or BeagleBone (which ever is free at that time)
*           
*/

header('Content-Type: text/plain');

// Edit this path to your log file
$file = '/home/netmon/log';

if (file_exists($file)){
	readfile($file);
} 
else{
	echo 'file not found :(';
}
?>
