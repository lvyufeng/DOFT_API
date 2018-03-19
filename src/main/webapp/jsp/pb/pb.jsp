<%--
  Created by IntelliJ IDEA.
  User: wangxue
  Date: 18/3/12
  Time: 下午4:28
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<c:ser var = "ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>指尖上的美味</title>
    <link rel="stylesheet" href="${ctx}/resource/css/bootstrap.min.css" >
    <!--<link rel="stylesheet" href="../resource/css/jquery-ui.min.css"-->
    <link rel="stylesheet" href="${ctx}/css/common.css">
    <!--<link rel="stylesheet" href="../css/dishes.css">-->
    <link rel="stylesheet" href="${ctx}/css/pb.css">
    <!--<script type="text/javascript" src="../resource/js/jquery-ui.min.js"></script>-->
    <script type="text/javascript" src="${ctx}/resource/js/jquery-1.12.4.js"></script>

</head>
<body>
<div id="left">
    <a style="text-decoration: none">
        <div id="sideBar" >
            <ul class="nav  nav-stacked">
                <%--<li  value="0" class="bar" ><a href="${ctx}/jsp/dishes/dishes.jsp">日本菜</a></li>--%>
            </ul>
        </div>
    </a>
</div>
<div id="contain">
    <br/>
    <div class="dish_list">
        <ul>
            <li id="empty_tips" class="hidden">
                <p>购物车空空如也，赶快去点菜吧！(*^__^*) 嘻嘻……</p>
            </li>
            <%--<li>--%>
                <%--<div class="dish">--%>
                    <%--<div class="dish_img">--%>
                        <%--<img src="${ctx}/resource/img/dishes/_三文鱼刺身.jpg">--%>
                    <%--</div>--%>
                    <%--<div class="dish_inf">--%>
                        <%--<div class="dish_inf_name">--%>
                            <%--<p>三文鱼片</p>--%>
                        <%--</div>--%>
                        <%--<div class="dish_inf_money_and_recommand">--%>
                            <%--<div class="dish_inf_money">--%>
                                <%--<p>￥<input type="text" value="23"  class="univalent"/></p>--%>
                            <%--</div>--%>
                            <%--<div class="dish_inf_recommand">--%>
                                <%--<span>显示星星</span>--%>
                                <%--<span>5</span>--%>
                                <%--<!--<p>这里显示有多少颗星星</p>-->--%>
                            <%--</div>--%>
                        <%--</div>--%>
                        <%--<div class="dish_inf_dec">--%>
                            <%--<p>这里是对菜品的描述</p>--%>
                        <%--</div>--%>
                    <%--</div>--%>
                    <%--<div class="dish_total_money">--%>
                        <%--<p>￥<input style="width: 50px;" type="text" value="23"  class="t_price"/></p>--%>
                    <%--</div>--%>
                    <%--<div class="dish_add_pb">--%>
                        <%--<div class="pb_num ">--%>
                            <%--<em class="dec">-</em>--%>
                            <%--<input  type="text" value="1" class="num" />--%>
                            <%--<em class="add">+</em>--%>
                        <%--</div>--%>
                    <%--</div>--%>
                <%--</div>--%>
            <%--</li>--%>
        </ul>
    </div>
    <div class="up_order">
        <div class="set_time" style="text-align: right">
            <%--<div class="show_time">--%>
                <%--<span>就餐时间</span>--%>
            <%--</div>--%>
            <%--<div class="set_time_btn">--%>
                <%--<button class=" btn mybtn">修改时间</button>--%>
            <%--</div>--%>
        </div>
        <div class="total_money">
            <p>合计：<b >￥<input type="text" value="…" id="all_price" readonly="readonly"/></b></p>
            <br>
            <p >已优惠<input value="20" type="text" id="pre_price" readonly="readonly"/>元</p>
        </div>
        <div class="button_up">
                <button class=" btn mybtn">提交订单</button>
        </div>
    </div>
</div>
<script type="text/javascript " src="${ctx}/js/common_dish_pb_order.js"></script>
<script>
    var bar=document.getElementsByClassName("bar");
    var is_addedSeat;
    // var add_dish_num=1;
    // var dec_dish_num=-1;
    // var car_dish_list=new Object();

    // 向后台更新对应菜品id 下的 菜品数量
    function change_dish_num(dish_id,dish_num){
        $.ajax({
            url: "http://192.168.1.180:8080/cart/add.do",
            xhrFields: {           withCredentials: true       },
            crossDomain: true,
            type : "POST",
            data :{"dishId":dish_id,"count":dish_num},
            dataType: "json",
            error : function(xhr, status, error) {
                console.info(JSON.stringify(xhr));
            },
            success : function(responsedObj) {
                console.log("该菜品加入购物车成功！");
            }

        });

    }

    // 计算 菜品单价 * 菜品数量 = 菜品总价
    function UTPrice(){
        var t_price=document.getElementsByClassName("t_price");
        var univalent=document.getElementsByClassName("univalent");
        var num=document.getElementsByClassName("num");
        for(var i=0;i<t_price.length;i++){
            var univalent_v=univalent[i].value;
            var num_v=num[i].value;
            var t_price_new=univalent_v*num_v;
            $(t_price[i]).val(t_price_new);
        }
    }

    // 通过页面元素 计算购物车中的总价
    function UAprice(){
        var t_price=document.getElementsByClassName("t_price");
        var price=0;
        if(t_price.length==0){
            $("#all_price").val(price);
        }
        else{
            for(var i=0;i<t_price.length;i++){
                var price_one=t_price[i].value;
                price = price + parseInt(price_one);
                console.log(price);
            }
            $("#all_price").val(price);
        }
    }

    //在购物车页面中加载 指定的菜品
    function Up_car_list(dish_id,quantites,dishName,dishPrice,dishImgUrl,dishTotalPrice) {
        var html='<li value='+dish_id+'>\n' +
            '                <div class="dish">\n' +
            '                    <div class="dish_img">\n' +
            '                        <img src='+dishImgUrl+'>\n' +
            '                    </div>\n' +
            '                    <div class="dish_inf">\n' +
            '                        <div class="dish_inf_name">\n' +
            '                            <p> '+dishName+'</p>\n' +
            '                        </div>\n' +
            '                        <div class="dish_inf_money_and_recommand">\n' +
            '                            <div class="dish_inf_money">\n' +
            '                                <p>￥<input type="text" value='+dishPrice+'  class="univalent"/></p>\n' +
            '                            </div>\n' +
            // '                            <div class="dish_inf_recommand">\n' +
            // '                                <span>显示星星</span>\n' +
            // '                                <span>5</span>\n' +
            '                                <!--<p>这里显示有多少颗星星</p>-->\n' +
            // '                            </div>\n' +
            '                        </div>\n' +
            // '                        <div class="dish_inf_dec">\n' +
            // '                            <p>这里是对菜品的描述</p>\n' +
            // '                        </div>\n' +
            '                    </div>\n' +
            '                    <div class="dish_total_money">\n' +
            '                        <p>￥<input style="width: 50px;" type="text" value='+dishTotalPrice+'  class="t_price"/></p>\n' +
            '                    </div>\n' +
            '                    <div class="dish_add_pb">\n' +
            '                        <div class="pb_num ">\n' +
            '                            <em class="dec">-</em>\n' +
            '                            <input style="padding-top: 3px; font-size: 16px;" type="text" value='+quantites+' class="num" />\n' +
            '                            <em class="add">+</em>\n' +
            '                        </div>\n' +
            '                    </div>\n' +
            '                </div>\n' +
            '            </li>';
        $(".dish_list ul").append(html);

    }

    // 获取购物车中所有菜品的总价
    function get_cartTotalPrice(){
        $.ajax({
            url: "http://192.168.1.180:8080/cart/list.do",
            xhrFields: {           withCredentials: true       },
            crossDomain: true,
            type: "POST",
            dataType: "json",
            error: function (xhr, status, error) {
                console.info(JSON.stringify(xhr));
            },
            success: function (car_obj) {
                if (car_obj.status == '1') {
                    console.log("购物车状态异常");
                    return;
                }
                var cartTotalPrice=car_obj.data.cartTotalPrice;
                $("#all_price").val(cartTotalPrice);
            }
        });
    }

    //删除购物车中的菜品，但菜品数量减到0时执行。
    function delete_dish(dishID){
        $.ajax({
            url: "http://192.168.1.180:8080/cart/delete_dish.do",
            xhrFields: {           withCredentials: true       },
            crossDomain: true,
            type : "POST",
            dataType: "json",
            data:{"dishIds":dishID},
            error : function(xhr, status, error) {
                console.info(JSON.stringify(xhr));
            },
            success : function(car) {
                if (car.status == '1') {
                    console.log("菜系列表状态异常");
                    return;
                }
                console.log("dishid="+dishID+"的菜品，已经删除成功");
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
                        // 更新顶部购物车内的菜品数量
                        var html = car_dish_list.length;
                        console.log("提交订单按钮 ：html = car_dish_list.length="+html);
                        var dishType_num_in_car = window.parent.document.getElementById("dishType_num");
                        $(dishType_num_in_car).html(html);
                        if(html==0){
                            // console.log("car_num="+nnum);
                            if(!$(dishType_num_in_car).hasClass('hidden'))
                                $(dishType_num_in_car).addClass("hidden");
                        }
                        else{
                            if($(dishType_num_in_car).hasClass('hidden')){
                                $(dishType_num_in_car).removeClass('hidden');
                            }
                            // $("#dishType_num").innerHTML(car_dish_list.length);
                        }

                        //判断是否有餐位信息
                        is_addedSeat=car_obj.data.addedSeat;
                        if(is_addedSeat){
                            console.log("购物车中有餐位信息");
                            $('.button_up').attr("disabled",false);
                        }
                        else{
                            $(".set_time").append("提交订单前，请选择餐位信息！");
                            $('.button_up').attr("disabled",true);
                        }
                    }
                });
                //获取购物车中的信息  ---end

            }
        });

    }
    function initial_btn(){
        //加的效果
        $(".add").click(function(){
            var n=$(this).prev().val();
            var num=parseInt(n)+1;
            $(this).prev().val(num);
            var dishId=$(this).parent().parent().parent().parent().val();
            console.log("dish id = "+dishId+'  即将加入购物车');
            change_dish_num(dishId,add_dish_num);
            UTPrice();
            get_cartTotalPrice();
            // UAprice();

        });
        //减的效果
        $(".dec").click(function(){
            var n=$(this).next().val();
            var num=parseInt(n)-1;
            $(this).next().val(num); //写
            var dishId=$(this).parent().parent().parent().parent().val();
            console.log("dish id = "+dishId+'  即将加入购物车');
            if(num==0){
                delete_dish(dishId);
                $(this).parent().parent().parent().parent().addClass("hidden");

            }
            else{
                change_dish_num(dishId,dec_dish_num);
                UTPrice();
            }
            get_cartTotalPrice();
        });

        $(".bar").click(function(){
            console.log("当前id="+current_dishID);
            current_dishID=$(this).val();
            console.log("跳转之前点击的current_dishID="+current_dishID);
            //获取父亲页面的元素
            var header_main = window.parent.document.getElementsByClassName('header_main');
            $(header_main).attr('id',current_dishID);
            // $("#left a").attr("href":'${ctx}/jsp/dishes/dishes.jsp');
            window.location.href="../dishes/dishes.jsp";
        });
        $(".button_up").click(function(){
            if($(".button_up").attr('disabled')){ //button被禁用掉了
                console.log("button 被禁用掉了");
                $(".set_time").css('color','#fb9100');
                $(".set_time").css('font-size','17px');
                return;
            }
            // 分配餐桌
            $.ajax({
                url: "http://192.168.1.180:8080/doft/desk/getRandomFreeDeskId.aj",
                xhrFields: {           withCredentials: true       },
                crossDomain: true,
                type: "POST",
                dataType: "json",
                error: function (xhr, status, error) {
                    console.info(JSON.stringify(xhr));
                },
                success: function (responseObj) {
                    if (responseObj.status == '1') {
                        console.log("菜系列表状态异常");
                        return;
                    }
                    if (responseObj.data == 0) {
                        console.log("暂无可分配的餐桌！");
                        return;
                    }
                    var deskID = responseObj.data;
                    console.log("分配到的餐桌号为："+deskID);

                    // 提交订单
                    $.ajax({
                        url: "http://192.168.1.180:8080/doft/order/create.do",
                        xhrFields: {           withCredentials: true       },
                        crossDomain: true,
                        type: "POST",
                        dataType: "json",
                        data:{"deskId": deskID,"peopleCount":4},
                        error: function (xhr, status, error) {
                            console.info(JSON.stringify(xhr));
                        },
                        success: function (respondeObj) {
                            console.log("订单创建成功！");
                            if(respondeObj.status=='1'){
                                console.log("订单状态错误！");
                                return;
                            }
                            console.log("订单号="+respondeObj.data.orderNo);
                            // 获取购物车中的信息 ---start
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
                                        // 更新顶部购物车内的菜品数量
                                        var html = car_dish_list.length;
                                        console.log("提交订单按钮 ：html = car_dish_list.length="+html);
                                        var dishType_num_in_car = window.parent.document.getElementById("dishType_num");
                                        $(dishType_num_in_car).html(html);
                                        if(html==0){
                                            // console.log("car_num="+nnum);
                                            if(!$(dishType_num_in_car).hasClass('hidden'))
                                                $(dishType_num_in_car).addClass("hidden");
                                        }
                                        else{
                                            if($(dishType_num_in_car).hasClass('hidden')){
                                                $(dishType_num_in_car).removeClass('hidden');
                                            }
                                            // $("#dishType_num").innerHTML(car_dish_list.length);
                                        }
                                        window.location.href="../order/order.jsp";


                                    }
                                });
                                //获取购物车中的信息  ---end

                        }
                    });
                }
            });

        });


    }
    $(document).ready(function(){
        console.log("document.ready开始执行");
        // clean_active();
        $.ajax({
            url: "http://192.168.1.180:8080/dish/list_type.do",
            xhrFields: {           withCredentials: true       },
            crossDomain: true,
            type : "POST",
            dataType: "json",
            error : function(xhr, status, error) {
                console.info(JSON.stringify(xhr));
            },
            success : function(list_type) {
                if(list_type.status=='1'){
                    console.log("菜系列表状态异常");
                    return;
                }
                console.log("菜系列表可成功访问");
                dishes_length=list_type.data.length;
                dishes_list=list_type.data;
                console.log("菜系列表长度为"+dishes_length);
                for(var i=0;i<dishes_length;i++){
                    var dish=dishes_list[i];
                    // console.log(dish.dishTypeId+';'+dish.typeName);
                    var html='<li class="bar" value='
                        + dish.dishTypeId
                        + '><a>'
                        + dish.typeName
                        + '</a></li>';
                    $("#sideBar ul").append(html);

                }
            }
        });
        //获取购物车中的信息 ---start
        $.ajax({
            url: "http://192.168.1.180:8080/cart/list.do",
            xhrFields: {           withCredentials: true       },
            crossDomain: true,
            type: "POST",
            dataType: "json",
            error: function (xhr, status, error) {
                console.info(JSON.stringify(xhr));
            },
            success: function (car_obj) {
                if (car_obj.status == '1') {
                    console.log("购物车状态异常");
                    return;
                }
                car_dish_list = car_obj.data.cartDishVoList;
                console.log("car_dish_list.length=" + car_dish_list.length);
                if(car_dish_list.length==0){
                    $(".up_order").addClass("hidden");
                    $("#empty_tips").removeClass("hidden");
                }
                else{
                    for(var i=0;i<car_dish_list.length;i++){
                        var dish=car_dish_list[i];
                        var dish_id=dish.dishId;
                        var quantites=dish.quantites;
                        var dishName=dish.dishName;
                        var dishPrice=dish.dishPrice;
                        var dishImgUrl=dish.dishImgUrl;
                        var dishTotalPrice=dish.dishTotalPrice;
                        Up_car_list(dish_id,quantites,dishName,dishPrice,dishImgUrl,dishTotalPrice);
                    }
                    //加上餐桌信息
                    var cartTotalPrice=car_obj.data.cartTotalPrice;
                    $("#all_price").val(cartTotalPrice);

                    //判断是否有餐位信息
                    is_addedSeat=car_obj.data.addedSeat;
                    if(is_addedSeat){
                        console.log("购物车中有餐位信息");
                        $('.button_up').attr("disabled",false);
                    }
                    else{
                        $(".set_time").append("提交订单前，请选择餐位信息！");
                        $('.button_up').attr("disabled",true);
                    }

                }
                initial_btn();
            }
        });
        // $("#addtoPB").click(function(){
        //     var n=$(this).prev().children()[1];
        //     // console.log(n.value);
        //     n.value++;
        //     // console.log(n.value);
        //     $(n).val(n.value);
        //     $(this).prev().removeClass("hidden");
        //     $(this).addClass("hidden");
        // });


    });
</script>
<script type="text/javascript" src="${ctx}/js/pb.js"></script>
</body>
</html>
