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
                            <button id="district_unit_plan_viewer" class="btnTextF" type="button" title="지구단위계획 파일 보기" >Viewer</button>
                        </li>
<%--                        <li>--%>
                            <%--                            <button id="regMapButtion" class="btnTextF" type="button" title="지도보기">건축물 지도보기</button>--%>
<%--                        </li>--%>
                        <li>
                            <div>
                                <label for="">기준 용적율</label>
                                <label id="" for="">140.0%</label>
                                <label for="">기준 건폐율</label>
                                <label id="" for="">50.0%</label>
                            </div>
                        </li>
                        <li>
                            <input id="longitude" name="longitude" class="m" placeholder="longitude" type="text" value="" style="width: 140px;" readonly>
                            <input id="latitude" name="latitude" class="m" placeholder="latitude" type="text" value="" style="width: 140px;" readonly>
                            <input id="altitude" name="altitude" class="m" placeholder="altitude" type="text" value="" style="width: 140px;" readonly>
                        </li>
                        <li>
                            <div>
                                <label for="">용적율</label>
                                <label id="cur_floorAreaRatio" for="">130.84%</label>
                                <label for="">건폐율</label>
                                <label id="cur_buildingLandRatio" for="">16.36%</label>
                            </div>
                        </li>
                        <li>
                            <button id="agenda_consultations" class="btnTextF" type="button" title="의제협의사항" >의제협의사항</button>
                        </li>
                        <li>
                            <label for="">용적률 적합 여부</label>
                            <label id="floorAreaRatio_isGood" for="" style="font-weight: bold; color:blue;">적합</label>
                            <label for="">건폐율 적합 여부</label>
                            <label id="buildingLandRatio_isGood" for="" style="font-weight: bold; color:blue;">적합</label>
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
                            <textarea id="notSuitableReason" name="notSuitableReason" class="radius" type="text" rows="4" placeholder="부적합 사유를 작성해 주시기 바랍니다." style="width:74%;">
                            </textarea>
                        </li>
                    </ul>
                </div>
            </li>
        </ul>

        <div style="float:right; margin-top: 10px;">
            <button id="permSend" class="focusA" type="submit" title="전송" style="width:200px;">전송</button>
            <button id="permCancel" class="focusC" type="button" title="취소" >취소</button>
        </div>
    </form>

</div>


<script>
    $("#agenda_consultations").click(() => {
        renderAgendaConsultations(getAgendaList());
        agendaConsultationDialog.dialog("open");
    });

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
            changeAcceptBuild('N');
            changeAcceptBuild('Y');
            $("#permViewDialog").dialog("close");
        }, 300);
    });

    function changeAcceptBuild(permReqType) {
        const permReqParam = {
            isComplete: permReqType
        };
        $.ajax({
            url: "/data/simulation-rest/getPermRequest",
            type: "POST",
            data: permReqParam,
            headers: {"X-Requested-With": "XMLHttpRequest"},
            dataType: "json",
            success: function(permList){
                var perDomItems = "";
                for (let i = 0; i<permList.length; i++) {
                    var permName = permList[i].constructor + ' - ' + permList[i].permSeq;
                    perDomItems += "<option value=" + permList[i].permSeq + ">" + permName + "</option>";
                }
                if(permReqType === 'N') {
                    let cell = $("#acceptBuildList")[0];
                    while (cell.length > 1) {
                        cell.removeChild(cell.lastChild);
                    }
                    $("#acceptBuildList").append(perDomItems);
                } else {
                    let cell = $("#acceptCompleteBuildList")[0];
                    while (cell.length > 1) {
                        cell.removeChild(cell.lastChild);
                    }
                    $("#acceptCompleteBuildList").append(perDomItems);
                }
            },
            error:function(request,status,error) {
                console.log("err=", request, status, error);
            }
        });
    }

    function renderAgendaConsultations(agendaList) {
        const tbody = document.getElementById("agenda_tbody");

        if (tbody.innerHTML.trim()!=="") {
            return;
        }

        agendaList.map((agenda, idx) => {
            const tr = document.createElement("tr");
            tr.setAttribute("idx", idx);
            tr.setAttribute("processItem", agenda.processItem);

            const td_processItem = document.createElement("td");
            td_processItem.setAttribute("class", "col-type");
            td_processItem.textContent = agenda.processItem;

            const td_content = document.createElement("td");
            td_content.setAttribute("class", "col-name");
            td_content.textContent = agenda.content;

            const td_timeLimit = document.createElement("td");
            td_timeLimit.setAttribute("class", "col-name");
            if (agenda.isChecked) {
                td_timeLimit.textContent = agenda.timeLimit;
            } else {
                td_timeLimit.textContent = "";
            }

            const td_fee = document.createElement("td");
            td_fee.setAttribute("class", "col-name");
            if (agenda.isChecked) {
                if (agenda.fee !== 0 && agenda.fee !== undefined) {
                    td_fee.textContent = new Intl.NumberFormat('ko-KR', { style: 'currency', currency: 'KRW' }).format(agenda.fee);
                }
            }

            const td_application = document.createElement("td");
            td_application.setAttribute("class", "col-name");
            td_application.textContent = agenda.application;

            const td_isChecked = document.createElement("td");
            td_isChecked.setAttribute("class", "col-checkbox");
            const input_isChecked = document.createElement("input");
            input_isChecked.setAttribute("type", "checkbox");
            input_isChecked.setAttribute("id", "idx_"+idx);
            if (agenda.isChecked) {
                input_isChecked.setAttribute("checked", true);
            }
            td_isChecked.append(input_isChecked);

            input_isChecked.addEventListener("change", function (){
                if (this.checked) {
                    console.log("checked");
                    td_timeLimit.textContent = agenda.timeLimit;
                    if (agenda.fee !== 0 && agenda.fee !== undefined) {
                        td_fee.textContent = new Intl.NumberFormat('ko-KR', { style: 'currency', currency: 'KRW' }).format(agenda.fee);
                    }
                } else {
                    console.log("not checked");
                    td_timeLimit.textContent = "";
                    td_fee.textContent = "";
                }
            });

            tr.append(td_processItem);
            tr.append(td_content);
            tr.append(td_timeLimit);
            tr.append(td_fee);
            tr.append(td_application);
            tr.append(td_isChecked);
            tbody.append(tr);
        });

    }

    function getAgendaList() {
        let agendaList = [{
            processItem: "가축분뇨배출시설설치 신고",
            content: "",
            timeLimit: "10일",
            fee: 1500,
            application: "",
            isChecked: false
        },{
            processItem: "가축분뇨배출시설설치 허가",
            content: "",
            timeLimit: "7일",
            fee: 1000,
            application: "",
            isChecked: false
        }
        ,{ processItem: "개발행위 허가", timeLimit: "14일", fee: 2000 }
        ,{ processItem: "개인하수처리시설설치 신고", timeLimit: "10일", fee: 1200 }
        ,{ processItem: "공사용가설건출물축조 신고", timeLimit: "10일", fee: 1200 }
        ,{ processItem: "공원구역행위 허가", timeLimit: "10일", fee: 1200 }
        ,{ processItem: "공작물축조신고", timeLimit: "10일", fee: 1200 }
        ,{ processItem: "농지전용 변경 신고", timeLimit: "10일", fee: 1200 }
        ,{ processItem: "농지전용 변경 허가", timeLimit: "10일", fee: 1200 }
        ,{ processItem: "농지전용 신고", timeLimit: "10일", fee: 1200 }
        ,{ processItem: "농지전용 허가", timeLimit: "10일", fee: 1200 }
        ,{ processItem: "농지전용 협의", timeLimit: "10일", fee: 1200 }
        ,{ processItem: "대기오염물질배출시설설치의 신고", timeLimit: "10일", fee: 1200 }
        ,{ processItem: "대기오염물질배출시설설치의 허가", timeLimit: "10일", fee: 1200 }
        ,{ processItem: "도로점용 허가", timeLimit: "10일", fee: 1200 }
        ,{ processItem: "도시계획시설사업시행자의지정 및 실시계획", timeLimit: "10일", fee: 1200 }
        ,{ processItem: "도시공원점용 허가", timeLimit: "10일", fee: 1200 }
        ,{ processItem: "배수설비설치 신고", timeLimit: "10일", fee: 1200 }
        ,{ processItem: "비관리청도로공사시행 허가 및 도로의연결 허가", timeLimit: "10일", fee: 1200 }
        ,{ processItem: "사도개설 허가", timeLimit: "10일", fee: 1200 }
        ,{ processItem: "산지일시사용 신고", timeLimit: "10일", fee: 1200 }
        ,{ processItem: "산지일시사용 허가", timeLimit: "10일", fee: 1200 }
        ,{ processItem: "산지전용 변경 신고", timeLimit: "10일", fee: 1200 }
        ,{ processItem: "산지전용 변경 허가", timeLimit: "10일", fee: 1200 }
        ,{ processItem: "산지전용 신고", timeLimit: "10일", fee: 1200 }
        ,{ processItem: "산지전용 허가", timeLimit: "10일", fee: 1200 }
        ,{ processItem: "산지전용 협의", timeLimit: "10일", fee: 1200 }
        ,{ processItem: "상수도공급 신청", timeLimit: "10일", fee: 1200 }
        ,{ processItem: "소음진동배출시설설치의 신고", timeLimit: "10일", fee: 1200 }
        ,{ processItem: "소음진동배출시설설치의 허가", timeLimit: "10일", fee: 1200 }
        ,{ processItem: "수질오염물질배출시설설치의 신고", timeLimit: "10일", fee: 1200 }
        ,{ processItem: "수질오염물질배출시설설치의 허가", timeLimit: "10일", fee: 1200 }
        ,{ processItem: "에너지절약계획서 - [국토해양부고시 제2010-1031호, 2010.12.31] 이후 적용대상", timeLimit: "10일", fee: 1200 }
        ,{ processItem: "자가용전기설비공사계획의 신고", timeLimit: "10일", fee: 1200 }
        ,{ processItem: "자가용전기설비공사계획의 인가", timeLimit: "10일", fee: 1200 }
        ,{ processItem: "특정토양오염관리대상시설 신고", timeLimit: "10일", fee: 1200 }
        ,{ processItem: "하천점용허가", timeLimit: "10일", fee: 1200 }
        ];
        return agendaList;
    }
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