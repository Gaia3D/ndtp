<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script type="text/javascript" src="/externlib/jquery-3.3.1/jquery.min.js"></script>
<script type="text/javascript" src="/externlib/jquery-ui-1.12.1/jquery-ui.min.js"></script>

<!-- 건축인허가 신청 Modal -->
<div id="metadataDialog" title="건축물 정보" class="basicTable" style="display: none;">
    <h4 class="category" style="margin-top: 5px; margin-bottom: 6px; font-size: 15px;">🔸 건축물 상세 정보</h4>
    <ul class="layerDiv">
        <li>
            <label >ID: </label>
            <span id="materialID"></span>
        </li>
        <li>
            <label >분류: </label>
            <span id="detailNo"></span>
        </li>
        <li>
            <label style="margin-bottom: 5px;" >건축물 마감 자재: </label>
            <div id="material"></div>
        </li>
    </ul>

</div>


<script>
    // $("#agenda_save").click(() => {
    //     agendaConsultationDialog.dialog("close");
    // });
    // $("#agenda_cancel").click(() => {
    //     console.log("cancel");
    //     agendaConsultationDialog.dialog("close");
    // });

</script>

<style>
    #metadataDialog .layerDiv label {
        width: 110px;
        font-size: 15px;
    }

    #metadataDialog .layerDiv li {
        margin-bottom: 6px;
    }

   /* #agendaConsultationDialog td {
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
    }*/
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