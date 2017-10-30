// JavaScript Document
function welcome(a){
	alert("欢迎您，亲爱的用户"+a);
}

function bye(a){
	
	confirm("亲爱的"+a+",您确定要离开吗？")
}
function a(){
	window.onbeforeunload = function (event) {
	var event = event || window.event;
	 // 兼容IE8和Firefox 4之前的版本
	if (event) {
	 event.returnValue = "确定要关闭窗口吗？";
	 }
	 // Chrome, Safari, Firefox 4+, Opera 12+ , IE 9+
	 return '确定要关闭窗口吗>现代浏览器？';
 	}
}
