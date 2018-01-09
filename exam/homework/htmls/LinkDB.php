<?php

$link = mysql_connect("localhost", "root", "") or die('无法连接数据库: '.mysql_error());
mysql_select_db("mydb") or die ('无法连接数据库MyDB: '.mysql_error());
mysql_query("set names utf8");

?>