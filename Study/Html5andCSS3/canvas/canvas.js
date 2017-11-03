/**
 * Created by zhenglei on 2017/11/3.
 */

function drawRectangle(id){
	var canvas = document.getElementById(id);
	var context = canvas.getContext('2d');
	context.fillStyle = "#000000";
    context.strokeStyle = "#ff6600";
    context.lineWidth = 5;
    context.fillRect(0,0,400,300);
    context.strokeRect(50,50,180,120);
    context.strokeStyle = "#ffffff";
    context.strokeRect(110,110,180,120);
}

function drawCircle(id){
    var canvas = document.getElementById(id);
    var context = canvas.getContext('2d');
    context.fillStyle = "#f1f2f3";
    context.fillRect(0,0,400,400);
    for(var i=0;i < 10;i++){
        context.beginPath();
        context.arc(i*25,i*25,i*10,0,Math.PI*2,true);
        context.closePath();
        context.fillStyle = "rgba(255,0,0,0.25)";
        context.fill();
        context.strokeStyle = "red";
        context.stroke();
    }

}