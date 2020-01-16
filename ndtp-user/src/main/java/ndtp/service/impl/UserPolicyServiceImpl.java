package ndtp.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import ndtp.domain.UserPolicy;
import ndtp.persistence.UserPolicyMapper;
import ndtp.service.UserPolicyService;


@Service
public class UserPolicyServiceImpl implements UserPolicyService {

	@Autowired
	private UserPolicyMapper userPolicyMapper;

    @Transactional(readOnly = true)
    public UserPolicy getUserPolicy(String userId) {
        UserPolicy userPolicy = userPolicyMapper.getUserPolicy(userId);
        if(userPolicy == null) userPolicy = new UserPolicy();

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
