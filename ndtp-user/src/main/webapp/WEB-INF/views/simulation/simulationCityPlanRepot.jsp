<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script type="text/javascript" src="/externlib/jquery-3.3.1/jquery.min.js"></script>
<script type="text/javascript" src="/externlib/jquery-ui-1.12.1/jquery-ui.min.js"></script>

<div id="resultCityPlanDialog" title="도시계획 시뮬레이션 결과" class="basicTable" style="display: none;">
	<ul class="listDrop">
	    <li class="on">
	        <p>레포트 작성<span class="collapse-icon">icon</span></p>
	        <div class="listContents" >
	        <div style="display: flex;">
	        	<img id="cityplanImg" src='' style="width: 500px; hiehgt:500px;"/>
	        	<div style="margin-left: 50px;">
		            <ul class="analysisGroup">
		                <li>
		                    <label for="img_src">위치</label>
		                    <label for="constructor">에코델타 시티</label>
		                </li>
		                <li>
		                    <label for="constructor">대상 면적</label>
		                    <label id="cityPlanDlgArea" for="constructor">OO m</label>
		                </li>
		                <li>
			                <div>
			                    <label for="constructor">기준 용적율</label>
			                    <label id="cityPlanDlgStdFloorCov" for="constructor">OO%</label>
			                    <label for="constructor">예측 용적율</label>
			                    <label id="cityPlanDlgFloorCov" for="constructor">OO %</label>
			                </div>
		                </li>
		                <li>
			                <div>
			                    <label for="constructor">기준 건폐율</label>
			                    <label id="cityPlanDlgStdBuildCov" for="constructor">OO%</label>
			                    <label for="constructor">예측 건폐율</label>
			                    <label id="cityPlanDlgBuildCov" for="constructor">OO %</label>
			                </div>
		                </li>
		                <li>
		                    <label for="constructor">용적률 적합 여부</label>
		                    <label id="chkCityPlanDlgFloorCov" for="constructor">OO</label>
		                    <label for="constructor">건폐율 적합 여부</label>
		                    <label id="chkcityPlanDlgBuildCov" id="" for="constructor">OO</label>
		                </li>
		                <li>
		                    <label for="constructor">일조분석 평가기준</label>
		                    <input id="" class="" type="text" placeholder="" value="00~24시 연속 24시간">
		                </li>
		                <li>
		                    <label for="constructor">일조분석 의견 </label>
		                    <textarea id="" class="" cols="40" rows="8" value="특이사항 없음"></textarea>
		                </li>
		                
		            </ul>
	            </div>
	        </div>
	        </div>
	    </li>
	</ul>
<div style="float:right">
    <button id="resultCityPlanDlgReg" class="focusA" type="submit" title="적합" style="width: 200px;">적합</button>
    <button id="resultCityPlanDlgCle" class="focusC" type="button" title="부적합">부적합</button>
</div>
</div>



<script>
    $('#permRequestDialog ul.listDrop li > p').click(function() {
        var parentObj = $(this).parent();
        var index = parentObj.index();
        $('#permRequestDialog ul.listDrop > li').eq(index).toggleClass('on');
    });

    $('#permReqCancel').click(function() {
        $("#permRequestDialog").dialog("close");
    });

    /*
    $('#permReqRegister').click(function() {
        setTimeout(() => {
            $("#permRequestDialog").dialog("close");
        }, 1000);
    });
	*/
</script>

<style>

    #permRequestDialog ul.listDrop li ul li{
        display: inline-block;;
        width:49%;
    }

    #permRequestDialog ul.listDrop li ul li input {
        width: 300px;
    }

    table.type02 {
        border-collapse: separate;
        border-spacing: 0;
        text-align: left;
        line-height: 1.5;
        border-top: 1px solid #ccc;
        border-left: 1px solid #ccc;
        margin : 20px 10px;
    }
    table.type02 th {
        width: 150px;
        padding: 10px;
        font-weight: bold;
        vertical-align: top;
        border-right: 1px solid #ccc;
        border-bottom: 1px solid #ccc;
        border-top: 1px solid #fff;
        border-left: 1px solid #fff;
        background: #eee;
    }
    table.type02 td {
        width: 350px;
        padding: 10px;
        vertical-align: top;
        border-right: 1px solid #ccc;
        border-bottom: 1px solid #ccc;
    }
</style>