<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="setupContentWrap">
<!-- <div>
	<p>라벨</p>
	<input type="radio" id="showLabel" name="labelInfo" value="true" onclick="changeLabel(true);" />
	<label for="showLabel">표시</label>
	<input type="radio" id="hideLabel" name="labelInfo" value="false" onclick="changeLabel(false);"/>
	<label for="hideLabel">비표시</label>
</div> -->
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
<!-- <div>
	<p>선택 및 이동</p>
	<input type="radio" id="objectNoneMove" name="objectMoveMode" value="2" onclick="changeObjectMove('2');"/>
	<label for="objectNoneMove">None</label>
	<input type="radio" id="objectAllMove" name="objectMoveMode" value="0" onclick="changeObjectMove('0');"/>
	<label for="objectAllMove">All</label>
	<input type="radio" id="objectMove" name="objectMoveMode" value="1" onclick="changeObjectMove('1');"/>
	<label for="objectMove">Object</label>
	
	<button type="button" id="saveObjectMoveButton" class="btnTextF">저장</button>
	<button type="button" id="deleteAllObjectMoveButton" class="btnTextF">전체삭제</button>
</div> -->
<!-- <div>
	<p>Object Occlusion Culling</p>
	<div style="height: 30px;">
		<div style="display: inline-block; width: 70px;">선택</div>
		<input type="radio" id="useOcclusionCulling" name="occlusionCulling" value="true" />
		<label for="useOcclusionCulling">사용</label>
		<input type="radio" id="unusedOcclusionCulling" name="occlusionCulling" value="false" />
		<label for="unusedOcclusionCulling">미사용</label>
	</div>
	<div style="height: 30px;">
		<div style="display: inline-block; width: 70px;">Data key</div>
		<input type="text" id="occlusion_culling_data_key" name="occlusion_culling_data_key" size="22" />
		<button type="button" id="changeOcclusionCullingButton" class="btnTextF">변경</button>
	</div>
</div> -->
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
<!-- <div>
	<p>밝기</p>
	<div style="height: 30px;">주변 반사 계수</div>
	<div id="ambient_reflection_coef" style="display: inline-block; width: 65%;">
		<div id="geo_ambient_reflection_coef_view" class="ui-slider-handle"></div>
		<input type="hidden" id="geo_ambient_reflection_coef" name="geo_ambient_reflection_coef" value="0.5" />
	</div>
	<div style="height: 30px;">확산 반사 계수</div>
	<div id="diffuse_reflection_coef" style="display: inline-block; width: 65%;">
		<div id="geo_diffuse_reflection_coef_view" class="ui-slider-handle"></div>
		<input type="hidden" id="geo_diffuse_reflection_coef" name="geo_diffuse_reflection_coef" value="1" />
	</div>
	<div style="height: 30px;">정반사 반사 계수 </div>
	<div>
		<div id="specular_reflection_coef" style="display: inline-block; width: 65%;">
			<div id="geo_specular_reflection_coef_view" class="ui-slider-handle"></div>
			<input type="hidden" id="geo_specular_reflection_coef" name="geo_specular_reflection_coef" value="1" />
		</div>
		<div style="float: right;">
			<button type="button" id="changeLightingButton" class="btnTextF">변경</button>
		</div>
	</div>
	<div style="text-align: center">
	</div>
</div> -->
<div>
	<p><label for="geo_ssao_radius">SSAO 반경</label></p>
	<input type="text" id="geo_ssao_radius" name="geo_ssao_radius" />
	<button type="button" id="changeSsaoRadiusButton" class="btnTextF">변경</button>
</div>
<!-- <div>
	<p>화면 모드</p>
	<input type="radio" id="mode3PV" name="viewMode" value ="false" onclick="changeViewMode(false);"/>
	<label for="mode3PV">3인칭 모드</label>
	<input type="radio" id="mode1PV" name="viewMode" value ="true" onclick="changeViewMode(true);"/>
	<label for="mode1PV">1인칭 모드</label>
</div> -->
</div>
