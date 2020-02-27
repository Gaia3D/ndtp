<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script type="text/javascript" src="/externlib/jquery-3.3.1/jquery.min.js"></script>
<script type="text/javascript" src="/externlib/jquery-ui-1.12.1/jquery-ui.min.js"></script>
<!-- 건축인허가 신청 Modal -->
<div id="permRequestDialog" title="건축인 허가 신청" class="basicTable" style="display: none;">
    <form id="acceptBuildUpload" name="acceptBuildUpload"style="width:100%" target="dummyframe">
        <ul class="listDrop">
            <li class="on">
                <p>건축주<span class="collapse-icon">icon</span></p>
                <div class="listContents" >
                    <ul class="analysisGroup">
                        <li>
                            <label for="constructor">건축주</label>
                            <input id="constructor" name="constructor" class="observerOffset" type="text" placeholder="건축주명" value="" title="">
                        </li>
                        <li>
                            <label for="constructor_type">건축주 구분</label>
                            <select id="constructor_type" name="constructor_type" class="dataType">
                                <option value="individual" selected>개인</option>
                                <option value="corp">법인</option>
                            </select>
                        </li>
                        <li>
                            <label for="birthday">생년월일</label>
                            <input id="birthday" name="birthday" class="observerOffset" type="text" placeholder="생년월일 앞 6자만 입력바랍니다." value="" title="">
                        </li>
                        <li>
                            <label for="license_num">사업자 번호</label>
                            <input id="license_num" name="license_num" class="radius" type="text" placeholder="(-)는 생략하고 입력바랍니다." value="" title="관찰자 지점으로부터의 가시선 분석 수행 반경. 단위는 m">
                        </li>
                        <li>
                            <label for="bim_file">BIM 파일</label>
                            <input id="bim_file" type="file" name="bim_file"  multiple>
                        </li>
                        <li>
                            <label for="struct_calculation">구조 계산서 파일</label>
                            <input id="struct_calculation" type="file" name="struct_calculation" multiple>
                        </li>
                        <li>
                            <label for="struct_security">구조 안전 확인서 파일</label>
                            <input id="struct_security" type="file" name="struct_security"  multiple>
                        </li>
                        <li>
                            <label for="district_unit_plan">지구단위계획 파일</label>
                            <input id="district_unit_plan" type="file" name="district_unit_plan"  multiple>
                        </li>
<%--                        <li>--%>
<%--                            <label for="phone_number">휴대전화</label>--%>
<%--                            <input id="phone_number" name="phone_number" class="sides" type="text" placeholder="(-)는 생략하고 입력바랍니다." value="" title="방사형 가시선의 수">--%>
<%--                        </li>--%>
<%--                        <li style="width: 100%;">--%>
<%--                            <label for="rlosSidex">개인정보동의</label>--%>
<%--                            <span style="display:inline-block; margin-top: 4px;">00관련법에 따라 000000 동의합니다. <input type="checkbox" name="color" value="blue"></span>--%>
<%--                        </li>--%>
                    </ul>
                </div>
            </li>
            <li>
                <p>전체 개요<span class="collapse-icon">icon</span></p>
            </li>
            <li>
                <p>하수처리시설<span class="collapse-icon">icon</span></p>
            </li>
            <li >
                <p>주차장<span class="collapse-icon">icon</span></p>
            </li>
            <li class="on">
                <p>도서등록<span class="collapse-icon">icon</span></p>
                <div class="listContents" >
                    <div><label><input type="checkbox" name="color" value="blue"> 건축물 대장</label></div>
                    <div><label><input type="checkbox" name="color" value="blue"> 1층 평면도</label></div>
                    <div><label><input type="checkbox" name="color" value="blue"> 2층 평면도</label></div>
                    <div><label><input type="checkbox" name="color" value="blue"> 하수처리시설 상세도</label></div>
                    <div><label><input type="checkbox" name="color" value="blue"> 주차평면도</label></div>
                </div>
            </li>
        </ul>
        <div style="display: inline-block; position: absolute; bottom: 20px; right: 20px;">
            <button id="permReqRegister" class="focusA" type="button" title="등록" style="width: 200px;">등록</button>
            <button id="permReqCancel" class="focusC" type="button" title="취소">취소</button>
        </div>

    </form>


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
    $('#permReqRegister').click(function() {
        buildAcceptReq();
    });

    function buildAcceptReq() {
        var form = $('#acceptBuildUpload')[0];
        startLoading();
        // Create an FormData object
        var data = new FormData(form);
        data.append('longitude', 127.27030500949927);
        data.append('latitude', 36.524662808423344);
        data.append('altitude', -5.0000);
        data.append('heading', 48.000000);
        data.append('pitch', 0);
        data.append('roll', 0);
        $.ajax({
            type: "POST",
            enctype: 'multipart/form-data',
            url: "http://localhost/data/simulation-rest/uploadBuildAccept",
            data: data,
            processData: false,
            contentType: false,
            cache: false,
            timeout: 600000,
            success: function (data) {
                $.growl.notice({
                    message: "파일업로드가 완료되었습니다",
                    duration: 1000
                });
                $("#permRequestDialog").dialog("close");
                stopLoading();
            },
            error: function (e) {
                $.growl.notice({
                    message: "오류가 발생했습니다." + e,
                    duration: 1000
                });
                stopLoading();
            }
        });
    }

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