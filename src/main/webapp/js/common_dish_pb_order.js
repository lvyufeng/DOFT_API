var contentPath="${ctx}";


// 常量定义
var add_dish_num=1;
var dec_dish_num=-1;

// 点菜
var current_dishID; //     当前bar 的val值 （dishtype id）
var dish=document.getElementsByClassName('dish');
var bar=document.getElementsByClassName("bar");
var dishes_length;  //菜系列表长度
var dishes_list; //菜系列表

// 购物车定义
var car_dish_list=new Object();

// var person_num=1; //就餐人数的设置，默认1位，且至少一位。
// var meel_fee=3;   //餐位费
// var desk_dishId=0;   //餐位id,一定位于菜品列表的最后一位
// var desk_dishname='餐位';
// var desk_imgUrl='../resource/img/dishes/timg.jpeg';
// var desk_dishTotalPrice=3;
// // 订单定义


