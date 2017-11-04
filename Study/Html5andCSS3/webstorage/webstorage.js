/**
 * Created by zhenglei on 2017/11/4.
 */
function saveSession(id){
	var target = document.getElementById(id);
	var str = target.value;
	sessionStorage.setItem("message",str);
}
function readSession(id){
    var target = document.getElementById(id);
    var str = sessionStorage.getItem("message");
    target.innerHTML = str;
}

function saveLocal(id){
	var target = document.getElementById(id);
	var str = target.value;
	localStorage.setItem("message",str);
}
function readLocal(id){
    var target = document.getElementById(id);
    var str = localStorage.getItem("message");
    target.innerHTML = str;
}