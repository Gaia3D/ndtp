/**
 * 레이어 관련 기능
 * @param magoInstance
 * @param baseLayers
 * @param policy
 * @returns
 */
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
		/**
		 * 지도 객체에 baseLaye list를 추가 
		 */
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
						this.addTileLayer(geoserverDataWorkspace + ':'+layerKey);
					} else if (serviceType ==='wms' && !cacheAvailable) {
						wmsLayerList.push(geoserverDataWorkspace + ':'+layerKey);
					} else if(serviceType ==='wfs') {
						this.addWFSLayer(layerKey);
					} else {
						
					}
				}
			}
			
			if(wmsLayerList.length > 0) {
				this.initWMSLayer(wmsLayerList);
			}
		},
		
		/**
		 * wms layer init
		 */
		initWMSLayer : function(layerList) {
			var preLayer = this.getImageryLayerById('wmsLayer');
			if(preLayer) imageryLayers.remove(preLayer);
			
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
//		            ,maxZoom : 25
//		            ,maxNativeZoom : 23
		            ,CQL_FILTER: queryStrings
		        },
		        enablePickFeatures : false
		    });
		    
			var layer = viewer.imageryLayers.addImageryProvider(provider);
			layer.id = 'wmsLayer';
		},
		
		/**
		 * wfs 레이어 추가
		 */
		addWFSLayer : function(layerKey) {
			
		},
		
		/**
		 * tile 레이어 추가
		 */
		addTileLayer : function(layerKey) {
			var provider = new Cesium.WebMapServiceImageryProvider({
		        url : geoserverDataUrl + "/gwc/service/wms",
		        layers : [layerKey],
		        parameters : {
		            service : 'WMS'
		            ,version : '1.1.1'
		            ,request : 'GetMap'
		            ,transparent : 'true'
		            ,format : 'image/png'
		            ,time : 'P2Y/PRESENT',
//		            ,maxZoom : 25
//		            ,maxNativeZoom : 23,
		            tiled : true
		        }
		    });
		    
			var layer = viewer.imageryLayers.addImageryProvider(provider);
			layer.id = layerKey.split(":")[1];
		},
		
		/**
		 * wfs 레이어 제거 
		 */
		removeWFSLayer : function(layerKey) {
			
		},
		
		/**
		 * tile 레이어 제거 
		 */
		removeTileLayer : function(layerKey) {
			var layer = this.getImageryLayerById(layerKey);
			imageryLayers.remove(layer);
		},
		
		/**
		 * layerKey에 해당하는 imageryLayer 객체를 리턴 
		 */
		getImageryLayerById : function(layerKey) {
			var layer = null;
			var length = imageryLayers.length;
			for(var i=0; i < length; i++) {
				var id = imageryLayers.get(i).id;
				if(!id) continue;
				if(imageryLayers.get(i).id === layerKey){
		            layer = imageryLayers.get(i);
		            break;
		        }
			}
			
			return layer;
		},
		
		/**
		 * layerKey에 해당하는 dataSources 객체를 리턴
		 */
		getDataSourceById : function(layerKey) {
			
		}
	}
}
