$(document).ready(function() {
	
	$(".ui-slider-handle").slider({});
	
	//데이터 그룹 목록 초기화
	mapDataGroupList(1, null);
	
	// 데이터 그룹 검색 버튼 클릭
	$("#mapDataGroupSearch").click(function() {
		mapDataGroupList(1, $("#searchDataGroupName").val());
	});

	// 데이터 그룹 검색 엔터키
	$("#searchDataGroupName").keyup(function(e) {
		if(e.keyCode == 13) mapDataGroupList(1, $("#searchDataGroupName").val());
	});
	
	//데이터그룹 3D Instance show/hide
	$('#dataGroupListArea').on('click', '.showHideButton', function() {
		var dataGroupId = $(this).data('group-id');
		
		if(dataGroupId === null || dataGroupId === '') {
			alert("객체 정보가 올바르지 않습니다. 확인하여 주십시오.");
			return;
		}
		
		var option = true;
		if ($(this).hasClass("show")) {
			$(this).removeClass("show");
			$(this).addClass("hide");
			option = false;
		} else {
			$(this).removeClass("hide");
			$(this).addClass("show");
		}
		
		//changePropertyRenderingAPI(MAGO3D_INSTANCE, option, dataGroupId, 'isPhysical=true');
		
		var groupMap = MAGO3D_INSTANCE.getMagoManager().hierarchyManager.projectsMap;
		dataGroupId = parseInt(dataGroupId);
		if (!$.isEmptyObject(groupMap) && groupMap[dataGroupId] && groupMap[dataGroupId].attributes) {
			groupMap[dataGroupId].attributes.visible = option;
		}
		
		var optionObject = { isVisible : option };
		var nodeMap = MAGO3D_INSTANCE.getMagoManager().hierarchyManager.getNodesMap(dataGroupId);
		for (var key in nodeMap){ 
		    var node = nodeMap[key];
		    if (!node || $.isEmptyObject(node)) break;
		    var nodeData = node.data;
		    if (nodeData && nodeData.attributes && nodeData.attributes.isPhysical === true) {
		        setNodeAttributeAPI(MAGO3D_INSTANCE, dataGroupId, key, optionObject);
		    }
		}
		
	});
});

//데이터 그룹 목록
function dataGroupList() {
	let dataGroupMap = new Map();
	$.ajax({
		url: "/data-groups/all",
		type: "GET",
		headers: {"X-Requested-With": "XMLHttpRequest"},
		dataType: "json",
		success: function(msg){
			if(msg.statusCode <= 200) {
				var dataGroupList = msg.dataGroupList;
				if(dataGroupList !== null && dataGroupList !== undefined) {
					var noneTilingDataGroupList = dataGroupList.filter(function(dataGroup){
						dataGroupMap.set(dataGroup.dataGroupId, dataGroup.dataGroupName);
						return !dataGroup.tiling;
					});
					
					NDTP.dataGroup = dataGroupMap;
					
					dataList(noneTilingDataGroupList);

					var tilingDataGroupList = dataGroupList.filter(function(dataGroup){
						return dataGroup.tiling;
					});

					var f4dController = MAGO3D_INSTANCE.getF4dController();
					for(var i in tilingDataGroupList)
					{
						var tilingDataGroup = tilingDataGroupList[i];
						if(i == tilingDataGroupList.length-1) {
							tilingDataGroup.smartTileIndexPath = 'infra/_TILE';
						}
						f4dController.addSmartTileGroup(tilingDataGroup);
					}
				}
			} else {
				alert(JS_MESSAGE[msg.errorCode]);
			}
		},
		error:function(request,status,error){
			alert(JS_MESSAGE["ajax.error.message"]);
		}
	});
}

//데이터 정보 목록
function dataList(dataGroupArray) {
	var dataArray = new Array();
	var dataGroupArrayLength = dataGroupArray.length;
	for(var i=0; i<dataGroupArrayLength; i++) {
		var dataGroup = dataGroupArray[i];
		if(!dataGroup.tiling) {
			var f4dController = MAGO3D_INSTANCE.getF4dController();
			$.ajax({
				url: "/datas/" + dataGroup.dataGroupId + "/list",
				type: "GET",
				headers: {"X-Requested-With": "XMLHttpRequest"},
				dataType: "json",
				success: function(msg){
					if(msg.statusCode <= 200) {
						var dataInfoList = msg.dataInfoList;
						if(dataInfoList != null && dataInfoList.length > 0) {
							var dataInfoFirst = dataInfoList[0];
							var dataInfoGroupId = dataInfoFirst.dataGroupId;
							var group;
							for(var j in dataGroupArray) {
								if(dataGroupArray[j].dataGroupId === dataInfoGroupId) {
									group = dataGroupArray[j];
									break;
								}
							}

							group.datas = dataInfoList;
							f4dController.addF4dGroup(group);
						}
					} else {
						alert(JS_MESSAGE[msg.errorCode]);
					}
				},
				error:function(request,status,error){
					alert(JS_MESSAGE["ajax.error.message"]);
				}
			});
		}
	}
}

//데이터 그룹 검색 페이징에서 호출됨
function pagingDataGroupList(pageNo, searchParameters) {
	// searchParameters=&searchWord=dataName&searchOption=&searchValue=%ED%95%9C%EA%B8%80&startDate=&endDate=&orderWord=&orderValue=&status=&dataType=
	var dataGroupName = null;
	var parameters = searchParameters.split("&");
	for(var i=0; i<parameters.length; i++) {
		if(i == 3) {
			var tempDataName = parameters[3].split("=");
			dataGroupName = tempDataName[1];
		}
	}

	mapDataGroupList(pageNo, dataGroupName);
}

//데이터 그룹 검색
var dataGroupSearchFlag = true;
function mapDataGroupList(pageNo, searchDataGroupName) {
	// searchOption : 1 like

	//searchDataName
	if(dataGroupSearchFlag) {
		dataGroupSearchFlag = false;
		//var formData =$("#searchDataForm").serialize();

		$.ajax({
			url: "/data-groups",
			type: "GET",
			data: { pageNo : pageNo, searchWord : "data_group_name", searchValue : searchDataGroupName, searchOption : "1"},
			dataType: "json",
			headers: {"X-Requested-With": "XMLHttpRequest"},
			success: function(msg){
				if(msg.statusCode <= 200) {
					$("#dataGroupListArea").html("");

					var source = $("#templateDataGroupList").html();
	                //핸들바 템플릿 컴파일
	                var template = Handlebars.compile(source);

	                //핸들바 템플릿에 데이터를 바인딩해서 HTML 생성
	                var dataGroupListHtml = template(msg);
	                $("#dataGroupListArea").html("");
	                $("#dataGroupListArea").append(dataGroupListHtml);
				} else {
					alert(JS_MESSAGE[msg.errorCode]);
				}
				dataGroupSearchFlag = true;
			},
			error:function(request,status,error){
				alert(JS_MESSAGE["ajax.error.message"]);
				dataGroupSearchFlag = true;
			}
		});
	} else {
		alert(JS_MESSAGE["button.dobule.click"]);
		return;
	}
}