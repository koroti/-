<?php
error_reporting(E_ALL ^ (E_NOTICE | E_WARNING));
date_default_timezone_set('Asia/Shanghai');
$id = $_COOKIE['id'];
$user = $_COOKIE['user'];
if (isset($_GET['cid'])) {
	setcookie('cid',$_GET['cid'],time()+3600);
	$url="location:$user"."course".'Record.php';
	header($url);
	
} else {
	$url="location:$user".'Record.php';
	header($url);
}
?>