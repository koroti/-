<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>登录界面</title>
<link type="text/css" rel="stylesheet" href="css/main.css">
</head>
<body>
<div class="loginTop clear">
	<div class="topLeft">
		<img src="img/logo.png"/>
		<span>欢 迎 登 录</span>
	</div>
</div>
<div class="content">
	<div class="main">
		<div class="loginBox">
			<div class="title">账号登录</div>
			<div class="loginItem">
				<form id="FORM" action="loginAction.php" method="post">
					<div class="nameList">
						<b></b><input type="text" name="id" placeholder="请输入您的账号"/>
					</div>
					<div class="pwdList">
						<b></b><input type="password" name="pwd" placeholder="请输入您的密码"/>
					</div>
					<div class="wjmm" style="font-size:12px;color:#808080;font-family: sans-serif;">
						初始密码为学号后六位
					</div>
					<div class="btnList">
						<button type="submit" name="user" value="student" class="btnLogin">
							<?php echo "学  生  登  录" ?>
						</button>
					</div>
					<br>
					<div class="btnList">
						<button type="submit" name="user" value="teacher" class="btnLogin">
							<?php echo "教  师  登  录" ?>
						</button>
					</div>
					<br>
				</form>
			</div>
		</div>
	</div>
</div>
</body>
</html>