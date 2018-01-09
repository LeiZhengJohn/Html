<?php session_start(); ?>
<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>WebEditor</title>
</head>
<body>
<form action=".php" method="post" target="_self">
<?php

require_once("../fckeditor/fckeditor.php");
$MyFCKeditor = new FCKeditor('MyWebEditor') ;
$MyFCKeditor->BasePath = '../fckeditor/' ;
$MyFCKeditor->ToolbarSet = 'Default' ;
$MyFCKeditor->InstanceName = 'MyWebEditor';
$MyFCKeditor->Width = '100%' ;
$MyFCKeditor->Height = '400' ;
	
$handle = fopen("../htmls/main.php","r");
$output = fread($handle,filesize("../htmls/main.php"));
fclose($handle);
	
$MyFCKeditor->Value = $output;
$MyFCKeditor->Create() ;


?>
</form>
</body>
</html>