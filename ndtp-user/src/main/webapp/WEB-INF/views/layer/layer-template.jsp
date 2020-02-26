<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script id="templateLayerList" type="text/x-handlebars-template">
	{{#ifMatch depth 1}}
		<li class="mapLayer on" data-depth="{{layerGroupId}}">
		<p class="depthOne ellipsis">
		<span class="folder"></span>{{layerGroupName}}
		<span class="layerGroup">OFF</span>
		</p>
		<ul>
	{{/ifMatch}}
	{{#ifMatch depth 2}}
		<li class="mapLayer" data-depth="{{layerGroupId}}" data-ancestor="{{ancestor}}">
		<p class="ellipsis"><span class="folder"></span>{{layerGroupName}}</p>
		<ul>
	{{/ifMatch}}
	{{#ifMatch depth 3}}
		<li class="mapLayer" data-depth="{{layerGroupId}}" data-ancestor="{{ancestor}}">
		<p class="ellipsis"><span class="depthThree"></span>{{layerGroupName}}</p>
		<ul>
	{{/ifMatch}}
		{{#if layerList}}
				{{#each layerList}}
					<li class="nodepth {{serviceType}}Layer {{#replace defaultDisplay true 'on'}}{{/replace}}"
						data-depth="{{layerId}}"
						data-parent="{{layerGroupId}}"
						data-ancestor="{{../ancestor}}"
						data-layer-key="{{layerKey}}">
        				<p><span></span>{{layerName}}</p>
    				</li>
				{{/each}}
		{{/if}}
		</ul>
    	</li>
</script>