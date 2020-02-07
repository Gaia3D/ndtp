<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/taglib.jsp" %>
<%@ include file="/WEB-INF/views/common/config.jsp" %>

<!DOCTYPE html>
<html lang="${accessibility}">
<head>
    <meta charset="utf-8">
    <meta name="referrer" content="origin">
    <meta name="viewport" content="width=device-width">
    <meta name="robots" content="index,nofollow"/>
    <title>Layer 수정 | NDTP</title>
    <link rel="stylesheet" href="/css/${lang}/font/font.css" />
	<link rel="stylesheet" href="/images/${lang}/icon/glyph/glyphicon.css" />
	<link rel="stylesheet" href="/externlib/normalize/normalize.min.css" />
	<link rel="stylesheet" href="/externlib/jquery-ui-1.12.1/jquery-ui.min.css" />
    <link rel="stylesheet" href="/css/${lang}/admin-style.css" />
    <script type="text/javascript" src="/externlib/jquery-3.3.1/jquery.min.js"></script>
<script type="text/javascript" src="/externlib/jquery-ui-1.12.1/jquery-ui.min.js"></script>
    <script type="text/javascript" src="/externlib/ol45/ol.js"></script>
    <script type="text/javascript" src="/js/${lang}/mapInit.js"></script>
 </head>
<body>
    <div style="height: 100%;">
        <div id="map" style="position: absolute; width: 100%; height: 100%; overflow: hidden;"></div>
    </div>
</body>
<script type="text/javascript">
    var policy = JSON.parse('${policyJson}');
    var layer = JSON.parse('${layerJson}');
    var mapInit = new MapInit(policy, layer, '${versionId}');
</script>
</html>