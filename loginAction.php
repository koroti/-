<?php
header("content-type:text/html;charset=utf-8");
// error_reporting(E_ALL ^ (E_NOTICE | E_WARNING));
$id = $_POST['id'];
$pwd = $_POST['pwd'];
$user = $_POST['user'];

if(empty($id) || empty($pwd)){
    echo "<script>alert('请仔细填写');location.href='login.php';</script>";
}else{
    include 'conn.php';
    $sql = "call login_$user('$id','$pwd')";
    $re = mysqli_query($mysql, $sql);
    $rs = mysqli_fetch_assoc($re);
    mysqli_close($mysql);
    if($rs){
      date_default_timezone_set('Asia/Shanghai');
      setcookie("user",$user,time()+3600);
      setcookie("id",$id,time()+3600);
      if(!isset($_COOKIE['lastLoginTime'])) {
        setcookie('lastLoginTime',date('Y-m-d H:i:s'),time()+24*3600*30);
      }
      header("location:infoAction.php");
    }else{
      echo "<script>alert('账号或密码错误');location.href='login.php';</script>";
    }
    
}
