<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script type="text/javascript" src="/externlib/jquery-3.3.1/jquery.min.js"></script>
<script type="text/javascript" src="/externlib/jquery-ui-1.12.1/jquery-ui.min.js"></script>

<script src="/externlib/cesium/Cesium.js" type="text/javascript"></script>
<link href="/externlib/cesium/Widgets/widgets.css" rel="stylesheet" type="text/css" />
<%--<script src="/externlib/Cesium-1.66/Build/Cesium/Cesium.js"></script>--%>
<%--<link href="/externlib/Cesium-1.66/Build/Cesium/Widgets/widgets.css" rel="stylesheet">--%>

<%--<link href="https://sandcastle.cesium.com/templates/bucket.css" rel="stylesheet" type="text/css" />--%>

<style>
    /*@import url(/externlib/Cesium-1.66/Apps/Sandcastle/templates/bucket.css);*/
    #toolbar {
        background: rgba(42, 42, 42, 0.5);
        padding: 4px;
        border-radius: 4px;
        position: absolute;
        top: 5px;
        color: white;
    }
    #toolbar input {
        vertical-align: middle;
        padding-top: 2px;
        padding-bottom: 2px;
    }
    input[type=range] {
        -webkit-appearance: slider-horizontal;
        color: rgb(144, 144, 144);
        cursor: default;
        padding: initial;
        border: initial;
        margin: 2px;
    }
    input {
        -webkit-writing-mode: horizontal-tb !important;
        text-rendering: auto;
        color: -internal-light-dark-color(black, white);
        letter-spacing: normal;
        word-spacing: normal;
        text-transform: none;
        text-indent: 0px;
        text-shadow: none;
        display: inline-block;
        text-align: start;
        -webkit-appearance: textfield;
        background-color: -internal-light-dark-color(white, black);
        -webkit-rtl-ordering: logical;
        cursor: text;
        margin: 0em;
        font: 400 11px system-ui;
        padding: 1px;
        border-width: 2px;
        border-style: inset;
        border-color: initial;
        border-image: initial;
    }
</style>

<div id="testingDialog" title="test fly" class="basicTable" style="display: none;">
    <div id="cesiumContainer" style="width:auto; height:600px;"></div>
    <div >
        <input type="button" class="cesium-button" value="커서 이벤트" onclick="look1();">
        <input type="button" class="cesium-button" value="btn2" onclick="look2();">
        <input type="button" class="cesium-button" value="btn3" onclick="look3();">
        <input type="button" class="cesium-button" value="용적률" onclick="look4();">
        <input type="button" class="cesium-button" value="sensor" onclick="look5();">
        <input type="button" class="cesium-button" value="btn6" onclick="look6();">
    </div>
    <div id="toolbar" style="display: none">
        <div>Model Height</div>
        <div>
            <input type="range" min="0.0" max="300.0" step="1" data-bind="value: floorAreaRatio, valueUpdate: 'input'" style="width:70%; -webkit-appearance: slider-horizontal">
            <input type="text" size="5" data-bind="value: floorAreaRatio">
        </div>
        <div>
            <input type="range" min="0.0" max="300.0" step="1" data-bind="value: buildingHeight, valueUpdate: 'input'" style="width:70%; -webkit-appearance: slider-horizontal">
            <input type="text" size="5" data-bind="value: buildingHeight">
        </div>
        <div>
            <input type="range" min="-100.0" max="100.0" step="1" data-bind="value: buildingAdjust, valueUpdate: 'input'" style="width:70%; -webkit-appearance: slider-horizontal">
            <input type="text" size="5" data-bind="value: buildingAdjust">
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
            // timeline : false,
            // animation : false,
            // selectionIndicator : true,
            // navigationHelpButton : false,
            // infoBox : true,
            // navigationInstructionsInitiallyVisible : false,
        });

    function look1(){
        // Gltf포맷 활용가능하게함.
        var scene = viewer.scene;
        var position = Cesium.Cartesian3.fromDegrees(126.934511, 37.521004, 0);
        var modelMatrix = Cesium.Transforms.eastNorthUpToFixedFrame(position);
        // fromGltf 함수를 사용하여 key : value 값으로 요소를 지정
        var name = '프로그APT';
        var model = viewer.scene.primitives.add(Cesium.Model.fromGltf({
            url : '/js/image/test.gltf',
            modelMatrix : modelMatrix,
            scale : 0.1,
            name : name
        }));
        viewer.scene.primitives.add(model);

        // nameoverlay를 위한 설정
        var nameOverlay = document.createElement('div');
        viewer.container.appendChild(nameOverlay);
        nameOverlay.className = 'backdrop';
        nameOverlay.style.display = 'none';
        nameOverlay.style.position = 'absolute';
        nameOverlay.style.bottom = '0';
        nameOverlay.style.left = '0';
        nameOverlay.style['pointer-events'] = 'none';
        nameOverlay.style.padding = '4px';
        nameOverlay.style.backgroundColor = 'black';

        // feature select
        var selected = {
            feature : undefined,
            originalColor : new Cesium.Color()
        };

        // 모델을 select하기위한 부분
        var selectedEntity = new Cesium.Entity(model);

        // 클릭핸들러 변수선언
        var clickHandler = viewer.screenSpaceEventHandler.getInputAction(Cesium.ScreenSpaceEventType.LEFT_CLICK);

        if(Cesium.PostProcessStageLibrary.isSilhouetteSupported(viewer.scene)){
            // 블루, 그린 실루엣 지원
            var silhouetteBlue = Cesium.PostProcessStageLibrary.createEdgeDetectionStage();
            silhouetteBlue.uniforms.color = Cesium.Color.BLUE;
            silhouetteBlue.uniforms.length = 0.01;
            silhouetteBlue.selected = [];

            var silhouetteGreen = Cesium.PostProcessStageLibrary.createEdgeDetectionStage();
            silhouetteGreen.uniforms.color = Cesium.Color.LIME;
            silhouetteGreen.uniforms.length = 0.01;
            silhouetteGreen.selected = [];

            viewer.scene.postProcessStages.add(Cesium.PostProcessStageLibrary.createSilhouetteStage([silhouetteBlue, silhouetteGreen]));
            // mousemove function을 이용하여 모델을 select 후 배열에 담음
            viewer.screenSpaceEventHandler.setInputAction(function onMouseMove(movement){
                silhouetteBlue.selected = [];
                // 모델에 마우스가 move될 시 nameoverlay 출현
                var pickedFeature = viewer.scene.pick(movement.endPosition);
                if(!Cesium.defined(pickedFeature)){
                    nameOverlay.style.display = 'none';
                    return;
                }
                // nameOverlay 설정
                nameOverlay.style.display = 'block';
                nameOverlay.style.bottom = viewer.canvas.clientHeight - movement.endPosition.y + 'px';
                nameOverlay.style.left = movement.endPosition.x +'px';

                nameOverlay.textContent = name;

                if(pickedFeature !== selected.feature){
                    silhouetteBlue.selected = [model];
                }
            }, Cesium.ScreenSpaceEventType.MOUSE_MOVE);

            // 모델을 클릭하여 알럿창을 띄우기위한 부분 / function onLeftClick
            viewer.screenSpaceEventHandler.setInputAction(function onLeftClick(movement){
                // silhouetteGreen 변수에 담을것
                silhouetteGreen.selected = [];

                // 새로운 모델 선택
                var pickedFeature = viewer.scene.pick(movement.position);
                if(!Cesium.defined(model)){
                    clickHandler(movement);
                    return;
                }

                // 선택된 모델이 없으면 새로운 모델 선택 가능
                if(silhouetteGreen.selected[model] === pickedFeature){
                    return;
                }
                alert("이곳은" +name+ "입니다." +'\n'+ "높이 : "+"68.7"+"m" +'\n'+ "넓이 : "+"30.2"+"m" +'\n'+ "가구 수 : " +"1000"+ "세대");

                // 샌택된 모델의 기존색상 저장(파란색)
                var highlightedFeature = silhouetteBlue.selected[model];
                if(model === highlightedFeature){
                    silhouetteBlue.selected = [];
                }

                // 새로 선택된 모델 highlight
                silhouetteGreen.selected = [model];

            }, Cesium.ScreenSpaceEventType.LEFT_CLICK);
        }

        viewer.scene.camera.flyTo({
            destination : Cesium.Cartesian3.fromDegrees(126.934511, 37.521004, 1000)
        });
    }
    function look2(){
        // let url = "https://sandcastle.cesium.com/SampleData/models/DracoCompressed/CesiumMilkTruck.gltf";
        let url = "/data/simulation-rest/cityPlanModelSelect";
        console.log("BASELINE url=", url);
        createModel(url, 1);
    }
    function look3(){
        // let url = "https://sandcastle.cesium.com/SampleData/models/DracoCompressed/CesiumMilkTruck.gltf";
        let url = "/data/simulation-rest/cityPlanModelSelect2";
        console.log("13 url=", url);
        createModel(url, 1);
    }
    function look4() {
        $("#toolbar").css("display", "block");
        let building1 = [ 126.91652864938153, 37.524363769181384, 126.91666340461144, 37.524247637818796, 126.91682331410799, 37.52432934563929, 126.91667773440538, 37.524445694816826 ];
        let building2 = [ 126.91710137997505, 37.524696432397825, 126.91725577562923, 37.52458252772058, 126.91745759427334, 37.524690824242136, 126.9173139107025, 37.524815545446394 ];
        let building3 = [ 126.91686418930314, 37.52499800473463, 126.91699773682063, 37.52488931956934, 126.91716605216082, 37.52498916809968, 126.91699479211833, 37.525150951980315 ];
        let building4 = [ 126.91625794666892, 37.524701445353806, 126.91643069756307, 37.524560540493646, 126.9166186812865, 37.52465864057907, 126.91643097658928, 37.52483033972023 ];

        let purplePolygonUsingRhumbLines = viewer.entities.add({
            name : '용적률 사이즈',
            polygon : {
                hierarchy : Cesium.Cartesian3.fromDegreesArray([
                    126.91596775015387, 37.52461289593738,
                    126.91658252344067, 37.52402062526981,
                    126.91772998112158, 37.5246939588847,
                    126.91709069229802, 37.52525801179375,
                ]),
                extrudedHeight: 100,
                material : new Cesium.ColorMaterialProperty(Cesium.Color.WHITE.withAlpha(0.4)),
                // outline : true,
                // outlineColor : Cesium.Color.BLACK,
                // arcType : Cesium.ArcType.RHUMB
            }
        });

        let entityBuilding1 = viewer.entities.add({
            name: "building1",
            polygon: {
                hierarchy: Cesium.Cartesian3.fromDegreesArray(building1),
                extrudedHeight: 120,
                material: new Cesium.ColorMaterialProperty(Cesium.Color.CYAN),
            }
        });
        let entityBuilding2 = viewer.entities.add({
            name: "building2",
            polygon: {
                hierarchy: Cesium.Cartesian3.fromDegreesArray(building2),
                extrudedHeight: 120,
                material: new Cesium.ColorMaterialProperty(Cesium.Color.CYAN),
            }
        });
        let entityBuilding3 = viewer.entities.add({
            name: "building3",
            polygon: {
                hierarchy: Cesium.Cartesian3.fromDegreesArray(building3),
                extrudedHeight: 120,
                material: new Cesium.ColorMaterialProperty(Cesium.Color.CYAN),
            }
        });
        let entityBuilding4 = viewer.entities.add({
            name: "building4",
            polygon: {
                hierarchy: Cesium.Cartesian3.fromDegreesArray(building4),
                extrudedHeight: 120,
                material: new Cesium.ColorMaterialProperty(Cesium.Color.CYAN),
            }
        });
        let areaTotal = getArea(purplePolygonUsingRhumbLines.polygon._hierarchy._value.positions);
        let area1 = getArea(entityBuilding1.polygon._hierarchy._value.positions);
        let area2 = getArea(entityBuilding2.polygon._hierarchy._value.positions);
        let area3 = getArea(entityBuilding3.polygon._hierarchy._value.positions);
        let area4 = getArea(entityBuilding4.polygon._hierarchy._value.positions);
        console.log("areaTotal=", areaTotal, " sss=", area1+area2+area3+area4);
        console.log("area1=", area1, " area2=", area2, " area3=", area3, " area4=", area4);

        let viewModel = {
            floorAreaRatio: 100,
            buildingHeight: 120,
            buildingAdjust: 0,
        };
        let toolbar = document.getElementById('toolbar');
        Cesium.knockout.track(viewModel);
        Cesium.knockout.applyBindings(viewModel, toolbar);
        standardHeight = parseInt(viewModel.buildingHeight);

        Cesium.knockout.getObservable(viewModel, 'floorAreaRatio').subscribe(
            function(newValue) {
                purplePolygonUsingRhumbLines.polygon.extrudedHeight = newValue;
            }
        );
        Cesium.knockout.getObservable(viewModel, 'buildingHeight').subscribe(
            function(newValue) {
                entityBuilding1.polygon.extrudedHeight = newValue;
                entityBuilding2.polygon.extrudedHeight = newValue;
                entityBuilding3.polygon.extrudedHeight = newValue;
                entityBuilding4.polygon.extrudedHeight = newValue;
                // viewModel.buildingAdjust = newValue;
                standardHeight = parseInt(newValue);
            }
        );
        Cesium.knockout.getObservable(viewModel, 'buildingAdjust').subscribe(
            function(newValue) {
                // let difference = Math.abs(parseInt(standardHeight) -  parseInt(newValue));
                let plusHeight = standardHeight + parseInt(newValue);
                let minusHeight = standardHeight - parseInt(newValue);
                // console.log("standardHeight=", standardHeight, " newValue=", newValue, " difference = ", difference);
                // console.log("plusHeight=", plusHeight, " minusHeight=", minusHeight);


                entityBuilding1.polygon.extrudedHeight = plusHeight;
                entityBuilding2.polygon.extrudedHeight = plusHeight;
                entityBuilding3.polygon.extrudedHeight = minusHeight;
                entityBuilding4.polygon.extrudedHeight = minusHeight;
            }
        );
        viewer.zoomTo(viewer.entities);
    }


    function look5() {
        let scene = viewer.scene;
        var sensor = scene.primitives.add(new Cesium.RectangularSensor({
            modelMatrix : Cesium.Transforms.eastNorthUpToFixedFrame(Cesium.Cartesian3.fromDegrees(-123.0744619, 44.0503706)),
            radius : 1000000.0,
            xHalfAngle : Cesium.Math.toRadians(25.0),
            yHalfAngle : Cesium.Math.toRadians(40.0)
        }));

        viewer.scene.camera.flyTo({
            destination : Cesium.Cartesian3.fromDegrees(-123.0744619, 44.0503706, 300)
        });
    }





















    function getArea(positions) {
        areaInMeters = 0;
        if (positions.length >= 3) {
            var points = [];
            for(var i = 0, len = positions.length; i < len; i++) {
                var cartographic = Cesium.Cartographic.fromCartesian(positions[i]);
                points.push(new Cesium.Cartesian2(cartographic.longitude, cartographic.latitude));
            }
            if(Cesium.PolygonPipeline.computeWindingOrder2D(points) === Cesium.WindingOrder.CLOCKWISE) {
                points.reverse();
            }

            var triangles = Cesium.PolygonPipeline.triangulate(points);

            for(var i = 0, len = triangles.length; i < len; i+=3) {
                areaInMeters += calArea(points[triangles[i]], points[triangles[i + 1]], points[triangles[i + 2]]);
            }
        }
        return areaInMeters;
    }
    function calArea(t1, t2, t3, i) {
        var r = Math.abs(t1.x * (t2.y - t3.y) + t2.x * (t3.y - t1.y) + t3.x * (t1.y - t2.y)) / 2;
        var cartographic = new Cesium.Cartographic((t1.x + t2.x + t3.x) / 3, (t1.y + t2.y + t3.y) / 3);
        var cartesian = _viewer.scene.globe.ellipsoid.cartographicToCartesian(cartographic);
        var magnitude = Cesium.Cartesian3.magnitude(cartesian);
        return r * magnitude * magnitude * Math.cos(cartographic.latitude)
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