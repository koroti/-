<?php 
error_reporting(E_ALL ^ (E_NOTICE | E_WARNING));
date_default_timezone_set('Asia/Shanghai');
    $id = $_COOKIE['id'];
    $cid = $_COOKIE['cid'];
    $user = $_COOKIE['user'];
    if(empty($id)){
         echo "<script>alert('登录超时');location.href='login.php';</script>";
    }
    include 'conn.php';
    $sql = "call show_info_$user('$id')";
    $re_check = mysqli_query($mysql, $sql);
    $data = mysqli_fetch_array($re_check);
    mysqli_close($mysql);
    if(empty($data)){
        echo "<script>alert('非法操作');location.href='login.php';</script>";
    }

    include 'conn.php';
    $sql = "show_signIn_teacher('$cid')";
    $result=mysqli_query($mysql, $sql);
?>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>考勤情况</title>
<link type="text/css" rel="stylesheet" href="css/main.css">
<script src="js/jquery-1.10.2.min.js"></script>
<style type="text/css">
    .rightBox {padding: 10px 0;}
    .user-attendanceR-list {
        border:1px solid #f1f1f1;
        border-radius:3px;
        width:978px;
        height:30px;
        
        margin:10px 0px 10px 0px;
        padding:10px;       
        
        transition: all .2s;
    }
    .user-attendanceR-list:hover{
        border-color:#ffb83b;
        background:#fafafa;
        box-shadow:0 0 8px #999
    }
    .user-attendanceR-detail {      
        line-height:30px;
        font-size:12px;
        color:#6c6c6c;
        
        cursor:default;
    }
    .user-attendanceR-detail .time{display:inline-block;width:135px; text-align: center;}
    .user-attendanceR-detail .address{display:inline-block;width:200px;}
    .user-attendanceR-detail span.right{color:#0f8ff2;}
    .user-attendanceR-detail span.warning{color:#ff8d13;}
    .user-attendanceR-detail span.error{color:#f25277;}
    .btn-attendance {
        display: inline-block;
        overflow: hidden;
        
        margin-left: 30px;

        width: 70px;
        height: 28px;
        
        text-align: center;
        vertical-align: middle;
        font-size:12px;
        line-height: 28px;
        text-align: center;
        
        color: #6c6c6c;

        border:2px solid #f1f1f1;
        border-radius: 3px;
    }
    .btn-attendance:hover{ 
        border-width: 1px;
        border-color:#ffb83b;
        background:#fafafa;
        box-shadow:0 0 8px #999;
    }
    .page_list{
        margin:20px 0 20px 0;
        text-align:right;
        font-size:12px;
    }
    .page_list a{
        display:inline-block;
        
        border: 1px solid #ddd;
        margin-right: 5px;
        padding: 0 14px;
        height: 26px;
        
        line-height: 26px;
        text-decoration:none;
        
        color: #333;
        background: #f7f7f7;
    }
    .page_list a:hover{background: #fff;}
</style>

</head>
<body>
<div class="loginTop clear">
	<div class="topLeft">
		<img src="img/logo.png"/>
		<span></span>
	</div>
	<div class="topRight registerTr">
        <span>欢迎您，<?php echo $data['tname'];?> </span><a href="logout.php">注销</a>
    </div>
</div>
<div class="checkWorkContent clearfix">
	<div class="checkTop clearfix">
		<div class="checkTopTitle">
			<dl class="topInfo">
				<dd class="userName"><?php echo $data['tname'];?><b></b></dd>
                <dd>账&nbsp;&nbsp;号：<?php echo $data['tid'];?></dd>
                <dd>上一次登录时间：<?php echo $_COOKIE['lastLoginTime'];?></dd>
			</dl>
			<div class="changePasswd"><a href="changePasswd.php">修改密码</a></div>
		</div>
		<div class="checkNav">
			<ul>
				<li class="navLi1">
				   <b></b><a href="teacherInfo.php">个人信息</a>
				</li>
				<li class="navLi2">
				   <b></b><a href="teacherCourse.php">我的课表</a>
				</li>
				<li class="navLi3">
				   <b></b><a href="recordAction.php">考勤记录</a>
				</li>
			</ul>
		</div>
		<div class="photo">
			<img alt="个人头像" src="img/fg-a-ava-0.png">
		</div>
	</div>
	<div class="checkConMiddle">
		<div class="rightTitle"><h1>考勤记录</h1></div>
		<div class="rightBox">
			<div class="user-attendanceR-list">
				<div class="user-attendanceR-detail">
                    <span class="time">课程编号</span>
                    <span class="time">课程名</span>
                    <span class="time">开课学院</span>
                    <span class="time">课程学分</span>
                    <span class="time">考勤日期</span>
                    <span class="time">查看详情</span>
				</div>
			</div>
			<?php
                include 'conn.php';
                $sql = "call show_signIn_teacher('$cid')";
                $result=mysqli_query($mysql, $sql);
                $num = mysqli_field_count($mysql);
                mysqli_close($mysql);
                while ($row=mysqli_fetch_array($result)) {
            ?>
			<div class="user-attendanceR-list ">
				<div class="user-attendanceR-detail">
                    <?php for($i = 0; $i < $num ; $i++) { ?>
					   <span class="time"><?php echo $row[$i];?></span>
                    <?php }?>
                    <a href="checksign.php?stime=<?php echo $row['sign_time'];?>" target="_self" class="btn-attendance">查看详情</a>
				</div>
			</div>
			<?php }?>
		</div>
	</div>
</div>
</body>
</html>
