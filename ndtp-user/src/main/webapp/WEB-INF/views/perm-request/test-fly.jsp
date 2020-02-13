<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script type="text/javascript" src="/externlib/jquery-3.3.1/jquery.min.js"></script>
<script type="text/javascript" src="/externlib/jquery-ui-1.12.1/jquery-ui.min.js"></script>

<script src="/externlib/cesium/Cesium.js" type="text/javascript"></script>
<link href="/externlib/cesium/Widgets/widgets.css" rel="stylesheet" type="text/css" />

<div id="testingDialog" title="tttttt" class="basicTable" style="display: none;">
    <div id="cesiumContainer" style="width:auto; height:600px;"></div>
    <div id="toolbar">
        <h5>항공기 관점 변경하기</h5>
        <div id="camcontrol">
            <input type="button" class="cesium-button" value="btn1" onclick="look1();">
            <input type="button" class="cesium-button" value="btn2" onclick="look2();">
            <input type="button" class="cesium-button" value="btn3" onclick="look3();">
        </div>
    </div>
</div>
<script>
    var extent = Cesium.Rectangle.fromDegrees(117.896284, 31.499028, 139.597380, 43.311528);

    Cesium.Camera.DEFAULT_VIEW_RECTANGLE = extent;
    Cesium.Camera.DEFAULT_VIEW_FACTOR = 0;

    Cesium.Ion.defaultAccessToken = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJqdGkiOiJkOGMxZjMzNy01N2FkLTQ3YTctODU0NS05NGY0MmE3MGJiOWEiLCJpZCI6NjExNywic2NvcGVzIjpbImFzciIsImdjIl0sImlhdCI6MTU0NTI3OTE3NH0.6VdcqK6vL7faWx_vYkkOuNNa8dapTn1geCi7qYBhGCw';
    var viewer = new Cesium.Viewer('cesiumContainer',
        {
            timeline : false,
            animation : false,
            selectionIndicator : false,
            navigationHelpButton : false,
            infoBox : false,
            navigationInstructionsInitiallyVisible : false
        });
    function look1(){
        height = 1000;
        viewer.scene.camera.flyTo({
            destination : Cesium.Cartesian3.fromDegrees(127.786754, 36.643957, height)
        });
        console.log("look1 height=", height);
    }
    function look2(){
        viewer.scene.camera.flyTo({
            destination : Cesium.Cartesian3.fromDegrees(128.075929, 33.014948, 500000.0),
            orientation : {
                heading : Cesium.Math.toRadians(0),
                pitch : Cesium.Math.toRadians(-420),
                roll : Cesium.Math.toRadians(0)
            }
        });
    }
    function look3(){
        viewer.scene.camera.flyTo({
            destination : Cesium.Cartesian3.fromDegrees(128.075929, 33.014948, 500000.0),
            orientation : {
                heading : Cesium.Math.toRadians(10),
                pitch : Cesium.Math.toRadians(0),
                roll : 0.0
            }
        });
    }


</script>

<style>

</style>