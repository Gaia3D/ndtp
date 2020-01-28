var Simulation = function(magoInstance) {
	var that = this;
	var CAMERA_MOVE_NEED_DISTANCE = 5000;
	var SEJONG_TILE_NAME = 'sejong_time_series_tiles';
	var SEJONG_POSITION = new Cesium.Cartesian3(-3108649.1049808883, 4086368.566202183, 3773910.6726226895);
	var magoManager = magoInstance.getMagoManager();
	
	var slider;
	var simulating = false;
	
	var observer;
	var observerTarget = document.getElementById('simulationContent');
	var observerConfig = { attributes: true};
	
	var cache = {};
	
	//건설공정 조회
	$('#constructionProcess .execute').click(function(){
		var targetArea = $('input[name="cpProtoArea"]:checked').val();
		
		var dataName;
		var initPosition;
		if(targetArea === 's') {
			dataName = SEJONG_TILE_NAME;
			initPosition = SEJONG_POSITION;
		} else {
			notyetAlram();
			return;
		}
		if(!slider) {
			slider = new KotSlider('rangeInput');
		}
		//레인지, 레전드 보이기
		$('div.sliderWrap, #constructionProcess .profileInfo').show();
		
		slider.setValue(0);
		simulating = true;
		
		if(!cache[dataName]) {
			if(dataName.indexOf('tiles') > 0) {
				magoManager.getObjectIndexFileSmartTileF4d(dataName);
				magoManager.on(Mago3D.MagoManager.EVENT_TYPE.SMARTTILELOADEND, smartTileLoaEndCallbak);
				
				var html = '';
				html += '<span>1단계</span>';
				html += '<span>2단계</span>';
				html += '<span>3단계</span>';
				html += '<span>4단계</span>';
				html += '<span>5단계</span>';
				html += '<span>6단계</span>';
				
				$('div.sliderWrap .rangeWrapChild.legend').html(html);
				$('div.sliderWrap .rangeWrapChild.legend').on('click','span',function(){
					slider.setValue($(this).index());
				});
			}
		}
		
		var dis = Math.abs(Cesium.Cartesian3.distance(initPosition, MAGO3D_INSTANCE.getViewer().camera.position));
		if(dis > CAMERA_MOVE_NEED_DISTANCE) {
			magoInstance.getViewer().camera.flyTo({
				destination:initPosition,
				duration : 1
			});
		}
		setObserver();
	});
	
	//건설공정 취소
	$('#constructionProcess .reset').click(function(){
		constructionProcessReset();
	});
	
	//경관 분석 위치지정
	$('#solarAnalysis .drawObserverPoint').click(function(){
		notyetAlram();
	});
	
	//경관 분석 조회
	$('#solarAnalysis .execute').click(function(){
		notyetAlram();
	});
	
	//경관 분석 취소
	$('#solarAnalysis .reset').click(function(){
		notyetAlram();
	});
	
	var smartTileLoaEndCallbak = function(evt){
		var nodes = evt.tile.nodesArray;
		for(var i in nodes){
			var node = nodes[i];
			var data = node.data;
			
			if(!cache[node.data.nodeId]) {
				cache[node.data.nodeId] = true;
			}else {
				return;
			}
			/**
			 * TODO: 스마트타일링 이슈
			 * 세종시 스마트타일링 데이터 높이값 보정 코드.
			 * 문제 : 노드가 로드 완료된 시점에서 처리하려하는데 해당 시점에는 bbox와 geoLocationDataManager가 존재하지 않음
			 * 해결 : 일단 억지로 끼워 넣음.
			 * 추후 목표 : 강제로 데이터 로드시 해당 부분을 미리 생성하는 옵션을 추가, 원래는 데이터가 표출될 때 처리되는 부분.
			 */
			var metaData = data.neoBuilding.metaData;
			if (metaData.fileLoadState === Mago3D.CODE.fileLoadState.LOADING_FINISHED) 
			{
				var auxBytesReaded = 0;
				data.neoBuilding.parseHeader(data.neoBuilding.headerDataArrayBuffer, auxBytesReaded);

			}
			if(!data.geoLocDataManager) {
				data.geoLocDataManager = new Mago3D.GeoLocationDataManager();
				data.geoLocDataManager.newGeoLocationData("deploymentLoc");
			}

			var bbox = data.neoBuilding.bbox;
			data.bbox = bbox;
			// 여기까지.
			
			var rotDeg = data.rotationsDegree;
			var pitch = rotDeg.x;
			var heading = rotDeg.z;
			var roll = rotDeg.y;
			var geo = data.geographicCoord;
			
			var offset;
			if(pitch > 0 ){
				 offset = bbox.getYLength() / 2;
			} else {
				offset = bbox.getZLength() / 2;
			}
			var newHeight = offset + geo.altitude;
			
			node.changeLocationAndRotation(geo.latitude, geo.longitude, newHeight, heading, pitch, roll,magoManager);
			
			node.setRenderCondition(function(data){
				var attributes = data.attributes; 
				if(!simulating) {
					attributes.isVisible = false;
					return;
				} 
				var sliderValue = slider.getValue();
				
				var dataId =data.nodeId;
				var refNum = parseInt(dataId.split('_')[2]);
				var specify = refNum % 6;
				
				if(sliderValue >= specify) {
					attributes.isVisible = true;
					
					if(data.currentLod < 4) {
						data.isColorChanged = false;
					} else {
						data.isColorChanged = true;
						if(!data.aditionalColor) {
							data.aditionalColor = new Mago3D.Color();
							
							switch(specify) {
								case 0 : data.aditionalColor.setRGB(230/255,8/255,0);break; 
								case 1 : data.aditionalColor.setRGB(255/255,100/255,28/255);break;
								case 2 : data.aditionalColor.setRGB(141/255,30/255,77/255);break;
								case 3 : data.aditionalColor.setRGB(125/255,44/255,121/255);break;
								case 4 : data.aditionalColor.setRGB(255/255,208/255,9/255);break;
								case 5 : data.aditionalColor.setRGB(0,169/255,182/255);break;
							}
						}
					}
				} else {
					attributes.isVisible = false;
				}
			})
		}
	}
	var setObserver = function(){
		if(!observer) {
			observer = new MutationObserver(function(mutations) {
				var mutation = mutations[0];
				var display = mutation.target.style.display;
				if(display === 'none') {
					constructionProcessReset();
					this.disconnect();
				}
			});
		}
		observer.observe(observerTarget, observerConfig);
	}
	var constructionProcessReset = function() {
		simulating = false;
		//레인지, 레전드 끄기
		$('div.sliderWrap, #constructionProcess .profileInfo').hide();
	}
}