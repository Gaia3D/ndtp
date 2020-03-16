<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/taglib.jsp" %>
<%@ include file="/WEB-INF/views/common/config.jsp" %>

<!DOCTYPE html>
<html lang="${accessibility}">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width">
	<title>Layer 수정 | NDTP</title>
	<link rel="stylesheet" href="/css/${lang}/font/font.css?cacheVersion=${contentCacheVersion}" />
	<link rel="stylesheet" href="/images/${lang}/icon/glyph/glyphicon.css?cacheVersion=${contentCacheVersion}" />
	<link rel="stylesheet" href="/externlib/normalize/normalize.min.css?cacheVersion=${contentCacheVersion}" />
	<link rel="stylesheet" href="/css/fontawesome-free-5.2.0-web/css/all.min.css?cacheVersion=${contentCacheVersion}">
	<link rel="stylesheet" href="/externlib/jquery-ui-1.12.1/jquery-ui.min.css?cacheVersion=${contentCacheVersion}" />
	<link rel="stylesheet" href="/externlib/dropzone/dropzone.min.css?cacheVersion=${contentCacheVersion}">
    <link rel="stylesheet" href="/css/${lang}/admin-style.css?cacheVersion=${contentCacheVersion}" />
    <script type="text/javascript" src="../externlib/handlebars-4.1.2/handlebars.js?cacheVersion=${contentCacheVersion}"></script>
    <script type="text/javascript" src="/externlib/dropzone/dropzone.min.js?cacheVersion=${contentCacheVersion}"></script>
    <style type="text/css">
        .dropzone .dz-preview.lp-preview {
            width: 150px;
        }
        .dropzone.hzScroll {
            min-width: 700px;
            overflow: auto;
            white-space: nowrap;
            border: 1px solid #e5e5e5;
        }
        
        .loader-txt p {
            font-size: 13px;
            color: #666;
        }
    
        .loader-txt p small {
            font-size: 11.5px;
            color: #999;
        }
        
        .loader {
            position: relative;
            text-align: center;
            margin: 15px auto 35px auto;
            z-index: 9999;
            display: block;
            width: 80px;
            height: 80px;
            border: 10px solid rgba(0, 0, 0, 0.3);
            border-radius: 50%;
            border-top-color: #000;
            animation: spin 1s ease-in-out infinite;
            -webkit-animation: spin 1s ease-in-out infinite;
        }
    
        @keyframes spin {
            to {
                -webkit-transform: rotate(360deg);
            }
        }
    
        @-webkit-keyframes spin {
            to {
                -webkit-transform: rotate(360deg);
            }
        }
    </style>
</head>
<body>
	<%@ include file="/WEB-INF/views/layouts/header.jsp" %>
	<%@ include file="/WEB-INF/views/layouts/menu.jsp" %>
	<div class="site-body">
		<div class="container">
			<div class="site-content">
				<%@ include file="/WEB-INF/views/layouts/sub_menu.jsp" %>
				<div class="page-area">
					<%@ include file="/WEB-INF/views/layouts/page_header.jsp" %>
					<div class="page-content">
						<div class="input-header row">
							<div class="content-desc u-pull-right"><span class="icon-glyph glyph-emark-dot color-warning"></span><spring:message code='check'/></div>
						</div>
						<form:form id="layer" modelAttribute="layer" method="post" onsubmit="return false;">
						<table class="input-table scope-row" summary="upload 레이어 수정 테이블">
						<caption class="hiddenTag">업로드 레이어 수정</caption>
							<colgroup>
			                    <col class="col-label l" style="width: 15%" >
			                    <col class="col-input" style="width: 35%" >
			                    <col class="col-label l" style="width: 15%" >
			                    <col class="col-input" style="width: 35%" >
			                </colgroup>
			                <tr>
								<th class="col-label" scope="row">
									<form:label path="layerGroupName">Layer 그룹명</form:label>
									<span class="icon-glyph glyph-emark-dot color-warning"></span>
								</th>
								<td class="col-input">
									<form:hidden path="layerGroupId" />
									<form:input path="layerGroupName" cssClass="ml" readonly="true" />
									<input type="button" id="layerGroupButtion" value="Layer 그룹 찾기" />
								</td>
								<th class="col-label" scope="row">
			                        <label for="sharing">공유 유형</label>
			                    </th>
			                    <td class="col-input radio-set">
			                        <form:radiobutton id="sharingPublic"  path="sharing" value="public" label="공개" />
									<form:radiobutton id="sharingPrivate" path="sharing" value="private" label="비공개" />
									<form:radiobutton id="sharingGroup" path="sharing" value="group" label="그룹" />
			                    </td>
							</tr>
							<tr>
			                    <th class="col-label" scope="row">
			                        <form:label path="layerName">Layer 명</form:label>
			                        <span class="icon-glyph glyph-emark-dot color-warning"></span>
			                    </th>
			                    <td class="col-input">
			                        <form:input path="layerName" cssClass="ml" />
			                        <form:errors path="layerName" cssClass="error" />
			                    </td>
			                    <th class="col-label" scope="row">
			                        <form:label path="layerKey">Layer Key</form:label>
			                        <span class="icon-glyph glyph-emark-dot color-warning"></span>
			                    </th>
			                    <td class="col-input">
			                        <form:input path="layerKey" cssClass="ml" readonly="true" />
			                        <form:errors path="layerKey" cssClass="error" />
			                    </td>
			                </tr>
			                <tr>
			                    <th class="col-label" scope="row">
			                        <form:label path="serviceType">서비스 타입</form:label>
			                        <span class="icon-glyph glyph-emark-dot color-warning"></span>
			                    </th>
			                    <td class="col-input">
			                        <select id="serviceType" name="serviceType" class="selectBoxClass">
										<option value="">선택</option>
										<option value="wms">WMS</option>
										<option value="wfs">WFS</option>
										<option value="wcs">WCS</option>
										<option value="wps">WPS</option>
									</select>
			                    </td>
			                    <th class="col-label" scope="row">
			                        <label for="cacheAvailableTrue">Cache 사용 유무</label>
			                    </th>
			                    <td class="col-input radio-set">
			                        <form:radiobutton id="cacheAvailableTrue"  path="cacheAvailable" value="true" label="사용" />
									<form:radiobutton id="cacheAvailableFalse" path="cacheAvailable" value="false" label="미사용" checked="checked"/>
			                    </td>
			                </tr>
			                <tr>
			                	<th class="col-label" scope="row">
			                        <form:label path="layerType">Layer 타입</form:label>
			                        <span class="icon-glyph glyph-emark-dot color-warning"></span>
			                    </th>
			                    <td class="col-input">
			                        <select id="layerType" name="layerType" class="selectBoxClass">
										<option value="">선택</option>
										<option value="vector">Vector</option>
										<option value="raster">Raster</option>
									</select>
			                    </td>
			                    <th class="col-label" scope="row">
			                        <form:label path="geometryType">도형 타입</form:label>
			                        <span class="icon-glyph glyph-emark-dot color-warning"></span>
			                    </th>
								<td class="col-input">
									<select id="geometryType" name="geometryType" class="forRaster selectBoxClass">
										<option value="">선택</option>
										<option value="Point">Point</option>
										<option value="Line">Line</option>
										<option value="Polygon">Polygon</option>
									</select>
								</td>
							</tr>
							<tr>	
								<th class="col-label" scope="row">
			                        <form:label path="layerLineColor">외곽선 색상</form:label>
			                        <span class="icon-glyph glyph-emark-dot color-warning"></span>
			                    </th>
								<td class="col-input">
									<label for="lineColorValue" class="hiddenTag">외곽선 색상값</label>
									<input id="lineColorValue" placeholder="RGB" class="forRaster forLineColor" />
									<input type="color" id="layerLineColor" name="layerLineColor" class="picker forLineColor" alt="외곽선 색상" />
								</td>
								<th class="col-label" scope="row">
			                        <form:label path="layerLineStyle">외곽선 두께</form:label>
			                    </th>
								<td class="col-input">
									<input type="number" id="layerLineStyle"  name="layerLineStyle" class="forRaster" alt="외곽선 두께" min="0.1" max="5.0" size="3" step="0.1">
								</td>
							</tr>
			                <tr>
			                	<th class="col-label" scope="row">
			                        <form:label path="layerFillColor">채우기 색상</form:label>
			                        <span class="icon-glyph glyph-emark-dot color-warning"></span>
			                    </th>
								<td class="col-input">
									<label for="fillColorValue" class="hiddenTag">채우기 색상값</label>
									<input id="fillColorValue" placeholder="RGB" class="forRaster forPolygon">
									<input type="color" id="layerFillColor" name="layerFillColor" class="picker forPolygon" alt="채우기 색상">
								</td>
			                	<th class="col-label" scope="row">
			                        <form:label path="layerAlphaStyle">투명도</form:label>
			                        <span class="icon-glyph glyph-emark-dot color-warning"></span>
			                    </th>
								<td class="col-input">
									<form:input type="text"  path="layerAlphaStyle" class="slider" alt="투명도"/>
									<label for="sliderRange" class="hiddenTag">투명도 값</label>
									<input type="range" id="sliderRange" min="0" max="100" value="100" alt="투명도">
								</td>
			                </tr>
			                <tr>
			                	<th class="col-label" scope="row">
			                        <label for="viewOrder">레이어 표시 순서</label>
			                    </th>
			                    <td class="col-input">
			                        <form:input path="viewOrder" cssClass="s"/>
			                        <form:errors path="viewOrder" cssClass="error" />
			                    </td>
			                	<th class="col-label" scope="row">
			                        <label for="zIndex">표시 순서(Z-Index)</label>
			                    </th>
			                    <td class="col-input">
			                        <form:input path="zIndex" cssClass="s" />
			                        <form:errors path="zIndex" cssClass="error" />
			                    </td>
			                </tr>
			                <tr>
			                	<th class="col-label" scope="row">
			                        <label for="defaultDisplayTrue">기본 표시</label>
			                        <span class="icon-glyph glyph-emark-dot color-warning"></span>
			                    </th>
			                    <td class="col-input radio-set">
			                        <form:radiobutton id="defaultDisplayTrue"  path="defaultDisplay" value="true" label="사용" />
									<form:radiobutton id="defaultDisplayFlase" path="defaultDisplay" value="false" label="미사용" />
			                    </td>
			                	<th class="col-label" scope="row">
			                        <label for="useY">사용유무</label>
			                        <span class="icon-glyph glyph-emark-dot color-warning"></span>
			                    </th>
			                    <td class="col-input radio-set">
			                        <form:radiobutton id="availableTrue"  path="available" value="true" label="사용" />
									<form:radiobutton id="availableFalse" path="available" value="false" label="미사용" />
			                    </td>
			                </tr>
			                <tr>
			                	<th class="col-label" scope="row">
			                        <label for="labelDisplayTrue">Label 표시 유무</label>
			                    </th>
			                    <td class="col-input radio-set">
			                        <form:radiobutton id="labelDisplayTrue"  path="labelDisplay" value="true" label="표시" />
									<form:radiobutton id="labelDisplayFalse" path="labelDisplay" value="false" label="비표시" />
			                    </td>
			                    <th class="col-label" scope="row">
			                        <form:label path="description">설명</form:label>
			                    </th>
			                    <td class="col-input">
			                        <form:input path="description" cssClass="l"/>
			                        <form:errors path="description" cssClass="error" />
			                    </td>
			                </tr>
			                <tr>
			                	<th class="col-label" scope="row">
			                        <form:label path="coordinate">좌표계</form:label>
			                    </th>
			                    <td class="col-input">
			                        <select id="coordinate"name="coordinate" class="selectBoxClass">
										<option value="EPSG:2096">EPSG:2096</option>
										<option value="EPSG:2097">EPSG:2097</option>
										<option value="EPSG:2098">EPSG:2098</option>
										<option value="EPSG:3857">EPSG:3857</option>
										<option value="EPSG:32651">EPSG:32651</option>
										<option value="EPSG:32652">EPSG:32652</option>
										<option value="EPSG:4004">EPSG:4004</option>
										<option value="EPSG:4019">EPSG:4019</option>
										<option value="EPSG:4326">EPSG:4326</option>
										<option value="EPSG:5173">EPSG:5173</option>
										<option value="EPSG:5174">EPSG:5174</option>
										<option value="EPSG:5175">EPSG:5175</option>
										<option value="EPSG:5176">EPSG:5176</option>
										<option value="EPSG:5177">EPSG:5177</option>
										<option value="EPSG:5178">EPSG:5178</option>
										<option value="EPSG:5179">EPSG:5179</option>
										<option value="EPSG:5180">EPSG:5180</option>
										<option value="EPSG:5181">EPSG:5181</option>
										<option value="EPSG:5182">EPSG:5182</option>
										<option value="EPSG:5183">EPSG:5183</option>
										<option value="EPSG:5184">EPSG:5184</option>
										<option value="EPSG:5185">EPSG:5185</option>
										<option value="EPSG:5186">EPSG:5186</option>
										<option value="EPSG:5187">EPSG:5187</option>
										<option value="EPSG:5188">EPSG:5188</option>
									</select>
			                        <form:errors path="coordinate" cssClass="error" />
			                    </td>
			                    <th class="col-label" scope="row">
			                        <form:label path="shapeEncoding">SHP 파일 인코딩</form:label>
			                    </th>
			                    <td class="col-input">
			                    	<select id="shapeEncoding" class="selectBoxClass" name="shapeEncoding" style="width:100px; height: 30px;">
				                    	<option value="CP949">CP949</option>
				                        <option value="UTF-8">UTF-8</option>
				                    </select>
			                    </td>
			                </tr>
						</table>
						</form:form>
						
						<h4 style="margin-top: 30px; margin-bottom: 5px;">파일 업로딩</h4>
				        <div class="fileSection" style="font-size: 17px;">
				            <form id="my-dropzone" action="" class="dropzone hzScroll">
				            	<label for="dropzoneFile" class="hiddenTag">dropzoneFile영역</label>
				            </form>
				        </div>
				        <div class="button-group">
							<div class="center-buttons">
								<input type="submit" id="allFileUpload" value="<spring:message code='save'/>"/>
								<input type="submit" id="allFileClear" value="파일 초기화" />
								<a href="/layer/list" class="button">목록</a>
							</div>
						</div>

						<h4 style="margin-top: 30px; margin-bottom: 5px;">레이어 변경 이력</h4>
						<div class="list">
							<table class="list-table scope-col" summary="레이어 변경 이력 테이블">
							<caption class="hiddenTag">레이어 변경 이력</caption>
								<thead>
									<tr>
										<th scope="col">번호</th>
										<th scope="col">파일명</th>
										<th scope="col">상세</th>
										<th scope="col">지도</th>
										<th scope="col">활성화 여부</th>
										<th scope="col">다운로드</th>
										<th scope="col">수정자</th>
										<th scope="col">수정일</th>
										<th scope="col">등록일</th>
									</tr>
								</thead>
								<tbody id="layerFileInfoListArea">
				<c:if test="${empty layerFileInfoList }">
									<tr style="height:50px;">
										<td colspan="9" style="padding-top:15px; text-align:center;">첨부 파일이 존재하지 않습니다.</td>
									</tr>
				</c:if>
				<c:if test="${!empty layerFileInfoList }">
					<c:forEach var="layerFileInfo" items="${layerFileInfoList}" varStatus="status">
						<c:if test="${layerFileInfo.enableYn eq 'Y'}">
							<c:set var="cssClass" value="selected"></c:set>
						</c:if>
						<c:if test="${layerFileInfo.enableYn ne 'Y'}">
							<c:set var="cssClass" value=""></c:set>
						</c:if>
									<tr class="${cssClass}">
										<td class="col-key">${layerFileInfoListSize - status.index}</td>
										<td class="col-key" style="max-width:315px; word-wrap:break-word;">${layerFileInfo.fileName}</td>
										<td class="col-type"><button type="button" onclick="viewFileDetail('${layerFileInfo.layerFileInfoId}');" title="보기" class="detailBtn">보기</button></td>
										<td class="col-type"><button type="button" onclick="viewLayerMap('${layerFileInfo.layerId}', '${layerFileInfo.layerName}',
											'${layerFileInfo.layerFileInfoId}');" title="보기" class="textBtn">보기</button></td>
										<td class="col-type">
						<c:if test="${layerFileInfo.enableYn eq 'Y'}">
											<p style="font-size:14px;">적용중</p>
						</c:if>
						<c:if test="${layerFileInfo.enableYn ne 'Y'}">
											<button type="button" onclick="changeStatus('${layerFileInfo.layerId }', '${layerFileInfo.layerFileInfoGroupId}', '${layerFileInfo.layerFileInfoId}');"
												title="적용하기" class="textBtn">적용하기</button>
						</c:if>
										</td>
										<td class="col-type"><a href="/layer/${layer.layerId}/layer-file-info/${layerFileInfo.layerFileInfoGroupId}/download" class="linkButton">다운로드</a></td>
										<td>${layerFileInfo.userId}</td>
										<td>						
											<fmt:parseDate value="${layerFileInfo.viewUpdateDate}" var="viewUpdateDate" pattern="yyyy-MM-dd HH:mm:ss"/>
											<fmt:formatDate value="${viewUpdateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
										</td>
										<td>
											<fmt:parseDate value="${layerFileInfo.viewInsertDate}" var="viewInsertDate" pattern="yyyy-MM-dd HH:mm:ss"/>
											<fmt:formatDate value="${viewInsertDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
										</td>
									</tr>
					</c:forEach>
				</c:if>
				                </tbody>
				            </table>
				        </div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<%@ include file="/WEB-INF/views/layouts/footer.jsp" %>
	<%@ include file="/WEB-INF/views/layer/loading-dialog.jsp" %>
	<%@ include file="/WEB-INF/views/layer/spinner-dialog.jsp" %>
	<%@ include file="/WEB-INF/views/layer/fileInfo-deatil-dialog.jsp"%>
	<!-- Dialog -->
	<%@ include file="/WEB-INF/views/layer/layer-group-dialog.jsp" %>

<script id="templateLayerFileInfoList" type="text/x-handlebars-template">
{{#each layerFileInfoList}}
	{{#if enableYn}}
        <tr class="selected">
    {{else}}
        <tr>
    {{/if}}
            <td class="col-key">{{subtract ../layerFileInfoList.length @index}}</td>
            <td class="col-key" style="max-width:315px; word-wrap:break-word;">{{fileName}}</td>
            <td class="col-type"><button type="button" class="detailBtn" title="보기" onclick="viewFileDetail('{{layerFileInfoId}}'); return false;" >보기</button>
            <td class="col-type"><button type="button" class="textBtn" title="보기" onclick="viewLayerMap('{{layerId}}', '{{layerName}}', '{{layerFileInfoId}}'); return false;" >보기</button></td>
            <td class="col-type">
    {{#if enableYn}}
               	<p style="font-size:14px;">적용중</p>
    {{else}}
                <button type="button" onclick="changeStatus('{{layerId}}', '{{layerFileInfoGroupId}}', '{{layerFileInfoId}}'); return false;" title="적용하기" class="textBtn">적용하기</button>
    {{/if}}
            </td>
            <td class="col-type"><a href="/layer/{{layerId }}/layer-file-info/{{layerFileInfoGroupId}}/download" download class="linkButton">다운로드</button></td>
            <td class="col-key">{{userId}}</td>
            <td class="col-key">{{viewUpdateDate}}</td>
			<td class="col-key">{{viewInsertDate}}</td>
		</tr>
{{/each}}
</script>
	
<script type="text/javascript" src="/externlib/jquery-3.3.1/jquery.min.js?cacheVersion=${contentCacheVersion}"></script>
<script type="text/javascript" src="/externlib/jquery-ui-1.12.1/jquery-ui.min.js?cacheVersion=${contentCacheVersion}"></script>
<script type="text/javascript" src="/js/${lang}/common.js?cacheVersion=${contentCacheVersion}"></script>
<script type="text/javascript" src="/js/${lang}/message.js?cacheVersion=${contentCacheVersion}"></script>
<script type="text/javascript" src="/js/navigation.js?cacheVersion=${contentCacheVersion}"></script>
<script type="text/javascript">
	$(document).ready(function() {
		showRange(parseInt('${layer.layerAlphaStyle * 100}'));
		changeLayerType('${layer.layerType}');
		changeGeometryType('${layer.geometryType}');
		$("#sliderRange").val(parseInt('${layer.layerAlphaStyle * 100}'));
		$("#layerLineStyle").val('${layer.layerLineStyle}');
		$("input[name='sharing']").filter("[value='${layer.sharing}']").prop("checked", true);
		$("input[name='defaultDisplay']").filter("[value='${layer.defaultDisplay}']").prop("checked", true);
		$("input[name='available']").filter("[value='${layer.available}']").prop("checked", true);
        $("input[name='labelDisplay']").filter("[value='${layer.labelDisplay}']").prop("checked", true);
        $("input[name='layerFillColor']").filter("[value='${layer.layerFillColor}']").prop("checked", true);
        $("input[name='labelDisplay']").filter("[value='${layer.labelDisplay}']").prop("checked", true);
        $("select[name=serviceType] option[value='${layer.serviceType}'").prop('selected',true);
        $("select[name=geometryType] option[value='${layer.geometryType}'").prop('selected',true);
        $("select[name=layerType] option[value='${layer.layerType}'").prop('selected',true);
        $("select[name=shapeEncoding] option[value='${layer.shapeEncoding}'").prop('selected',true);
        $("select[name=coordinate] option[value='${layer.coordinate}'").prop('selected',true);
        $(".forLineColor").val("${layer.layerLineColor}");
        $(".forPolygon").val("${layer.layerFillColor}");
        $("input[name='cacheAvailable']").filter("[value='${layer.cacheAvailable}']").prop("checked", true);
        
        if('${layer.serviceType}' !== 'wms') {
        	$("input[name='cacheAvailable']").attr("disabled", true);
        }
        
        $("input[type='file']").attr("id", "dropzoneFile");
	});
	
	$('[name=layerType]').on('change', function() {
		changeLayerType($("[name=layerType]").val());
	});
	
	$('[name=geometryType]').on('change', function() {
		changeGeometryType($("[name=geometryType]").val());
	});
	
	// wms일 경우에만 cache 설정 할 수 있도록 활성화
	$("select[name=serviceType]").change(function(e){
		var value = $(this).val();
	    if(value === "wms") {
	    	$("input[name='cacheAvailable']").attr("disabled", false);
	    } else {
	    	$("input[name='cacheAvailable']").attr("disabled", true);
	    	$("input[name='cacheAvailable']").filter("[value='false']").prop("checked", true);
	    }
	});
	
	// 레이어 타입 Raster 선택 시 입력폼 변경
	function changeLayerType(layerType) {
		if(layerType == 'vector') {
			$('.forRaster').attr('disabled', false);
			$('.forRaster').removeClass('disabled');
			$('.picker').attr('disabled', false);
			changeGeometryType(null);
			$('#layerLineStyle').val(Number(1.0));
		} else {
			$('.forRaster').attr('disabled', true);
			$('.forRaster').addClass('disabled');
			$('.picker').attr('disabled', true);
			$('.forRaster').val('');
			$('.picker').val(null);
		}
	}

	// 도형 타입 Polygon 선택시 선택폼 변경
	function changeGeometryType(geometryType) {
		if(geometryType == 'Polygon') {
			$('.forPolygon').attr('disabled', false);
			$('.forPolygon').removeClass("disabled");
			$('.picker.forPolygon').attr('disabled', false);
		} else {
			$('.forPolygon').attr('disabled', true);
			$('.forPolygon').addClass("disabled");
			$('.picker.forPolygon').attr('disabled', true);
			$('.forPolygon').val(null);
		}
	}
	
	// 슬라이더
	function showRange(valus) {
		$('#layerAlphaStyle').val(valus + "%");
	}

	var rangeSlider = function(){
		var range = $('#sliderRange');
		
		range.on('change', function(){		
			showRange(this.value);
		});
	};
	rangeSlider();

	// color picker
	function pickerColor() {
		var layerFillColor = $('#layerFillColor');
		var layerLineColor = $('#layerLineColor');
		var fillColorValue = $('#fillColorValue');
		var lineColorValue = $('#lineColorValue');
		
		layerFillColor.on('change', function(){		
			$('#fillColorValue').val($(this).val().toUpperCase());
		});

		layerLineColor.on('change', function(){		
			$('#lineColorValue').val($(this).val().toUpperCase());
		});

		fillColorValue.on('change', function(){		
			$('#layerFillColor').val($(this).val().toUpperCase());
		});

		lineColorValue.on('change', function(){		
			$('#layerLineColor').val($(this).val().toUpperCase());
		});
	}
	pickerColor();
	
	var layerGroupDialog = $( ".dialog" ).dialog({
		autoOpen: false,
		height: 600,
		width: 1200,
		modal: true,
		overflow : "auto",
		resizable: false
	});
	
	// Layer Group 찾기
	$( "#layerGroupButtion" ).on( "click", function() {
		layerGroupDialog.dialog( "open" );
		layerGroupDialog.dialog( "option", "title", "Layer 그룹 선택");
	});
	
	// 상위 Node
	function confirmParent(parent, parentName) {
		$("#layerGroupId").val(parent);
		$("#layerGroupName").val(parentName);
		layerGroupDialog.dialog( "close" );
	}
	
	function check() {
		var number = /^[0-9]+$/;
		
		if(!$("#layerGroupId").val() || !number.test($("#layerGroupId").val())) {
			alert("레이어 그룹을 선택해 주세요.");
			$("#layerGroupName").focus();
			return false;
		}
		if (!$("#layerName").val()) {
			alert("Layer 명을 입력하여 주십시오.");
			$("#layerName").focus();
			return false;
		}
		if (!$("#layerKey").val()) {
			alert("Layer key를 입력하여 주십시오.");
			$("#layerKey").focus();
			return false;
		}
		if (!$("select[name=serviceType]").val()) {
			alert("서비스 타입을 선택해 주십시오.");
			$("#serviceType").focus();
			return false;
		}
		if (!$("select[name=layerType]").val()) {
			alert("layer 타입을 선택해 주십시오.");
			$("#layerType").focus();
			return false;
		}
		if ($("select[name=layerType]").val() ==='vector' && !$("select[name=geometryType]").val()) {
			alert("도형 타입을 선택해 주십시오.");
			$("#geometryType").focus();
			return false;
		}
		if (!$("#coordinate").val()) {
			alert("좌표계를 선택해주세요.");
			$("#coordinate").focus();
			return false;
		}
	}
	
	var fileUploadDialog = $( ".spinner-dialog" ).dialog({
		autoOpen: false,
		width: 250,
		height: 290,
		modal: true,
		resizable: false
	});
	
	var layerLoadingDialog = $("#layerLoadingDialog").dialog({
		autoOpen: false,
		width: 250,
		height: 290,
		modal: true,
		resizable: false
	});
	
	function alertMessage(response) {
		if(uploadFileResultCount === 0) {
			if(response.errorCode === "upload.file.type.invalid") {
				alert("복수의 파일을 업로딩 할 경우 zip 파일은 사용할 수 없습니다.");
			} else if(response.errorCode === "layer.name.empty") {
				alert("Layer 명이 유효하지 않습니다.");
			} else if(response.errorCode === "db.exception") {
				alert("죄송 합니다. 서버 실행중에 오류가 발생 하였습니다. \n 로그를 확인하여 주십시오.");
			} else if(response.errorCode === "io.exception") {
	            alert("입출력 처리 과정중 오류가 발생하였습니다. 잠시 후 다시 이용하여 주시기 바랍니다.");
	        } else if(response.errorCode === "runtime.exception") {
	            alert("프로그램 실행중 오류가 발생하였습니다. 잠시 후 다시 이용하여 주시기 바랍니다.");
	        } else if(response.errorCode === "unknown.exception") {
	            alert("서버 장애가 발생하였습니다. 잠시 후 다시 이용하여 주시기 바랍니다.");
	        } else {
	        	alert(JS_MESSAGE[response.errorCode]);
	        }
			uploadFileResultCount++;
		}
		return;
	}

    // 업로딩 파일 개수
    var uploadFileCount = 0;
    // dropzone 업로딩 결과(n개 파일을 올리면 n개 리턴이 옴)
    var uploadFileResultCount = 0;
    Dropzone.options.myDropzone = {
   		url: "/layer/update/${layer.layerId}",
        //paramName: "file",
        // Prevents Dropzone from uploading dropped files immediately
        timeout: 3600000,
        autoProcessQueue: false,
        // 여러개의 파일 허용
        uploadMultiple: true,
        method: "post",
        // 병렬 처리
        parallelUploads: 10,
        // 최대 파일 업로드 갯수
        maxFiles: 10,
        // 최대 업로드 용량 Mb단위
        maxFilesize: 2000,
        dictDefaultMessage: "업로딩 하려면 Shape 파일을 올리거나 클릭 하십시오.",
        /* headers: {
            "x-csrf-token": document.querySelectorAll("meta[name=csrf-token]")[0].getAttributeNode("content").value,
        }, */
        // 허용 확장자
        acceptedFiles: initAcceptedFiles("${policy.shapeUploadType}"),
        // 업로드 취소 및 추가 삭제 미리 보기 그림 링크를 기본 추가 하지 않음
        // 기본 true false 로 주면 아무 동작 못함
        //clickable: true,
        fallback: function() {
            // 지원하지 않는 브라우저인 경우
            alert("죄송합니다. 최신의 브라우저로 Update 후 사용해 주십시오.");
            return;
        },
        init: function() {
            var myDropzone = this; // closure
            var uploadTask = document.querySelector("#allFileUpload");
            var clearTask = document.querySelector("#allFileClear");

            uploadTask.addEventListener("click", function(e) {
                if (check() === false) {
                    return;
                }

                uploadFileCount = 0;
                uploadFileResultCount = 0;
                e.preventDefault();
                e.stopPropagation();

                if (myDropzone.getQueuedFiles().length > 0) {
                    uploadFileCount = myDropzone.getQueuedFiles().length;
                    myDropzone.processQueue();
                    //startSpinner("fileUploadSpinner");
                    fileUploadDialog.dialog( "open" );
                } else {
                	layerLoadingDialog.dialog("open");
                    //send empty
                    //myDropzone.uploadFiles([{ name: 'nofiles', upload: { filename: 'nofiles' } }]);
                    myDropzone._uploadData([{ upload: { filename: '' } }], [{ filename: '', name: '', data: new Blob() }]);
                }
            });

            clearTask.addEventListener("click", function () {
                // Using "_this" here, because "this" doesn't point to the dropzone anymore
	            if (confirm("[파일 업로딩]의 모든 파일을 삭제하겠습니까?")) {
                    // true 주면 업로드 중인 파일도 다 같이 삭제
                    myDropzone.removeAllFiles(true);
                }
            });

            this.on("sending", function(file, xhr, formData) {
                formData.append("layerGroupId", $("#layerGroupId").val());
                formData.append("sharing", $(':radio[name="sharing"]:checked').val());
                formData.append("layerName", $("#layerName").val());
                formData.append("layerKey", $("#layerKey").val());
                formData.append("serviceType", $("select[name=serviceType]").val());
                formData.append("layerType", $("select[name=layerType]").val());
                formData.append("geometryType", $("select[name=geometryType]").val());
                formData.append("layerLineColor", $("#layerLineColor").val());
                formData.append("layerFillColor", $("#layerFillColor").val());
                formData.append("layerAlphaStyle", $("#sliderRange").val() / 100);
                formData.append("defaultDisplay", $(':radio[name="defaultDisplay"]:checked').val());
                formData.append("available", $(':radio[name="available"]:checked').val());
                formData.append("labelDisplay", $(':radio[name="labelDisplay"]:checked').val());
                formData.append("coordinate", $("#coordinate").val());
                formData.append("description", $("#description").val());
                formData.append("shapeEncoding", $("#shapeEncoding").val());
                formData.append("cacheAvailable", $(':radio[name="cacheAvailable"]:checked').val());
                formData.append("viewOrder", $("#viewOrder").val());
                var zIndex = 0;
                var viewOrder = 1;
                if($("#zIndex").val()) zIndex = $("#zIndex").val();
                if($("#viewOrder").val()) viewOrder = $("#viewOrder").val();
                formData.append("zIndex", zIndex);
                formData.append("viewOrder", viewOrder);
                var layerLineStyle = 0;
                if($("#layerLineStyle").val()) layerLineStyle = $("#layerLineStyle").val();
                formData.append("layerLineStyle", layerLineStyle);
            });

            // maxFiles 카운터를 초과하면 경고창
            this.on("maxfilesexceeded", function (data) {
                alert("최대 업로드 파일 수는 10개 입니다.");
                return;
            });

            this.on("success", function(file, response) {
            	if(file !== undefined && file.name !== undefined) {
	                console.log("file name = " + file.name);
	                $("#fileUploadSpinner").empty();
	                fileUploadDialog.dialog( "close" );
					if(response.errorCode === undefined || response.errorCode === null) {
						uploadFileResultCount ++;
						if(uploadFileCount === uploadFileResultCount) {
							alert(JS_MESSAGE["update"]);
						    uploadFileCount = 0;
						    uploadFileResultCount = 0;
						    myDropzone.removeAllFiles(true);
						}
	                } else {
	                	alertMessage(response);
	                	myDropzone.removeAllFiles(true);
	                }
	            } else {
					console.log("------- success response = " + response);
					if(response.statusCode <= 200) {
						layerLoadingDialog.dialog("close");
						setTimeout(function(){
		        			alert(JS_MESSAGE["update"]);
						},100);
					} else {
						alert(JS_MESSAGE[response.errorCode]);
						console.log("---- " + res.message);
					}
	            }
            });

            // 무한 루프 빠지네....
            /* this.on("error", function(response) {
                alert("파일 업로딩 중 오류가 발생하였습니다. 로그를 확인해 주십시오.");
            }); */
        }
    };
    
    var reloadLayerFileInfoListCount = 0;
	function reloadLayerFileInfoList() {
    	console.log("reloadLayerFileInfoListCount = " + reloadLayerFileInfoListCount);
    	$.ajax({
            url: "/layer/${layer.layerId}/layer-fileinfos",
            type: "GET",
            headers: {"X-Requested-With": "XMLHttpRequest"},
            dataType: "json",
            success: function(msg){
           		var source = $("#templateLayerFileInfoList").html();
				//핸들바 템플릿 컴파일
				var template = Handlebars.compile(source);

				// if helper
				Handlebars.registerHelper('if', function(conditional, options) {
					if(conditional === 'Y') {
						return options.fn(this);
					} else {
						return options.inverse(this);
					}
				});

				// 빼기 helper
				Handlebars.registerHelper("subtract", function(value1, value2) {
					return value1 - value2;
				});

				//핸들바 템플릿에 데이터를 바인딩해서 HTML 생성
				var reloadData = { layerFileInfoList: msg.layerFileInfoList };
				var layerFileInfoListHtml = template(reloadData);
				$("#layerFileInfoListArea").html("");
				$("#layerFileInfoListArea").append(layerFileInfoListHtml);

                reloadLayerFileInfoListCount++;
            },
            error: function(request, status, error) {
            	alert(" code : " + request.status + "\n" + ", message : " + request.responseText + "\n" + ", error : " + error);
            }
        });
    }

	// 비활성화 상태의 layer를 활성화 함
	function changeStatus(layerId, layerFileInfoGroupId, layerFileInfoId) {
		var info = "layerFileInfoGroupId=" + layerFileInfoGroupId;
		if(confirm("이 파일을 layer Shape 파일로 사용하시겠습니까?")) {
            $.ajax({
                url: "/layer/${layer.layerId}/layer-file-infos/" + layerFileInfoId,
				type: "POST",
				headers: {"X-Requested-With": "XMLHttpRequest"},
				data: info,
                dataType: "json",
                success: function(msg){
					reloadLayerFileInfoList();
					alert("적용 되었습니다.");
                },
                error: function(request, status, error) {
                	alert(" code : " + request.status + "\n" + ", message : " + request.responseText + "\n" + ", error : " + error);
                }
            });
        }
    }

    var fileInfoDetailDialog = $( "#fileInfoDetailDialog" ).dialog({
		autoOpen: false,
		width: 600,
		height: 310,
		modal: true,
		resizable: false
	});

 	// 상세 정보 보기
    function viewFileDetail(layerFileInfoId) {
    	fileInfoDetailDialog.dialog("open");

        $.ajax({
        	url: "/layer/file-info/" + layerFileInfoId,
        	type: "GET",
        	headers: {"X-Requested-With": "XMLHttpRequest"},
        	dataType: "json",
        	success: function(msg) {
        		var source = $("#templateFileInfoDetail").html();
				//핸들바 템플릿 컴파일
				var template = Handlebars.compile(source);

				// 빼기 helper
				Handlebars.registerHelper("multiply", function(value1, value2) {
					return value1 * value2;
				});
				Handlebars.registerHelper('ifEquals', function(arg1, arg2) {
				    return (arg1 === arg2) ? "" : arg1;
				});

				//핸들바 템플릿에 데이터를 바인딩해서 HTML 생성
				var fileInfoDetailHtml = template(msg.layerFileInfo);
				$("#fileInfoDetailDialog").html("");
				$("#fileInfoDetailDialog").append(fileInfoDetailHtml);
        	},
            error: function(request, status, error) {
            	alert(" code : " + request.status + "\n" + ", message : " + request.responseText + "\n" + ", error : " + error);
            }
        });
    }
 	
 	// 지도 보기
    function viewLayerMap(layerId, layerName, layerFileInfoId) {
    	var url = "/layer/" + layerId + "/map?layerFileInfoId=" + layerFileInfoId;
		var width = 1000;
		var height = 700;

		var popWin = window.open(url, "","toolbar=no ,width=" + width + " ,height=" + height
				+ ", directories=no,status=yes,scrollbars=no,menubar=no,location=no");
		popWin.document.title = layerName;
    }
	
</script>
</body>
</html>