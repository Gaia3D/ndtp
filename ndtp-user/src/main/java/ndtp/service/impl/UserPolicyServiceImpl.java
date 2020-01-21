package ndtp.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import ndtp.domain.GeoPolicy;
import ndtp.domain.UserPolicy;
import ndtp.persistence.UserPolicyMapper;
import ndtp.service.GeoPolicyService;
import ndtp.service.UserPolicyService;


@Service
public class UserPolicyServiceImpl implements UserPolicyService {

	@Autowired
	private UserPolicyMapper userPolicyMapper;
	@Autowired
	private GeoPolicyService geoPolicyService;

    @Transactional(readOnly = true)
    public UserPolicy getUserPolicy(String userId) {
        UserPolicy userPolicy = userPolicyMapper.getUserPolicy(userId);
        if(userPolicy == null) {
        	GeoPolicy geoPolicy = geoPolicyService.getGeoPolicy();
        	userPolicy = UserPolicy.builder()
        				.initLongitude(geoPolicy.getInitLongitude())
        				.initLatitude(geoPolicy.getInitLatitude())
        				.initAltitude(geoPolicy.getInitAltitude())
        				.initDuration(geoPolicy.getInitDuration())
        				.initDefaultFov(geoPolicy.getInitDefaultFov())
        				.lod0(geoPolicy.getLod0())
        				.lod1(geoPolicy.getLod1())
        				.lod2(geoPolicy.getLod2())
        				.lod3(geoPolicy.getLod3())
        				.lod4(geoPolicy.getLod4())
        				.lod5(geoPolicy.getLod5())
        				.ssaoRadius(geoPolicy.getSsaoRadius())
        				.build();
        }

        return userPolicy;
    }

    @Transactional
    public int updateUserPolicy(UserPolicy userPolicy) {
    	UserPolicy dbUserPolicy = userPolicyMapper.getUserPolicy(userPolicy.getUserId());

		if(dbUserPolicy == null) {
			return userPolicyMapper.insertUserPolicy(userPolicy);
		} else {
			return userPolicyMapper.updateUserPolicy(userPolicy);
		}
    }
}
