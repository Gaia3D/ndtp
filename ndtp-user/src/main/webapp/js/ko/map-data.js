var pageNo = 1;

$(document).ready(function() {
	
	$(".ui-slider-handle").slider({});
	
	//데이터 목록 초기화
	//mapDataInfoList(1, null);
	
	// 데이터 검색 버튼 클릭
	$("#mapDataSearch").click(function() {
		mapDataInfoList(1, $("#searchDataName").val(), $("#searchDataGroup").val(), $("#searchDataType").val());
	});
	
	// 데이터 그룹 검색 엔터키
	$("#mapDataSearch").keyup(function(e) {
		if(e.keyCode == 13) mapDataInfoList(1, $("#searchDataName").val(), $("#searchDataGroup").val(), $("#searchDataType").val());
	});
	
	// 데이터 목록 tab 클릭
	$('#dataListTab').click(function() {
		var pageNo = $('input[name="pageNo"]').val();
		mapDataInfoList(pageNo, $("#searchDataName").val(), $("#searchDataGroup").val(), $("#searchDataType").val());
	});
	
	//데이터 3D Instance show/hide
	$('#dataInfoListArea').on('click', '.showHideButton', function() {
		var dataGroupId = $(this).data('group-id');
		var dataKey = $(this).data('key');
		var dataTiling = $(this).data('tiling');
		
		if(dataGroupId === null || dataGroupId === '' || dataKey === null || dataKey === '') {
			alert("객체 정보가 올바르지 않습니다. 확인하여 주십시오.");
			return;
		}
		
		var option = true;
		if ($(this).hasClass("show")) {
			option = false;
		}
		
		if (dataTiling) {
			dataKey = "F4D_" + dataKey;
		}
		//setNodeAttributeAPI(MAGO3D_INSTANCE, dataGroupId, dataKey, optionObject);
		
		dataGroupId = parseInt(dataGroupId);
		//var nodeMap = MAGO3D_INSTANCE.getMagoManager().hierarchyManager.getNodesMap(dataGroupId);
		
		//isExistDataAPI(MAGO3D_INSTANCE, dataGroupId, dataKey);
		//isDataReadyToRender(MAGO3D_INSTANCE, dataGroupId, dataKey);
		
		if (!isExistDataAPI(MAGO3D_INSTANCE, dataGroupId, dataKey)) {
			alert('아직 로드되지 않은 데이터입니다.\n이동 후 다시 시도해 주시기 바랍니다.');
			return;
		}

		var optionObject = { isVisible : option };
		setNodeAttributeAPI(MAGO3D_INSTANCE, dataGroupId, dataKey, optionObject);
		
		if ($(this).hasClass("show")) {
			$(this).removeClass("show");
			$(this).addClass("hide");
		} else {
			$(this).removeClass("hide");
			$(this).addClass("show");
		}
		
	});
	
});

//데이터 검색 페이징에서 호출됨
function pagingDataInfoList(pageNo, searchParameters) {
	// searchParameters=&searchWord=data_name&searchOption=1&searchValue=&startDate=&endDate=&orderWord=&orderValue=&dataType=&dataGroupId=
	var dataName = null;
	var status = null;
	var dataType = null;
	var dataGroupId = null;
	var parameters = searchParameters.split("&");
	for(var i=0; i<parameters.length; i++) {
		if(i == 3) {
			var tempDataName = parameters[3].split("=");
			dataName = tempDataName[1];
		/*} else if(i == 8) {
			var tempDataStatus = parameters[8].split("=");
			status = tempDataStatus[1];*/
		} else if(i == 8) {
			var tempDataType = parameters[8].split("=");
			dataType = tempDataType[1];
		} else if(i == 9) {
			var tempDataGroupId = parameters[9].split("=");
			dataGroupId = tempDataGroupId[1];
		}
	}

	mapDataInfoList(pageNo, dataName, dataGroupId, dataType);
}

//데이터 검색
var dataSearchFlag = true;
function mapDataInfoList(pageNo, searchDataName, searchDataGroupId, searchDataType) {
	// searchOption : 1 like

	//searchDataName
	if(dataSearchFlag) {
		dataSearchFlag = false;
		//var formData =$("#searchDataForm").serialize();

		$.ajax({
			url: "/datas",
			type: "GET",
			data: { pageNo : pageNo, searchWord : "data_name", searchValue : searchDataName, searchOption : "1", dataGroupId : searchDataGroupId, dataType : searchDataType},
			dataType: "json",
			headers: {"X-Requested-With": "XMLHttpRequest"},
			success: function(msg){
				if(msg.statusCode <= 200) {
					
					var dataList = msg.dataList;
					var projectsMap = MAGO3D_INSTANCE.getMagoManager().hierarchyManager.projectsMap;
					
					if (dataList.length > 0) {
						for (i in dataList) {
							var data = dataList[i];
							var dataId = parseInt(data.dataGroupId);
							var isVisible = true;
							if (!$.isEmptyObject(projectsMap)) {
								var projects = projectsMap[dataId];
								if ($.isEmptyObject(projects)) {
									data.groupVisible = isVisible;
									continue;
								}
								if(!projects.attributes) {
									projects.attributes = {};
									projects.attributes.objectType = "basicF4d";
									if(data.tiling) {
										projects.attributes.fromSmartTile = true;
									}
								}
								 
								var groupVisible = projects.attributes.isVisible;
								if (groupVisible !== undefined) {
									isVisible = groupVisible;
								}
							}
							data.groupVisible = isVisible;
						}
					}
					pageNo = msg.pagination.pageNo;
					
					$("#dataInfoListArea").html("");
					var source = $("#templateDataList").html();
	                //핸들바 템플릿 컴파일
	                var template = Handlebars.compile(source);
	                
	               	//핸들바 템플릿에 데이터를 바인딩해서 HTML 생성
	                var dataInfoListHtml = template(msg);
	                $("#dataInfoListArea").html("");
	                $("#dataInfoListArea").append(dataInfoListHtml);
				} else {
					alert(JS_MESSAGE[msg.errorCode]);
				}
				dataSearchFlag = true;
			},
			error:function(request,status,error){
				alert(JS_MESSAGE["ajax.error.message"]);
				dataSearchFlag = true;
			}
		});
	} else {
		alert(JS_MESSAGE["button.dobule.click"]);
		return;
	}
}