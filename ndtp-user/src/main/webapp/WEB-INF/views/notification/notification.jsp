<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%--<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js" type="text/javascript"></script>--%>
<%--<script type="text/javascript" src="/externlib/jquery-3.3.1/jquery.min.js"></script>--%>
<%--<script type="text/javascript" src="/externlib/jquery-ui-1.12.1/jquery-ui.min.js"></script>--%>
<%--<script type="text/javascript" src="/js/${lang}/map-controll.js"></script>--%>

<script src="/externlib/notification/jquery.growl.js" type="text/javascript"></script>
<link href="/externlib/notification/jquery.growl.css" rel="stylesheet" type="text/css" />

<script src="/externlib/cesium/Cesium.js" type="text/javascript"></script>
<script type="text/javascript" src="/externlib/cesium-geoserver-terrain-provider/GeoserverTerrainProvider.js?cacheVersion=${contentCacheVersion}"></script>
<link href="/externlib/cesium/Widgets/widgets.css" rel="stylesheet" type="text/css" />
<script>
    Growl.settings.duration = 100000; // 100
    var permReqeustParam = {
        isComplete: 'N'
    }
    $.ajax({
        url: "/data/simulation-rest/getPermRequest",
        type: "POST",
        data: permReqeustParam,
        dataType: "json",
        success: function(msg) {
            console.log("msg  =", msg);
            msg.forEach(obj => {
                console.log("위도 =", obj.latitude, " 경도=", obj.longitude);
                let content = obj.constructor+"님의 건축인 허가 신청입니다. 좌표 ("+obj.latitude+", "+obj.longitude+")";
                $.growl.notice({
                    title: "민원이 접수되었습니다.",
                    message: content,
                    permSeq: obj.permSeq
                });
            });

            $(".growl").click(event => {
                const eventMessage = event.delegateTarget.children[2].textContent;
                const parmSeq = event.delegateTarget.children[3].textContent;
                // console.log("message=", eventMessage);
                const openIndex = eventMessage.lastIndexOf("(");
                const commaIndex = eventMessage.lastIndexOf(",");
                const closeIndex = eventMessage.lastIndexOf(")");

                const latitude = parseFloat(eventMessage.substring(openIndex+1, commaIndex));
                const longitude = parseFloat(eventMessage.substring(commaIndex+2, closeIndex));

                // todo: connect flyto
                console.log("go to("+latitude+", "+longitude+")");
                acceptMakeBuilding(parmSeq);
                $('#acceptBuildList').val(parmSeq);
                setTimeout(() => {
                    const fileName = "6-4_field.geojson";
                    createSpecificField(fileName);
                    event.delegateTarget.children[0].click();
                }, 200);
            });
        },
        error:function(request,status,error) {
            console.log("err=", request, status, error);
        }
    });

    function createSpecificField(fileName) {
        // const fileName = "6-4_field.geojson";
        const obj = {
            width : 5,
            leadTime : 0,
            trailTime : 100,
            resolution : 5,
            stroke: Cesium.Color.BLUEVIOLET.withAlpha(0.5),
            fill: Cesium.Color.BLUEVIOLET.withAlpha(0.5),
        };
        let url = "/data/simulation-rest/drawGeojson?fileName=" + fileName;

        Cesium.GeoJsonDataSource.load(url, obj).then(function(dataSource) {
            let entitis = dataSource.entities._entities._array;

            for(let index in entitis) {
                let entitiyObj = entitis[index];
                let registeredEntity = _viewer.entities.add(entitiyObj);
                registeredEntity.name = "specificField_6_4";
            }
        }, function(err) {
            console.log(err);
        });
    }

    function acceptMakeBuilding(perm_seq) {
        let data = {
            permSeq: perm_seq
        };
        // debugger;
        $.ajax({
            url: "/data/simulation-rest/getPermRequestByConstructor",
            type: "POST",
            headers: {"X-Requested-With": "XMLHttpRequest"},
            data: data,
            dataType: "json",
            success: function(msg){
                buildAcceptPermSeq = msg.permSeq;
                const longitude = msg.longitude;
                const latitude = msg.latitude;
                const altitude = msg.altitude;
                const heading = msg.heading;
                const pitch = msg.pitch;
                const roll = msg.roll;
                const f4dObject = f4dDataGenMaster.initIfc(msg.f4dObject, longitude, latitude, altitude, heading, pitch, roll);
                // let f4dObject = makeF4dObject(msg.f4dObject);
                // f4dObject.children = makeF4dSubObject(msg.f4dObject.f4dSubList, longitude, latitude, altitude, heading, pitch, roll);

                var f4dController = MAGO3D_INSTANCE.getF4dController();
                f4dController.addF4dGroup(f4dObject);
                whole_viewer.scene.camera.flyTo({
                    destination : Cesium.Cartesian3.fromDegrees(longitude, latitude, 200)
                });
            },
            error:function(request,status,error) {
                alert('error');
                console.log("err=", request, status, error);
            }
        });
    }
</script>

<style>
    .growl.growl-medium {
        width: 250px;
        padding: 10px;
        margin: 5px; }


</style>