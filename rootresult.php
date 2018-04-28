<?php
include "conn.php";
error_reporting(E_ALL ^ (E_NOTICE | E_WARNING));
$a = $_POST["a"];
$table = $_COOKIE['table'];
$opera = $_COOKIE['opera'];

if($opera == 'insert')
{
	$sql = "insert into $table values(";
	foreach($a as $b => $value)
	{
		if($b == count($a) - 1)
		{
			if($table == 'student'||$table == 'teacher')
				$sql = $sql."'$value',null)";
			else
				$sql = $sql."'$value')";
		}	
		else
			$sql = $sql."'$value',";
	}
}
else if($opera == 'delete')
{
	$sql = "delete from $table where ";
	$select = "select * from ".$table;
	$result = mysqli_query($mysql,$select);
	$row = mysqli_fetch_field($result);
	$sql = $sql.$row->name."='$a'";
	if($table == "student_course")
	{
		$b = $_POST["b"];
		$sql = $sql." and cid=$b";
	}
}
else if($opera == 'update')
{
	$sql = "update $table set ";
	$select = "select * from ".$table;
    $result = mysqli_query($mysql,$select);
    $v = null;
	foreach($a as $b => $value)
	{
		$row = mysqli_fetch_field($result);
		if($b == 0)
		{
			$v = $value;
		}
		else
		{
			if($b == count($a) - 1)
				$sql = $sql."$row->name='$value' ";
			else
				$sql = $sql."$row->name='$value',";
		}
		
	}
	$result = mysqli_query($mysql,$select);
	$row = mysqli_fetch_field($result);
	$sql = $sql."where $row->name=$v";
}

$result = mysqli_query($mysql,$sql);
if(mysqli_affected_rows($mysql) > 0)
{
	echo "<script>alert('操作成功！');location.href='rootAction.php';</script>";
}	
else
{
	echo "<script>alert('操作失败！');location.href='rootAction.php';</script>";
}
?>