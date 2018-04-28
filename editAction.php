<?php 
	error_reporting(E_ALL ^ (E_NOTICE | E_WARNING));
	date_default_timezone_set('Asia/Shanghai');
    $id = $_COOKIE['id'];
    $user = $_COOKIE['user'];
    if(empty($id)){
         echo "<script>alert('登录超时');location.href='login.php';</script>";
    }
	
	if (!isset($_POST["birth"])) {
		$url="location:$user".'Edit.php';
		header($url);
	}

	$birth=$_POST["birth"];
	$tele=$_POST["tele"];
    

    include 'conn.php';

	$update = "call alter_info_$user('$id','$birth','$tele')";
	mysqli_query($mysql, $update);
	if(mysqli_affected_rows($mysql) > 0) {
		echo "<script>alert('修改信息成功!');</script>";
	} else {
		echo "<script>alert('修改信息失败!');</script>";
	}
	echo "<script>location.href='infoAction.php';</script>";
?>