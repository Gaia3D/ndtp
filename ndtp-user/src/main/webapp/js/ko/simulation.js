var Simulation = function(magoInstance) {
	
	$('#constructionProcess .execute').click(function(){
		var slider = new KotSlider('rangeInput');
		slider.setMax(6);
		slider.setMin(1);
		$('div.sliderWrap').show();
		
		var magoManager = magoInstance.getMagoManager();
		magoManager.getObjectIndexFileSmartTileF4d('sejong_time_series_tiles');
		
		magoManager.on(Mago3D.MagoManager.EVENT_TYPE.SMARTTILELOADEND, function(evt){
			var nodes = evt.tile.nodesArray;
			for(var i in nodes){
				var node = nodes[i];
				var data = node.data;
				
				
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
					var sliderValue = document.getElementById("rangeInput").value;
					
					var dataId =data.nodeId;
					var refNum = parseInt(dataId.split('_')[2]);
					var specify = refNum % 6;
					
					if(sliderValue > specify) {
						data.attributes.isVisible = true;
					} else {
						data.attributes.isVisible = false;
					}
					
					if(!data.aditionalColor) {
						data.aditionalColor = new Mago3D.Color();
					}
					/*#e60800 setRGB(230,8,0)
					#ff641c setRGB(255,100,28)
					#8d1e4d .setRGB(141,30,77)
					#7d2c79 setRGB(125,44,121)
					#ffd009 setRGB(255,208,9)
					#00a9b6 setRGB(0,169,182)
					#e2db09
					#f096b5*/
					switch(specify) {
						case 0 : data.aditionalColor.setRGB(230/255,8/255,0);break; 
						case 1 : data.aditionalColor.setRGB(255/255,100/255,28/255);break;
						case 2 : data.aditionalColor.setRGB(141/255,30/255,77/255);break;
						case 3 : data.aditionalColor.setRGB(125/255,44/255,121/255);break;
						case 4 : data.aditionalColor.setRGB(255/255,208/255,9/255);break;
						case 5 : data.aditionalColor.setRGB(0,169/255,182/255);break;
					}
					
					if(data.currentLod < 4) {
						data.isColorChanged = false;
					} else {
						data.isColorChanged = true;
					}
					
				})
			}
		});
		
		/*setTimeout(function(){
			
			var nodes = magoManager.hierarchyManager.getRootNodes('sejong_time_series');
			for(var i in nodes){
				var node = nodes[i];
				var halfY = node.data.bbox.getYLength() / 2;
				
				var geo = node.data.geographicCoord;
				var newHeight = halfY + geo.altitude;
				
				node.changeLocationAndRotation(geo.latitude, geo.longitude, newHeight, 0, 90, 0,magoManager);
				
				node.setRenderCondition(function(data){
					var sliderValue = document.getElementById("rangeInput").value;
					
					var dataId =data.nodeId;
					var refNum = parseInt(dataId.split('_')[2]);
					var specify = refNum % 6;
					
					if(sliderValue > specify) {
						data.attributes.isVisible = true;
					} else {
						data.attributes.isVisible = false;
					}
					
					if(!data.aditionalColor) {
						data.aditionalColor = new Mago3D.Color();
					}
					#e60800
					#ff641c
					#8d1e4d
					#7d2c79
					#ffd009
					#00a9b6
					#e2db09
					#f096b5
					switch(specify) {
						case 0 : data.aditionalColor.setRGB(255,0,0);break; 
						case 1 : data.aditionalColor.setRGB(0,0,255);break;
						case 2 : data.aditionalColor.setRGB(0,255,0);break;
						case 3 : data.aditionalColor.setRGB(255,255,0);break;
						case 4 : data.aditionalColor.setRGB(255,0,255);break;
						case 5 : data.aditionalColor.setRGB(0,255,255);break;
					}
					
					if(data.currentLod < 5) {
						data.isColorChanged = false;
					} else {
						data.isColorChanged = true;
					}
					
				})
			}
			
			magoInstance.getMagoManager().setRenderCondition('sejong_time_series', undefined, function(data){
				var sliderValue = document.getElementById("rangeInput").value;
				
				var dataId =data.nodeId;
				var refNum = parseInt(dataId.split('_')[2]);
				var specify = refNum % 6;
				
				if(sliderValue > specify) {
					data.attributes.isVisible = true;
				} else {
					data.attributes.isVisible = false;
				}
				
				if(!data.aditionalColor) {
					data.aditionalColor = new Mago3D.Color();
				}
				#e60800
				#ff641c
				#8d1e4d
				#7d2c79
				#ffd009
				#00a9b6
				#e2db09
				#f096b5
				switch(specify) {
					case 0 : data.aditionalColor.setRGB(255,0,0);break; 
					case 1 : data.aditionalColor.setRGB(0,0,255);break;
					case 2 : data.aditionalColor.setRGB(0,255,0);break;
					case 3 : data.aditionalColor.setRGB(255,255,0);break;
					case 4 : data.aditionalColor.setRGB(255,0,255);break;
					case 5 : data.aditionalColor.setRGB(0,255,255);break;
				}
				
				if(data.currentLod < 5) {
					data.isColorChanged = false;
				} else {
					data.isColorChanged = true;
				}
				
			});
		},15000)*/
	});
}