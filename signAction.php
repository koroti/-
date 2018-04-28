<?php 
error_reporting(E_ALL ^ (E_NOTICE | E_WARNING));
date_default_timezone_set('Asia/Shanghai');
    $id = $_COOKIE['id'];
    $user = $_COOKIE['user'];
    $cid = $_COOKIE['cid'];
    if(empty($id)){
         echo "<script>alert('登录超时');location.href='login.php';</script>";
    }
    include 'conn.php';
    $sql="call sign_teacher('$cid')";
    mysqli_query($mysql, $sql);
    foreach ($_POST as $key => $value) {
    	if($key=="Submit") break;
    	$sql="call sign_student('$key','$cid','$value')";
    	mysqli_query($mysql, $sql);
    	echo "$sql<br>";
    }
    header("location:teacherRecord.php");
?>