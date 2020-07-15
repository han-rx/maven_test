
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
    <title>Title</title>
    <script type="text/javascript" src="<%=request.getContextPath() %>/res/js/jquery-1.12.4.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath() %>/res/layer/layer.js"></script>
    <script type="text/javascript">

        function update() {
            var index = layer.load(0,{shade:0.3});
            $.post("<%=request.getContextPath()%>/user/userUpdate",
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
    </script>
</head>
<body style="text-align: center"  bgcolor="#CCDDFF">
<h2>用户修改</h2>

    <form id="fm">
        <input type="hidden" name="id" value="${user.id}"/>
        用户名: <input type="text" name="userName" value="${user.userName}"/><br/>
        密码: <input type="text" name="userPwd" value="${user.userPwd}"/><br/>
        年龄: <input type="text" name="userAge" value="${user.userAge}"/><br/>
        班级:
        <select name="classRoom">
             <option <c:if test="${user.classRoom==1801}">selected="selected"</c:if> value="1801">1801</option>
            <option <c:if test="${user.classRoom==1802}">selected="selected"</c:if> value="1802">1802</option>
            <option <c:if test="${user.classRoom==1803}">selected="selected"</c:if> value="1803">1803</option>
            <option <c:if test="${user.classRoom==1804}">selected="selected"</c:if> value="1804">1804</option>
            <option <c:if test="${user.classRoom==1805}">selected="selected"</c:if> value="1805">1805</option>
            <option <c:if test="${user.classRoom==1806}">selected="selected"</c:if> value="1806">1806</option>
        </select><br>
        爱好:
        <input type="radio" name="hobbys" value="0">游戏
        <input type="radio" name="hobbys" value="1">羽毛球
        <input type="radio" name="hobbys" value="2">足球
        <input type="radio" name="hobbys" value="3">篮球
        <input type="radio" name="hobbys" value="4">跑步
        <br>
        <input type="button" value="修改" onclick="update()"/>
    </form>
</body>
</html>
