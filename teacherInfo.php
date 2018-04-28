<?php 
error_reporting(E_ALL ^ (E_NOTICE | E_WARNING));
date_default_timezone_set('Asia/Shanghai');
    $id = $_COOKIE['id'];
    $user = $_COOKIE['user'];
    if(empty($id)){
         echo "<script>alert('登录超时');location.href='login.php';</script>";
    }
    include 'conn.php';
    $sql_check = "call show_info_$user('$id')";
    $re_check = mysqli_query($mysql, $sql_check);
    $data = mysqli_fetch_array($re_check);
    if(empty($data)){
        echo "<script>alert('非法操作');location.href='login.html';</script>";
    }
?>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>个人资料</title>
<link type="text/css" rel="stylesheet" href="css/main.css">
<style type="text/css">
	.checkConLeft ul li:nth-child(1){border:1px solid #0f8ff2;}
	.checkConLeft ul li:nth-child(1):before,.checkConLeft ul li:nth-child(1):after{background-color:#0f8ff2;}
	.checkConLeft ul li:before{content:"";position:absolute;top:18px;left:156px;width:17px;height:2px;}
	.checkConLeft ul li:after{content:"";position:absolute;top:11px;left:173px;width:15px;height:15px;background-color:#eaeaea;border-radius:50%;}
	.infoBox table{border:1px solid #d9d9d9;width:1000px;font-size:14px;margin-bottom:20px;}
	.infoBox th{height:50px;font-weight:500;}
	.infoBox .infoTr th{border-bottom:1px solid #d9d9d9;}
	.thLeft{width:140px;background:#fafafa;text-align:right;}
	.thRight{text-align:left;padding-left:25px;}
	#edit{color:#fff;background:#ffab16;font-size:14px;width:140px;height:40px;border:none;border-radius:5px;display:block;margin:0 auto;}
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
				   <b></b><a href="#">个人信息</a>
				</li>
				<li class="navLi2">
				   <b></b><a href="courseAction.php">我的课表</a>
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
	<div class="checkContentMidele">
		<div class="checkCon perInfo">
			<div class="rightTitle"><h1>个人资料</h1></div>
			<form class="infoBox" action="editAction.php" method="post">
				<table>
					<tr class="infoTr">
						<th class="thLeft">工号:</th>
						<th class="thRight"><?php echo $data['tid'];?></th>
					</tr>
					<tr class="infoTr">
						<th class="thLeft">姓名:</th>
						<th class="thRight"><?php echo $data['tname'];?></th>
					</tr>
					<tr class="infoTr">
						<th class="thLeft">出生日期:</th>
						<th class="thRight"><?php echo $data['birthday'];?></th>
					</tr>
					<tr class="infoTr">
						<th class="thLeft">性别:</th>
						<th class="thRight"><?php echo $data['sex'];?></th>
					</tr>
					<tr class="infoTr">
						<th class="thLeft">联系号码:</th>
						<th class="thRight"><?php echo $data['telephone'];?></th>
					</tr>					
					<tr class="infoTr">
						<th class="thLeft">所属学院:</th>
						<th class="thRight"><?php echo $data['colname'];?></th>
					</tr>
					<tr class="infoTr">
						<th class="thLeft">职称:</th>
						<th class="thRight"><?php echo $data['rank'];?></th>
					</tr>
				</table>
				<?php setcookie("action","Edit.php"); ?>
				<input type="submit" id="edit" name="Submit" value="编  辑"/>
			</form>
		</div>
	</div>
</div>
<br>
<br>
</body>
</html>