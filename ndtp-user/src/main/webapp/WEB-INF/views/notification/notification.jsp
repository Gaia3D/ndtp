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
                    message: content
                });
            });

            $(".growl").click(event => {
                const eventMessage = event.delegateTarget.children[2].textContent;
                // console.log("message=", eventMessage);
                const openIndex = eventMessage.lastIndexOf("(");
                const commaIndex = eventMessage.lastIndexOf(",");
                const closeIndex = eventMessage.lastIndexOf(")");

                const latitude = parseFloat(eventMessage.substring(openIndex+1, commaIndex));
                const longitude = parseFloat(eventMessage.substring(commaIndex+2, closeIndex));

                // todo: connect flyto
                console.log("go to("+latitude+", "+longitude+")");

                // genBuild(126.92377563766438, 37.5241752651257 , 0.3);
                makeBuilding();
                // $("#testBuilding").trigger("click");
                setTimeout(() => {
                    event.delegateTarget.children[0].click();
                }, 200);
            });
        },
        error:function(request,status,error) {
            console.log("err=", request, status, error);
        }
    });

    function makeBuilding(perm_seq, magoInstance) {
        let data = {
            isComplete: "N",
            constructor: "건축주1",
            permSeq: perm_seq
        };
        $.ajax({
            url: "/data/simulation-rest/getPermRequestByConstructor",
            type: "POST",
            headers: {"X-Requested-With": "XMLHttpRequest"},
            data: data,
            dataType: "json",
            success: function(msg){
                debugger;
                const result = SampleJsonSejon;
                const resultObj = makeSampleJson(result);
                var f4dController = MAGO3D_INSTANCE.getF4dController();
                f4dController.addF4dGroup(resultObj);
                whole_viewer.scene.camera.flyTo({
                    destination : Cesium.Cartesian3.fromDegrees(126.9785978787040, 37.56690158584144, 1000)
                });
            },
            error:function(request,status,error) {
                alert('error');
                console.log("err=", request, status, error);
            }
        });
    }

    function makeSampleJson(sampleJson) {
        var object = {
            "attributes": {
                "isPhysical": false,
                "nodeType": " root ",
                "projectType": "collada",
                "specularLighting": true
            },
            "children": [],
            "parent": 0,
            "depth": 1,
            "view_order": 2,
            "data_key": "ds-service\\finish\\202002261053137\\Output",
            "data_name": "ds-service\\finish\\202002261053137\\Output",
            "mapping_type": "origin"
        }

        for(var i = 0; i < SampleJsonSejon.length; i++) {
            var obj = SampleJsonSejon[i];
            var dataKey = obj.data_key;
            var lat = obj.latitude;
            var lon = obj.longitude;

            var imsiObj = {
                "attributes": {
                    "isPhysical": true,
                    "nodeType": "daejeon",
                    "flipYTexCoords": true
                },
                "children": [],
                "data_key": "",
                "data_name": "",
                "mapping_type":"origin",
                "longitude": 0,
                "latitude": 0,
                "height": -5.000000,
                "heading": 48.000000,
                "pitch": 0.000000,
                "roll": 0.000000
            };

            imsiObj.data_key = dataKey;
            imsiObj.data_name = dataKey;
            imsiObj.latitude = lat;
            imsiObj.longitude = lon;
            object.children.push(imsiObj);
        }
        return object;
    }
    var SampleJsonSejon =
    [
        {
            "data_key" : "KSJ_100",
            "longitude" : 127.27030500949927,
            "latitude" : 36.524662808423344,
        }
    ]

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