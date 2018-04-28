<?php 
error_reporting(E_ALL ^ (E_NOTICE | E_WARNING));
date_default_timezone_set('Asia/Shanghai');
    $id = $_COOKIE['id'];
    if(empty($id)){
         echo "<script>alert('登录超时');location.href='login.php';</script>";
    }
    $user=$_COOKIE['user'];
    if($id == 'root')
    {
    	$url="location:rootmenu.php";
    	header($url);
    }
    else
    {
    	$url="location:$user".'Info.php';
    header($url);
    }
?>