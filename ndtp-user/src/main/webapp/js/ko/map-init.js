function mapInit(magoInstance, baseLayers, policy) {
	if(!(this instanceof mapInit)) {
        throw new Error("New 를 통해 생성 하십시오.");
    }
	
	var viewer = magoInstance.getViewer();
	var imageryLayers = viewer.imageryLayers;
	var dataSources = viewer.dataSources;
	var geoserverDataUrl = policy.geoserverDataUrl;
	var geoserverDataWorkspace = policy.geoserverDataWorkspace;
	
	return {
		initLayer : function() {
			var wmsLayerList = [];
			var groupLength = baseLayers.length;
			for(var i=0; i < groupLength; i++) {
				var layerList = baseLayers[i].layerList;
				var layerLength = layerList.length;
				for(var j=0; j < layerLength; j++) {
					var serviceType = layerList[j].serviceType;
					var cacheAvailable = layerList[j].cacheAvailable;
					var layerKey = layerList[j].layerKey;
					if(!layerList[j].defaultDisplay) continue;
					if(serviceType ==='wms' && cacheAvailable) {
						this.addTileLayer(layerKey);
					} else if (serviceType ==='wms' && !cacheAvailable) {
						wmsLayerList.push(layerKey);
					} else if(serviceType ==='wfs') {
						this.addWFSLayer(layerKey);
					} else {
						
					}
				}
			}
			
			if(wmsLayerList.length > 0) {
				this.addWMSLayer(wmsLayerList);
			}
		},
		
		addWMSLayer : function(layerList) {
			var queryString = "enable_yn='Y'";
		    var queryStrings = layerList.map(function(){ return queryString; }).join(';');	// map: ie9부터 지원
			var provider = new Cesium.WebMapServiceImageryProvider({
		        url : geoserverDataUrl + "/wms",
		        layers : layerList.join(","),
		        parameters : {
		            service : 'WMS'
		            ,version : '1.1.1'
		            ,request : 'GetMap'
		            ,transparent : 'true'
		            ,format : 'image/png'
		            ,time : 'P2Y/PRESENT'
		            ,maxZoom : 25
		            ,maxNativeZoom : 23
		            ,CQL_FILTER: queryStrings
		        },
		        enablePickFeatures : false
		    });
		    
			var layer = viewer.imageryLayers.addImageryProvider(provider);
			layer.id = 'wmsLayer';
		},
		
		addWFSLayer : function(layerKey) {
			
		},
		
		addTileLayer : function(layerKey) {
			
		},
		
		removeWMSLayer : function(layerKey) {
			
		},
		
		removeWFSLayer : function(layerKey) {
			
		},
		
		removeTileLayer : function(layerKey) {
			
		},
		
		getImageryLayerById : function(layerKey) {
			var layer = null;
			var length = imageryLayers.length;
			for(var i=0; i < length; i++) {
				var id = imageryLayers.get(i).id;
				if(!id) continue;
				if(imageryLayers.get(i).id === layerKey){
		            layer = imageryLayers.get(i);
		            debugger;
		            break;
		        }
			}
			
			return layer;
		},
		
		getDataSourcesById : function(layerKey) {
			
		}
	}
}
