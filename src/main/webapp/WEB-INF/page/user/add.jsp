
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
    <title>Title</title>
    <script type="text/javascript" src="<%=request.getContextPath() %>/res/js/jquery-1.12.4.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath() %>/res/layer/layer.js"></script>
    <script type="text/javascript">

        function add() {
            var index = layer.load(0,{shade:0.3});
            $.post("<%=request.getContextPath()%>/user/add",
                $("#fm").serialize(),
                function(data){
                    layer.close(index);
                    if (data.code == 200) {
                        layer.msg(data.msg,{icon:6});;
                        parent.location.href = "<%=request.getContextPath()%>/user/toShow";
                        return
                    }
                    layer.msg(data.msg,{icon:5});
                })

        }

        var i = 0;
        function adds(){
            i++;
            var html = "<div> <hr/>"
            html+="<input type = 'button' value='-' onclick = 'del(this)' /><br/>"
            html+="用户名:<input type='text' name='list["+i+"].userName'/><br/>"
            html+="密码:<input type='text' name='list["+i+"].userPwd'/><br/>"
            html+="年龄:<input type='text' name='list["+i+"].userAge'/><br/>"
            html+="班级:<select name=\'list["+i+"].classRoom\'>\n" +
            "                <option value=\"1801\">1801</option>\n" +
            "                <option value=\"1802\">1802</option>\n" +
            "                <option value=\"1803\">1803</option>\n" +
            "                <option value=\"1804\">1804</option>\n" +
            "                <option value=\"1805\">1805</option>\n" +
            "                <option  value=\"1806\">1806</option>\n" +
            "            </select><br>"
            html+="爱好:<input type='radio' name='list["+i+"].hobbys' value='0'/>游戏"
            html+="<input type='radio' name='list["+i+"].hobbys' value='1'/>羽毛球"
            html+="<input type='radio' name='list["+i+"].hobbys' value='2'/>足球"
            html+="<input type='radio' name='list["+i+"].hobbys' value='3'/>篮球"
            html+="<input type='radio' name='list["+i+"].hobbys' value='4'/>跑步<br/>"
            $("#adds").append(html);
        }

        function del(obj){
            $(obj).parent().remove();
        }

    </script>
</head>
<body style="text-align: center"  bgcolor="#CCDDFF">
<h2>用户新增</h2>
    <input type='button' value='+' onclick = "adds()"/>

    <form id="fm">
        用户名: <input type="text" name="list[0].userName" /><br/>
        密码: <input type="text" name="list[0].userPwd" /><br/>
        年龄: <input type="text" name="list[0].userAge"/><br/>
        班级:
        <select name="list[0].classRoom">
            <option value="1801">1801</option>
            <option value="1802">1802</option>
            <option value="1803">1803</option>
            <option value="1804">1804</option>
            <option value="1805">1805</option>
            <option  value="1806">1806</option>
        </select><br>
        爱好:
        <input type="radio" name="list[0].hobbys" value="0">游戏
        <input type="radio" name="list[0].hobbys" value="1">羽毛球
        <input type="radio" name="list[0].hobbys" value="2">足球
        <input type="radio" name="list[0].hobbys" value="3">篮球
        <input type="radio" name="list[0].hobbys" value="4">跑步
        <br>
        <div id="adds"></div>
        <input type="button" onclick="add()" value="新增"/>
    </form>
</body>
</html>
