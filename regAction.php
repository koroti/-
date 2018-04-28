<?php
    error_reporting(E_ALL ^ (E_NOTICE | E_WARNING));
    date_default_timezone_set('Asia/Shanghai');

    header("content-type:text/html;charset=utf-8");
    $id = $_COOKIE['id'];
    $user = $_COOKIE['user'];
    if(empty($id)){
        echo "<script>alert('登录超时');location.href='login.php';</script>";
    }
    include 'conn.php';

    $oldPwd = $_POST['old_pwd'];
    $pwd= $_POST['pwd'];
    $pwd_repeat = $_POST['pwd_repeat'];

    if(empty($oldPwd) || empty($pwd) || empty($pwd_repeat)){
        echo "<script>alert('请仔细填写');location.href='changePasswd.php';</script>";
    }

    $sql = "call login_$user('$id','$oldPwd')";
    $re = mysqli_query($mysql, $sql);
    $rs = mysqli_fetch_assoc($re);
    mysqli_close($mysql);
    if(!$rs){
        echo "<script>alert('原密码错误');location.href='changePasswd.php';</script>";
    } elseif ($oldPwd == $pwd) {
        echo "<script>alert('新密码与原密码相同');location.href='changePasswd.php';</script>";
    } elseif ($pwd_repeat != $pwd) {
        echo "<script>alert('请重新确认新密码');location.href='changePasswd.php';</script>";
    } elseif ($pwd_repeat == $pwd) {
        include 'conn.php';
        $sql = "call change_password_$user('$id','$pwd')";
        $re = mysqli_query($mysql, $sql);
        $rs = mysqli_fetch_assoc($re);
        $sql = "call login_$user('$id','$pwd')";
        $re = mysqli_query($mysql, $sql);
        $rs = mysqli_fetch_assoc($re);
        if (!$rs) {
            echo "<script>alert('服务器繁忙');location.href='changePasswd.php';</script>";
        } else {
            echo "<script>alert('修改密码成功');location.href='login.php';</script>";
        }
    }
?>