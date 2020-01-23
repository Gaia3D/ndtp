<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script id="templateLayerList" type="text/x-handlebars-template">
	{{#ifMatch depth 1}}
		<li class="mapLayer on" data-depth="{{layerGroupId}}">
		<p class="depthOne"><span class="folder"></span>{{layerGroupName}}</p>
		<ul>		
	{{/ifMatch}}
	{{#ifMatch depth 2}}
		<li class="mapLayer" data-depth="{{layerGroupId}}">
		<p><span class="folder"></span>{{layerGroupName}}</p>
		<ul>
	{{/ifMatch}}
	{{#ifMatch depth 3}}
		<li class="mapLayer" data-depth="{{layerGroupId}}">
		<p><span class="depthThree"></span>{{layerGroupName}}</p>
		<ul>
	{{/ifMatch}}
		{{#if layerList}}
				{{#each layerList}}
					<li class="nodepth {{viewType}}Layer "
						data-target-layer="{{#getPrefix viewType layerKey}}{{/getPrefix}}"
						data-z-index="{{zindex}}"
						data-view-type="{{viewType}}"
						data-label="{{labelDisplayYn}}"
						data-depth="{{layerId}}"
						data-parent="{{ancestor}}"
						data-layer-name="{{layerKey}}">
        				<p><span></span>{{layerName}}</p>
    				</li>
				{{/each}}				
		{{/if}}
		</ul>
    	</li>
</script>