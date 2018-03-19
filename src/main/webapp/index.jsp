<!DOCTYPE html>
<html lang="en">
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<c:ser var = "ctx" value="${pageContext.request.contextPath}"/>
<head>
    <meta charset="UTF-8">
    <meta name="viewpoint" content="width=device-width,initial-scale=1">
    <title>指尖上的美味</title>
    <link rel="stylesheet" href="${ctx}/resource/css/bootstrap.min.css">
    <!--<link rel="stylesheet" href="../resource/css/jquery-ui.min.css" type="text/css">-->
    <link rel="stylesheet" href="${ctx}/css/index.css">
    <!--<link rel="stylesheet" href="../resource/zui/css/zui.css">-->
    <script type="text/javascript" src="${ctx}/resource/js/jquery-1.12.4.js" ></script>
    <script type="text/javascript" src="${ctx}/resource/js/bootstrap.js" ></script>
    <!-- 引入Jquery js库文件 -->

    <!--<script type="text/javascript" src="../js/index.js"></script>-->
</head>
<body>
<div id="header">
    <div class="header_main" id="1">
        <div class="logo">
            <div class="logo_img">
                <a href="${ctx}/jsp/dishes/dishes.jsp" target="mainFrame"><img src="${ctx}/resource/img/logo.png"/></a>
            </div>
            <p>指尖上的美味</p>
        </div>
        <div class="search">
            <input type="text" placeholder="输入你想要的菜品">
            <span class="search-btn">
                    <button class="btn"><img src="${ctx}/resource/img/search.png" alt=""></button>
                </span>
        </div>
        <div class="headBar">
            <div class="bar_list pb">
                <div id="dishType_num" class="hidden">
                   0
                </div>
                <div class=" pb_img">
                    <a href="${ctx}/jsp/pb/pb.jsp" target="mainFrame"><img src="${ctx}/resource/img/PB.png"/></a>
                </div>

                <p>购物车</p>
            </div>
            <div class="bar_list order">
                <div class=" order_img">
                    <a href="${ctx}/jsp/order/order.jsp" target="mainFrame"><img src="${ctx}/resource/img/Order.png"/></a>
                </div>
                <p>订单中心</p>
            </div>
            <div class="bar_list person">
                <div class=" person_img">
                    <%--<a href="${ctx}/jsp/person/person_info_finished.jsp" target="mainFrame"><img src="${ctx}/resource/img/Person.png"/></a>--%>
                    <a href="${ctx}/jsp/person/person_info_finished.jsp" target="mainFrame"><img src="${ctx}/resource/img/Person.png"/></a>
                </div>
                <p>个人中心</p>
            </div>
        </div>
    </div>
</div>
<div id="main">
    <!--内联框架，网页中嵌套另外一个网页-->
    <iframe id="mainFrame" name="mainFrame" src="${ctx}/jsp/person/person_info_finished.jsp" width="100%" height="100%" frameborder="0"></iframe>
</div>
<div id="footer">
    <div class="footBtn" id="dish_btn">
        <a href="${ctx}/jsp/dishes/dishes.jsp" target="mainFrame">
            <button>点菜</button>
        </a>
    </div>
    <div class="footBtn" id="pb_btn">
        <a href="${ctx}/jsp/pb/pb.jsp" target="mainFrame">
            <button>购物车</button>
        </a>
    </div>
    <div class="footBtn" id="order_btn">
        <a href="${ctx}/jsp/order/order.jsp" target="mainFrame">
            <button>订单中心</button>
        </a>
    </div>
    <div class="footBtn" id="person_btn">
        <%--<a href="${ctx}/jsp/person/person_info_finished.jsp" target="mainFrame">--%>
        <a href="${ctx}/jsp/person/person_info_finished.jsp" target="mainFrame">
            <button>个人中心</button>
        </a>
    </div>
</div>
</div>
<script type="text/javascript " src="${ctx}/js/common_dish_pb_order.js"></script>
<script>
    function load_car(){
        //获取购物车中的信息 ---start
        $.ajax({
            url: "http://192.168.1.180:8080/cart/list.do",
            xhrFields: {           withCredentials: true       },
            crossDomain: true,
            type : "POST",
            dataType: "json",
            error : function(xhr, status, error) {
                console.info(JSON.stringify(xhr));
            },
            success : function(car_obj) {
                console.log("购物车状态="+car_obj.status);
                if(car_obj.status=='1'){
                    console.log("购物车状态异常");
                    return;
                }

                car_dish_list=car_obj.data.cartDishVoList;
                console.log("car_dish_list.length="+car_dish_list.length);
                // initial_car_num();
                console.log("initial_car_num已经执行");

                // 更新顶部购物车内的数量。
                var html = car_dish_list.length;
                $("#dishType_num").html(html);
                // var nnum=parseInt(num);
                // console.log("car_num="+nnum);
                if(html==0){
                    // console.log("car_num="+nnum);
                    if(!$("#dishType_num").hasClass('hidden'))
                        $("#dishType_num").addClass("hidden");
                }
                else{
                    if($("#dishType_num").hasClass('hidden')){
                        $("#dishType_num").removeClass('hidden');
                    }
                    // $("#dishType_num").innerHTML(car_dish_list.length);
                }

            }
        });
        //获取购物车中的信息  ---end
    }
    function initail_header_btn(){
        $(".pb").click(function () {
            console.log("开始初始化 pb-button");
            load_car();

        });
    }
    $(document).ready(function(){
        console.log("document).ready已经执行");
        load_car();
        initail_header_btn();



    });
</script>
</body>
</html>