<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script type="text/javascript" src="/externlib/jquery-3.3.1/jquery.min.js"></script>
<script type="text/javascript" src="/externlib/jquery-ui-1.12.1/jquery-ui.min.js"></script>

<div id="permRequestDialog" title="건축인 허가 신청" class="basicTable" style="display: none;">

    <ul class="listDrop">
        <li class="on">
            <p>건축주<span class="collapse-icon">icon</span></p>
            <div class="listContents" >
                <ul class="analysisGroup">
                    <li>
                        <label for="constructor">건축주</label>
                        <input id="constructor" class="observerOffset" type="text" placeholder="건축주명" value="" title="">
                    </li>
                    <li>
                        <label for="">건축주 구분</label>
                        <select class="dataType">
                            <option value="individual" selected>개인</option>
                            <option value="corp">법인</option>
                        </select>
                    </li>
                    <li>
                        <label for="rlosOffset">생년월일</label>
                        <input id="rlosOffset" class="observerOffset" type="text" placeholder="생년월일 앞 6자만 입력바랍니다." value="" title="">
                    </li>
                    <li>
                        <label for="rlosRadius">사업자 번호</label>
                        <input id="rlosRadius" class="radius" type="text" placeholder="(-)는 생략하고 입력바랍니다." value="" title="관찰자 지점으로부터의 가시선 분석 수행 반경. 단위는 m">
                    </li>
                    <li>
                        <label for="rlosSidex">휴대전화</label>
                        <input id="rlosSidex" class="sides" type="text" placeholder="(-)는 생략하고 입력바랍니다." value="" title="방사형 가시선의 수">
                    </li>
                    <li style="width: 100%;">
                        <label for="rlosSidex">개인정보동의</label>
                        <span style="display:inline-block; margin-top: 4px;">00관련법에 따라 000000 동의합니다. <input type="checkbox" name="color" value="blue"></span>
                    </li>
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
    <div style="display: inline-block; position: absolute; bottom: 20; right: 20;">
        <button class="focusA" title="등록" style="width: 200px;">등록</button>
        <button class="focusC" title="취소">취소</button>
    </div>

    <li>
        <iframe name="dummyframe" id="dummyframe" style="display: none;"></iframe>
        <form id="file_upload" name="file_upload"method="post" enctype="multipart/form-data" action="simulation-rest/upload" style="width:100%" target="dummyframe">
            <input type="file" name="files" style="width:100%" multiple>

            <button id="upload_cityplan" type="submit" class="btnTextF" title="업로드">업로드</button>
            <button type="button" class="btnText reset" title="취소">취소</button>
        </form>
    </li>

</div>


<script>
    $('#permRequestDialog ul.listDrop li > p').click(function() {
        var parentObj = $(this).parent();
        var index = parentObj.index();
        $('#permRequestDialog ul.listDrop > li').eq(index).toggleClass('on');
    });

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