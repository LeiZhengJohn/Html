<?php

session_start();
require_once('LinkDB.php');
$TestCode2 = strtolower($_POST['TestCode2']);
$username = $_POST['username'];
$password = $_POST['password'];
$password2 = $_POST['password2'];


if($_SESSION['TestCode'] != $TestCode2){
	echo "<script>alert(' 验证码错?');history.back();</script>";
}else{
	if($password==$password2){
		$sql ="SELECT * FROM `user` WHERE 1 AND `username` = '".$username. "';";
		$result = mysql_query($sql) or die("无效的查询: ".mysql_error());
		$line = mysql_fetch_object($result);
		if($line == false){
			$sql2 = "insert into `user`(`username`,`password`) values('{$username}','{$password}')";
			$result2 = mysql_query($sql2) or die(" 无效查询:".mysql_error());
			$_SESSION["username"] = $username;
			header("location:main.php");
		}else{
			echo "<script>alert('用户名已经存在!');history.back();</script>";
		}
	}else{
		echo "<script>alert('密码输入不一致！');history.back();</script>";
	}
	
}


?>