<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>修改密码</title>
<link type="text/css" rel="stylesheet" href="css/main.css">
<script src="js/jquery-1.10.2.min.js"></script>
<script type="text/javascript">
$().ready(function(){
	$("#old_pwd").blur(function(){
		var oldPwd = $("#old_pwd").val();
		var ob = $("#old_pwd").parent().parent().find(".msgBox");
		if(oldPwd == ""){
			ob.html("请填写旧密码");
			ob.addClass('error');
		} else {
			ob.html("");
			ob.removeClass('error').addClass('ok');
		}	
	});
	$("#pwd").blur(function(){
		var pwd = $("#pwd").val();
		var ob = $("#pwd").parent().parent().find(".msgBox");
		if(pwd == ""){
			ob.html("请填写密码");
			ob.addClass('error');
		}else{
			if(pwd.length<6 || pwd.length>12){
				ob.html("密码由6~12数字、字母或下划线组成");
				ob.addClass('error');
			} else {
				$.post("checkPwd.php",{pwd:pwd},function(re){
					if(re.status != 1){
						ob.html(re.msg);
						ob.removeClass('ok').addClass('error');
					}else{
						ob.html(re.msg);
						ob.removeClass('error').addClass('ok');
					}
				},'json');
			}
		}	
	});
	$("#pwd_repeat").blur(function(){
		var pwd_repeat = $("#pwd_repeat").val();
		var pwd=$("#pwd").val();
		var ob = $("#pwd_repeat").parent().parent().find(".msgBox");
		if(pwd_repeat == ""){
			ob.html("请填写密码");
			ob.addClass('error');
		}else{
			if(pwd_repeat==pwd){
				ob.html("密码一致");
				ob.addClass('ok');
			}else{
				ob.html("密码不一致");
				ob.removeClass('ok').addClass('error');
			}
		}
	});
});
</script>
<style type="text/css">
#old_pwd,#pwd,#pwd_repeat {
	width: 73%;
	height: 50px;

	float: right;
}
.formInput {
	height: 50px;
}
</style>
</head>
<body>
<div class="loginTop clear">
	<div class="topLeft">
		<img src="img/logo.png"/>
	</div>
</div>
<div class="registerContent clearfix">
	<div class="registerTitle">
	    <p>修改密码</p>
	</div>
	<div class="registerBox">
		<div class="registerForm">
			<form action="regAction.php" method="post">
				<div class="regList clear">
					<div class="formInput">
						<span>原密码</span>
						<input type="password" id="old_pwd" name="old_pwd" placeholder="旧密码" onblur="checkName()"/>
					</div>
					<div class="msgBox" id="oldpwdMsg">现在使用的密码</div>
				</div>
				<div class="regList clear">
					<div class="formInput">
						<span>新密码</span>
						<input type="password" id="pwd" name="pwd" placeholder="建议至少使用两种字符组合" onblur="checkPwd()"/>
					</div>
					<div class="msgBox" id="pwdMsg">支持6~12位字母、数字或特殊字符</div>
				</div>
				<div class="regList clear">
					<div class="formInput">
						<span>确认密码</span>
						<input type="password" id="pwd_repeat" name="pwd_repeat" placeholder="请再次输入密码"/>
					</div>
					<div class="msgBox" id="repwdMsg">请再次输入密码</div>
				</div>
				<div class="registerTip">
				   <button type="submit" class="btnRegister" id="btnRegister">修改密码</button>
				</div>
			</form>
		</div>
	</div>
	<div class="registerBoxR"></div>
</div>

</body>
</html>