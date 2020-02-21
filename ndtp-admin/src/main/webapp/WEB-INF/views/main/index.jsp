<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/taglib.jsp" %>
<%@ include file="/WEB-INF/views/common/config.jsp" %>

<!DOCTYPE html>
<html lang="${accessibility}">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width">
	<title>대시보드 | NDTP</title>
	<link rel="stylesheet" href="/css/${lang}/font/font.css" />
	<link rel="stylesheet" href="/images/${lang}/icon/glyph/glyphicon.css" />
	<link rel="stylesheet" href="/externlib/normalize/normalize.min.css" />
	<link rel="stylesheet" href="/externlib/jquery-ui-1.12.1/jquery-ui.min.css" />
	<link rel="stylesheet" href="/externlib/jqplot/jquery.jqplot.min.css" />
	<link rel="stylesheet" href="/css/fontawesome-free-5.2.0-web/css/all.min.css">
    <link rel="stylesheet" href="/css/${lang}/admin-style.css" />
    <style type="text/css">
        .jqplot-table-legend {
            width: 0%;
            border-collapse: inherit;
        }
        .jqplot-table-legend-label {
			max-width: 150px;
			overflow:hidden;
			white-space: nowrap;
			text-overflow: ellipsis;
        }
    </style>
</head>
<body>
	<%@ include file="/WEB-INF/views/layouts/header.jsp" %>
	<%@ include file="/WEB-INF/views/layouts/menu.jsp" %>
	<div class="site-body">
		<div class="container">
			<div class="widgets">
				<div class="row">
					<div class="widget widget-low widget-otp-usage full column">
						<div class="widget-header row">
							<div class="widget-heading u-pull-left">
								<h3 class="widget-title"><spring:message code='main.data.status'/><span class="widget-desc">${yearMonthDay } (<spring:message code='main.today'/>)</span></h3>
							</div>
						</div><!-- .widget-header -->
						<div class="widget-content row">
							<div class="one-third column banner-container">
								<div class="banner info-generates">
									<div>
										<div class="info-device">
											<span class="icon-glyph glyph-plus-circle"></span>
											<span class="info-numbers"></span>
										</div>
									</div>
									<div>
										<span class="banner-title"><spring:message code='main.data.new'/></span>
										<span id="firstCountSpinner" class="banner-number"></span>
										<span class="banner-unit"> ${issueTotalCount} <spring:message code='main.count'/> </span>
									</div>
								</div>
							</div>

							<div class="one-third column banner-container">
								<div class="banner info-success">
									<div>
										<div class="info-device">
											<span class="icon-glyph glyph-check-circle"></span>
											<span class="info-numbers"></span>
										</div>
									</div>
									<div>
										<span class="banner-title"><spring:message code='main.data.success'/></span>
										<span id="secondeCountSpinner" class="banner-number"></span>
										<span class="banner-unit"> 5 <spring:message code='main.count'/></span>
									</div>
								</div>
							</div>

							<div class="one-third column banner-container">
								<div class="banner info-failures">
									<div>
										<div class="info-device">
											<span class="icon-glyph glyph-emark-circle"></span>
											<span class="info-numbers"></span>
										</div>
									</div>
									<div>
										<span class="banner-title"><spring:message code='main.data.fail'/></span>
										<span id="thirdCountSpinner" class="banner-number"></span>
										<span class="banner-unit"> 0 <spring:message code='main.count'/></span>
									</div>
								</div>
							</div>
						</div><!-- .widget-content -->
					</div><!-- .widget -->

<c:forEach var="dbWidget" items="${widgetList }">
	<c:choose>
		<c:when test="${dbWidget.name == 'dataGroupWidget'}">
					<div id="${dbWidget.widgetId }" class="widget one-third column" style="font-size: 16px;">
						<div class="widget-header row">
							<div class="widget-heading u-pull-left">
								<h3 class="widget-title"><spring:message code='main.status.data.group'/><span class="widget-desc">${today } <spring:message code='config.widget.basic'/></span></h3>
							</div>
							<div class="widget-functions u-pull-right">
								<a href="/data/list" title="<spring:message code='config.widget.project.more'/>"><span class="icon-glyph glyph-plus"></span></a>
							</div>
						</div>
						<div id="${dbWidget.name}" class="widget-content row">
							<div style="text-align: center; padding-top: 60px; padding-left: 150px;">
					            <div id="dataGroupSpinner" style="width: 150px; height: 70px;"></div>
							</div>
						</div>
					</div>
		</c:when>
		<c:when test="${dbWidget.name == 'dataInfoWidget'}">
					<div id="${dbWidget.widgetId }" class="widget one-third column" style="font-size: 16px;">
						<div class="widget-header row">
							<div class="widget-heading u-pull-left">
								<h3 class="widget-title"><spring:message code='main.status.use.data'/><span class="widget-desc">${today } <spring:message code='config.widget.basic'/></span></h3>
							</div>
							<div class="widget-functions u-pull-right">
								<a href="/data/list" title="<spring:message code='config.widget.data.info.more'/>"><span class="icon-glyph glyph-plus"></span></a>
							</div>
						</div>
						<div id="${dbWidget.name}" class="widget-content row">
							<div style="text-align: center; padding-top: 60px; padding-left: 150px;">
					      		<div id="dataInfoSpinner" style="width: 150px; height: 70px;"></div>
					       	</div>
						</div>
					</div>
		</c:when>
		<c:when test="${dbWidget.name == 'dataInfoLogListWidget'}">
					<div id="${dbWidget.widgetId }" class="widget one-third column">
						<div class="widget-header row">
							<div class="widget-heading u-pull-left">
								<h3 class="widget-title"><spring:message code='main.status.data.log'/><span class="widget-desc">${today } <spring:message code='config.widget.basic'/></span></h3>
							</div>
							<div class="widget-functions u-pull-right">
								<a href="/data/list-data-log" title="<spring:message code='config.widget.data.info.log.more'/>"><span class="icon-glyph glyph-plus"></span></a>
							</div>
						</div>
						<div id="${dbWidget.name}" class="widget-content row">
							<div style="text-align: center; padding-top: 60px; padding-left: 150px;">
					       		<div id="dataInfoLogListSpinner" style="width: 150px; height: 70px;"></div>
					       	</div>
						</div>
					</div>
		</c:when>
		<c:when test="${dbWidget.name == 'userWidget'}">
					<div id="${dbWidget.widgetId }" class="widget one-third column" style="font-size: 16px;">
						<div class="widget-header row">
							<div class="widget-heading u-pull-left">
								<h3 class="widget-title"><spring:message code='main.status.userstatus'/><span class="widget-desc">${today }<spring:message code='main.standard'/></span></h3>
							</div>
							<div class="widget-functions u-pull-right">
								<spring:message code='main.status.moreuserstatus' var="moreuserstatus"/>
								<a href="/user/list" title="${moreuserstatus}"><span class="icon-glyph glyph-plus"></span></a>
							</div>
						</div>
						<div id="${dbWidget.name}" class="widget-content row">
						</div>
					</div>
		</c:when>
		<c:when test="${dbWidget.name == 'civilVoiceWidget'}">
					<div id="${dbWidget.widgetId }" class="widget one-third column">
						<div class="widget-header row">
							<div class="widget-heading u-pull-left">
								<h3 class="widget-title"><spring:message code='main.status.civilvoice.data'/><span class="widget-desc">${thisYear }<spring:message code='main.status.civilvoice.date'/></span></h3>
							</div>
							<div class="widget-functions u-pull-right">
								<spring:message code='main.status.civilvoice.moreexecution' var="moreExectuion"/>
								<a href="/civil-voice/list" title="${moreExectuion}"><span class="icon-glyph glyph-plus"></span></a>
							</div>
						</div>
						<div id="${dbWidget.name}" class="widget-content row">
							<div style="text-align: center; padding-top: 60px; padding-left: 150px;">
			            		<div id="civilVoiceSpinner" style="width: 150px; height: 70px;"></div>
			            	</div>
						</div>
					</div>
		</c:when>
		<c:when test="${dbWidget.name == 'accessLogWidget'}">
					<div id="${dbWidget.widgetId }" class="widget one-third column">
						<div class="widget-header row">
							<div class="widget-heading u-pull-left">
								<h3 class="widget-title"><spring:message code='main.status.user.tracking'/><span class="widget-desc">${today } <spring:message code='main.standard'/></span></h3>
							</div>
							<div class="widget-functions u-pull-right">
								<spring:message code='main.status.user.moretracking' var='moreTracking'/>
								<a href="/access/list" title="${moreTracking}"><span class="icon-glyph glyph-plus"></span></a>
							</div>
						</div>

						<div id="${dbWidget.name}" class="widget-content row">
							<div style="text-align: center; padding-top: 60px; padding-left: 150px;">
			            		<div id="accessLogSpinner" style="width: 150px; height: 70px;"></div>
			            	</div>
						</div>
					</div>
		</c:when>
		<c:when test="${dbWidget.name == 'dbcpWidget'}">
					<div id="${dbWidget.widgetId }" class="widget one-third column">
						<div class="widget-header row">
							<div class="widget-heading u-pull-left">
								<h3 class="widget-title"><spring:message code='main.status.db.connection.pool'/><span class="widget-desc">${today }<spring:message code='main.standard'/></span></h3>
							</div>
						</div>

						<div id="${dbWidget.name}" class="widget-content row">
							<table class="widget-table">
								<col class="col-left" />
								<col class="col-center" />
								<col class="col-center" />
								<col class="col-center" />
								<tr>
									<td class="col-left">
										<em><spring:message code='main.status.property'/></em>
									</td>
									<td class="col-center">
										<em><spring:message code='main.status.admin'/></em>
									</td>
									<td class="col-center">
										<em><spring:message code='main.status.user'/></em>
									</td>
									<td class="col-center">
										<em><spring:message code='main.status'/></em>
									</td>
								</tr>
								<tr>
									<td class="col-left">
										<span class="icon-glyph glyph-users-circle"></span>
										<em><spring:message code='main.status.usersession.count'/></em>
									</td>
									<td class="col-center">
										<span id="userSessionCount" class="tendency increase">${userSessionCount }</span>
									</td>
									<td class="col-center">
										<span id="userUserSessionCount" class="tendency increase">${userUserSessionCount }</span>
									</td>
									<td class="col-center">
										<span class="tendency increase">
											<span class="icon-glyph glyph-up"></span>
										</span>
									</td>
								</tr>
								<tr>
									<td class="col-left">
										<span class="icon-glyph glyph-imark-circle"></span>
										<em><spring:message code='main.status.initialSize' /></em> (initialSize)
									</td>
									<td class="col-center">
										<span id="initialSize" class="tendency increase">${initialSize }</span>
									</td>
									<td class="col-center">
										<span id="userInitialSize" class="tendency increase">${userInitialSize }</span>
									</td>
									<td class="col-center">
										<span class="tendency increase">
											<span class="icon-glyph glyph-up"></span>
										</span>
									</td>
								</tr>
								<tr>
									<td class="col-left">
										<span class="icon-glyph glyph-plus-circle"></span>
										<em><spring:message code='main.status.maxtotal'/></em> (maxTotal)
									</td>
									<td class="col-center">
										<span id="maxTotal" class="tendency decrease">${maxTotal }</span>
									</td>
									<td class="col-center">
										<span id="userMaxTotal" class="tendency decrease">${userMaxTotal }</span>
									</td>
									<td class="col-center">
										<span class="tendency decrease">
											<span class="icon-glyph glyph-down"></span>
										</span>
									</td>
								</tr>
								<tr>
									<td class="col-left">
										<span class="icon-glyph glyph-top-circle"></span>
										<em><spring:message code='main.status.maxIdle'/></em> (maxIdle)
									</td>
									<td class="col-center">
										<span id="maxIdle" class="tendency decrease">${maxIdle }</span>
									</td>
									<td class="col-center">
										<span id="userMaxIdle" class="tendency decrease">${userMaxIdle }</span>
									</td>
									<td class="col-center">
										<span class="tendency decrease">
											<span class="icon-glyph glyph-down"></span>
										</span>
									</td>
								</tr>
								<tr>
									<td class="col-left">
										<span class="icon-glyph glyph-mouse-circle"></span>
										<em><spring:message code='main.status.numactive'/></em> (numActive)
									</td>
									<td class="col-center">
										<span id="numActive" class="tendency increase">${numActive }</span>
									</td>
									<td class="col-center">
										<span id="userNumActive" class="tendency increase">${userNumActive }</span>
									</td>
									<td class="col-center">
										<span class="tendency increase">
											<span class="icon-glyph glyph-up"></span>
										</span>
									</td>
								</tr>
								<tr>
									<td class="col-left">
										<span class="icon-glyph glyph-bottom-circle"></span>
										<em><spring:message code='main.status.minIdle'/></em> (minIdle, numIdle)
									</td>
									<td class="col-center">
										<span id="minIdle" class="tendency increase">${minIdle },${numIdle }</span>
									</td>
									<td class="col-center">
										<span id="userMinIdle" class="tendency increase">${userMinIdle },${userNumIdle }</span>
									</td>
									<td class="col-center">
										<span class="tendency increase">
											<span class="icon-glyph glyph-up"></span>
										</span>
									</td>
								</tr>
								<%-- <tr>
									<td class="col-left">
										<span class="icon-glyph glyph-check-circle"></span>
										<em>유지수</em> (numIdle)
									</td>
									<td class="col-center">
										<span id="numIdle" class="tendency increase">${numIdle }</span>
									</td>
									<td class="col-center">
										<span id="userNumIdle" class="tendency increase">${userNumIdle }</span>
									</td>
									<td class="col-center">
										<span class="tendency increase">
											<span class="icon-glyph glyph-up"></span>
										</span>
									</td>
								</tr> --%>
							</table>
						</div>
					</div>
		</c:when>
		<c:when test="${dbWidget.name == 'dbSessionWidget'}">
					<div id="${dbWidget.widgetId }" class="widget one-third column">
						<div class="widget-header row">
							<div class="widget-heading u-pull-left">
								<h3 class="widget-title"><spring:message code='main.status.db.session'/>(${dbSessionCount })<span class="widget-desc">${today }<spring:message code='main.standard'/></span></h3>
							</div>
							<div class="widget-functions u-pull-right">
								<spring:message code='main.status.db.moresession' var='moreSession'/>
								<a href="/monitoring/list-db-session.do" title="${moreSession}"><span class="icon-glyph glyph-plus"></span></a>
							</div>
						</div>
						<div id="${dbWidget.name}" class="widget-content row">
							<table class="widget-table">
								<col class="col-left" />
								<col class="col-left" />
			<c:if test="${empty dbSessionList }">
								<tr>
									<td colspan="2" class="col-none"><spring:message code='main.status.db.nosession'/></td>
								</tr>
			</c:if>
			<c:if test="${!empty dbSessionList }">
				<c:forEach var="pGStatActivity" items="${dbSessionList}" varStatus="status">
								<tr>
									<td class="col-left">
										<span class="index"></span>
										${pGStatActivity.clientAddr }
									</td>
									<td class="col-left">${pGStatActivity.viewQuery }</td>
								</tr>
				</c:forEach>
			</c:if>
							</table>
						</div>
					</div>
		</c:when>
		<c:otherwise>

		</c:otherwise>
	</c:choose>
</c:forEach>
				</div>
			</div>
		</div>
	</div>

	<%@ include file="/WEB-INF/views/layouts/footer.jsp" %>

<script type="text/javascript" src="/externlib/jquery-3.3.1/jquery.min.js"></script>
<script type="text/javascript" src="/externlib/jquery-ui-1.12.1/jquery-ui.min.js"></script>

<script type="text/javascript" src="/externlib/jqplot/jquery.jqplot.min.js"></script>
<script type="text/javascript" src="/externlib/jqplot/plugins/jqplot.barRenderer.min.js"></script>
<script type="text/javascript" src="/externlib/jqplot/plugins/jqplot.categoryAxisRenderer.min.js"></script>
<script type="text/javascript" src="/externlib/jqplot/plugins/jqplot.dateAxisRenderer.min.js"></script>
<script type="text/javascript" src="/externlib/jqplot/plugins/jqplot.pieRenderer.min.js"></script>
<script type="text/javascript" src="/externlib/jqplot/plugins/jqplot.pointLabels.min.js"></script>

<script type="text/javascript" src="/externlib/spinner/progressSpin.min.js"></script>
<script type="text/javascript" src="/externlib/spinner/raphael.js"></script>

<script type="text/javascript" src="/js/${lang}/common.js"></script>
<script type="text/javascript" src="/js/${lang}/message.js"></script>
<script type="text/javascript" src="/js/navigation.js"></script>
<script type="text/javascript">
	var refreshTime = parseInt("${widgetInterval}") * 1000;

	var isDataGroupDraw = "${isDataGroupDraw}";
	var isDataInfoDraw = "${isDataInfoDraw}";
	var isDataInfoLogListDraw = "${isDataInfoLogListDraw}";
	var isIssueDraw = "${isIssueDraw}";
	var isUserDraw = "${isUserDraw}";
	var isCivilVoiceDraw = "${isCivilVoiceDraw}";
	var isAccessLogDraw = "${isAccessLogDraw}";
	var isDbcpDraw = "${isDbcpDraw}";
	var isDbSessionDraw = "${isDbSessionDraw}";

	$(document).ready(function() {
		if(isDataGroupDraw == "true") {
			startSpinner("dataGroupSpinner");
			dataGroupWidget();
		}
		if(isDataInfoDraw == "true") {
			startSpinner("dataInfoSpinner");
			dataInfoWidget();
		}
		if(isDataInfoLogListDraw == "true") {
			startSpinner("dataInfoLogListSpinner");
			dataInfoLogListWidget();
		}
		if(isIssueDraw == "true") {
			// TODO spinner
			issueWidget();
		}
		if(isUserDraw == "true") {
			userWidget(0, null);
		}
		if(isCivilVoiceDraw == "true") {
			startSpinner("civilVoiceSpinner");
			civilVoiceWidget();
		}
		if(isAccessLogDraw == "true") {
			startSpinner("accessLogSpinner");
		    setTimeout(callAccessLogWidget, 1000);
		}
		if(isDbcpDraw == "true") {
			setTimeout(callDbcpWidget, 2000);
		}
		if(isDbSessionDraw == "true") {
			//startSpinner("dbSessionSpinner");
		    setTimeout(dbSessionWidget, 3000);
		}

		var isActive = "${isActive}";
		if(isActive == "true") {
			// Active 일때만 화면을 갱신함
			setInterval(refreshMain, refreshTime);
		}
	});

	function refreshMain() {
		if(isDataGroupDraw == "true") {
			dataGroupWidget();
		}
		if(isDataInfoDraw == "true") {
			dataInfoWidget();
		}
		if(isDataInfoLogListDraw == "true") {
			dataInfoLogListWidget();
		}
		if(isIssueDraw == "true") {
			issueWidget();
		}
		if(isUserDraw == "true") {
			//userWidget();
		}
		// TODO You'll need to add the remaining widgets later
	}

	// DB Connection Pool 현황
	function callDbcpWidget() {
		//dbcpWidget();
		//setInterval(ajaxDbcpWidget, refreshTime);
	}

	// 사용자 추적
	function callAccessLogWidget() {
		accessLogWidget();
		setInterval(accessLogWidget, refreshTime);
	}

	function dataGroupWidget() {
		var url = "/main/ajax-data-group-widget";
		var info = "";
		$.ajax({
			url: url,
			type: "GET",
			data: info,
			dataType: "json",
			headers: { "X-mago3D-Header" : "mago3D"},
			success : function(msg) {
				if(msg.result === "success") {
					showDataGroup(msg.dataGroupWidgetList);
				} else {
					alert(JS_MESSAGE[msg.result]);
				}
			},
			error : function(request, status, error) {
				alert(JS_MESSAGE["ajax.error.message"]);
				console.log("code : " + request.status + "\n message : " + request.responseText + "\n error : " + error);
			}
		});
	}

	function showDataGroup(dataGroupWidgetList) {

		$("#dataGroupWidget").empty();
		if(dataGroupWidgetList == null || dataGroupWidgetList.length == 0) {
			return;
		}

		var data = [];
		var dataGroupCount =  dataGroupWidgetList.length;
		for(i=0; i<dataGroupCount; i++ ) {
			var dataGroupStatisticsArray = [ dataGroupWidgetList[i]["name"], dataGroupWidgetList[i]["count"]];
			data.push(dataGroupStatisticsArray);
		}

		var plot = $.jqplot("dataGroupWidget", [data], {
            //title : "project 별 chart",
            seriesColors: [ "#a67ee9", "#FE642E", "#01DF01", "#2E9AFE", "#F781F3", "#F6D8CE", "#99a0ac" ],
            grid: {
                drawBorder: false,
                drawGridlines: false,
                background: "#ffffff",
                shadow:false
            },
            gridPadding: {top:0, bottom:85, left:0, right:170},
            seriesDefaults:{
                renderer:$.jqplot.PieRenderer,
                trendline : { show : false},
                rendererOptions: {
                    padding:8,
                    showDataLabels: true,
                    dataLabels: "value",
                    startAngle: -90,
                    //dataLabelFormatString: "%.1f%"
                },
            },
            legend: {
                show: true,
                fontSize: "10pt",
                placement : "outside",
                rendererOptions: {
                    numberRows: 7,
                    numberColumns: 1
                },
                location: "e",
                //border: "none",
                marginLeft: "10px"
            }
        });
	}

	function dataInfoWidget() {
		$.ajax({
			url : "/main/ajax-data-status-widget",
			type : "GET",
			cache : false,
			dataType : "json",
			success : function(msg) {
				if (msg.result == "success") {
					showDataInfo(msg);
				} else {
					alert(JS_MESSAGE[msg.result]);
				}
			},
			error : function(request, status, error) {
				alert(JS_MESSAGE["ajax.error.message"]);
			}
		});
	}

	function showDataInfo(jsonData) {

		$("#dataInfoWidget").empty();

		var useTotalCount = parseInt(jsonData.useTotalCount);
		var forbidTotalCount = parseInt(jsonData.forbidTotalCount);
		var etcTotalCount = parseInt(jsonData.etcTotalCount);

		var use = "<spring:message code='data.status.use'/>";
		var unused = "<spring:message code='data.status.unused'/>";
		var etc = "<spring:message code='data.status.etc'/>";

		var dataValues = [ useTotalCount, forbidTotalCount, etcTotalCount];
		var ticks = [use, unused, etc];
		var yMax = 10;
		if(useTotalCount > 10 || forbidTotalCount > 10 || etcTotalCount > 10) {
			yMax = Math.max(useTotalCount, forbidTotalCount, etcTotalCount) + (useTotalCount * 0.2);
		}

		var plot = $.jqplot("dataInfoWidget", [dataValues], {
        	//title : "data info status",
        	height: 205,
        	animate: !$.jqplot.use_excanvas,
        	seriesColors: [ "#40a7fe", "#3fbdf8" ],
        	seriesDefaults:{
            	shadow:false,
            	renderer:$.jqplot.BarRenderer,
                pointLabels: { show: true },
                rendererOptions: {
                	barWidth: 50
                }
            },
            grid: {
				background: "#fff",
				//background: "#14BA6C"
				gridLineWidth: 0.7,
				//borderColor: 'transparent',
				shadow: false,
				borderWidth:0.1
				//shadowColor: 'transparent'
			},
            gridPadding:{
		        left:35,
		        right:1,
		        to:40,
		        bottom:27
		    },
            axes: {
                xaxis: {
                    renderer: $.jqplot.CategoryAxisRenderer,
                    ticks: ticks,
                    tickOptions:{
                    	formatString: "%'d",
	                	fontSize: "10pt"
	                }
                },
                yaxis: {
	            	numberTicks : 6,
	                min : 0,
	                max : yMax,
                    tickOptions:{
                    	formatString: "%'d",
	                	fontSize: "10pt"
	                }
				}
            },
            highlighter: { show: false }
        });
	}

	function dataInfoLogListWidget() {
		$.ajax({
			url : "/main/ajax-data-info-log-widget",
			type : "GET",
			cache : false,
			dataType : "json",
			success : function(msg) {
				if (msg.result == "success") {
					var dataAdjustLogList = msg.dataAdjustLogList;
					var content = "";
					content 	= "<table class=\"widget-table\">"
								+	"<col class=\"col-left\" />"
								+	"<col class=\"col-left\" />";
								+	"<col class=\"col-left\" />";
					if(dataAdjustLogList == null || dataAdjustLogList.length == 0) {
						content += 	"<tr>"
								+	"	<td colspan=\"3\" class=\"col-none\">데이터 변경 요청 이력이 존재하지 않습니다.</td>"
								+	"</tr>";
					} else {
						for(i=0; i<dataAdjustLogList.length; i++ ) {
							var dataInfoAdjustLog = null;
							dataInfoAdjustLog = dataAdjustLogList[i];
							var viewStatus = "";
							if(dataInfoAdjustLog.status === "0") viewStatus = "<spring:message code='request'/>";
							else if(dataInfoAdjustLog.status === "1") viewStatus = "<spring:message code='complete'/>";
							else if(dataInfoAdjustLog.status === "2") viewStatus = "<spring:message code='reject'/>";
							else if(dataInfoAdjustLog.status === "3") viewStatus = "<spring:message code='reset'/>";

							content = content
								+ 	"<tr>"
								+ 	"	<td class=\"col-left\">"
								+		"	<span class=\"index\"></span>"
								+		"	<em>" + dataInfoAdjustLog.dataName + "</em>"
								+		"</td>"
								+ 		"<td class=\"col-left\">" + viewStatus + "</td>"
								+ 		"<td class=\"col-left\">" + dataInfoAdjustLog.viewInsertDate + "</td>"
								+ 	"</tr>";
						}
					}
					$("#dataInfoLogListWidget").empty();
					$("#dataInfoLogListWidget").html(content);
				} else {
					alert(JS_MESSAGE[msg.result]);
				}
			},
			error : function(request, status, error) {
				console.log("code : " + request.status + "\n message : " + request.responseText + "\n error : " + error);
				alert(JS_MESSAGE["ajax.error.message"]);
			}
		});
	}

	function issueWidget() {

	}

	// 사용자 상태별 현황
	function showUser(drawType, jsonData) {
		var activeUserTotalCount = null;
		var fobidUserTotalCount = null;
		var failUserTotalCount = null;
		var sleepUserTotalCount = null;
		var expireUserTotalCount = null;
		var tempPasswordUserTotalCount = null;

		if(drawType == 0) {
			// el 데이터 표시
			activeUserTotalCount = parseInt("${activeUserTotalCount}");
			fobidUserTotalCount = parseInt("${fobidUserTotalCount}");
			failUserTotalCount = parseInt("${failUserTotalCount}");
			sleepUserTotalCount = parseInt("${sleepUserTotalCount}");
			expireUserTotalCount = parseInt("${expireUserTotalCount}");
			tempPasswordUserTotalCount = parseInt("${tempPasswordUserTotalCount}");
		} else {
			// ajax 데이터 표시
			activeUserTotalCount = parseInt(jsonData.activeUserTotalCount);
			fobidUserTotalCount = parseInt(jsonData.fobidUserTotalCount);
			failUserTotalCount = parseInt(jsonData.failUserTotalCount);
			sleepUserTotalCount = parseInt(jsonData.sleepUserTotalCount);
			expireUserTotalCount = parseInt(jsonData.expireUserTotalCount);
			tempPasswordUserTotalCount = parseInt(jsonData.tempPasswordUserTotalCount);
		}

		var userValues = [ activeUserTotalCount, fobidUserTotalCount, failUserTotalCount, sleepUserTotalCount, expireUserTotalCount, tempPasswordUserTotalCount];
		var ticks = [JS_MESSAGE["main.status.in.use"], JS_MESSAGE["main.status.stop.use"], JS_MESSAGE["main.status.fail.count"], JS_MESSAGE["main.status.dormancy"], JS_MESSAGE["main.status.expires"], JS_MESSAGE["main.status.temporary.password"]];
		var yMax = 10;
		if(activeUserTotalCount > 10 || fobidUserTotalCount > 10 || failUserTotalCount > 10 || sleepUserTotalCount > 10 || expireUserTotalCount > 10 || tempPasswordUserTotalCount > 10) {
			yMax = Math.max(activeUserTotalCount, fobidUserTotalCount, failUserTotalCount, sleepUserTotalCount, expireUserTotalCount, tempPasswordUserTotalCount) + (activeUserTotalCount * 0.2);
		}

        var plot = $.jqplot("userWidget", [userValues], {
        	//title : "사용자 상태별 현황",
        	height: 205,
        	animate: !$.jqplot.use_excanvas,
        	seriesColors: [ "#ffa076"],
        	grid: {
        		background: "#fff",
				//background: "#14BA6C"
				gridLineWidth: 0.7,
				//borderColor: 'transparent',
				shadow: false,
				borderWidth:0.1
				//shadowColor: 'transparent'
			},
        	gridPadding:{
		        left:35,
		        right:1,
		        to:40,
		        bottom:27
		    },
            seriesDefaults:{
            	shadow:false,
            	renderer:$.jqplot.BarRenderer,
                pointLabels: { show: true },
                rendererOptions: {
                	barWidth: 40
                }
            },
            axes: {
                xaxis: {
                    renderer: $.jqplot.CategoryAxisRenderer,
                    ticks: ticks,
                    tickOptions:{
                    	formatString: "%'d",
	                	fontSize: "10pt"
	                }
                },
                yaxis: {
	            	numberTicks : 6,
	            	min : 0,
	                max : yMax,
                    tickOptions:{
                    	formatString: "%'d",
	                	fontSize: "10pt"
	                }
				}
            },
            highlighter: { show: false }
        });
	}

	// 사용자 상태별 현황 정보 갱신
	function userWidget() {
		$.ajax({
			url : "/main/ajax-user-widget",
			type : "GET",
			cache : false,
			dataType : "json",
			success : function(msg) {
				if (msg.result == "user.session.empty") {
					//alert("로그인 후 사용 가능한 서비스 입니다.");
				} else if (msg.result == "db.exception") {
					//alert("데이터 베이스 장애가 발생하였습니다. 잠시 후 다시 이용하여 주시기 바랍니다.");
				} else if (msg.result == "success") {
					$("#userWidget").empty();
					showUser(1, msg);
				}
			},
			error : function(request, status, error) {
				//alert("잠시 후 이용해 주시기 바랍니다. 장시간 같은 현상이(사용자) 반복될 경우 관리자에게 문의하여 주십시오.");
			}
		});
	}

	// 스케줄 실행 이력 갱신
	function civilVoiceWidget() {
		$.ajax({
			url : "/main/ajax-civil-voice-widget",
			type : "GET",
			cache : false,
			dataType : "json",
			success : function(msg) {
				if (msg.result == "user.session.empty") {
					//alert("로그인 후 사용 가능한 서비스 입니다.");
				} else if (msg.result == "db.exception") {
					//alert("데이터 베이스 장애가 발생하였습니다. 잠시 후 다시 이용하여 주시기 바랍니다.");
				} else if (msg.result == "success") {
					var civilVoiceList = msg.civilVoiceList;
					var content = "";
					content 	= "<table class=\"widget-table\">"
								+	"<col class=\"col-left\" />"
								+	"<col class=\"col-center\" style=\"min-width:50px;\"/>"
								+	"<col class=\"col-center\" style=\"width:140px;\"/>";
					if(civilVoiceList == null || civilVoiceList.length == 0) {
						content += 	"<tr>"
								+	"	<td colspan=\"3\" class=\"col-none\"><spring:message code='main.status.no.civilvoice'/></td>"
								+	"</tr>";
					} else {
						for(i=0; i<civilVoiceList.length; i++ ) {
							var civilVoice = null;
							civilVoice = civilVoiceList[i];

							var date = new Date(civilVoice.insertDate);
							var insertDate = date.toLocaleString();

							content = content
								+ 	"<tr>"
								+ 	"	<td class=\"col-left\">"  + civilVoice.title + "</td>"
								+ 	"	<td class=\"col-center\">" + civilVoice.userId + "</td>"
								+ 	"	<td class=\"col-center\">" + insertDate + "</td>"
								+ 	"</tr>";
						}
					}
					$("#civilVoiceWidget").empty();
					$("#civilVoiceWidget").html(content);
				}
			},
			error : function(request, status, error) {
				//alert("잠시 후 이용해 주시기 바랍니다. 장시간 같은 현상이 반복될 경우 관리자에게 문의하여 주십시오.");
			}
		});
	}

	// DB Connection Pool 현황
	function dbcpWidget() {
		$.ajax({
			url : "/main/ajax-dbcp-widget",
			type : "GET",
			cache : false,
			dataType : "json",
			success : function(msg) {
				if (msg.result == "user.session.empty") {
					//alert("로그인 후 사용 가능한 서비스 입니다.");
				} else if (msg.result == "db.exception") {
					//alert("데이터 베이스 장애가 발생하였습니다. 잠시 후 다시 이용하여 주시기 바랍니다.");
				} else if (msg.result == "success") {
					$("#userSessionCount").html(msg.userSessionCount);
					$("#userUserSessionCount").html(msg.userUserSessionCount);
					$("#initialSize").html(msg.initialSize);
					$("#userInitialSize").html(msg.userInitialSize);
					$("#maxTotal").html(msg.maxTotal);
					$("#userMaxTotal").html(msg.userMaxTotal);
					$("#maxIdle").html(msg.maxIdle);
					$("#userMaxIdle").html(msg.userMaxIdle);
					$("#numActive").html(msg.numActive);
					$("#userNumActive").html(msg.userNumActive);
					$("#minIdle").html(msg.minIdle + "," + msg.numIdle);
					$("#userMinIdle").html(msg.userMinIdle + "," + msg.userNumIdle);
				}
			},
			error : function(request, status, error) {
				//alert("잠시 후 이용해 주시기 바랍니다. 장시간 같은 현상이(DBCP) 반복될 경우 관리자에게 문의하여 주십시오.");
			}
		});
	}

	// 사용자 추적
	function accessLogWidget() {
		$.ajax({
			url : "/main/ajax-access-log-widget",
			type : "GET",
			cache : false,
			dataType : "json",
			success : function(msg) {
				if (msg.result == "user.session.empty") {
					//alert("로그인 후 사용 가능한 서비스 입니다.");
				} else if (msg.result == "db.exception") {
					//alert("데이터 베이스 장애가 발생하였습니다. 잠시 후 다시 이용하여 주시기 바랍니다.");
				} else if (msg.result == "success") {
					var accessLogList = msg.accessLogList;
					var content = "";
					content 	= "<table class=\"widget-table\">"
								+	"<col class=\"col-left\" />"
								+	"<col class=\"col-left\" />";
					if(accessLogList == null || accessLogList.length == 0) {
						content += 	"<tr>"
								+	"	<td colspan=\"2\" class=\"col-none\"><spring:message code='main.status.no.user.tracking'/></td>"
								+	"</tr>";
					} else {
						for(i=0; i<accessLogList.length; i++ ) {
							var accessLog = null;
							accessLog = accessLogList[i];
							content = content
								+ 	"<tr>"
								+ 	"	<td class=\"col-left\">"
								+		"	<span class=\"index\"></span>"
								+		"	<em>" + accessLog.userName + "</em>"
								+		"</td>"
								+ 		"<td class=\"col-left\">" + accessLog.viewRequestUri + "</td>"
								+ 	"</tr>";
						}
					}
					$("#accessLogWidget").empty();
					$("#accessLogWidget").html(content);
				}
			},
			error : function(request, status, error) {
				//alert("잠시 후 이용해 주시기 바랍니다. 장시간 같은 현상이(DBCP) 반복될 경우 관리자에게 문의하여 주십시오.");
				$("#accessLogWidget").empty();
				$("#accessLogWidget").html(content);
			}
		});
	}
	function goMagoAPIGuide() {
		var url = "/guide/help";
		//console.log("test");
		var width = 1200;
		var height = 800;

		// 만들 팝업창 좌우 크기의 1/2 만큼 보정값으로 빼주었음
		var popupX = (window.screen.width / 2) - (width / 2);
		var popupY = (window.screen.height / 2) - (height / 2);
		
		var popWin = window.open(url, "", "toolbar=no, width=" + width + " ,height=" + height + ", top=" + popupY + ", left=" + popupX + 
				", directories=no,status=yes,scrollbars=no,menubar=no,location=no");
		return false;
	}
</script>
</body>
</html>