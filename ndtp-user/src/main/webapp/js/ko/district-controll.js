var district;
function DistrictControll(magoInstance)
{
	var viewer = magoInstance.getViewer();
    district = new District(magoInstance, viewer);
}

function District(magoInstance, viewer)
{
    this.drawDistrict = function (name, sdoCode, sggCode, emdCode) {
    	this.deleteDistrict();
        var now = new Date();
        var rand = ( now - now % 5000) / 5000;
        var policy = NDTP.policy;
        // 시도(2) + 시군구(3) + 읍면동(3) + 리(2)
        var queryString = "bjcd = " + sdoCode.toString().padStart(2, '0') + sggCode.toString().padStart(3, '0') + emdCode.toString().padStart(3, '0') + '00';
        // TODO 개발 서버 포팅후 geoserver url 변경하기 
        var provider = new Cesium.WebMapServiceImageryProvider({
            url : policy.geoserverDataUrl + "/wms",
            layers : 'ndtp:district',
            parameters : {
                service : 'WMS'
                ,version : '1.1.1'
                ,request : 'GetMap'
                ,transparent : 'true'
                ,format : 'image/png'
                ,time : 'P2Y/PRESENT'
                ,rand:rand
                ,maxZoom : 25
                ,maxNativeZoom : 23
                ,CQL_FILTER: queryString
                //bjcd LIKE '47820253%' AND name='청도읍'
            },
            enablePickFeatures : false
        });
        
        NDTP.districtProvider = viewer.imageryLayers.addImageryProvider(provider);
    }

    this.deleteDistrict = function () {
        if(NDTP.districtProvider !== null && NDTP.districtProvider !== undefined) {
            viewer.imageryLayers.remove(NDTP.districtProvider, true);
        }
        NDTP.districtProvider = null;
    }
}
loadDistrict();

var sdoName = "";
var sggName = "";
var emdName = "";
var sdoCode = "";
var sggCode = "";
var emdCode = "";
var districtMapType = 1;

var defaultDistrictObject = '<li class="on">전체</li>';

function updateViewDistrictName()
{
	// 시군구가 blank
	if(sggName.trim() === "" || sdoName === sggName) {
		// 읍면동이 blan 이거나 시도랑 같은 경우
		if(emdName.trim() === "" || sdoName === emdName) {
			$("#viewDistrictName").html([sdoName]);
		} else {
			$("#viewDistrictName").html([sdoName, emdName].join(" "));
		}
	} else {
		// 시도랑 시군구랑 다를때
		// 시도랑 읍면동이 같을때
		if(sdoName === emdName) {
			$("#viewDistrictName").html([sdoName, sggName].join(" "));
		} else {
			if(sggName === emdName) {
				$("#viewDistrictName").html([sdoName, sggName].join(" "));
			} else {
				$("#viewDistrictName").html([sdoName, sggName, emdName].join(" "));
			}
		}
			
		if(sggName === emdName) {
			$("#viewDistrictName").html([sdoName, sggName].join(" "));
		} else {
			$("#viewDistrictName").html([sdoName, sggName, emdName].join(" "));
		}
	}
}
/**
 * 시도 목록을 로딩
 */
function loadDistrict()
{
    var url = "../searchmap/sdos";
    $.ajax({
        url: url,
        type: "GET",
        dataType: "json",
        success : function(msg) {
            if(msg.result === "success") {
                var sdoList = msg.sdoList;
                var content = "";

                content += defaultDistrictObject;
                for(var i=0, len=sdoList.length; i < len; i++)                    
                {
                    var sdo = sdoList[i];
                    content += '<li onclick="changeSdo(this, '+sdo.sdoCode+')">'+sdo.name+'</li>';
                }
                $('#sdoList').html(content);
            }
        },
        error : function(request, status, error) {
            console.log("code : " + request.status + "\n message : " + request.responseText + "\n error : " + error);
        }
    });
}

// 시도가 변경되면 하위 시군구, 읍면동이 변경됨
function changeSdo(_this, _sdoCode) {
    sdoCode = _sdoCode;
    sggCode = "";
    emdCode = "";
    districtMapType = 1;

    var url = "../searchmap/sdos/" + sdoCode + "/sggs";
    $.ajax({
        url: url,
        type: "GET",
        dataType: "json",
        success : function(msg) {
            if(msg.result === "success") {
                var sggList = msg.sggList;
                var content = "";

                content += defaultDistrictObject;
                for(var i=0, len=sggList.length; i < len; i++)                    
                {
                    var sgg = sggList[i];
                    content += '<li onclick="changeSgg(this, '+sdoCode+', '+sgg.sggCode+')">'+sgg.name+'</li>';
                }
                sdoName = $(_this).text();
                sggName = "";
                emdName = "";

                $('#sggList').html(content);
                $('#emdList').html(defaultDistrictObject);

                $("#sdoList li").removeClass("on");
                $(_this).addClass('on');

                updateViewDistrictName();
            }
        },
        error : function(request, status, error) {
            console.log("code : " + request.status + "\n message : " + request.responseText + "\n error : " + error);
        }
    });
}

// 시군구가 변경되면 하위 읍면동이 변경됨
function changeSgg(_this, _sdoCode, _sggCode) {
    sdoCode = _sdoCode;
    sggCode = _sggCode;
    emdCode = "";
    districtMapType = 2;

    var url = "../searchmap/sdos/" + sdoCode + "/sggs/" + sggCode + "/emds" ; 
    $.ajax({
        url: url,
        type: "GET",
        dataType: "json",
        success : function(msg) {
            if(msg.result === "success") {
                var emdList = msg.emdList;
                var content = "";

                content += defaultDistrictObject;
                for(var i=0, len=emdList.length; i < len; i++)                    
                {
                    var emd = emdList[i];
                    content += '<li onclick="changeEmd(this, '+sdoCode+', '+sggCode+', '+emd.emdCode+')">'+emd.name+'</li>';
                }
                sggName = $(_this).text();
                emdName = "";

                $('#emdList').html(content);

                $("#sggList li").removeClass("on");
                $(_this).addClass('on');

                updateViewDistrictName();
            }
        },
        error : function(request, status, error) {
            console.log("code : " + request.status + "\n message : " + request.responseText + "\n error : " + error);
        }
    });
}

// 읍면동을 선택
function changeEmd(_this, _sdoCode, _sggCode, _emdCode)
{
    sdoCode = _sdoCode;
    sggCode = _sggCode;
    emdCode = _emdCode;
    districtMapType = 3;

    emdName = $(_this).text();

    $("#emdList li").removeClass("on");
    $(_this).addClass('on');

    updateViewDistrictName();
}

$("#districtFlyButton").click(function () {
    var name = [sdoName, sggName, emdName].join(" ").trim();
    district.drawDistrict(name, sdoCode, sggCode, emdCode);
    getCentroid(name, sdoCode, sggCode, emdCode);
});

$("#districtCancleButton").click(function () {
    district.deleteDistrict();
});


function getCentroid(name, sdoCode, sggCode, emdCode) {
    var layerType = districtMapType;
    var bjcd = sdoCode.toString().padStart(2, '0') + sggCode.toString().padStart(3, '0') + emdCode.toString().padStart(3, '0') + '00';
    var time = 3;

    var info = "layerType=" + layerType + "&name=" + name  + "&bjcd=" + bjcd;
    $.ajax({
        url: "../searchmap/centroids",
        type: "GET",
        data: info,
        dataType: "json",
        success : function(msg) {
            if(msg.result === "success") {
                var altitude = 50000;
                if(layerType === 2) {
                    altitude = 15000;
                } else if(layerType === 3) {
                    altitude = 1500;
                }
                gotoFly(msg.longitude, msg.latitude, altitude, time);
            } else {
                alert(msg.result);
            }
        },
        error : function(request, status, error) {
            //alert(JS_MESSAGE["ajax.error.message"]);
            console.log("code : " + request.status + "\n message : " + request.responseText + "\n error : " + error);
        }
    });		
}

function gotoFly(longitude, latitude, altitude, duration)
{
  gotoFlyAPI(MAGO3D_INSTANCE, longitude, latitude, altitude, duration);
}