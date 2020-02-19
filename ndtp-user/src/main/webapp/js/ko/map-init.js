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
	
	var WMS_LAYER = 'wmsLayer';
	var viewer = magoInstance.getViewer();
	var imageryLayers = viewer.imageryLayers;
	var dataSources = viewer.dataSources;
	var geoserverDataUrl = policy.geoserverDataUrl;
	var geoserverDataWorkspace = policy.geoserverDataWorkspace;
	// 레이어 목록을 맵 형태로 저장 
	var layerMap = [];
	
	return {
		/**
		 * 지도 객체에 baseLaye list를 추가
		 * @param displayFlag {boolean} true일경우에는 모든 레이어 추가, 아닐 경우에는 defaultDiaply true인 레이어만 추가 
		 * @returns
		 */
		initLayer : function(displayFlag) {
			// 이미 모든 레이어가 활성화된 경우에는 return
			var wmsLayerList = [];
			var groupLength = baseLayers.length;
			for(var i=0; i < groupLength; i++) {
				var layerList = baseLayers[i].layerList;
				var layerLength = layerList.length;
				for(var j=0; j < layerLength; j++) {
					var serviceType = layerList[j].serviceType;
					var cacheAvailable = layerList[j].cacheAvailable;
					var layerKey = layerList[j].layerKey;
					layerMap[layerKey] = layerList[j];
					// 기본 표시 true일 경우에만 레이어 추가 
					if(!displayFlag && !layerList[j].defaultDisplay) continue;
					if(serviceType ==='wms' && cacheAvailable) {
						this.addTileLayer(layerKey);
					} else if (serviceType ==='wms' && !cacheAvailable) {
						wmsLayerList.push(layerKey);
					} else if(serviceType ==='wfs') {
						this.addWFSLayer(layerKey);
					} else {
						alert(serviceType+" 타입은  지원하지 않습니다.");
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
			var preLayer = this.getImageryLayerById(WMS_LAYER);
			if(preLayer) imageryLayers.remove(preLayer);
			if(layerList.length ===0) return; 
			
			var queryString = "enable_yn='Y'";
		    var queryStrings = layerList.map(function(){ return queryString; }).join(';');	// map: ie9부터 지원
			var provider = new Cesium.WebMapServiceImageryProvider({
		        url : geoserverDataUrl + "/wms",
		        layers : layerList.map(function(e){return geoserverDataWorkspace + ':'+e}).join(','),
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
			layer.id = WMS_LAYER;
		},
		
		/**
		 * wms 레이어 추가 TODO 인덱스 확인해서 정렬 필요 
		 */
		addWMSLayer : function(layerKey) {
			var layerList = null;
			if(this.getWMSLayers()) {
				layerList = this.getWMSLayers().split(",");
			} else {
				layerList = [];
			}
			layerList.push(layerKey);
			
			this.initWMSLayer(layerList);
		},
		
		/**
		 * wfs 레이어 추가
		 */
		addWFSLayer : function(layerKey) {
			var geoJson = geoserverDataUrl+ "/" + geoserverDataWorkspace + "/" + "/ows?service=WFS&version=1.0.0&request=GetFeature&typeName=" +
					geoserverDataWorkspace + ":" + layerKey + "&maxFeatures=200&outputFormat=application/json";
			var promise = Cesium.GeoJsonDataSource.load(geoJson, {
				//TODO terrain 사용시 외곽선 disable 되는거 처리 해야함 
				stroke: Cesium.Color.fromCssColorString(layerMap[layerKey].layerLineColor),
		        fill: Cesium.Color.fromCssColorString(layerMap[layerKey].layerFillColor).withAlpha(layerMap[layerKey].layerAlphaStyle),
		        strokeWidth: layerMap[layerKey].layerLineStyle,
		        clampToGround: true
			});
			promise.then(function(wfsLayer) {
				wfsLayer.id = layerKey;
		        dataSources.add(wfsLayer);
		    }).otherwise(function(error){
		        //Display any errrors encountered while loading.
		        alert(error);
		    });
		},
		
		/**
		 * tile 레이어 추가
		 */
		addTileLayer : function(layerKey) {
			var provider = new Cesium.WebMapServiceImageryProvider({
		        url : geoserverDataUrl + "/gwc/service/wms",
		        layers : [geoserverDataWorkspace + ':'+layerKey],
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
			layer.id = layerKey;
		},
		
		/**
		 * wms 레이어 제거
		 */
		removeWMSLayer : function(layerKey) {
			var layerList = this.getWMSLayers().split(",");
			for(var i=0; i < layerList.length;i++) {
				if(layerKey === layerList[i]) {
					layerList.splice(i,1);
				}
			}
			
			this.initWMSLayer(layerList);
		},
		
		/**
		 * wfs 레이어 제거 
		 */
		removeWFSLayer : function(layerKey) {
			var layer = this.getDataSourceById(layerKey);
			dataSources.remove(layer);
		},
		
		/**
		 * tile 레이어 제거 
		 */
		removeTileLayer : function(layerKey) {
			var layer = this.getImageryLayerById(layerKey);
			imageryLayers.remove(layer);
		},
		
		/**
		 * 전체 레이어 삭제
		 */
		removeAllLayer : function() {
			if(imageryLayers.length > 0) {
				// 기본 provider를 제외하고 모두 삭제
				while(imageryLayers.length > 1) {
					imageryLayers.remove(imageryLayers.get(1));
				}
			}
			// wfs 삭제 
			dataSources.removeAll();
		},
		
		/*
		 * wms layer string 리턴 
		 */
		getWMSLayers : function() {
			var layer = this.getImageryLayerById(WMS_LAYER);
			var layerList = "";
			if(layer) {
				layerList = layer._imageryProvider.layers;
				return layerList.split(geoserverDataWorkspace+":").join(""); 
			} else {
				return layerList;
			}
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
			var layer = null;
			var length = dataSources.length;
			for(var i=0; i < length; i++) {
				var id = dataSources.get(i).id;
				if(!id) continue;
				if(dataSources.get(i).id === layerKey){
		            layer = dataSources.get(i);
		            break;
		        }
			}
			
			return layer;
		}
	}
}
