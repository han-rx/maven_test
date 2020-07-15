
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
    <title>Title</title>
    <script type="text/javascript" src="<%=request.getContextPath() %>/res/js/jquery-1.12.4.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath() %>/res/layer/layer.js"></script>
    <script type="text/javascript">

        $(function() {
            search();
        })

        var pages = 1;

        //赋选中复选框的值
        function selectedValue() {
            appliancesIds = $('input[name="id"]:checked');
            var chk_value = [];
            $.each(appliancesIds,function(){
                chk_value.push($(this).val());
            })
            $("#ids").val(chk_value);
            return chk_value;
        }

        function search() {
            $("#pageNo").val(1);
            locdUser();
        }

        function locdUser() {
            var index = layer.load(0,{shade:0.3});
            $.post("<%=request.getContextPath() %>/user/show",
                $("#fm").serialize(),
                function(data){
                    layer.close(index);
                    if(data.code != 200){
                        layer.msg(data.msg,{icon:5});
                        return;
                    }
                    var html = "";
                    var pageHtml = "";
                    for (var i = 0; i <  data.data.m.length; i++) {
                        var u = data.data.m[i];
                        html+="<tr>";
                        html+="<td><input type = 'checkbox' name='id' value="+ u.id+" /></td>";
                        html+="<td>"+u.userName+"</td>";
                        html+="<td>"+u.userPwd+"</td>";
                        html+="<td>"+u.userAge+"</td>";
                        html+="<td>"+u.classRoom+"</td>";
                        html+="<td>"+u.hobby+"</td>";
                        html+="<td>";
                        html+="<input type='button' value='修改'onclick='upd("+u.id+")'/>";
                        html+="</td>";
                        html+="</tr>";
                    }
                    $("#tbd").html(html);
                    pages = data.data.pages;
                    pageHtml += "<input type = 'button' value='上一页' onclick='page(0)'/>";
                    pageHtml +="第"+$("#pageNo").val()+"/"+pages+"页";
                    pageHtml += "<input type = 'button' value='下一页' onclick='page(1)'/>";
                    $("#pageInfo").html(pageHtml);
                });

        }
        //分页
        function page(temp){
            var page = $("#pageNo").val();
            if (temp == 0) {
                if (page == 1) {
                    layer.msg("已是首页", {icon: 5, time: 2000});
                    return;
                }
                $("#pageNo").val(parseInt(page) - 1);
            }
            if (temp == 1) {
                if (parseInt(page) + 1 > pages ) {
                    layer.msg("已是尾页", {icon: 5, time: 2000});
                    return;
                }
                $("#pageNo").val(parseInt(page) + 1);
            }
            locdUser();
        }

        //修改
        function upd(id){
            layer.open({
                type: 2,
                title: '修改用户',
                shade: 0.8,
                area: ['400px', '70%'],
                content: '<%=request.getContextPath()%>/user/toUpdate?id='+id
            });
        }

        //新增
        function toAdd(){
            layer.open({
                type: 2,
                title: '用户新增',
                shade: 0.8,
                area: ['400px', '70%'],
                content: '<%=request.getContextPath()%>/user/toAdd'
            });
        }

        //删除
        function del(){
            var id = selectedValue();
            var index = layer.load(0,{shade:0.3});
            $.post(
                "<%=request.getContextPath()%>/user/del",
                {"ids" : id},
                function(data){
                    layer.close(index);
                    if (data.code != 200) {
                        layer.msg(data.msg,{icon:5});
                        return;
                    }
                    layer.msg(data.msg, {
                        icon: 6,
                        time: 2000 //2秒关闭（如果不配置，默认是3秒）
                    }, function(){
                        window.location.href = "<%=request.getContextPath() %>/user/toShow";
                    });
                }
            );
        }

    </script>
</head>
<body style="text-align: center"  bgcolor="#CCDDFF">
<h2>用户展示</h2>

<form id = "fm" align="center">
    <!-- 分页按钮 -->
    <input type="hidden" value="1" id="pageNo" name="pageNo"/>
    <input type = "button" value="删除" onclick="del()">
    <input type = "button" value="新增" onclick="toAdd()"><br/>
    姓名<input type="text" name="userName"/><br/>
    爱好:
    <input type="checkbox" name="hobbys" value="0">游戏
    <input type="checkbox" name="hobbys" value="1">羽毛球
    <input type="checkbox" name="hobbys" value="2">足球
    <input type="checkbox" name="hobbys" value="3">篮球
    <input type="checkbox" name="hobbys" value="4">跑步<br/>
    年龄:<input type = "text" name="minAge" />~<input type = "text" name="maxAge" />
    <input type = "button" value="搜索" onclick="search()">
</form>
<table border="2px" cellpadding="10px" cellspacing="0px" bgcolor="pink" align="center">
    <tr>
        <td></td>
        <td>用户名</td>
        <td>密码</td>
        <td>年龄</td>
        <td>班级</td>
        <td>爱好</td>
        <td>操作</td>
    </tr>
    <tbody id = "tbd">

    </tbody>
</table>
<div id = "pageInfo"></div>
</body>
</html>
