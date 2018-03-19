function timestampToTime(timestamp) { //时间戳转为时间
    var date = new Date(timestamp);//时间戳为10位需*1000，时间戳为13位的话不需乘1000
    Y = date.getFullYear() + '/';
    M = (date.getMonth()+1 < 10 ? '0'+(date.getMonth()+1) : date.getMonth()+1) + '/';
    D = date.getDate() + ' ';
    h = date.getHours() + ':';
    m = date.getMinutes();
//        s = date.getSeconds();
    return Y+M+D+h+m;
}

function initPage(obj,currentPage,pageTotall) {//根据返回的页总数显示页码
    addPageHtml(obj,currentPage,pageTotall);
}

function addPageHtml(obj,current,pageNum) {
    obj.empty();
    /*上一页*/
    obj.append('<li><a id="pre_btn"><<</a></li>');
    if (current == 1){
        $("#pre_btn").attr("disabled",true);
        $("#pre_btn").css("pointer-events","none");
    }
    /* 中间页 */
    if (pageNum < 8){
        for (var i=1;i<= pageNum;i++){
            if(i == current){
                obj.append('<li><a class="active">'+i+'</a></li>');
                continue;
            }
            obj.append('<li><a class="pagenum">'+i+'</a></li>');
        }
    }
    if (pageNum >= 8){
        if (current>4 && pageNum>4){
            obj.append('<li><a class="pagenum">'+1+'</a></li>');
            obj.append('<li><a class="pagenum">'+2+'</a></li>');
            obj.append('<li><a id="dot1"><span>...</span></a></li>');
        }
        /*中间页*/
        if (current >4 && current <= pageNum-3) {
            var start  = current - 1,end = current + 1;
        }else if(current >4 && current > pageNum-3){
            var start  = pageNum - 3,end = pageNum;
        }else{
            var start = 1,end = 7;
        }
        for (;start <= end;start++) {
            if (start <= pageNum && start >=1) {
                if (start == current) {
                    obj.append('<li><a class="active">'+start+'</a></li>');
                } else if(start == current+1){
                    obj.append('<li><a id="pagenum">'+ start +'</a></li>');
                }else{
                    obj.append('<li><a class="pagenum">'+ start +'</a></li>');
                }
            }
        }
        if (end < pageNum) {
            if (end != (pageNum-1)){
                obj.append('<li><a id="dot2"><span>...</span></a></li>');
            }
            obj.append('<li><a class="pagenum">'+pageNum+'</a></li>');
        }
    }
    /*下一页*/
    obj.append('<li><a id="next_btn">>></a></li>');
    if (current == pageNum) {
        $("#next_btn").attr("disabled",true);
        $("#next_btn").css("pointer-events","none");
    }
}

function addNewsPageEvent() {
    $("#pre_btn").click(function () {
        --currentPage; //除去上一页btn
        console.log(currentPage);
        $("#newList").empty();//empty原来的news
        requestNewsPages(); //添加新的news
    });

    $("#next_btn").click(function () {
        ++currentPage; //除去上一页btn
        console.log(currentPage);
        $("#newList").empty();//empty原来的news
        requestNewsPages(); //添加新的news
    });

    $(".pagenum").click(function () {
        // console.log("come on ?？");
        var currentPageString = $(this).text().trim();
        currentPage = Number(currentPageString);
        console.log(currentPage);
        $("#newList").empty();
        requestNewsPages();
    });
    console.log("event finished!");
}

function addOrderPageEvent() {
    $("#pre_btn").click(function () {
        --currentPage; //除去上一页btn
        console.log(currentPage);
        $(".order_history ul").empty();//empty原来的news
        newOrderList();
    });

    $("#next_btn").click(function () {
        ++currentPage; //除去上一页btn
        console.log(currentPage);
        $(".order_history ul").empty();
        newOrderList();
    });

    $(".pagenum").click(function () {
        console.log("come on ?？");
        var currentPageString = $(this).text().trim();
        currentPage = Number(currentPageString);
        console.log(currentPage);
        $(".order_history ul").empty();
        newOrderList();
    });
    console.log("event finished!");
}

function addDishPageEvent() {
    $("#pre_btn").click(function () {
        --currentPage; //除去上一页btn
        console.log(currentPage);
        $(".dish_list ul").empty();//empty原来的news
        get_dish_list(current_dishID,currentPage,pageSize);
    });

    $("#next_btn").click(function () {
        ++currentPage; //除去上一页btn
        console.log(currentPage);
        $(".dish_list ul").empty();
        // newOrderList();
        get_dish_list(current_dishID,currentPage,pageSize);
    });

    $(".pagenum").click(function () {
        console.log("come on ?？");
        var currentPageString = $(this).text().trim();
        currentPage = Number(currentPageString);
        console.log(currentPage);
        $(".dish_list ul").empty();
        get_dish_list(current_dishID,currentPage,pageSize);
    });
    console.log("event finished!");
}