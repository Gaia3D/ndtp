<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%--<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js" type="text/javascript"></script>--%>
<script type="text/javascript" src="/externlib/jquery-3.3.1/jquery.min.js"></script>
<script type="text/javascript" src="/externlib/jquery-ui-1.12.1/jquery-ui.min.js"></script>

<script src="/externlib/notification/jquery.growl.js" type="text/javascript"></script>
<link href="/externlib/notification/jquery.growl.css" rel="stylesheet" type="text/css" />

<script>
    Growl.settings.duration = 100000;
    let data = {
        is_complete: "N",
        constructor: "김도현",
    };

    $.ajax({
        url: "/data/simulation-rest/getPermRequest",
        type: "POST",
        headers: {"X-Requested-With": "XMLHttpRequest"},
        data: data,
        dataType: "json",
        success: function(msg){
            msg.forEach(obj => {
                console.log(obj);
                let content = obj.constructor+"님의 건축인 허가 신청입니다.";
                $.growl.notice({
                    title: "민원이 접수되었습니다.",
                    message: content,
                    // url: "/kittens"
                });
            });
        },
        error:function(request,status,error) {
            console.log("err=", request, status, error);
        }
    });


</script>

<style>
    #growls-default {
        background-color: blue;
        top: 20px;
        right: 10px; }
    #growls-tl {
        top: 10px;
        left: 10px; }
    #growls-tr {
        top: 10px;
        right: 10px; }
    #growls-bl {
        bottom: 10px;
        left: 10px; }
    #growls-br {
        bottom: 10px;
        right: 10px; }
    #growls-tc {
        top: 10px;
        right: 10px;
        left: 10px; }
    #growls-bc {
        bottom: 10px;
        right: 10px;
        left: 10px; }
    #growls-cc {
        top: 50%;
        left: 50%;
        margin-left: -125px; }
    #growls-cl {
        top: 50%;
        left: 10px; }
    #growls-cr {
        top: 50%;
        right: 10px; }
    #growls-tc .growl, #growls-bc .growl {
        margin-left: auto;
        margin-right: auto; }

    /*.growl.growl-notice {*/
    /*    color: #FFF;*/
    /*    background: blue; }*/
    /*#growls-default {*/
    /*    vertical-align: bottom;*/
    /*    bottom: 10px;*/
    /*    right: 10px; }*/
    /*#growls-tl {*/
    /*    bottom: 10px;*/
    /*    left: 10px; }*/
    /*#growls-tr {*/
    /*    bottom: 10px;*/
    /*    right: 10px; }*/
    /*#growls-bl {*/
    /*    bottom: 10px;*/
    /*    left: 10px; }*/
    /*#growls-br {*/
    /*    bottom: 10px;*/
    /*    right: 10px; }*/
    /*#growls-tc {*/
    /*    bottom: 10px;*/
    /*    right: 10px;*/
    /*    left: 10px; }*/
    /*#growls-bc {*/
    /*    bottom: 10px;*/
    /*    right: 10px;*/
    /*    left: 10px; }*/
    /*#growls-cc {*/
    /*    bottom: 50%;*/
    /*    left: 50%;*/
    /*    margin-left: -125px; }*/
    /*#growls-cl {*/
    /*    bottom: 50%;*/
    /*    left: 10px; }*/
    /*#growls-cr {*/
    /*    bottom: 50%;*/
    /*    right: 10px; }*/
    /*#growls-tc .growl, #growls-bc .growl {*/
    /*    margin-left: auto;*/
    /*    margin-right: auto; }*/

    /*.growl {*/
    /*    bottom: 10px;*/
    /*    opacity: 1;*/
    /*    filter: alpha(opacity=80);*/
    /*    position: relative;*/
    /*    border-radius: 4px;*/
    /*    -webkit-transition: all 0.4s ease-in-out;*/
    /*    -moz-transition: all 0.4s ease-in-out;*/
    /*    transition: all 0.4s ease-in-out; }*/

    /*.growl.growl-notice {*/
    /*    position: absolute;*/
    /*    right: 20px;*/
    /*    bottom: 20px;*/
    /*    color: #FFF;*/
    /*    background: #2ECC71; }*/

    /*.growl {*/
    /*    position: absolute;*/
    /*    bottom: 10px;*/
    /*    opacity: 1;*/
    /*    filter: alpha(opacity=80);*/
    /*    position: relative;*/
    /*    border-radius: 4px;*/
    /*    -webkit-transition: all 0.4s ease-in-out;*/
    /*    -moz-transition: all 0.4s ease-in-out;*/
    /*    transition: all 0.4s ease-in-out; }*/
    /*.growl.growl-incoming {*/
    /*    opacity: 1;*/
    /*    filter: alpha(opacity=1); }*/
    /*.growl.growl-outgoing {*/
    /*    opacity: 1;*/
    /*    filter: alpha(opacity=1); }*/
    /*.growl.growl-small {*/
    /*    width: 200px;*/
    /*    padding: 5px;*/
    /*    margin: 5px; }*/
    /*.growl.growl-medium {*/
    /*    width: 250px;*/
    /*    padding: 10px;*/
    /*    margin: 10px; }*/
    /*.growl.growl-large {*/
    /*    width: 300px;*/
    /*    padding: 15px;*/
    /*    margin: 15px; }*/
    /*.growl.growl-default {*/
    /*    color: #FFF;*/
    /*    background: #7f8c8d; }*/
    /*.growl.growl-error {*/
    /*    color: #FFF;*/
    /*    background: #C0392B; }*/
    /*.growl.growl-notice {*/
    /*    position: absolute;*/
    /*    right: 20px;*/
    /*    color: #FFF;*/
    /*    background: #2ECC71; }*/
    /*.growl.growl-warning {*/
    /*    color: #FFF;*/
    /*    background: #F39C12; }*/
    /*.growl .growl-close {*/
    /*    cursor: pointer;*/
    /*    float: right;*/
    /*    font-size: 14px;*/
    /*    line-height: 18px;*/
    /*    font-weight: normal;*/
    /*    font-family: helvetica, verdana, sans-serif; }*/
    /*.growl .growl-title {*/
    /*    font-size: 18px;*/
    /*    line-height: 24px; }*/
    /*.growl .growl-message {*/
    /*    font-size: 14px;*/
    /*    line-height: 18px; }*/

</style>