/*全局变量*/
//订单号
var orderNo = 0 ;

$(document).ready(function () {
    /*订单详情*/
    orderDetail();
    console.log("订单号11:"+orderNo);
    /*支付订单*/

});

/*订单详情*/
function  orderDetail() {
    $.ajax({
        url:"http://192.168.1.180:8080/doft/order/detail.do" ,
        // url: "http://192.168.1.180:8080/cart/list.do",
        xhrFields: {           withCredentials: true       },
        crossDomain: true,
        type: "POST" ,
        dataType:"json" ,
        error:function (xhr, status, error) {
            console.info(JSON.stringify(xhr));
        },
        success:function (responseObj) {
            if(responseObj.status == '1'){
                console.log("订单详情异常");
                return ;
            }
            // responseObj.data == null
            /*这种情况是用户未登录时*/
            if(responseObj.data.orderNo == null){
                $(".filter").hide();
                $(".filter all_function_btn").hide();
                var tip ="亲，您还没有创建订单哦，赶快去点餐吧！";
                var showMsg = '<p>'+tip+'</p> ';
                $(".none_order").append(showMsg);
                return ;
            }
            $(".none_order").css("height 0 ; width 0; display none;");
            $(".none_order p").css("height 0 ; width 0; display none;");
            $(".none_order").remove(showMsg);
            /*订单标题*/
            var order = responseObj.data ;
            orderNo = order.orderNo ;
            console.log("订单号:"+orderNo);
            var creationDate = order.creationDate ;
            var orderStatus = order.orderStatusDesc ;
            var orderTitle = '<div class="order_no_time">\n' +
                '            <p  id="order_no_p">订单号: '+ orderNo +'</p>\n' +
                '            <p  id="order_time_p">'+creationDate+'</p>\n' +
                '        </div>\n' +
                '        <div class="order_status">\n' +
                '            <p  id="order_status_p">'+orderStatus+'</p>\n' +
                '        </div>\n' ;
            $('.order_title').append(orderTitle);

            /*菜品列表*/
            var orderDetail = order.orderDetailList;
            var i ;
            /*输出菜品数量*/
            console.log(orderDetail.length+'菜品数量');
            for(i=0 ; i<orderDetail.length ; i++){
                var dishName = orderDetail[i].dishName;
                var price = orderDetail[i].currentUnitPrice ;
                var count = orderDetail[i].dishCount ;
                var price_count = orderDetail[i].totalPrice;
                console.log(dishName+'菜品名');
                console.log(price+'价格');
                console.log(count+'数量');
                console.log(price_count+'单个菜品总价');
                var dish_html = '<li>\n' +
                    '                <div class="dish">\n' +
                    '                    <div class="dish_info">\n' +
                    '                        <div class="dish_img">\n' +
                    '                            <img src="${ctx}/resource/img/dishes/_三文鱼刺身.jpg">\n' +
                    '                        </div>\n' +
                    '                        <div class="dish_inf_name">\n' +
                    '                            <p>'+dishName+'</p>\n' +
                    '                        </div>\n' +
                    '                    </div>\n' +
                    '                    <div class="dish_inf_money">\n' +
                    '                        <p>￥<span>'+price+'</span></p>\n' +
                    '                    </div>\n' +
                    '                    <div class="dish_count">\n' +
                    '                        <p>'+count+'</p>\n' +
                    '                    </div>\n' +
                    '                    <div class="dish_inf_act">\n' +
                    '                        <p>满减</p>\n' +
                    '                    </div>\n' +
                    '                    <div class="dish_totle_money">\n' +
                    '                        <p>'+price_count +'</p>\n' +
                    '                    </div>\n' +
                    '                </div>\n' +
                    '            </li>';
                $(".dish_list ul").append(dish_html);
            }
            // /*餐桌信息*/
            // var imgURL = "../../resource/img/dishes/timg.jpeg";
            // /*var url = "./order_history.jsp"*/
            // var peopleCount = order.peopleCount;
            // var desk_price = 3 ;
            // var desk_money = desk_price * peopleCount ;
            //
            // var desk_html = ' <li>\n' +
            //     '                <div class="dish">\n' +
            //     '                    <div class="dish_info">\n' +
            //     '                        <div class="dish_img">\n' +
            //     '                          <img src='+imgURL+'>\n' +
            //     '                        </div>\n' +
            //     '                        <div class="dish_inf_name">\n' +
            //     '                            <p>餐桌</p>\n' +
            //     '                        </div>\n' +
            //     '                    </div>\n' +
            //     '                    <div class="dish_inf_money">\n' +
            //     '                        <p>￥<span>'+desk_price+'</span></p>\n' +
            //     '                    </div>\n' +
            //     '                    <div class="dish_count">\n' +
            //     '                        <p>'+peopleCount +'</p>\n' +
            //     '                    </div>\n' +
            //     '                    <div class="dish_inf_act">\n' +
            //     '                    </div>\n' +
            //     '                    <div class="dish_totle_money">\n' +
            //     '                        <p>'+desk_money +'</p>\n' +
            //     '                    </div>\n' +
            //     '                </div>\n' +
            //     '            </li>' ;
            // $(".dish_list ul").append(desk_html);

            /*总价*/
            var total_price = order.totalPrice;
            var discount_inf = 20;
            var total_price_html = ' <p class="money_inf" >合计: ￥<span>'+total_price +'</span></p>\n' +
                '        <p class="discount_inf">已优惠<span>'+discount_inf+'</span>元</p>';
            $(".all_totle_money ").append(total_price_html);

            /*支付订单*/
            orderPay();
        }
    });
}
/*支付订单*/
function orderPay() {
    $.ajax({
        url: "http://192.168.1.180:8080/doft/order/pay.do" ,
        xhrFields: {withCredentials: true},
        crossDomain: true,
        type: "POST",
        dataType: "json",
        data: {"orderNo":orderNo},
        error: function (xhr, status, error) {
            console.info(JSON.stringify(xhr));
        },
        success: function (responseObj) {
            if (responseObj.status == '1') {
                console.log("支付异常");
                return;
            }
            var payUrl = responseObj.data.qrUrl ;
            var payImg ='<img src='+ payUrl+' alt="扫码付款" title="扫一扫" />';
            console.log("付款码地址"+payUrl);
            $(".pay_img").append(payImg);
        }
    })
}


