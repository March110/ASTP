function controlState(objs,stateClass) {//objs是所要控制状态的元素，stateClass是选中状态的类名
    var getBtnsL = objs.length;//保存按钮的个数
    var getClassName = new String();//用来保存按钮的class值
    function clearActive() {//清除选中状态方法
        for (var i = 0; i < getBtnsL; i++) {
            getClassName = objs[i].className;
            if (getClassName.indexOf(stateClass) > -1) {
                objs[i].className = getClassName.substr(0, getClassName.indexOf(" "));
            }
        }
    }
    for (var j = 0; j < getBtnsL; j++) {
        objs[j].onclick = function() {//定义事件
            clearActive();
            if (this.className != "") {
                this.className = this.className + " " + stateClass;
                return;
            }
            this.className = stateClass;
        }
    }
}