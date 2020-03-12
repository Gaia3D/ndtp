<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script type="text/javascript" src="/externlib/jquery-3.3.1/jquery.min.js"></script>
<script type="text/javascript" src="/externlib/jquery-ui-1.12.1/jquery-ui.min.js"></script>

<!-- 건축인허가 신청 Modal -->
<div id="sunConditionDialog" title="일조 조건" class="basicTable" style="display: none;">
    <h3 style="margin-top:9px; margin-bottom: 7px;">🔸일조 조건</h3>
    <table class="list-table scope-col">
        <colgroup>
            <col class="col-name">
            <col class="col-name">
            <col class="col-name">
            <col class="col-name">
            <col class="col-name">
            <col class="col-name">
        </colgroup>
        <thead>
        <tr>
            <th colspan="3" scope="col" class="col-name" >교사</th>
            <th colspan="3" scope="col" class="col-name" >체육장</th>
        </tr>
        </thead>
        <tbody >
        <tr align="center">
            <td colspan="3">동짓날 기준</td>
            <td colspan="3">동짓날 기준</td>
        </tr>
        <tr align="center">
            <td colspan="3">08:00 ~ 16:00 중 4시간 이상 일조 확보 또는</td>
            <td colspan="3">08:00 ~ 16:00 중 2시간 이상 일조 확보 또는</td>
        </tr>
        <tr align="center">
            <td>유치원/초등학교</td>
            <td>09:00 ~ 13:00 중</td>
            <td rowspan="3" style="vertical-align: middle;">연속 <br>2시간 <br>일조확보</br></td>
            <td>유치원/초등학교</td>
            <td>09:00 ~ 13:00 중</td>
            <td rowspan="3" style="vertical-align: middle;">연속 <br>1시간 <br>일조확보</td>
        </tr>
        <tr align="center">
            <td>중학교</td>
            <td>09:00 ~ 14:00 중</td>
            <td>중학교</td>
            <td>09:00 ~ 14:00 중</td>
        </tr>
        <tr align="center">
            <td>고등학교</td>
            <td>09:00 ~ 15:00 중</td>
            <td>고등학교</td>
            <td>09:00 ~ 15:00 중</td>
        </tr>
        </tbody>
    </table>

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