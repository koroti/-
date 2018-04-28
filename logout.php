<?php
setcookie("id",'',time()-3600);
header("location:login.php");
setcookie('lastLoginTime',date('Y-m-d H:i:s'),time()+24*3600*30);
?>