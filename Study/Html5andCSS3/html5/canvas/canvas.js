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

function drawText(id){
    var canvas = document.getElementById(id);
    var context = canvas.getContext('2d');
    context.fillStyle = "green";
    context.fillRect(0,0,800,300);
    context.fillStyle = "#ffffff";
    context.strokeStyle = "#ffffff";
    context.font = "700 40px '微软雅黑','宋体'";
    context.textBaseline = "hanging";
    context.textAlign = "start";
    context.fillText("HTML5+CSS3",50,50,800);
    context.strokeText("HTML5+CSS3",50,100,800);
}

function draw_save(id){
    var canvas = document.getElementById(id);
    var context = canvas.getContext('2d');
    context.fillStyle = "blue";
    context.fillRect(0,0,400,300);
    window.location = canvas.toDataURL("image/jpeg");
}

function drawAnimation(id){
    var canvas = document.getElementById(id);
    var context = canvas.getContext("2d");
    var width = canvas.width;
    var height = canvas.height;
    var i = 0;
    var j = 0;
    function painting(){
        if(i < width && j == 0){
            context.fillStyle = "green";
            context.fillRect(i,0,10,10);
            i = i + 20;
        }else if(i >= width && j < height){
            context.fillStyle = "green";
            context.fillRect(i-20,j,10,10);
            j = j + 20;
        }else if(i >= 0 && j >= height){
            context.fillStyle = "green";
            context.fillRect(i-20,j-20,10,10);
            i = i - 20;
        }else if(i < 0 && j >= 0) {
            context.fillStyle = "green";
            context.fillRect(i + 20, j - 20, 10, 10);
            j = j - 20;
        }
    }
    function removing(){
        if(i < width && j == 0){
            //context.fillStyle = "#ffffff";
            context.clearRect(i,0,10,10);
            i = i + 20;
        }else if(i >= width && j < height){
            //context.fillStyle = "#ffffff";
            context.clearRect(i-20,j,10,10);
            j = j + 20;
        }else if(i >= 0 && j >= height){
            //context.fillStyle = "#ffffff";
            context.clearRect(i-20,j-20,10,10);
            i = i - 20;
        }else if(i < 0 && j >= 0) {
            //context.fillStyle = "#ffffff";
            context.clearRect(i + 20, j - 20, 10, 10);
            j = j - 20;
        }
    }
    setInterval(painting,100);
    setInterval(removing,100);
}
