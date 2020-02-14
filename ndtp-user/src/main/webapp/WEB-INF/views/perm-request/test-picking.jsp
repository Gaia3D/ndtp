<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script type="text/javascript" src="/externlib/jquery-3.3.1/jquery.min.js"></script>
<script type="text/javascript" src="/externlib/jquery-ui-1.12.1/jquery-ui.min.js"></script>

<script src="/externlib/cesium/Cesium.js" type="text/javascript"></script>
<link href="/externlib/cesium/Widgets/widgets.css" rel="stylesheet" type="text/css" />

<div id="testingPickingDialog" title="test picking" class="basicTable" style="display: none;">
    <div id="cesiumContainer" style="width:auto; height:700px;"></div>
</div>
<script>
    var extent = Cesium.Rectangle.fromDegrees(117.896284, 31.499028, 139.597380, 43.311528);

    Cesium.Camera.DEFAULT_VIEW_RECTANGLE = extent;
    Cesium.Camera.DEFAULT_VIEW_FACTOR = 0;

    var viewer = new Cesium.Viewer('cesiumContainer', {
        timeline : false,
        animation : false,
        selectionIndicator : false,
        navigationHelpButton : false,
        infoBox : false,
        navigationInstructionsInitiallyVisible : false
    });

    // Gltf포맷 사용을 위한 변수들 선언
    var scene = viewer.scene;
    var position = Cesium.Cartesian3.fromDegrees(126.934511, 37.521004, 0);
    var modelMatrix = Cesium.Transforms.eastNorthUpToFixedFrame(position);
    // fromGltf 함수를 사용하여 key : value 값으로 요소를 지정
    scene.primitives.add(Cesium.Model.fromGltf({
        url : 'images/sample.gltf', // Gltf포맷의 위치
        modelMatrix : modelMatrix,
        scale : 5000.0
    }));


    출처: https://progworks.tistory.com/64?category=815215 [프로그웍스]


</script>

<style>

</style>