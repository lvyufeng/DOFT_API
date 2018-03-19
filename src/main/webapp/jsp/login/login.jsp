<%--
  Created by IntelliJ IDEA.
  User: wangxue
  Date: 18/3/10
  Time: 下午3:27
  To change this template use File | Settings | File Templates.
--%>
<!DOCTYPE HTML>
<html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<c:ser var = "ctx" value="${pageContext.request.contextPath}"/>
<%--<%@include file="../../index.jsp"%>--%>
<%--<%@ page contentType="text/html;charset=UTF-8" language="java" import="com.doft.pojo.User" %>--%>
<head>
    <meta charset="UTF-8">
    <title>login</title>
    <%--<script type="text/javascript" src="../../resource/js/jquery-ui.min.js"></script>--%>
    <!-- 引入Jquery js库文件 -->
    <script type="text/javascript" src="${ctx}/resource/js/jquery-1.12.4.js" ></script>
    <link rel="stylesheet" href="${ctx}/css/login.css">
</head>
<body>

<div class="login">
    <!-- 登录左侧图片 -->
    <div class="login_left" >
        <div class="login_left_img">
            <img src="../../resource/img/login_left.jpg">
        </div>
    </div>
    <!-- 手机号登录 -->
    <div class="login_phone_password">
        <%--登录logo--%>
        <div class="bigLogo">
            <img src="${ctx}/resource/img/bigLogo.png" >
        </div>
        <!-- 登录表单 -->
        <form id="form_login" action="" method="post">
            <div class="oneform">
                <div class="form_label">
                    <label>手机</label>
                </div>
                <div class="form_input">
                    <input type="text" id="uphone" placeholder="手机号">
                </div>
            </div>
            <div class="oneform">
                <div class="form_label">
                    <label >密码 </label>
                </div>
                <div class="form_input">
                    <input type="password" id="pwd" placeholder="密码"/>
                </div>
            </div>
            <%--错误信息提示--%>
            <div class="error_tip">
                <p id="error_msg"></p>
            </div>
            <!-- 记住手机号 -->
            <div class="oneform">
                <div class="remember">
                    <input id="check_box" type="checkbox" name="checkbox"/>
                    <label >记住手机号</label>
                </div>
                <div class="register">
                    <a href="${ctx}/jsp/login/register.jsp"><p>注册</p></a>
                </div>
            </div>

            <!-- 登录按钮 -->
            <div class="oneform">
                <div class="login_btn">
                    <input id="login_btn" type="button" value="登录"/>
                </div>
            </div>
        </form>

    </div>
</div>

<script type="text/javascript">

    
    $("#login_btn").click(function () {
        var Uname = $("#uphone").val().trim(); // trim 去除字符串两端的空白字符
        var Upass = $("#pwd").val().trim();
        if (Uname.length != 11) {
            document.getElementById("error_msg").innerHTML = "请输入11位手机号";
            return false;
        }
        if (Upass.length > 20 || Upass.length < 4) {
//            window.alert("密码请输入4-20位字符");
            document.getElementById("error_msg").innerHTML = "密码请输入4-20位字符";
            return false;
        }
        if(Uname!="" && Upass!=""){
            console.log("path");
            $.ajax({
                //get the input phoneNum;
                url : "http://192.168.1.180:8080/user/login.do",//url
                xhrFields: {           withCredentials: true       },
                crossDomain: true,
                type : "POST",//方法类型
                dataType: "json",//预期服务器返回的数据类型
                data: {"phoneNumber":Uname,"password":Upass},
                error : function(xhr, status, error) {
                    console.info(JSON.stringify(xhr));
                },
                success : function(data) {
                    console.log(data);
                    if (data.status == '0'){
                        console.log("ok");
                        window.location.href="${ctx}/jsp/dishes/dishes.jsp";//js跳转页面
                        <%--window.location.href="${ctx}/jsp/pb/pb.jsp";--%>
                    }
                    else{
                        document.getElementById("error_msg").innerHTML = data.msg;
                    }
                }
            });
        }
    })
</script>
</body>
</html>