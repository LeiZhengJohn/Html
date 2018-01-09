<?php

session_start(); 
header('Content-type:image/png'); 
$TestCodeChars="1234567890ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
$TestCodeLen=6; 
$TestCode="";
for($i=0;$i<$TestCodeLen;$i++) {
	srand();
	$TestCode .= $TestCodeChars[rand(0,strlen($TestCodeChars) -1)];
}
if(isset($_SESSION['TestCode'])) {
	unset($_SESSION['TestCode']);
}
$_SESSION['TestCode'] = strtolower($TestCode);
$font = "C:\WINDOWS\Fonts\TIMESBD.ttf";
$FontSize = 14;
$angle = 10;
$AddSize = 6; 
$x_size = $TestCodeLen*$FontSize+$AddSize;
$y_size = $FontSize+$AddSize;
$im = @imagecreatetruecolor($x_size, $y_size);
$white = imagecolorallocate($im, 255, 255, 255);
$red = imagecolorallocate($im, 255, 0, 0);
imagefilledrectangle($im, 0, 0, $x_size-1, $y_size-1, $white);
for($i=0;$i<$TestCodeLen;$i++){ 
	imagettftext($im, $FontSize, $angle, $FontSize*$i+$AddSize, $FontSize+$AddSize/2, $red, $font,$TestCode[$i]);
}
for($j=0;$j<50;$j++){
	imagesetpixel($im,rand(0,$x_size),rand(0,$y_size),$red);
}
imagepng($im);
imagedestroy($im);

?>