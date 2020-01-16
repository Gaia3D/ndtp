<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="userPolicyContentWrap">
<div>
	<p>객체정보</p>
	<input type="radio" id="showObjectInfo" name="objectInfo" value="true" onclick="changeObjectInfoViewMode(true);" />
	<label for="showObjectInfo">표시</label>
	<input type="radio" id="hideObjectInfo" name="objectInfo" value="false" onclick="changeObjectInfoViewMode(false);"/>
	<label for="hideObjectInfo">비표시</label>
</div>
<div>
	<p>Origin</p>
	<input type="radio" id="showOrigin" name="origin" value="true" onclick="changeOrigin(true);" />
	<label for="showOrigin">표시</label>
	<input type="radio" id="hideOrigin" name="origin" value="false" onclick="changeOrigin(false);"/>
	<label for="hideOrigin">비표시</label>
</div>
<div>
	<p>Bounding Box</p>
	<input type="radio" id="showBoundingBox" name="boundingBox" value="true" onclick="changeBoundingBox(true);" />
	<label for="showBoundingBox">표시</label>
	<input type="radio" id="hideBoundingBox" name="boundingBox" value="false" onclick="changeBoundingBox(false);"/>
	<label for="hideBoundingBox">비표시</label>
</div>
<div>
	<p>LOD</p>
	<div style="height: 30px;">
		<div style="display: inline-block; width: 70px;">LOD0</div>
		<input type="text" id="geo_lod0" name="geo_lod0" value="${policy.geo_lod0 }" size="15" />&nbsp;M
	</div>
	<div style="height: 30px;">
		<div style="display: inline-block; width: 70px;">LOD1</div>
		<input type="text" id="geo_lod1" name="geo_lod1" value="${policy.geo_lod1 }" size="15" />&nbsp;M
	</div>
	<div style="height: 30px;">
		<div style="display: inline-block; width: 70px;">LOD2</div>
		<input type="text" id="geo_lod2" name="geo_lod2" value="${policy.geo_lod2 }" size="15" />&nbsp;M
	</div>
	<div style="height: 30px;">
		<div style="display: inline-block; width: 70px;">LOD3</div>
		<input type="text" id="geo_lod3" name="geo_lod3" value="${policy.geo_lod3 }" size="15" />&nbsp;M
	</div>
	<div style="height: 30px;">
		<div style="display: inline-block; width: 70px;">LOD4</div>
		<input type="text" id="geo_lod4" name="geo_lod4" value="${policy.geo_lod4 }" size="15" />&nbsp;M
	</div>
	<div style="height: 30px;">
		<div style="display: inline-block; width: 70px;">LOD5</div>
		<input type="text" id="geo_lod5" name="geo_lod5" value="${policy.geo_lod5 }" size="15" />&nbsp;M&nbsp;&nbsp;
		<button type="button" id="changeLodButton" class="btnTextF">변경</button>
	</div>
</div>
<div>
	<p><label for="geo_ssao_radius">SSAO 반경</label></p>
	<input type="text" id="geo_ssao_radius" name="geo_ssao_radius" />
	<button type="button" id="changeSsaoRadiusButton" class="btnTextF">변경</button>
</div>
</div>
<button class="focusA" style="width:100%;margin-top:20px;" title="저장">저장</button>
