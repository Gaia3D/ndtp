<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script type="text/javascript" src="/externlib/jquery-3.3.1/jquery.min.js"></script>
<script type="text/javascript" src="/externlib/jquery-ui-1.12.1/jquery-ui.min.js"></script>

<!-- 건축인허가 신청 Modal -->
<div id="addrSearchDialog" title="대지 정보" class="basicTable" style="display: none;">
<%--    <h4 class="category" style="margin-top: 5px; margin-bottom: 6px; font-size: 15px;">🔸 건축물 상세 정보</h4>--%>
    <ul class="analysisGroup">
        <li>
            <label for="addressLoc">위치</label>
            <label id ="addressLoc" for=""></label>
        </li>
        <li>
            <label for="">대상 면적</label>
            <label id="" for="">734.13㎡</label>
        </li>
        <li>
            <div>
                <label for="">기준 용적율</label>
                <label id="" for="">180.0%</label>
                <label for="">기준 건폐율</label>
                <label id="" for="">40.0%</label>
            </div>
        </li>
        <li>
            <div>
                <label for="">용적율</label>
                <label id="" for="">163.56%</label>
                <label for="">건폐율</label>
                <label id="" for="">24.83%</label>
            </div>
        </li>
        <li>
            <label for="">용적률 적합 여부</label>
            <label id="" for="" style="font-weight: bold; color: blue;">적합</label>
            <label for="">건폐율 적합 여부</label>
            <label id="" for="" style="font-weight: bold; color: blue;">적합</label>
        </li>
        <li>
            <label for="">건축 가능 여부</label>
            <label id="" for="" style="font-weight: bold; color: blue;">가능</label>
        </li>

    </ul>

</div>


<script>


</script>

<style>
    /*#metadataDialog .layerDiv label {*/
    /*    width: 110px;*/
    /*    font-size: 15px;*/
    /*}*/

    /*#metadataDialog .layerDiv li {*/
    /*    margin-bottom: 6px;*/
    /*}*/
    #addrSearchDialog .analysisGroup li label{
        width: 106px;
    }

</style>