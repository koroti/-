<?php 
	error_reporting(E_ALL ^ (E_NOTICE | E_WARNING));
	date_default_timezone_set('Asia/Shanghai');
    $id = $_COOKIE['id'];
    $user = $_COOKIE['user'];
    if(empty($id)){
         echo "<script>alert('登录超时');location.href='login.php';</script>";
    }
	
	if (!isset($_POST["birth"])) {
		$url="location:$user".'Course.php';
		header($url);
	}
?>