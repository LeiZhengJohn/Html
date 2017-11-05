/**
 * Created by zhenglei on 2017/11/4.
 */
function saveStorage(id){
    var data = document.getElementById(id).value;
    var time = new Date().getTime();
    localStorage.setItem(time,data);
    alert("数据保存成功！")
}
function readStorage(id){
    var result = '<table border="1">';
    for(var i=0;i < localStorage.length;i++){
        var key = localStorage.key(i);
        var value = localStorage.getItem(key);
        var date = new Date();
        date.setTime(key);
        var datestr = date.toGMTString();
        result += ('<tr><td>'+'这是第'+(i+1)+'条数据</td><td>'+datestr+'</td><td>'+value+'</td></tr>');
    }
    result += '</table>';
    var target = document.getElementById(id);
    target.innerHTML = result;
}
function clearStorage(){
    localStorage.clear();
    alert("数据已经成功删除！");
}