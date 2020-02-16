<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%--<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js" type="text/javascript"></script>--%>
<%--<script type="text/javascript" src="/externlib/jquery-3.3.1/jquery.min.js"></script>--%>
<%--<script type="text/javascript" src="/externlib/jquery-ui-1.12.1/jquery-ui.min.js"></script>--%>
<%--<script type="text/javascript" src="/js/${lang}/map-controll.js"></script>--%>

<script src="/externlib/notification/jquery.growl.js" type="text/javascript"></script>
<link href="/externlib/notification/jquery.growl.css" rel="stylesheet" type="text/css" />

<script src="/externlib/cesium/Cesium.js" type="text/javascript"></script>
<link href="/externlib/cesium/Widgets/widgets.css" rel="stylesheet" type="text/css" />

<script>
    Growl.settings.duration = 100000; // 100
    let data = {
        is_complete: "N",
        constructor: "아무개",
    };

    $.ajax({
        url: "/data/simulation-rest/getPermRequest",
        type: "POST",
        headers: {"X-Requested-With": "XMLHttpRequest"},
        data: data,
        dataType: "json",
        success: function(msg){
            console.log("msg  =", msg);

            msg.forEach(obj => {
                console.log("위도 =", obj.latitude, " 경도=", obj.longitude);
                let content = obj.constructor+"님의 건축인 허가 신청입니다. 좌표 ("+obj.latitude+", "+obj.longitude+")";
                $.growl.notice({
                    title: "민원이 접수되었습니다.",
                    message: content,
                    // url: "www.naver.com"
                });
            });

            $(".growl").click(event => {
                console.log("whole_viewer=", whole_viewer);

                const eventMessage = event.delegateTarget.children[2].textContent;
                // console.log("message=", eventMessage);
                const openIndex = eventMessage.lastIndexOf("(");
                const commaIndex = eventMessage.lastIndexOf(",");
                const closeIndex = eventMessage.lastIndexOf(")");

                const latitude = parseFloat(eventMessage.substring(openIndex+1, commaIndex));
                const longitude = parseFloat(eventMessage.substring(commaIndex+2, closeIndex));

                // todo: connect flyto
                console.log("go to("+latitude+", "+longitude+")");

                whole_viewer.scene.camera.flyTo({
                    destination : Cesium.Cartesian3.fromDegrees(latitude, longitude, 1000)
                });

                setTimeout(() => {
                    event.delegateTarget.children[0].click();
                }, 200);
            });
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