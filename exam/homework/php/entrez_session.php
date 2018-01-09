<?php

$db = $_POST['db2'];
$term = $_POST['term2'];
session_start();
$_SESSION['db2'] = $db;
$_SESSION['term2'] = $term;

header("Location: entrez_session2.php");
?>