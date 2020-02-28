var pageNo = 1;

$(document).ready(function() {
	
	$(".ui-slider-handle").slider({});
	
	//데이터 목록 초기화
	mapDataInfoList(1, null);
	
	// 데이터 검색 버튼 클릭
	$("#mapDataSearch").click(function() {
		mapDataInfoList(1, $("#searchDataName").val(), $("#searchDataStatus").val(), $("#searchDataType").val());
	});
	
	// 데이터 그룹 검색 엔터키
	$("#mapDataSearch").keyup(function(e) {
		if(e.keyCode == 13) mapDataInfoList(1, $("#searchDataName").val(), $("#searchDataStatus").val(), $("#searchDataType").val());
	});
	
	// 데이터 목록 tab 클릭
	$('#dataListTab').click(function() {
		var pageNo = $('input[name="pageNo"]').val();
		mapDataInfoList(pageNo, $("#searchDataName").val(), $("#searchDataStatus").val(), $("#searchDataType").val());
	});
	
	//데이터 3D Instance show/hide
	$('#dataInfoListArea').on('click', '.showHideButton', function() {
		var dataGroupId = $(this).data('group-id');
		var dataKey = $(this).data('key');
		
		if(dataGroupId === null || dataGroupId === '' || dataKey === null || dataKey === '') {
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
		
		var optionObject = { isVisible : option };
		setNodeAttributeAPI(MAGO3D_INSTANCE, dataGroupId, dataKey, optionObject);
		
	});
	
});

//데이터 검색 페이징에서 호출됨
function pagingDataInfoList(pageNo, searchParameters) {
	// searchParameters=&searchWord=dataName&searchOption=&searchValue=%ED%95%9C%EA%B8%80&startDate=&endDate=&orderWord=&orderValue=&status=&dataType=
	var dataName = null;
	var status = null;
	var dataType = null;
	var parameters = searchParameters.split("&");
	for(var i=0; i<parameters.length; i++) {
		if(i == 3) {
			var tempDataName = parameters[3].split("=");
			dataName = tempDataName[1];
		} else if(i == 8) {
			var tempDataStatus = parameters[8].split("=");
			status = tempDataStatus[1];
		} else if(i == 9) {
			var tempDataType = parameters[9].split("=");
			dataType = tempDataType[1];
		}
	}

	mapDataInfoList(pageNo, dataName, status, dataType);
}

//데이터 검색
var dataSearchFlag = true;
function mapDataInfoList(pageNo, searchDataName, searchStatus, searchDataType) {
	// searchOption : 1 like

	//searchDataName
	if(dataSearchFlag) {
		dataSearchFlag = false;
		//var formData =$("#searchDataForm").serialize();

		$.ajax({
			url: "/datas",
			type: "GET",
			data: { pageNo : pageNo, searchWord : "data_name", searchValue : searchDataName, searchOption : "1", status : searchStatus, dataType : searchDataType},
			dataType: "json",
			headers: {"X-Requested-With": "XMLHttpRequest"},
			success: function(msg){
				if(msg.statusCode <= 200) {
					$("#dataInfoListArea").html("");
					
					var dataList = msg.dataList;
					var groupMap = MAGO3D_INSTANCE.getMagoManager().hierarchyManager.projectsMap;
					
					if (dataList.length > 0) {
						for (i in dataList) {
							var data = dataList[i];
							var dataId = parseInt(data.dataGroupId);
							if (!$.isEmptyObject(groupMap)) {
								if (!groupMap[dataId]) {
									break;
								}
								var visible = groupMap[dataId].attributes.visible;
								if (visible === undefined) {
									data.groupVisible = true;
								} else {
									data.groupVisible = visible;
								}
							} else {
								data.groupVisible = true;
							}
						}
					}
					pageNo = msg.pagination.pageNo;
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