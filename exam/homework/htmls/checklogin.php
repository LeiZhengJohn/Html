<?php

session_start();
require_once('LinkDB.php');
$TestCode2 = strtolower($_POST['TestCode2']);
$username = $_POST['username'];
$password = $_POST['password'];

if($_SESSION['TestCode'] != $TestCode2){
	echo "<script>alert(' 验证码错?');history.back();</script>";
}else{
	$sql ="SELECT * FROM `user` WHERE 1 AND `username` = '".$username. "';";
	$result = mysql_query($sql) or die("无效的查询: ".mysql_error());
	$line = mysql_fetch_object($result);
	if($line->password==$password){
		$_SESSION["username"] = $line->username;
		header("location:main.php");
	}else{
		echo "<script>alert(' 密码错误!');history.back();</script>";
	}
}


?>