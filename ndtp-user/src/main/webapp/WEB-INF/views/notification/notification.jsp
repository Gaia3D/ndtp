<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%--<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js" type="text/javascript"></script>--%>
<script type="text/javascript" src="/externlib/jquery-3.3.1/jquery.min.js"></script>
<script type="text/javascript" src="/externlib/jquery-ui-1.12.1/jquery-ui.min.js"></script>

<script src="/externlib/notification/jquery.growl.js" type="text/javascript"></script>
<link href="/externlib/notification/jquery.growl.css" rel="stylesheet" type="text/css" />

<script>
    Growl.settings.duration = 100000; // 100
    let data = {
        is_complete: "N",
        constructor: "testing",
    };

    $.ajax({
        url: "/data/simulation-rest/getPermRequest",
        type: "POST",
        headers: {"X-Requested-With": "XMLHttpRequest"},
        data: data,
        dataType: "json",
        success: function(msg){
            console.log("msg=", msg);
            $.growl.notice({
                title: "민원이 접수되었습니다.",
                message: "aaa",
                // url: "/kittens"
            });
            $.growl.notice({
                title: "민원이 접수되었습니다.",
                message: "bbb",
                // url: "/kittens"
            });
            $.growl.notice({
                title: "민원이 접수되었습니다.",
                message: "ccc",
                // url: "/kittens"
            });

            // msg.forEach(obj => {
            //     console.log(obj);
            //     let content = obj.constructor+"님의 건축인 허가 신청입니다.";
            //     $.growl.notice({
            //         title: "민원이 접수되었습니다.",
            //         message: content,
            //         // url: "/kittens"
            //     });
            // });
        },
        error:function(request,status,error) {
            console.log("err=", request, status, error);
        }
    });


</script>

<style>
    #growls-default {
        display: flex;
        flex-direction: column-reverse;
        /*background-color: red;*/
        bottom: 30px;
        right: 20px; }

    .growl.growl-medium {
        width: 250px;
        padding: 10px;
        margin: 5px; }


</style>