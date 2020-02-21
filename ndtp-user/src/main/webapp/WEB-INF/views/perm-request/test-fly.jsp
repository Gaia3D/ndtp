<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script type="text/javascript" src="/externlib/jquery-3.3.1/jquery.min.js"></script>
<script type="text/javascript" src="/externlib/jquery-ui-1.12.1/jquery-ui.min.js"></script>

<script src="/externlib/cesium/Cesium.js" type="text/javascript"></script>
<link href="/externlib/cesium/Widgets/widgets.css" rel="stylesheet" type="text/css" />

<div id="testingDialog" title="test fly" class="basicTable" style="display: none;">
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
    let extent = Cesium.Rectangle.fromDegrees(117.896284, 31.499028, 139.597380, 43.311528);

    Cesium.Camera.DEFAULT_VIEW_RECTANGLE = extent;
    Cesium.Camera.DEFAULT_VIEW_FACTOR = 0;

    Cesium.Ion.defaultAccessToken = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJqdGkiOiJkOGMxZjMzNy01N2FkLTQ3YTctODU0NS05NGY0MmE3MGJiOWEiLCJpZCI6NjExNywic2NvcGVzIjpbImFzciIsImdjIl0sImlhdCI6MTU0NTI3OTE3NH0.6VdcqK6vL7faWx_vYkkOuNNa8dapTn1geCi7qYBhGCw';
    let viewer = new Cesium.Viewer('cesiumContainer',
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
        // let url = "https://sandcastle.cesium.com/SampleData/models/DracoCompressed/CesiumMilkTruck.gltf";
        let url = "http://localhost/data/simulation-rest/cityPlanModelSelect";
        console.log("BASELINE url=", url);
        createModel(url, 1);
    }
    function look3(){
        // let url = "https://sandcastle.cesium.com/SampleData/models/DracoCompressed/CesiumMilkTruck.gltf";
        let url = "http://localhost/data/simulation-rest/cityPlanModelSelect2";
        console.log("13 url=", url);
        createModel(url, 1);
    }

    function createModel(url, height) {
        viewer.entities.removeAll();
        let pinBuilder = new Cesium.PinBuilder();

        let position = Cesium.Cartesian3.fromDegrees(127.786754, 36.643957, height);
        // let heading = Cesium.Math.toRadians(135);
        // let pitch = 0;
        // let roll = 0;
        // let hpr = new Cesium.HeadingPitchRoll(heading, pitch, roll);
        // let orientation = Cesium.Transforms.headingPitchRollQuaternion(position, hpr);

        let entity = viewer.entities.add({
            name : url,
            billboard : {
                image : pinBuilder.fromText('!', Cesium.Color.BLACK, 48).toDataURL(),
                // horizontalOrigin: Cesium.HorizontalOrigin.LEFT,
                verticalOrigin: Cesium.VerticalOrigin.BOTTOM,
                // eyeOffset: new Cesium.Cartesian3(0, 800.0504106, 0)
                eyeOffset: new Cesium.Cartesian3(0, 3.0504106, 0)
                // height: 10
            },
            position : position,
            // orientation : orientation,
            model : {
                uri : url,
                minimumPixelSize : 128,
                maximumScale : 20000
            }
        });
        viewer.trackedEntity = entity;


        // let height = viewer.scene.sampleHeight(position);
        // let possss = Cesium.Cartesian3.fromDegrees(61.296382224724795,35.628536117000692, 12);
        let cartesian3 = viewer.scene.clampToHeight(position);

        let carto  = Cesium.Ellipsoid.WGS84.cartesianToCartographic(cartesian3);
        let lon = Cesium.Math.toDegrees(carto.longitude);
        let lat = Cesium.Math.toDegrees(carto.latitude);
        console.log(lon, lat, carto.height);

        viewer.entities.add({
            position: cartesian3,
            ellipsoid : {
                radii : new Cesium.Cartesian3(20, 20, 20),
                material : Cesium.Color.RED
            }
        });

        viewer.scene.camera.flyTo({
            destination : Cesium.Cartesian3.fromDegrees(lon, lat, carto.height)
        });


        // viewer.scene.clampToHeightMostDetailed(position).then(function(clampedCartesians) {
        //     debugger;
        //     viewer.entities.add({
        //         position: clampedCartesians,
        //         ellipsoid : {
        //             radii : new Cesium.Cartesian3(0.2, 0.2, 0.2),
        //             material : Cesium.Color.RED
        //         }
        //     });
        // });

    }



</script>

<style>

</style>