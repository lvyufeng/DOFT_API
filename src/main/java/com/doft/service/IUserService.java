package com.doft.service;

import com.doft.common.ServerResponse;
import com.doft.pojo.User;
import com.doft.vo.UserManageVo;

import java.util.Date;
import java.util.List;

/**
 *  
 * 
 * @author lvyufeng
 * @date 18-3-8 下午3:55
 * @param
 * @return 
 */

public interface IUserService {
    ServerResponse<User> login(String username, String password);
    ServerResponse<User> loginBackend(String username, String password);
    ServerResponse<String> register(User user);
    ServerResponse<String> checkValid(String str,String type);
    ServerResponse selectQuestion(String username);
    ServerResponse<String> checkAnswer(String username,String question,String answer);
    ServerResponse<String> forgetResetPassword(String username,String passwordNew,String forgetToken);
    ServerResponse<String> resetPassword(String passwordOld,String passwordNew,User user);
    ServerResponse<User> updateInformation(User user);
    ServerResponse<User> getInformation(Long userId);
    ServerResponse checkAdminRole(User user);
    List<UserManageVo> getAllUsersByType(Integer type);
    void updateAdminInfo(User submit, User user);
    void deleteAdminByAdminId(Long id, User user);
    Long addedUserCount(Date date);

}
