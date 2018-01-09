<?php

session_start();
require_once('LinkDB.php');
$TestCode2 = strtolower($_POST['TestCode2']);
$username = $_SESSION["username"];
$oldpwd = $_POST['oldpwd'];
$newpwd = $_POST['newpwd'];
$newpwd2 = $_POST['newpwd2'];


if($_SESSION['TestCode'] != $TestCode2){
	echo "<script>alert(' 验证码错?');history.back();</script>";
}else{
	if($newpwd==$newpwd2){
		$sql ="SELECT * FROM `user` WHERE 1 AND `username` = '".$username. "';";
		$result = mysql_query($sql) or die("无效的查询: ".mysql_error());
		$line = mysql_fetch_object($result);
		if($line->password == $oldpwd){
			$update = "update `user` set `password`='{$newpwd}' where `username` = '{$username}'";
			$result2 = mysql_query($update) or die(' 更新失败： '.mysql_error());
			echo "<script>alert(' 密码修改成功!');</script>";
			header("location:main.php");
		}else{
			echo "<script>alert('旧密码输入有误!');history.back();</script>";
		}
	}else{
		echo "<script>alert('新密码输入不一致！');history.back();</script>";
	}
	
}


?>