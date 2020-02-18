package ndtp.controller;

import java.math.BigDecimal;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.fasterxml.jackson.databind.ObjectMapper;

import lombok.extern.slf4j.Slf4j;
import ndtp.domain.DataInfo;
import ndtp.domain.GeoPolicy;
import ndtp.domain.Key;
import ndtp.domain.LayerGroup;
import ndtp.domain.UserPolicy;
import ndtp.domain.UserSession;
import ndtp.service.DataService;
import ndtp.service.GeoPolicyService;
import ndtp.service.LayerGroupService;
import ndtp.service.UserPolicyService;
import ndtp.support.LayerDisplaySupport;

/**
 * 지도에서 위치 찾기, 보기 등을 위한 공통 클래스
 * @author Jeongdae
 *
 */
@Slf4j
@Controller
@RequestMapping("/map")
public class MapController {
	
	@Autowired
	private DataService dataService;
	@Autowired
	private GeoPolicyService geoPolicyService;
	@Autowired
	private UserPolicyService userPolicyService;
	@Autowired
	private LayerGroupService layerGroupService;
	@Autowired
	private ObjectMapper objectMapper;
	
	/**
	 * 위치(경도, 위도) 찾기
     * @param request
     * @param dataId
     * @param model
     * @return
     */
    @GetMapping(value = "/find-data-point")
    public String findDataPoint(HttpServletRequest request, DataInfo dataInfo, Model model) {
    	log.info("@@@@@@ dataInfo referrer = {}", dataInfo.getReferrer());
    	
    	// list, modify 에서 온것 구분하기 위함
    	String referrer = dataInfo.getReferrer();
        UserSession userSession = (UserSession)request.getSession().getAttribute(Key.USER_SESSION.name());
        String userId = userSession.getUserId();
        
        GeoPolicy geoPolicy = geoPolicyService.getGeoPolicy();
		UserPolicy userPolicy = userPolicyService.getUserPolicy(userId);
		
//		dataInfo.setUserId(userSession.getUserId());
		dataInfo = dataService.getData(dataInfo);
		
		if(userPolicy.getUserId() != null) {
			
//			geoPolicy.setInitLatitude(userPolicy.getInitLatitude());
//			geoPolicy.setInitLongitude(userPolicy.getInitLongitude());
//			geoPolicy.setInitAltitude(userPolicy.getInitAltitude());
			geoPolicy.setInitCameraEnable(false);
			geoPolicy.setInitLongitude(dataInfo.getLongitude().toString());
			geoPolicy.setInitLatitude(dataInfo.getLatitude().toString());
			BigDecimal altitude = new BigDecimal(dataInfo.getAltitude().toString());
			geoPolicy.setInitAltitude(altitude.add(new BigDecimal("10")).toString());
			geoPolicy.setInitDuration(userPolicy.getInitDuration());
			geoPolicy.setInitDefaultFov(userPolicy.getInitDefaultFov());
			geoPolicy.setLod0(userPolicy.getLod0());
			geoPolicy.setLod1(userPolicy.getLod1());
			geoPolicy.setLod2(userPolicy.getLod2());
			geoPolicy.setLod3(userPolicy.getLod3());
			geoPolicy.setLod4(userPolicy.getLod4());
			geoPolicy.setLod5(userPolicy.getLod5());
			geoPolicy.setSsaoRadius(userPolicy.getSsaoRadius());
		}
        
        String geoPolicyJson = "";
		try {
			geoPolicyJson = objectMapper.writeValueAsString(geoPolicy);
		} catch(Exception e) {
			log.info("@@ objectMapper exception");
			e.printStackTrace();
		}
		
		String dataInfoJson = "";
		String baseLayerJson = "";
		try {
			dataInfoJson = objectMapper.writeValueAsString(dataInfo);
			List<LayerGroup> layerGroupList = LayerDisplaySupport.getListDisplayLayer(layerGroupService.getListLayerGroupAndLayer(), userPolicy.getBaseLayers());
			baseLayerJson = objectMapper.writeValueAsString(layerGroupList);
		} catch(Exception e) {
			log.info("@@ objectMapper exception");
			e.printStackTrace();
		}
		
		model.addAttribute("referrer", referrer);
		model.addAttribute("geoPolicyJson", geoPolicyJson);
		model.addAttribute("baseLayerJson", baseLayerJson);
		model.addAttribute("dataInfo", dataInfo);
		model.addAttribute("dataInfoJson", dataInfoJson);
		model.addAttribute("owner", userId);
        
        return "/map/find-data-point";
    }
    
    /**
	 * 위치(경도, 위도) 찾기
     * @param request
     * @param model
     * @return
     */
    @GetMapping(value = "/find-point")
    public String findPoint(HttpServletRequest request, Model model) {

        UserSession userSession = (UserSession)request.getSession().getAttribute(Key.USER_SESSION.name());
        UserPolicy userPolicy = userPolicyService.getUserPolicy(userSession.getUserId());
        GeoPolicy geoPolicy = geoPolicyService.getGeoPolicy();
        try {
        	List<LayerGroup> layerGroupList = LayerDisplaySupport.getListDisplayLayer(layerGroupService.getListLayerGroupAndLayer(), userPolicy.getBaseLayers());
            model.addAttribute("geoPolicyJson", objectMapper.writeValueAsString(geoPolicy));
            model.addAttribute("baseLayerJson", objectMapper.writeValueAsString(layerGroupList));
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return "/map/find-point";
    }
    
    /**
	 * 위치(경도, 위도) 찾기
     * @param request
     * @param model
     * @return
     */
    @GetMapping(value = "/help")
    public String gotoApiHelp(HttpServletRequest request, Model model) {

//        UserSession userSession = (UserSession)request.getSession().getAttribute(Key.USER_SESSION.name());
//        UserPolicy userPolicy = userPolicyService.getUserPolicy(userSession.getUserId());
        GeoPolicy geoPolicy = geoPolicyService.getGeoPolicy();
        try {
            model.addAttribute("geoPolicyJson", objectMapper.writeValueAsString(geoPolicy));
        } catch (Exception e) {
            e.printStackTrace();
        }
//        
//        model.addAttribute("baseLayers", userPolicy.getBaseLayers());
        
        return "/api-help/layout";
    }
}
