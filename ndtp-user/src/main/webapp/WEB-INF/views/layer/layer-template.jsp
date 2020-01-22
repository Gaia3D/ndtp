<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script id="templateLayerList" type="text/x-handlebars-template">
    {{#ifMatch  depth 1}}
    	<li class="mapLayer {{#replace defaultYn 'Y' 'on'}}{{/replace}} {{layerKey}}"
				data-depth="{{layerId}}"
				data-layer-name="{{layerKey}}">
        	<p class="depthOne"><span class="folder"></span>{{layerName}} 레이어</p>
        	<ul></ul>
    	</li>
    {{/ifMatch}}
    {{#ifMatchTwo  depth 2 shapeInsertYn 'N'}}
    	<li class="{{#replace defaultYn 'Y' 'on'}}{{/replace}}"
				data-depth="{{layerId}}"
				data-layer-name="{{layerKey}}">
        	<p><span class="folder"></span>{{layerName}}</p>
        	<ul></ul>
    	</li>
    {{/ifMatchTwo}}
    {{#ifMatch  shapeInsertYn 'Y'}}
    	<li class="nodepth {{viewType}}Layer {{#replace defaultYn 'Y' 'on'}}{{/replace}}"
				data-target-layer="{{#getPrefix viewType layerKey}}{{/getPrefix}}"
				data-z-index="{{zindex}}"
				data-view-type="{{viewType}}"
				data-label="{{labelDisplayYn}}"
				data-depth="{{layerId}}"
				data-parent="{{ancestor}}"
				data-layer-name="{{layerKey}}">
        	<p><span></span>{{layerName}}</p>
    	</li>
    {{/ifMatch}}
</script>