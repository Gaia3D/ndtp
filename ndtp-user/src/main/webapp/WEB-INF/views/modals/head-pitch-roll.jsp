<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script type="text/javascript" src="/externlib/jquery-3.3.1/jquery.min.js"></script>
<script type="text/javascript" src="/externlib/jquery-ui-1.12.1/jquery-ui.min.js"></script>

<script src="/externlib/cesium/Cesium.js" type="text/javascript"></script>
<link href="/externlib/cesium/Widgets/widgets.css" rel="stylesheet" type="text/css" />

<div id="headPitchRollDialog" title="객체 정보" class="basicTable" style="display: none;">
    <div id="rotation_adjustment" style="width: 240px;">
        <div style="font-weight: bold; margin-top: 3px;">🔸 위치 정보</div>
        <div>
            <div>
                <span>경도: </span><span id="selected_obj_longitude"></span>
            </div>
            <div>
                <span>위도: </span><span id="selected_obj_latitude"></span>
            </div>
        </div>

        <div style="font-weight: bold; margin-top: 10px;">🔸 회전 정보</div>
        <div>
<%--            <span>Heading: </span>--%>
            <input type="range" min="0.0" max="360.0" step="1" data-bind="value: heading, valueUpdate: 'input'" style="width:69%; -webkit-appearance: slider-horizontal">
            <input type="text" size="5" data-bind="value: heading">
        </div>
        <div>
<%--            <span>Pitch: </span>--%>
            <input type="range" min="0.0" max="360.0" step="1" data-bind="value: pitch, valueUpdate: 'input'" style="width:69%; -webkit-appearance: slider-horizontal">
            <input type="text" size="5" data-bind="value: pitch">
        </div>
        <div>
<%--            <span>Roll: </span>--%>
            <input type="range" min="0.0" max="360.0" step="1" data-bind="value: roll, valueUpdate: 'input'" style="width:69%; -webkit-appearance: slider-horizontal">
            <input type="text" size="5" data-bind="value: roll">
        </div>

        <div style="font-weight: bold; margin-top: 10px;">🔸 자동 회전 조정</div>
        <button id="auto_heading" type="button" class="btnTextF">Heading</button>
        <button id="auto_pitch" type="button" class="btnTextF">Pitch</button>
        <button id="auto_roll" type="button" class="btnTextF">Roll</button>
    </div>
</div>


<script>
    rotationModel = {
        heading: 0,
        pitch: 0,
        roll: 0
    };
    console.log("rotationMoel=", rotationModel);
    let adjRotation = document.getElementById('rotation_adjustment');

    // rotationModel track
    Cesium.knockout.track(rotationModel);
    Cesium.knockout.applyBindings(rotationModel, adjRotation);

    // heading
    Cesium.knockout.getObservable(rotationModel, 'heading').subscribe(
        // newValue는 웹상에서 수정된 값
        function (newValue) {
            let heading = Cesium.Math.toRadians(newValue);
            let hpr = new Cesium.HeadingPitchRoll(heading, Cesium.Math.toRadians(rotationModel.pitch), Cesium.Math.toRadians(rotationModel.roll));
            let orientation = Cesium.Transforms.headingPitchRollQuaternion(selectedEntity.position.getValue(), hpr);
            selectedEntity.orientation.setValue(orientation);
        }
    );

    //pitch
    Cesium.knockout.getObservable(rotationModel, 'pitch').subscribe(
        function (newValue) {
            let pitch = Cesium.Math.toRadians(newValue);
            let hpr = new Cesium.HeadingPitchRoll(Cesium.Math.toRadians(rotationModel.heading), pitch, Cesium.Math.toRadians(rotationModel.roll));
            let orientation = Cesium.Transforms.headingPitchRollQuaternion(selectedEntity.position.getValue(), hpr);
            selectedEntity.orientation.setValue(orientation);
        }
    );

    //roll
    Cesium.knockout.getObservable(rotationModel, 'roll').subscribe(
        function (newValue) {
            let roll = Cesium.Math.toRadians(newValue);
            let hpr = new Cesium.HeadingPitchRoll(Cesium.Math.toRadians(rotationModel.heading), Cesium.Math.toRadians(rotationModel.pitch), roll);
            let orientation = Cesium.Transforms.headingPitchRollQuaternion(selectedEntity.position.getValue(), hpr);
            selectedEntity.orientation.setValue(orientation);
        }
    );

    var stop_heading = false;
    $('#auto_heading').click(function () {

        var rotation_val = rotationModel.heading;
        console.log(stop_heading);
        if (stop_heading) {
            clearInterval(heading_run);
            stop_heading = false;
        }
        else {
            stop_heading = true;

            heading_run = setInterval(function () {

                if (rotation_val >= 360) {
                    rotation_val = 0;
                }
                rotationModel.heading = rotation_val;
                rotation_val++
            }, 100);

        }
    });

    var stop_pitch = false;
    $('#auto_pitch').click(function () {
        var rotation_val = rotationModel.pitch;

        console.log(stop_pitch);

        if (stop_pitch) {
            clearInterval(pitch_run);
            stop_pitch = false;
        }
        else {
            stop_pitch = true;

            pitch_run = setInterval(function () {

                if (rotation_val >= 360) {
                    rotation_val = 0;
                }
                rotationModel.pitch = rotation_val;
                rotation_val++
            }, 100);

        }
    });

    var stop_roll = false;
    $('#auto_roll').click(function () {
        var rotation_val = rotationModel.roll;
        console.log(stop_roll);
        if (stop_roll) {
            clearInterval(roll_run);
            stop_roll = false;
        }
        else {
            stop_roll = true;

            roll_run = setInterval(function () {

                if (rotation_val >= 360) {
                    rotation_val = 0;
                }
                rotationModel.roll = rotation_val;
                rotation_val++
            }, 100);

        }
    });




</script>

<style>
    /*#rotation_adjustment {*/
    /*    background: rgba(42, 42, 42, 0.8);*/
    /*    padding: 4px;*/
    /*    border-radius: 4px;*/
    /*}*/

    /*#rotation_adjustment input {*/
    /*    vertical-align: middle;*/
    /*    padding-top: 2px;*/
    /*    padding-bottom: 2px;*/
    /*}*/

    /*#rotation_adjustment .header {*/
    /*    font-weight: bold;*/
    /*}*/

    #rotation_adjustment {
        background: rgba(42, 42, 42, 0.5);
        padding: 4px;
        border-radius: 4px;
        position: absolute;
        top: 5px;
        color: white;
    }

    #rotation_adjustment input {
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