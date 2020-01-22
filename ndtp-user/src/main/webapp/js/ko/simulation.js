var Simulation = function(magoInstance) {
	$('#constructionProcess .execute').click(function(){
		$.ajax({
			url: "/js/temp/mipo.json",
			type: "GET",
			headers: {"X-Requested-With": "XMLHttpRequest"},
			dataType: "json",
			success: function(object){
				//$('div.sliderWrap').html('<input id="rangeInput"/>');
				var slider = new KotSlider('rangeInput');
				slider.setMax(3);
				slider.setMin(1);
				$('div.sliderWrap').show();
				var f4dController = magoInstance.getF4dController();
				f4dController.addF4dGroup(object);
				console.info(slider);
				setTimeout(function(){
					magoInstance.getMagoManager().setRenderCondition('mipo', undefined, function(data){
						var sliderValue = document.getElementById("rangeInput").value;
						
						if(sliderValue == 3) {
							data.attributes.isVisible = true;
						}else if(sliderValue == 2) {
							if(data.nodeId == '2B11') {
								data.attributes.isVisible = false;
							} else {
								data.attributes.isVisible = true;
							}
						}else{
							if(data.nodeId == 'B11P' || data.nodeId == '2B11') {
								data.attributes.isVisible = false;
							} else {
								data.attributes.isVisible = true;
							}
						}
					});
				},1000)
				
				/*var node= Node;
				node.rendercondtion = function(data) {
					if(currentLod <2) {
						data.attributes.isVisible = false;
					} else {
						data.aditionalColor = red;
					}
					
					data.neobuilding.
					if(objectName.indexOf('pipe') < 0) {
						visible =false;
					}
				}*/
			},
			error:function(request,status,error){
				alert(JS_MESSAGE["ajax.error.message"]);
			}
		});
	});
}