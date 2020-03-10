<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script type="text/javascript" src="/externlib/jquery-3.3.1/jquery.min.js"></script>
<script type="text/javascript" src="/externlib/jquery-ui-1.12.1/jquery-ui.min.js"></script>

<!-- 건축인허가 신청 Modal -->
<div id="agendaConsultationDialog" title="의제협의사항" class="basicTable" style="display: none;">
    <h3 style="margin-top:9px; margin-bottom: 7px;">🔶일괄 처리사항</h3>
    <table class="list-table scope-col">
        <colgroup>
            <col class="col-name">
            <col class="col-name">
            <col class="col-name">
            <col class="col-name">
            <col class="col-name">
            <col class="col-checkbox">
        </colgroup>
        <thead>
            <tr>
                <th scope="col" class="col-name" style="width: 60%;">일괄처리사항</th>
                <th scope="col" class="col-name" style="width: 75px;">내용</th>
                <th scope="col" class="col-name">처리기한</th>
                <th scope="col" class="col-name">수수료(원)</th>
                <th scope="col" class="col-name">신청서</th>
                <th scope="col" class="col-name">신청여부</th>
            </tr>
        </thead>
        <tbody id="agenda_tbody">
        </tbody>
    </table>
    <div style="float:right; margin-top: 10px;">
        <button id="agenda_save" class="focusA" type="button" title="저장" style="width:200px;">저장</button>
        <button id="agenda_cancel" class="focusC" type="button" title="취소" >취소</button>
    </div>
</div>


<script>
    $("#agenda_save").click(() => {
        console.log("save");
        agendaConsultationDialog.dialog("close");
    });
    $("#agenda_cancel").click(() => {
        console.log("cancel");
        agendaConsultationDialog.dialog("close");
    });

</script>

<style>

    #agendaConsultationDialog td {
        cursor: default;
    }
    #agendaConsultationDialog td.col-name {
        text-align: center;
    }
    #agendaConsultationDialog td.col-checkbox {
        text-align: center;
        width: 60px;
    }
    #agendaConsultationDialog .col-checkbox input {
        margin-top: 5px;
        cursor: pointer;
    }
    /*table.type02 {
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
    }*/
</style>