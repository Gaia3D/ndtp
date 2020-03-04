<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script type="text/javascript" src="/externlib/jquery-3.3.1/jquery.min.js"></script>
<script type="text/javascript" src="/externlib/jquery-ui-1.12.1/jquery-ui.min.js"></script>

<div id="permViewDialog" title="인허가 시뮬레이션" class="basicTable" style="display: none;">
    <iframe name="dummyframe" id="dummyframe" style="display: none;"></iframe>
    <form id="file_upload" name="file_upload"method="post" enctype="multipart/form-data" action="simulation-rest/updateStructPermission" style="width:100%" target="dummyframe">
        <ul class="listDrop">
            <li class="on">
                <p>건축주<span class="collapse-icon">icon</span></p>
                <div class="listContents" >
                    <ul class="analysisGroup">
                        <li>
                            <label for="constructor">건축주</label>
                            <input id="constructor" name="constructor" class="observerOffset" type="text" placeholder="건축주명" value="" title="" readonly>
                        </li>
                        <li>
                            <label for="constructor_type">건축주 구분</label>
                            <select id="constructor_type" name="constructor_type" class="dataType" readonly>
                                <option value="individual" selected>개인</option>
                                <option value="corp">법인</option>
                            </select>
                        </li>
                        <li>
                            <label for="birthday">생년월일</label>
                            <input id="birthday" name="birthday" class="observerOffset" type="text" placeholder="생년월일 앞 6자만 입력바랍니다." value="" title="" readonly>
                        </li>
                        <li>
                            <label for="license_num">사업자 번호</label>
                            <input id="license_num" name="license_num" class="radius" type="text" placeholder="(-)는 생략하고 입력바랍니다." value="" title="관찰자 지점으로부터의 가시선 분석 수행 반경. 단위는 m" readonly>
                        </li>
                        <li>
                            <label for="district_unit_plan">지구단위계획 파일</label>
                            <input id="district_unit_plan" name="district_unit_plan" class="radius" type="text" value="" title="" readonly style="display:none;">
                            <button id="district_unit_plan_viewer" class="focusC" type="button" title="지구단위계획 파일 보기" >Viewer</button>

                        </li>
<%--                        <li>--%>
<%--                            <label for="struct_calculation">구조 계산서 파일</label>--%>
<%--                            <input id="struct_calculation" type="file" name="struct_calculation" readonly>--%>
<%--                        </li>--%>
<%--                        <li>--%>
<%--                            <label for="struct_security">구조 안전 확인서 파일</label>--%>
<%--                            <input id="struct_security" type="file" name="struct_security"  readonly>--%>
<%--                        </li>--%>
<%--                        <li>--%>
<%--                            <label for="struct_confirm">구조 확인서 파일</label>--%>
<%--                            <input id="struct_confirm" type="file" name="struct_confirm"  readonly>--%>
<%--                        </li>--%>
<%--                        <li>--%>
<%--                            <label for="phone_number">휴대전화</label>--%>
<%--                            <input id="phone_number" name="phone_number" class="sides" type="text" placeholder="(-)는 생략하고 입력바랍니다." value="" title="방사형 가시선의 수" readonly>--%>
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
            <li >
                <p>도서등록<span class="collapse-icon">icon</span></p>
                <div class="listContents" >
                    <div><label><input type="checkbox" name="color" value="blue" disabled> 건축물 대장</label></div>
                    <div><label><input type="checkbox" name="color" value="blue" disabled> 1층 평면도</label></div>
                    <div><label><input type="checkbox" name="color" value="blue" disabled> 2층 평면도</label></div>
                    <div><label><input type="checkbox" name="color" value="blue" disabled> 하수처리시설 상세도</label></div>
                    <div><label><input type="checkbox" name="color" value="blue" disabled> 주차평면도</label></div>
                </div>
            </li>
            <li class="on">
                <p>적합 / 부적합<span class="collapse-icon">icon</span></p>
                <div class="listContents" >
                    <ul class="analysisGroup">
                        <li style="width:28%;">
                            <label for="suitableCheck">적합/부적 구분</label>
                            <select id="suitableCheck" name="suitableCheck" class="dataType">
                                <option value="true" selected>적합</option>
                                <option value="false">부적합</option>
                            </select>
                        </li>
                        <li style="width:70%;">
                            <label for="notSuitableReason" style="width:25%;">부적합 사유</label>
                            <textarea id="notSuitableReason" name="notSuitableReason" class="radius" type="text" rows="4" style="width:74%;">
                            </textarea>
                        </li>
                    </ul>
                </div>
            </li>
        </ul>

        <div style="display: inline-block; position: absolute; bottom: 20px; right: 20px;">
            <button id="permSend" class="focusA" type="submit" title="전송" style="width:200px;">전송</button>
            <button id="permCancel" class="focusC" type="button" title="취소" >취소</button>
        </div>
    </form>

</div>


<script>
    // function b64DecodeUnicode(str) {
    //     // Going backwards: from bytestream, to percent-encoding, to original string.
    //     return decodeURIComponent(atob(str).split('').map(function(c) {
    //         return '%' + ('00' + c.charCodeAt(0).toString(16)).slice(-2);
    //     }).join(''));
    // }
    $("#permViewDialog #district_unit_plan_viewer").click(()=> {
        console.log("clicked pdf_file");
        let data = {
            permSeq: buildAcceptPermSeq,
        };
        $.ajax({
            url: "/data/simulation-rest/viewPdf",
            type: "POST",
            headers: {"X-Requested-With": "XMLHttpRequest"},
            data: data,
            // dataType: "json",
            success: function(msg){
                console.log("msg=", msg);

                setTimeout(() => {
                    const fileLoc = "pdf_files/" + msg;
                    const url = "/externlib/pdfjs/web/viewer.html?file=" + fileLoc;
                    const name = "PDF File Viewer";
                    const option = "width = 1000, height = 750, top = 100, left = 200, location = no";
                    window.open(url, name, option);
                }, 1000);

                // viewPdfDialog.dialog("open");
            },
            error:function(request,status,error) {
                console.log("err=", request, status, error);
            }
        });
    });

    $('#permViewDialog ul.listDrop li > p').click(function() {
        var parentObj = $(this).parent();
        var index = parentObj.index();
        $('#permViewDialog ul.listDrop > li').eq(index).toggleClass('on');
    });

    $('#permCancel').click(function() {
        $("#permViewDialog").dialog("close");
    });
    $('#permSend').click(function() {
        setTimeout(() => {
            $("#permViewDialog").dialog("close");
        }, 300);
    });
</script>

<style>

    #permViewDialog ul.listDrop li ul li{
        display: inline-block;;
        width:49%;
    }

    #permViewDialog ul.listDrop li ul li input {
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