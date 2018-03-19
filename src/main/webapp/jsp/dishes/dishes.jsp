<%--
  Created by IntelliJ IDEA.
  User: wangxue
  Date: 18/3/12
  Time: 下午4:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<c:ser var = "ctx" value="${pageContext.request.contextPath}"/>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>指尖上的美味</title>
    <link rel="stylesheet" href="${ctx}/resource/css/bootstrap.min.css" >
    <!--<link rel="stylesheet" href="../resource/css/jquery-ui.min.css"-->
    <link rel="stylesheet" href="${ctx}/css/common.css">
    <link rel="stylesheet" href="${ctx}/css/dishes/dishes.css">
    <link rel="stylesheet" href="${ctx}/css/pagination.css">
    <script type="text/javascript" src="${ctx}/resource/js/jquery-1.12.4.js"></script>
    <script type="text/javascript" src="${ctx}/resource/js/bootstrap.js"></script>
</head>
<body>
<div id="left">
    <div id="sideBar">
        <ul class="nav  nav-stacked">
            <%--<li  value="0" class="bar" ><a href="#">日本菜</a></li>--%>
        </ul>
    </div>
</div>
<div id="contain">
    <div class="filter">
        <button class="btn text_btn">默认</button>
        <button class="text_btn btn">推荐</button>
        <button class="text_btn btn">价格</button>
        <button class="text_btn btn">满减</button>
    </div>
    <div class="dish_list">
        <ul>
        </ul>
    </div>
    <div class="page_wrapper">
        <ul class="pagination">
        </ul>
    </div>
    <script type="text/javascript" src="${ctx}/js/common_func.js"></script>
    <script type="text/javascript " src="${ctx}/js/common_dish_pb_order.js"></script>
    <%--<script type="text/javascript" src="${ctx}/js/dishes.js"></script>--%>
    <script>
        var dish_list; //菜品列表
        var dish_length;  //    菜品长度
        /*全局数据*/
        var currentPage; //current page index
        var newId; // messageId
        var pageSize = 6; //6 news a page
        var pageTotal; //页总数
        var dishTotal;
        function initial_num(){
            currentPage=1;
            pageTotal=1;
        }
        // var current_bar; //     当前bar
        // var car_dish_list=new Object();
        // function load_car(){
        //     //获取购物车中的信息 ---start
        //     $.ajax({
        //         url: "http://192.168.1.180:8080/cart/list.do",
        //         xhrFields: {           withCredentials: true       },
        //         crossDomain: true,
        //         type : "POST",
        //         dataType: "json",
        //         error : function(xhr, status, error) {
        //             console.info(JSON.stringify(xhr));
        //         },
        //         success : function(car_obj) {
        //             console.log("购物车状态="+car_obj.status);
        //             if(car_obj.status=='1'){
        //                 console.log("购物车状态异常");
        //                 return;
        //             }
        //
        //             car_dish_list=car_obj.data.cartDishVoList;
        //             console.log("car_dish_list.length="+car_dish_list.length);
        //
        //
        //         }
        //     });
        //     //获取购物车中的信息  ---end
        // }

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
                    change_car_num();
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

                            // //判断是否有餐位信息
                            // is_addedSeat=car_obj.data.addedSeat;
                            // if(is_addedSeat){
                            //     console.log("购物车中有餐位信息");
                            //     $('.button_up').attr("disabled",false);
                            // }
                            // else{
                            //     $(".set_time").append("提交订单前，请选择餐位信息！");
                            //     $('.button_up').attr("disabled",true);
                            // }
                        }
                    });
                    //获取购物车中的信息  ---end

                }
            });

        }

        function change_car_num(){
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
                    var html = car_dish_list.length;
                    console.log("var html = car_dish_list.length"+html);
                    var dishType_num_in_car = window.parent.document.getElementById("dishType_num");
                    $(dishType_num_in_car).html(html);
                    if(html==0){
                        $(dishType_num_in_car).addClass('hidden');
                    }
                    else{
                        $(dishType_num_in_car).removeClass('hidden');
                    }


                }
            });
            //获取购物车中的信息  ---end


        }

        //初始化加入购物车按钮
        function pb_btn(){
            console.log("pb_btn开始执行");
            var nArry = document.getElementsByClassName("num");
            var pbArry = document.getElementsByClassName("pb_num");
            // console.log(nArry.length);
            // console.log(pbArry.length);
            // console.log(nArry[i].value, typeof nArry[i].value);
            for(var i=0;i<nArry.length;i++){
                // console.log("开始执行【加入购物车】的隐藏或显示");
                // console.log("num="+nArry[i].value);
                if(nArry[i].value == 0){

                    $(pbArry[i]).addClass("hidden");
                    $(pbArry[i]).next().removeClass("hidden");
                }
                else{
                    $(pbArry[i]).next().addClass("hidden");
                    $(pbArry[i]).removeClass("hidden");

                }
            }
        }
        // 清楚所有bar的active-class
        function clean_active(){
            for(var i=0;i<bar.length;i++){
                if($(bar[i]).hasClass('active')){
                    $(bar[i]).removeClass('active');
                }
            }
            // console.log("加载工作已经执行完成");
            // $(bar[current_bar]).addClass("active");
        }

        // 在页面中加载指定的菜品
        function Upadd_dish(dish){
            var dish_num_in_car=0;
            // console.log("upadd car_dish_list.length="+car_dish_list.length);
            for(var i=0;i<car_dish_list.length;i++){
                // console.log("DB id = " + car_dish_list[i].dishId + "   dish id = " + dish.dishId);
                if(car_dish_list[i].dishId==dish.dishId){
                    dish_num_in_car+=car_dish_list[i].quantites;
                }
            }
            console.log("dish_num_in_car="+dish_num_in_car);
            var html='<li value='
                + dish.dishId
                + '><div class="dish"><div class="dish_img"><img src='
                + dish.dishImgUrl
                + '></div><div class="dish_inf"><div class="dish_inf_name"><p>'
                + dish.dishName
                + '</p></div><div class="dish_inf_money_and_recommand"><div class="dish_inf_money"><p>￥<span>'
                + dish.price
                + '</span></p></div>'
                + '<div class="dish_inf_recommand">\n' +
                '                                <span>推荐指数：</span>\n' +
                '                                <span>'+dish.recommendIndex
                +'</span></div></div>'
                + '<div class="dish_inf_dec">\n' +
                '                            <p>'+dish.description
                +'</p>\n' +
                '                        </div></div>'
                +' <div class="dish_add_pb">\n' +
                '                        <div class="pb_num ">\n' +
                '                            <em class="dec">-</em>\n' +
                '                            <input type="text" value='
                + dish_num_in_car
                +' class="num" />\n' +
                '                            <em class="add">+</em>\n' +
                '                        </div>\n' +
                '                        <button class="com_btn addtoPB">加入购物车</button>\n' +
                '                    </div></div>\n' +
                '            </li>';
            $(".dish_list ul").append(html);
        }
        // 初始化button效果以及button点击效果
        function initial_btn_center(){
            $(".addtoPB").click(function(){
                var n=$(this).prev().children()[1];
                // console.log(n.value);
                n.value++;
                // console.log(n.value);
                $(n).val(n.value);
                $(this).prev().removeClass("hidden");
                $(this).addClass("hidden");
                var dishId=$(this).parent().parent().parent().val();
                console.log("dish id = "+dishId+'  即将加入购物车');
                change_dish_num(dishId,add_dish_num);

            });
            //加的效果
            $(".add").click(function(){
                var n=$(this).prev().val();
                var num=parseInt(n)+1;
                $(this).prev().val(num);
                // if(num==0){ return;}
                var dishId=$(this).parent().parent().parent().parent().val();
                // console.log("dish id = "+dishId+';数量='+dish_num);
                console.log("dish id = "+dishId+'  即将加入购物车');
                change_dish_num(dishId,add_dish_num);

            });

            //减的效果
            $(".dec").click(function(){
                var n=$(this).next().val();
                var num=parseInt(n)-1;
                $(this).next().val(num); //写
                var dishId=$(this).parent().parent().parent().parent().val();
                // console.log("dish id = "+dishId+';数量='+dish_num);
                console.log("dish id = "+dishId+'  即将减出购物车');
                if(num==0){
                    delete_dish(dishId);
                    $(this).parent().addClass("hidden");
                    $(this).parent().next().removeClass("hidden");
                }
                else{
                    change_dish_num(dishId,dec_dish_num);
                }

            });
        }
        function initial_btn_bar(){
            console.log("initial_btn 开始执行！");
            $(".bar").click(function(){
                if(!$(this).hasClass('active')){
                    // console.log("本来没有class");
                    clean_active();
                    $(this).addClass('active');
                    if($(this).hasClass('active')){
                        // console.log("现在有class了");
                    }
                    initial_num();
                    $(".dish_list ul").empty();
                    current_dishID=$(this).val();
                    // 请求button菜系对应的菜品
                    get_dish_list(current_dishID,currentPage,pageSize);

                }
            });
        }
        function get_dish_list(typeid,curPage,paSize) {
            $.ajax({
                url: "http://192.168.1.180:8080/dish/list.do",
                xhrFields: {           withCredentials: true       },
                crossDomain: true,
                type : "POST",
                data :{"dishTypeId":typeid,"pageNum":curPage,"pageSize":pageSize},
                dataType: "json",
                error : function(xhr, status, error) {
                    console.info(JSON.stringify(xhr));
                },
                success : function(respondeObj) {
                    if(respondeObj.status==1){
                        console.log("菜系状态异常");
                        return;
                    }

                    initial_btn_bar();
                    // console.log(respondeObj);
                    dish_length=respondeObj.data.size;
                    dish_list=respondeObj.data.list;
                    console.log("currentPage="+currentPage);
                    if(dish_length==0){
                        console.log("dish 列表为空！");
                    }
                    else{
                        for(var i=0;i<dish_length;i++){
                            Upadd_dish(dish_list[i]);

                        }
                        pb_btn();
                        initial_btn_center();
                        pageTotal = respondeObj.data.pages;
                        currentPage = respondeObj.data.pageNum;
                        initPage($(".pagination ") ,currentPage  ,pageTotal );
                        addDishPageEvent();
                        // dishTotal=respondeObj.data.size;
                        // dish_length=dishes.data.size;

                    }


                    // if(!(dishTotal>pageSize)){
                    //     $(".pagination ").addClass('hidden');
                    //     return;
                    // }
                    // else{
                    //     $(".pagination ").removeClass('hidden');
                    // }
                    /*当前页*/


                }
            });
        }

        function load_dishType(typeid){
            $.ajax({
                url: "http://192.168.1.180:8080/dish/list_type.do",
                // url: "http://192.168.1.180:8080/dish/list_type.do",
                xhrFields: {           withCredentials: true       },
                crossDomain: true,
                type : "POST",
                dataType: "json",
                // jsonp:"jsonpCallback",
                error : function(xhr, status, error) {
                    console.info(JSON.stringify(xhr));
                },
                success : function(list_type) {
                    if(list_type.status=='1'){
                        console.log("菜系列表状态异常");
                        return;
                    }
                    initial_btn_bar();
                    // console.log("菜系列表可成功访问");
                    dishes_length=list_type.data.length;
                    dishes_list=list_type.data;
                    // console.log("菜系列表长度为"+dishes_length);
                    for(var i=0;i<dishes_length;i++){
                        var dish=dishes_list[i];
                        // console.log(dish.dishTypeId+';'+dish.typeName);
                        var html='<li class="bar" value='
                            + dish.dishTypeId
                            + '><a href="#">'
                            + dish.typeName
                            + '</a></li>';
                        // if(typeid=='undefined')typeid=1;
                        $("#sideBar ul").append(html);
                        if(dish.dishTypeId==typeid){
                            console.log("当前选择的bar是："+i);
                            $(bar[i]).addClass('active');
                        }
                    }
                    console.log("即将加载id为"+current_dishID+"的菜系");
                    get_dish_list(current_dishID,currentPage,pageSize);
                    // // 默认选择第二项菜系
                    // current_bar=document.getElementsByClassName('bar')[1];
                    // $(current_bar).addClass('active');
                }
            });
        }


        $(document).ready(function(){
            console.log("ready(function)开始执行,curren_dishID="+current_dishID);
            initial_num();
            var header_main = window.parent.document.getElementsByClassName('header_main');
            current_dishID=$(header_main).attr('id');
            console.log("加载列表前,curren_dishID="+current_dishID);
            load_dishType(current_dishID);
            change_car_num();


        });
    </script>
</div>
</body>
</html>