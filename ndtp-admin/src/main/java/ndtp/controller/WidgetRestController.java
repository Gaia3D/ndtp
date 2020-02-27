package ndtp.controller;

import java.net.URI;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;

import com.zaxxer.hikari.HikariDataSource;

import lombok.extern.slf4j.Slf4j;
import ndtp.domain.AccessLog;
import ndtp.domain.CivilVoice;
import ndtp.domain.DataAdjustLog;
import ndtp.domain.DataGroup;
import ndtp.domain.DataInfo;
import ndtp.domain.DataStatus;
import ndtp.domain.Key;
import ndtp.domain.UserInfo;
import ndtp.domain.UserSession;
import ndtp.domain.UserStatus;
import ndtp.service.AccessLogService;
import ndtp.service.CivilVoiceService;
import ndtp.service.DataAdjustLogService;
import ndtp.service.DataGroupService;
import ndtp.service.DataService;
import ndtp.service.UserService;
import ndtp.support.SessionUserSupport;
import ndtp.utils.DateUtils;
import ndtp.utils.FormatUtils;

@Slf4j
@Controller
@RequestMapping("/widgets")
public class WidgetRestController {

	private static final long WIDGET_LIST_VIEW_COUNT = 7l;

	@Autowired
	private HikariDataSource dataSource;

	@Autowired
	private DataGroupService dataGroupService;

	@Autowired
	private DataService dataService;

	@Autowired
	private DataAdjustLogService dataAdjustLogService;

	@Autowired
	private AccessLogService logService;

//	@Autowired
//	private MonitoringService monitoringService;

	@Autowired
	private UserService userService;

	@Autowired
	private CivilVoiceService civilVoiceService;

	/**
	 * 데이터 그룹 건수
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/data-group")
	@ResponseBody
	public Map<String, Object> dataGroupStatistics(HttpServletRequest request) {

		Map<String, Object> map = new HashMap<>();
		String result = "success";
		try {
			UserSession userSession = (UserSession)request.getSession().getAttribute(Key.USER_SESSION.name());

			DataGroup dataGroup = new DataGroup();
			dataGroup.setUserId(userSession.getUserId());
			List<DataGroup> dataGroupList = dataGroupService.getListDataGroup(dataGroup);

			List<Map<String, Object>> dataGroupWidgetList = new ArrayList<>();
			for(DataGroup dbDataGroup : dataGroupList) {
				// get count
				DataInfo dataInfo = new DataInfo();
				dataInfo.setDataGroupId(dbDataGroup.getDataGroupId());
				Long dataTotalCount = dataService.getDataTotalCount(dataInfo);

				// set list
				Map<String, Object> tempMap = new HashMap<>();
				tempMap.put("name", dbDataGroup.getDataGroupName());
				tempMap.put("count", dataTotalCount);
				dataGroupWidgetList.add(tempMap);
			}

			// 건수를 기준으로 DESC 정렬
			Collections.sort(dataGroupWidgetList, new Comparator<Map<String, Object>>() {
				@Override
	            public int compare(final Map<String, Object> o1, final Map<String, Object> o2) {
					Integer i1 = Math.toIntExact((long) o1.get("count"));
					Integer i2 = Math.toIntExact((long) o2.get("count"));
	                return i2.compareTo(i1);
	            }
	        });

			map.put("dataGroupWidgetList", dataGroupWidgetList);
		} catch(Exception e) {
			e.printStackTrace();
			result = "db.exception";
		}

		map.put("result", result);
		return map;
	}

	/**
	 * 데이터 상태별 통계 정보
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/data-status")
	@ResponseBody
	public Map<String, Object> dataStatusStatistics(HttpServletRequest request) {

		Map<String, Object> map = new HashMap<>();
		String result = "success";
		try {
			long useTotalCount = dataService.getDataTotalCountByStatus(DataStatus.USE.name().toLowerCase());
			long forbidTotalCount = dataService.getDataTotalCountByStatus(DataStatus.UNUSED.name().toLowerCase());
			long etcTotalCount = dataService.getDataTotalCountByStatus(DataStatus.DELETE.name().toLowerCase());

			map.put("useTotalCount", useTotalCount);
			map.put("forbidTotalCount", forbidTotalCount);
			map.put("etcTotalCount", etcTotalCount);
		} catch(Exception e) {
			e.printStackTrace();
			result = "db.exception";
		}

		map.put("result", result);
		return map;
	}

	/**
	 * 데이터 변경 요청 목록
	 * @param model
	 * @return
	 */
	@GetMapping(value = "/data-adjust-log")
	@ResponseBody
	public Map<String, Object> dataAdjustLogStatistics(HttpServletRequest request) {
		Map<String, Object> map = new HashMap<>();
		String result = "success";
		try {
			String today = DateUtils.getToday(FormatUtils.YEAR_MONTH_DAY);
			Calendar calendar = Calendar.getInstance();
			calendar.add(Calendar.DATE, -7);
			SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyyMMdd");
			String searchDay = simpleDateFormat.format(calendar.getTime());
			String startDate = searchDay + DateUtils.START_TIME;
			String endDate = today + DateUtils.END_TIME;

			DataAdjustLog dataInfoAdjustLog = new DataAdjustLog();
			dataInfoAdjustLog.setStartDate(startDate);
			dataInfoAdjustLog.setEndDate(endDate);
			dataInfoAdjustLog.setOffset(0l);
			dataInfoAdjustLog.setLimit(WIDGET_LIST_VIEW_COUNT);
			List<DataAdjustLog> dataAdjustLogList = dataAdjustLogService.getListDataAdjustLog(dataInfoAdjustLog);

			map.put("dataAdjustLogList", dataAdjustLogList);
		} catch(Exception e) {
			e.printStackTrace();
			result = "db.exception";
		}

		map.put("result", result);
		return map;
	}

	/**
	 * 사용자 현황
	 * @param model
	 * @return
	 */
	@GetMapping(value = "/user-status")
	@ResponseBody
	public Map<String, Object> userWidget(HttpServletRequest request) {
		Map<String, Object> map = new HashMap<>();
		String result = "success";
		try {
			// 사용자 현황
			UserInfo userInfo = new UserInfo();
			userInfo.setStatus(UserStatus.USE.getValue());
			Long activeUserTotalCount = userService.getUserTotalCount(userInfo);
			userInfo.setStatus(UserStatus.FORBID.getValue());
			Long fobidUserTotalCount = userService.getUserTotalCount(userInfo);
			userInfo.setStatus(UserStatus.FAIL_LOGIN_COUNT_OVER.getValue());
			Long failUserTotalCount = userService.getUserTotalCount(userInfo);
			userInfo.setStatus(UserStatus.SLEEP.getValue());
			Long sleepUserTotalCount = userService.getUserTotalCount(userInfo);
			userInfo.setStatus(UserStatus.TERM_END.getValue());
			Long expireUserTotalCount = userService.getUserTotalCount(userInfo);
			userInfo.setStatus(UserStatus.TEMP_PASSWORD.getValue());
			Long tempPasswordUserTotalCount = userService.getUserTotalCount(userInfo);

			map.put("activeUserTotalCount", activeUserTotalCount);
			map.put("fobidUserTotalCount", fobidUserTotalCount);
			map.put("failUserTotalCount", String.valueOf(failUserTotalCount));
			map.put("sleepUserTotalCount", sleepUserTotalCount);
			map.put("expireUserTotalCount", expireUserTotalCount);
			map.put("tempPasswordUserTotalCount", tempPasswordUserTotalCount);

		} catch(Exception e) {
			e.printStackTrace();
			result = "db.exception";
		}

		map.put("result", result);

		return map;
	}

	/**
	 * 시민 참여 현황 갱신
	 * @param model
	 * @return
	 */
	@GetMapping(value = "/civil-voice")
	@ResponseBody
	public Map<String, Object> civilVoiceWidget(HttpServletRequest request) {

		Map<String, Object> map = new HashMap<>();
		String result = "success";
		try {
			String today = DateUtils.getToday(FormatUtils.YEAR_MONTH_DAY);
			Calendar calendar = Calendar.getInstance();
			calendar.add(Calendar.DATE, -7);
			SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyyMMdd");
			String searchDay = simpleDateFormat.format(calendar.getTime());
			String startDate = searchDay + DateUtils.START_TIME;
			String endDate = today + DateUtils.END_TIME;

			CivilVoice civilVoice = new CivilVoice();
			civilVoice.setStartDate(startDate);
			civilVoice.setEndDate(endDate);
			civilVoice.setOffset(0l);
			civilVoice.setLimit(WIDGET_LIST_VIEW_COUNT);
			civilVoice.setOrderWord("comment_count");
			civilVoice.setOrderValue("desc");
			List<CivilVoice> civilVoiceList = civilVoiceService.getListCivilVoice(civilVoice);

//			map.put("civilVoiceList", new JSONArray.fromObject(civilVoiceList));
			map.put("civilVoiceList", civilVoiceList);
		} catch(Exception e) {
			e.printStackTrace();
			result = "db.exception";
		}

		map.put("result", result);

		return map;
	}

	/**
	 * 시스템 사용량 갱신
	 * @param model
	 * @return
	 */
	@GetMapping(value = "/system-usage")
	@ResponseBody
	public Map<String, Object> systemUsageWidget(HttpServletRequest request) {

		Map<String, Object> map = new HashMap<>();
		String result = "success";
		try {
			RestTemplate restTemplate = new RestTemplate();
			String serverHost = "http://localhost:9090";

			URI diskSpaceURI = new URI(serverHost + "/actuator/health/diskSpace");
			ResponseEntity<Map> response1 = restTemplate.getForEntity(diskSpaceURI, Map.class);
			Map<String, Long> diskSpace = (Map<String, Long>) response1.getBody().get("details");

			URI memoryMax = new URI(serverHost + "/actuator/metrics/jvm.memory.max");
			ResponseEntity<Map> response2 = restTemplate.getForEntity(memoryMax, Map.class);
			List<Map<String, Object>> jvmMemoryMax = (List<Map<String, Object>>) response2.getBody().get("measurements");

			URI memoryUsed = new URI(serverHost + "/actuator/metrics/jvm.memory.used");
			ResponseEntity<Map> response3 = restTemplate.getForEntity(memoryUsed, Map.class);
			List<Map<String, Object>> jvmMemoryUsed = (List<Map<String, Object>>) response3.getBody().get("measurements");

			URI cpuMax = new URI(serverHost + "/actuator/metrics/system.cpu.usage");
			ResponseEntity<Map> response4 = restTemplate.getForEntity(cpuMax, Map.class);
			List<Map<String, Object>> systemCpuUsage = (List<Map<String, Object>>) response4.getBody().get("measurements");

			URI cpuUsed = new URI(serverHost + "/actuator/metrics/process.cpu.usage");
			ResponseEntity<Map> response5 = restTemplate.getForEntity(cpuUsed, Map.class);
			List<Map<String, Object>> processCpuUsage = (List<Map<String, Object>>) response5.getBody().get("measurements");

			map.put("diskSpaceTotal", diskSpace.get("total"));
			map.put("diskSpaceFree", diskSpace.get("free"));
			map.put("jvmMemoryMax", jvmMemoryMax);
			map.put("jvmMemoryUsed", jvmMemoryUsed);
			map.put("systemCpuUsage", systemCpuUsage);
			map.put("processCpuUsage", processCpuUsage);

		} catch(Exception e) {
			e.printStackTrace();
			result = "db.exception";
		}

		map.put("result", result);

		return map;
	}

	/**
	 * DB Connection Pool 현황
	 * @param model
	 * @return
	 */
	@GetMapping(value = "/dbcp-status")
	@ResponseBody
	public Map<String, Object> dbcpWidget(HttpServletRequest request) {
		Map<String, Object> map = new HashMap<>();
		String result = "success";
		try {
			map.put("userSessionCount", SessionUserSupport.signinUsersMap.size());

			map.put("initialSize", dataSource.getMaximumPoolSize());
			map.put("minIdle", dataSource.getMinimumIdle());
			map.put("numIdle", dataSource.getMaximumPoolSize());

//			map.put("initialSize", dataSource.getInitialSize());
////			map.put("maxTotal", dataSource.getMaxTotal());
//			map.put("maxIdle", dataSource.getMaxIdle());
//			map.put("minIdle", dataSource.getMinIdle());
//			map.put("numActive", dataSource.getNumActive());
//			map.put("numIdle", dataSource.getNumIdle());

			// 사용자 dbcp 정보
			Map<String, Integer> userDbcp = getUserDbcp();
			map.put("userUserSessionCount", userDbcp.get("userSessionCount"));
			map.put("userInitialSize", userDbcp.get("initialSize"));
			map.put("userMaxTotal", userDbcp.get("maxTotal"));
			map.put("userMaxIdle", userDbcp.get("maxIdle"));
			map.put("userMinIdle", userDbcp.get("minIdle"));
			map.put("userNumActive", userDbcp.get("numActive"));
			map.put("userNumIdle", userDbcp.get("numIdle"));
		} catch(Exception e) {
			e.printStackTrace();
			result = "db.exception";
		}

		map.put("result", result);

		return map;
	}

	/**
	 * 사용자 추적 이력 목록
	 * @param model
	 * @return
	 */
	@GetMapping(value = "/access-log")
	@ResponseBody
	public Map<String, Object> accessLogWidget(HttpServletRequest request) {
		Map<String, Object> map = new HashMap<>();
		String result = "success";
		try {
			String today = DateUtils.getToday(FormatUtils.YEAR_MONTH_DAY);
			Calendar calendar = Calendar.getInstance();
			calendar.add(Calendar.DATE, -7);
			SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyyMMdd");
			String searchDay = simpleDateFormat.format(calendar.getTime());
			String startDate = searchDay + DateUtils.START_TIME;
			String endDate = today + DateUtils.END_TIME;

			AccessLog accessLog = new AccessLog();
			accessLog.setStartDate(startDate);
			accessLog.setEndDate(endDate);
			accessLog.setOffset(0l);
			accessLog.setLimit(WIDGET_LIST_VIEW_COUNT);
			List<AccessLog> accessLogList = logService.getListAccessLog(accessLog);

			map.put("accessLogList", accessLogList);
		} catch(Exception e) {
			e.printStackTrace();
			result = "db.exception";
		}

		map.put("result", result);

		return map;
	}

	/**
	 * 사용자 페이지 DBCP 정보
	 * @return
	 */
	private Map<String, Integer> getUserDbcp() {
		// 사용자 페이지에서 API로 가져와야 함
		Map<String, Integer> userDbcp = new HashMap<>();
		String success_yn = null;
		String result_message = "";
		Integer userSessionCount = 0;
		Integer initialSize = 0;
		Integer maxTotal = 0;
		Integer maxIdle = 0;
		Integer minIdle = 0;
		Integer numActive = 0;
		Integer numIdle = 0;

		userDbcp.put("userSessionCount", userSessionCount);
		userDbcp.put("initialSize", initialSize);
		userDbcp.put("maxTotal", maxTotal);
		userDbcp.put("maxIdle", maxIdle);
		userDbcp.put("minIdle", minIdle);
		userDbcp.put("numActive", numActive);
		userDbcp.put("numIdle", numIdle);

		return userDbcp;
	}
}
