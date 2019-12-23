//package ndtp.controller;
//
//import java.text.SimpleDateFormat;
//import java.util.ArrayList;
//import java.util.Calendar;
//import java.util.HashMap;
//import java.util.List;
//import java.util.Map;
//
//import javax.servlet.http.HttpServletRequest;
//
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.stereotype.Controller;
//import org.springframework.ui.Model;
//import org.springframework.web.bind.annotation.GetMapping;
//import org.springframework.web.bind.annotation.RequestMapping;
//import org.springframework.web.bind.annotation.ResponseBody;
//
//import com.gaia3d.domain.AccessLog;
//import com.gaia3d.domain.CacheManager;
//import com.gaia3d.domain.DataInfo;
//import com.gaia3d.domain.DataInfoLog;
//import com.gaia3d.domain.Issue;
//import com.gaia3d.domain.PGStatActivity;
//import com.gaia3d.domain.Policy;
//import com.gaia3d.domain.Project;
//import com.gaia3d.domain.ScheduleLog;
//import com.gaia3d.domain.UserInfo;
//import com.gaia3d.domain.Widget;
//import com.gaia3d.helper.SessionUserHelper;
//import com.gaia3d.service.AccessLogService;
//import com.gaia3d.service.DataLogService;
//import com.gaia3d.service.DataService;
//import com.gaia3d.service.IssueService;
//import com.gaia3d.service.MonitoringService;
//import com.gaia3d.service.ProjectService;
//import com.gaia3d.service.ScheduleService;
//import com.gaia3d.service.UserService;
//import com.gaia3d.service.WidgetService;
//import com.gaia3d.util.DateUtil;
//import com.gaia3d.util.FormatUtil;
//import com.zaxxer.hikari.HikariDataSource;
//
//import lombok.extern.slf4j.Slf4j;
//
//
///**
// * 메인
// * @author jeongdae
// *
// */
//@Slf4j
//@Controller
//@RequestMapping("/main/")
//public class MainController {
//	
//	private static final long WIDGET_LIST_VIEW_COUNT = 7l;
//	
//	@Autowired
//	private HikariDataSource dataSource;
//	
//	@Autowired
//	private ProjectService projectService;
//	@Autowired
//	private DataService dataService;
//	@Autowired
//	private DataLogService dataLogService;
//	@Autowired
//	private IssueService issueService;
//	@Autowired
//	private AccessLogService logService;
//	@Autowired
//	private MonitoringService monitoringService;
//	@Autowired
//	private UserService userService;
//	@Autowired
//	private ScheduleService scheduleService;
//	@Autowired
//	private WidgetService widgetService;
//	
//	/**
//	 * 메인 페이지
//	 * @param model
//	 * @return
//	 */
//	@GetMapping(value = "index.do")
//	public String index(HttpServletRequest request, Model model) {
////		if(!ConfigCache.isCompanyConfigValidation()) {
////			log.error("@@@@@@@@@@@@@@@@@ 설정 파일을 잘못 로딩 하였습니다. Properties, Quartz 파일등을 확인해 주십시오.");
////			return "/error/config-error";
////		}
//		
//		Policy policy = CacheManager.getPolicy();
//		boolean isActive = true;
////		if("UNIX".equals(OS_TYPE)) {
////			SystemConfig systemConfig = loadBalancingService.getSystemConfig();
////			String hostname = ConfigCache.getHostname();
////			if(hostname == null || "".equals(hostname)) {
////				hostname = WebUtil.getHostName();
////			}
////			if(systemConfig == null 
////					|| !SystemConfig.ACTIVE.equals(systemConfig.getLoad_balancing_status()) 
////					|| !hostname.equals(systemConfig.getHostname())) {
////				log.error("@@@@@@@@@ hostname = {}, load_balancing_status = {}", hostname, systemConfig);
////				isActive = false;
////			}
////		}
//		
//		Widget widget = new Widget();
//		widget.setLimit(policy.getContent_main_widget_count());
//		List<Widget> widgetList = widgetService.getListWidget(widget);
//		
//		String today = DateUtils.getToday(FormatUtils.VIEW_YEAR_MONTH_DAY_TIME);
//		String yearMonthDay = today.substring(0, 4) + today.substring(5,7) + today.substring(8,10);
//		String startDate = yearMonthDay + DateUtils.START_TIME;
//		String endDate = yearMonthDay + DateUtils.END_TIME;
//		
//		boolean isProjectDraw = false;
//		boolean isDataInfoDraw = false;
//		boolean isDataInfoLogListDraw = false;
//		boolean isIssueDraw = false;
//		boolean isUserDraw = false;
//		boolean isScheduleLogListDraw = false;
//		boolean isAccessLogDraw = false;
//		boolean isDbcpDraw = false;
//		boolean isDbSessionDraw = false;
//		for(Widget dbWidget : widgetList) {
//			if("projectWidget".equals(dbWidget.getName())) {
//				isProjectDraw = true;
//				projectWidget(startDate, endDate, model);
//			} else if("dataInfoWidget".equals(dbWidget.getName())) {
//				isDataInfoDraw = true;
//				dataInfoWidget(startDate, endDate, model);
//			} else if("dataInfoLogListWidget".equals(dbWidget.getName())) {
//				isDataInfoLogListDraw = true;
//				dataInfoLogListWidget(startDate, endDate, model);
//			} else if("issueWidget".equals(dbWidget.getName())) {
//				isIssueDraw = true;
//				issueWidget(startDate, endDate, model);
//			} else if("userWidget".equals(dbWidget.getName())) {
//				isUserDraw = true;
//				userWidget(startDate, endDate, model);
//			} else if("scheduleLogListWidget".equals(dbWidget.getName())) {
//				isScheduleLogListDraw = true;
//				scheduleLogListWidget(startDate, endDate, model);
//			} else if("accessLogWidget".equals(dbWidget.getName())) {
//				isAccessLogDraw = true;
//				accessLogWidget(startDate, endDate, model);
//			} else if("dbcpWidget".equals(dbWidget.getName())) {
//				isDbcpDraw = true;
//				dbcpWidget(model);
//			} else if("dbSessionWidget".equals(dbWidget.getName())) {
//				isDbSessionDraw = true;
//				dbSessionWidget(model);	
//			}
//		}
//		
//		model.addAttribute("today", today);
//		model.addAttribute("yearMonthDay", today.subSequence(0, 10));
//		model.addAttribute("thisYear", yearMonthDay.subSequence(0, 4));
//		// 메인 페이지 갱신 속도
//		model.addAttribute("widgetInterval", policy.getContent_main_widget_interval());
//		// 현재 접속자수
//		model.addAttribute("userSessionCount", SessionUserHelper.loginUsersMap.size());
//		model.addAttribute(widget);
//		model.addAttribute(widgetList);
//		
//		model.addAttribute("isActive", isActive);
//		model.addAttribute("isProjectDraw", isProjectDraw);
//		model.addAttribute("isDataInfoDraw", isDataInfoDraw);
//		model.addAttribute("isDataInfoLogListDraw", isDataInfoLogListDraw);
//		model.addAttribute("isIssueDraw", isIssueDraw);
//		model.addAttribute("isUserDraw", isUserDraw);
//		model.addAttribute("isScheduleLogListDraw", isScheduleLogListDraw);
//		model.addAttribute("isAccessLogDraw", isAccessLogDraw);
//		model.addAttribute("isDbcpDraw", isDbcpDraw);
//		model.addAttribute("isDbSessionDraw", isDbSessionDraw);
//		
//		return "/main/index";
//	}
//	
//	/**
//	 * project
//	 * @param startDate
//	 * @param endDate
//	 * @param model
//	 */
//	private void projectWidget(String startDate, String endDate, Model model) {
//		// ajax 에서 처리 하기 위해서 여기는 공백
//	}
//	
//	/**
//	 * project
//	 * @param startDate
//	 * @param endDate
//	 * @param model
//	 */
//	private void dataInfoWidget(String startDate, String endDate, Model model) {
//		// ajax 에서 처리 하기 위해서 여기는 공백
//	}
//	
//	/**
//	 * project
//	 * @param startDate
//	 * @param endDate
//	 * @param model
//	 */
//	private void dataInfoLogListWidget(String startDate, String endDate, Model model) {
//		// ajax 에서 처리 하기 위해서 여기는 공백
//	}
//	
//	/**
//	 * CPU 모니터링, 메모리 모니터링, 디스크 사용현황
//	 * @param startDate
//	 * @param endDate
//	 * @param model
//	 */
//	private void issueWidget(String startDate, String endDate, Model model) {
//		Issue issue = new Issue();
//		issue.setStart_date(startDate);
//		issue.setEnd_date(endDate);
//		Long issueTotalCount = issueService.getIssueTotalCount(issue);
//		
//		model.addAttribute("issueTotalCount", issueTotalCount);
//	}
//	
//	/**
//	 * 사용자 현황
//	 * @param startDate
//	 * @param endDate
//	 * @param model
//	 */
//	private void userWidget(String startDate, String endDate, Model model) {
//		// 사용자 현황
//		UserInfo userInfo = new UserInfo();
//		userInfo.setStatus(UserInfo.STATUS_USE);
//		Long activeUserTotalCount = userService.getUserTotalCount(userInfo);
//		userInfo.setStatus(UserInfo.STATUS_FORBID);
//		Long fobidUserTotalCount = userService.getUserTotalCount(userInfo);
//		userInfo.setStatus(UserInfo.STATUS_FAIL_LOGIN_COUNT_OVER);
//		Long failUserTotalCount = userService.getUserTotalCount(userInfo);
//		userInfo.setStatus(UserInfo.STATUS_SLEEP);
//		Long sleepUserTotalCount = userService.getUserTotalCount(userInfo);
//		userInfo.setStatus(UserInfo.STATUS_TERM_END);
//		Long expireUserTotalCount = userService.getUserTotalCount(userInfo);
//		userInfo.setStatus(UserInfo.STATUS_TEMP_PASSWORD);
//		Long tempPasswordUserTotalCount = userService.getUserTotalCount(userInfo);
//		
//		model.addAttribute("activeUserTotalCount", activeUserTotalCount);
//		model.addAttribute("fobidUserTotalCount", fobidUserTotalCount);
//		model.addAttribute("failUserTotalCount", failUserTotalCount);
//		model.addAttribute("sleepUserTotalCount", sleepUserTotalCount);
//		model.addAttribute("expireUserTotalCount", expireUserTotalCount);
//		model.addAttribute("tempPasswordUserTotalCount", tempPasswordUserTotalCount);
//	}
//	
//	/**
//	 * 스케줄 실행 이력 목록
//	 * @param startDate
//	 * @param endDate
//	 * @param model
//	 */
//	private void scheduleLogListWidget(String startDate, String endDate, Model model) {
//		// ajax 에서 처리 하기 위해서 여기는 공백
//	}
//	
//	/**
//	 * DB Connection Pool 현황
//	  * @param model
//	 */
//	private void dbcpWidget(Model model) {
//		model.addAttribute("userSessionCount", SessionUserHelper.loginUsersMap.size());
//		
//		model.addAttribute("initialSize", dataSource.getMaximumPoolSize());
////	model.addAttribute("maxIdle", dataSource.getMaxIdle());
//		model.addAttribute("minIdle", dataSource.getMinimumIdle());
////	model.addAttribute("numActive", dataSource.getNumActive());
////	model.addAttribute("numIdle", dataSource.getNumIdle());
//		
////		model.addAttribute("initialSize", dataSource.getInitialSize());
//////		model.addAttribute("maxTotal", dataSource.getMaxTotal());
////		model.addAttribute("maxIdle", dataSource.getMaxIdle());
////		model.addAttribute("minIdle", dataSource.getMinIdle());
////		model.addAttribute("numActive", dataSource.getNumActive());
////		model.addAttribute("numIdle", dataSource.getNumIdle());
//		
//		// 사용자 dbcp 정보
//		Map<String, Integer> userDbcp = getUserDbcp();
//		model.addAttribute("userUserSessionCount", userDbcp.get("userSessionCount"));
//		model.addAttribute("userInitialSize", userDbcp.get("initialSize"));
//		model.addAttribute("userMaxTotal", userDbcp.get("maxTotal"));
//		model.addAttribute("userMaxIdle", userDbcp.get("maxIdle"));
//		model.addAttribute("userMinIdle", userDbcp.get("minIdle"));
//		model.addAttribute("userNumActive", userDbcp.get("numActive"));
//		model.addAttribute("userNumIdle", userDbcp.get("numIdle"));
//	}
//	
//	/**
//	 * 사용자 페이지 DBCP 정보
//	 * @return
//	 */
//	private Map<String, Integer> getUserDbcp() {
//		// 사용자 페이지에서 API로 가져와야 함
//		Map<String, Integer> userDbcp = new HashMap<>();
//		String success_yn = null;
//		String result_message = "";
//		Integer userSessionCount = 0;
//		Integer initialSize = 0;
//		Integer maxTotal = 0;
//		Integer maxIdle = 0;
//		Integer minIdle = 0;
//		Integer numActive = 0;
//		Integer numIdle = 0;
//		
//		userDbcp.put("userSessionCount", userSessionCount);
//		userDbcp.put("initialSize", initialSize);
//		userDbcp.put("maxTotal", maxTotal);
//		userDbcp.put("maxIdle", maxIdle);
//		userDbcp.put("minIdle", minIdle);
//		userDbcp.put("numActive", numActive);
//		userDbcp.put("numIdle", numIdle);
//		
//		return userDbcp;
//	}
//	
//	/**
//	 * 사용자 추적
//	 * @param startDate
//	 * @param endDate
//	 * @param model
//	 */
//	private void accessLogWidget(String startDate, String endDate, Model model) {
//	}
//	
//	/**
//	 * DB Session 현황
//	  * @param model
//	 */
//	private void dbSessionWidget(Model model) {
//		List<PGStatActivity> dbSessionList = monitoringService.getListDBSession();
//		Integer dbSessionCount = dbSessionList.size();
//		if(dbSessionCount > 7) dbSessionList = dbSessionList.subList(0, 7);
//		model.addAttribute("dbSessionCount", dbSessionCount);
//		model.addAttribute("dbSessionList", dbSessionList);
//	}
//	
//	/**
//	 * 프로젝트별 데이터 건수
//	 * @param request
//	 * @return
//	 */
//	@RequestMapping(value = "ajax-project-data-widget.do")
//	@ResponseBody
//	public Map<String, Object> ajaxProjectDataWidget(HttpServletRequest request) {
//		
//		Map<String, Object> map = new HashMap<>();
//		String result = "success";
//		try {
//			Project defaultProject = new Project();
//			defaultProject.setUse_yn(Project.IN_USE);
//			List<Project> projectList = projectService.getListProject(defaultProject);
//			List<String> projectNameList = new ArrayList<>();
//			List<Long> dataTotalCountList = new ArrayList<>();
//			for(Project project : projectList) {
//				projectNameList.add(project.getProject_name());
//				DataInfo dataInfo = new DataInfo();
//				dataInfo.setProject_id(project.getProject_id());
//				Long dataTotalCount = dataService.getDataTotalCount(dataInfo);
//				dataTotalCountList.add(dataTotalCount);
//			}
//			
//			map.put("projectNameList", projectNameList);
//			map.put("dataTotalCountList", dataTotalCountList);
//		} catch(Exception e) {
//			e.printStackTrace();
//			result = "db.exception";
//		}
//		
//		map.put("result", result);
//		return map;
//	}
//	
//	/**
//	 * 데이터 상태별 통계 정보
//	 * @param request
//	 * @return
//	 */
//	@RequestMapping(value = "ajax-data-status-widget.do")
//	@ResponseBody
//	public Map<String, Object> ajaxDataStatusStatistics(HttpServletRequest request) {
//		
//		Map<String, Object> map = new HashMap<>();
//		String result = "success";
//		try {
//			long useTotalCount = dataService.getDataTotalCountByStatus(DataInfo.STATUS_USE);
//			long forbidTotalCount = dataService.getDataTotalCountByStatus(DataInfo.STATUS_FORBID);
//			long etcTotalCount = dataService.getDataTotalCountByStatus(DataInfo.STATUS_ETC);
//			
//			map.put("useTotalCount", useTotalCount);
//			map.put("forbidTotalCount", forbidTotalCount);
//			map.put("etcTotalCount", etcTotalCount);
//		} catch(Exception e) {
//			e.printStackTrace();
//			result = "db.exception";
//		}
//		
//		map.put("result", result);
//		return map;
//	}
//	
//	/**
//	 * 데이터 변경 요청 목록
//	 * @param model
//	 * @return
//	 */
//	@GetMapping(value = "ajax-data-info-log-widget.do")
//	@ResponseBody
//	public Map<String, Object> ajaxDataInfoLogWidget(HttpServletRequest request) {
//		Map<String, Object> map = new HashMap<>();
//		String result = "success";
//		try {
//			String today = DateUtils.getToday(FormatUtils.YEAR_MONTH_DAY);
//			Calendar calendar = Calendar.getInstance();
//			calendar.add(Calendar.DATE, -7);
//			SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyyMMdd");
//			String searchDay = simpleDateFormat.format(calendar.getTime());
//			String startDate = searchDay + DateUtils.START_TIME;
//			String endDate = today + DateUtils.END_TIME;
//			
//			DataInfoLog dataInfoLog = new DataInfoLog();
//			dataInfoLog.setStart_date(startDate);
//			dataInfoLog.setEnd_date(endDate);
//			dataInfoLog.setOffset(0l);
//			dataInfoLog.setLimit(WIDGET_LIST_VIEW_COUNT);
//			List<DataInfoLog> dataInfoLogList = dataLogService.getListDataInfoLog(dataInfoLog);
//			
//			map.put("dataInfoLogList", dataInfoLogList);
//		} catch(Exception e) {
//			e.printStackTrace();
//			result = "db.exception";
//		}
//	
//		map.put("result", result);
//		return map;
//	}
//	
//	/**
//	 * 사용자 현황
//	 * @param model
//	 * @return
//	 */
//	@GetMapping(value = "ajax-user-widget.do")
//	@ResponseBody
//	public Map<String, Object> ajaxUserWidget(HttpServletRequest request) {
//		Map<String, Object> map = new HashMap<>();
//		String result = "success";
//		try {
//			// 사용자 현황
//			UserInfo userInfo = new UserInfo();
//			userInfo.setStatus(UserInfo.STATUS_USE);
//			Long activeUserTotalCount = userService.getUserTotalCount(userInfo);
//			userInfo.setStatus(UserInfo.STATUS_FORBID);
//			Long fobidUserTotalCount = userService.getUserTotalCount(userInfo);
//			userInfo.setStatus(UserInfo.STATUS_FAIL_LOGIN_COUNT_OVER);
//			Long failUserTotalCount = userService.getUserTotalCount(userInfo);
//			userInfo.setStatus(UserInfo.STATUS_SLEEP);
//			Long sleepUserTotalCount = userService.getUserTotalCount(userInfo);
//			userInfo.setStatus(UserInfo.STATUS_TERM_END);
//			Long expireUserTotalCount = userService.getUserTotalCount(userInfo);
//			userInfo.setStatus(UserInfo.STATUS_TEMP_PASSWORD);
//			Long tempPasswordUserTotalCount = userService.getUserTotalCount(userInfo);
//			
//			map.put("activeUserTotalCount", activeUserTotalCount);
//			map.put("fobidUserTotalCount", fobidUserTotalCount);
//			map.put("failUserTotalCount", String.valueOf(failUserTotalCount));
//			map.put("sleepUserTotalCount", sleepUserTotalCount);
//			map.put("expireUserTotalCount", expireUserTotalCount);
//			map.put("tempPasswordUserTotalCount", tempPasswordUserTotalCount);
//			
//		} catch(Exception e) {
//			e.printStackTrace();
//			result = "db.exception";
//		}
//	
//		map.put("result", result);
//		
//		return map;
//	}
//	
//	/**
//	 * 스케줄 실행 이력 갱신
//	 * @param model
//	 * @return
//	 */
//	@GetMapping(value = "ajax-schedule-log-list-widget.do")
//	@ResponseBody
//	public Map<String, Object> ajaxScheduleLogListWidget(HttpServletRequest request) {
//		
//		Map<String, Object> map = new HashMap<>();
//		String result = "success";
//		try {
//			String today = DateUtils.getToday(FormatUtils.YEAR_MONTH_DAY);
//			Calendar calendar = Calendar.getInstance();
//			calendar.add(Calendar.DATE, -7);
//			SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyyMMdd");
//			String searchDay = simpleDateFormat.format(calendar.getTime());
//			String startDate = searchDay + DateUtils.START_TIME;
//			String endDate = today + DateUtils.END_TIME;
//			
//			ScheduleLog scheduleLog = new ScheduleLog();
//			scheduleLog.setStart_date(startDate);
//			scheduleLog.setEnd_date(endDate);
//			scheduleLog.setOffset(0l);
//			scheduleLog.setLimit(WIDGET_LIST_VIEW_COUNT);
//			List<ScheduleLog> scheduleLogList = scheduleService.getListScheduleLog(scheduleLog);
//			
////			map.put("scheduleLogList", new JSONArray.fromObject(scheduleLogList));
//		} catch(Exception e) {
//			e.printStackTrace();
//			result = "db.exception";
//		}
//	
//		map.put("result", result);
//		
//		return map;
//	}
//	
//	/**
//	 * DB Connection Pool 현황
//	 * @param model
//	 * @return
//	 */
//	@GetMapping(value = "ajax-dbcp-widget.do")
//	@ResponseBody
//	public Map<String, Object> ajaxDbcpWidget(HttpServletRequest request) {
//		Map<String, Object> map = new HashMap<>();
//		String result = "success";
//		try {
//			map.put("userSessionCount", SessionUserHelper.loginUsersMap.size());
//			
//			map.put("initialSize", dataSource.getMaximumPoolSize());
//			map.put("minIdle", dataSource.getMinimumIdle());
//			map.put("numIdle", dataSource.getMaximumPoolSize());
//			
////			map.put("initialSize", dataSource.getInitialSize());
//////			map.put("maxTotal", dataSource.getMaxTotal());
////			map.put("maxIdle", dataSource.getMaxIdle());
////			map.put("minIdle", dataSource.getMinIdle());
////			map.put("numActive", dataSource.getNumActive());
////			map.put("numIdle", dataSource.getNumIdle());
//			
//			// 사용자 dbcp 정보
//			Map<String, Integer> userDbcp = getUserDbcp();
//			map.put("userUserSessionCount", userDbcp.get("userSessionCount"));
//			map.put("userInitialSize", userDbcp.get("initialSize"));
//			map.put("userMaxTotal", userDbcp.get("maxTotal"));
//			map.put("userMaxIdle", userDbcp.get("maxIdle"));
//			map.put("userMinIdle", userDbcp.get("minIdle"));
//			map.put("userNumActive", userDbcp.get("numActive"));
//			map.put("userNumIdle", userDbcp.get("numIdle"));
//		} catch(Exception e) {
//			e.printStackTrace();
//			result = "db.exception";
//		}
//	
//		map.put("result", result);
//		
//		return map;
//	}
//	
//	/**
//	 * 사용자 추적 이력 목록
//	 * @param model
//	 * @return
//	 */
//	@GetMapping(value = "ajax-access-log-widget.do")
//	@ResponseBody
//	public Map<String, Object> ajaxAccessLogWidget(HttpServletRequest request) {
//		Map<String, Object> map = new HashMap<>();
//		String result = "success";
//		try {
//			String today = DateUtils.getToday(FormatUtils.YEAR_MONTH_DAY);
//			Calendar calendar = Calendar.getInstance();
//			calendar.add(Calendar.DATE, -7);
//			SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyyMMdd");
//			String searchDay = simpleDateFormat.format(calendar.getTime());
//			String startDate = searchDay + DateUtils.START_TIME;
//			String endDate = today + DateUtils.END_TIME;
//			
//			AccessLog accessLog = new AccessLog();
//			accessLog.setStart_date(startDate);
//			accessLog.setEnd_date(endDate);
//			accessLog.setOffset(0l);
//			accessLog.setLimit(WIDGET_LIST_VIEW_COUNT);
//			List<AccessLog> accessLogList = logService.getListAccessLog(accessLog);
//			
//			map.put("accessLogList", accessLogList);
//		} catch(Exception e) {
//			e.printStackTrace();
//			result = "db.exception";
//		}
//	
//		map.put("result", result);
//		
//		return map;
//	}
//}
