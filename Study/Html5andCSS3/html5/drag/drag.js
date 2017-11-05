/**
 * Created by zhenglei on 2017/11/5.
 */
function allowDrop(ev){
    ev.preventDefault();
    ev.dataTransfer.dropEffect = "link";
}

function drag(ev){
    ev.effeAllowed = "all";
    ev.dataTransfer.setData("Text",ev.target.id);
}

function drop(ev){
    ev.preventDefault();
    var data = ev.dataTransfer.getData("Text");
    ev.target.appendChild(document.getElementById(data));
}