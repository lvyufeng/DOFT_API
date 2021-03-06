package com.doft.service.impl;

import com.doft.common.Const;
import com.doft.common.ServerResponse;
import com.doft.common.TokenCache;
import com.doft.common.constant.EnumUserType;
import com.doft.dao.UserMapper;
import com.doft.pojo.User;
import com.doft.service.IUserService;
import com.doft.util.DateTimeUtil;
import com.doft.util.MD5Util;
import com.doft.vo.UserManageVo;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang3.StringUtils;
import org.joda.time.DateTime;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

import static com.google.common.collect.Lists.newArrayList;

@Service("iUserService")
public class IUserServiceImpl implements IUserService {

    @Autowired
    private UserMapper userMapper;

    @Override
    public ServerResponse<User> login(String phoneNumber, String password) {


        //check username
        int resultCount = userMapper.checkPhoneNumber(phoneNumber);
        if (resultCount == 0){
            return ServerResponse.createByErrorMessage("用户名不存在");
        }

        //password md5
        String md5Password = MD5Util.MD5EncodeUtf8(password);
        User user = userMapper.selectLoginByPhoneNumber(phoneNumber,md5Password);
        if (user == null){
            return ServerResponse.createByErrorMessage("密码错误");
        }

        user.setPassword(StringUtils.EMPTY);
        return ServerResponse.createBySuccess("登录成功",user);
//        return null;
    }


    public ServerResponse<User> loginBackend(String username, String password) {

        //check username
        int resultCount = userMapper.checkUsername(username);
        if (resultCount == 0){
            return ServerResponse.createByErrorMessage("用户名不存在");
        }

        //password md5
        String md5Password = MD5Util.MD5EncodeUtf8(password);
        User user = userMapper.selectLoginByUsername(username,md5Password);
        if (user == null){
            return ServerResponse.createByErrorMessage("密码错误");
        }

        user.setPassword(StringUtils.EMPTY);
        return ServerResponse.createBySuccess("登录成功",user);
//        return null;
    }

    public ServerResponse register(User user){
        ServerResponse validResponse = this.checkValid(user.getUserName(),Const.USERNAME);
        if (!validResponse.isSuccess()){
            return validResponse;
        }

        validResponse = this.checkValid(user.getPhoneNumber(),Const.PHONENUMBER);
        if (!validResponse.isSuccess()){
            return validResponse;
        }

        user.setRoleId(EnumUserType.COMMON_USER.getCode());

        //MD5 加密
        user.setPassword(MD5Util.MD5EncodeUtf8(user.getPassword()));
        user.setCreatedBy("User register");
        user.setLastUpdatedBy("User register");
        user.setRemainingMoney(Long.valueOf(0));
        user.setIsDeletedFlag(false);
//        user.setUserName(user.getUserName().toString());
//        System.out.println(user.getUserName());
        int resultCount = userMapper.insert(user);
        if (resultCount == 0){
            return ServerResponse.createByErrorMessage("注册失败");
        }
        return ServerResponse.createBySuccess("注册成功",user);
    }


    public ServerResponse<String> checkValid(String str,String type){
        if (StringUtils.isNotBlank(type)){
            //开始校验
            if (Const.USERNAME.equals(type)){
                int resultCount = userMapper.checkUsername(str);
                if (resultCount > 0){
                    return ServerResponse.createByErrorMessage("用户名已存在");
                }
            }
            if (Const.PHONENUMBER.equals(type)) {
                int resultCount = userMapper.checkPhoneNumber(str);
                if (resultCount > 0) {
                    return ServerResponse.createByErrorMessage("手机号码已存在");
                }
            }
        }else {
            return ServerResponse.createByErrorMessage("参数错误");
        }

        return ServerResponse.createBySuccessMessage("校验成功");
    }


    public ServerResponse selectQuestion(String username){
        ServerResponse validResponse = this.checkValid(username,Const.USERNAME);
        if (validResponse.isSuccess()){
            //用户不存在
            return ServerResponse.createByErrorMessage("用户不存在");
        }
        String question = userMapper.selectQuestionByUsername(username);
        if (StringUtils.isNotBlank(question)){
            return ServerResponse.createBySuccess(question);
        }
        return ServerResponse.createByErrorMessage("找回密码问题为空");
    }

    public ServerResponse<String> checkAnswer(String username,String question,String answer){
        int resultCount = userMapper.checkAnswer(username,question,answer);
        if (resultCount > 0){
            //用户及用户答案正确
            String forgetToken = UUID.randomUUID().toString();
            TokenCache.setKey(TokenCache.TOKEN_PREFIX+username,forgetToken);
            return ServerResponse.createBySuccessMessage(forgetToken);
        }

        return ServerResponse.createByErrorMessage("问题答案错误");
    }

    public ServerResponse<String> forgetResetPassword(String username,String passwordNew,String forgetToken){
        if (StringUtils.isBlank(forgetToken)){
            ServerResponse.createByErrorMessage("参数错误，Token需要传递");
        }
        ServerResponse validResponse = this.checkValid(username,Const.USERNAME);
        if (validResponse.isSuccess()){
            //用户不存在
            return ServerResponse.createByErrorMessage("用户不存在");
        }
        String token = TokenCache.getKey(TokenCache.TOKEN_PREFIX+username);
        if (StringUtils.isBlank(token)){
            return ServerResponse.createByErrorMessage("Token无效或过期");
        }

        if (StringUtils.equals(forgetToken,token)){
            String md5Password = MD5Util.MD5EncodeUtf8(passwordNew);
            int rowCount = userMapper.updatePasswordByUsername(username,md5Password);
            if (rowCount > 0){
                return ServerResponse.createBySuccessMessage("密码修改成功");
            }
        }else{
            return ServerResponse.createByErrorMessage("Token错误，请重新获取重置密码的Token");
        }
        return ServerResponse.createByErrorMessage("修改密码失败");
    }

    public ServerResponse<String> resetPassword(String passwordOld,String passwordNew,User user){
        //防止横向越权
        int resultCount = userMapper.checkPassword(MD5Util.MD5EncodeUtf8(passwordOld),user.getUserId());

        if (resultCount == 0){
            return ServerResponse.createByErrorMessage("旧密码错误");
        }

        user.setPassword(MD5Util.MD5EncodeUtf8(passwordNew));
        int updateCount = userMapper.updateByPrimaryKeySelective(user);
        if (updateCount > 0){
            return ServerResponse.createBySuccessMessage("密码更新成功");
        }
        return ServerResponse.createByErrorMessage("密码更新失败");
    }


    public ServerResponse<User> updateInformation(User user){
        //username不能更改
        //phone进行校验，校验新的手机号是否存在，如果存在，不能是当前用户的。
        int resultCount = userMapper.checkPhoneNumberByUserId(user.getPhoneNumber(),user.getUserId());
        if (resultCount > 0){
            return ServerResponse.createByErrorMessage("手机号码已存在，请更换手机号码再尝试");
        }
        resultCount = userMapper.checkUsername(user.getUserName());
        if (resultCount > 0){
            return ServerResponse.createByErrorMessage("用户名已存在，请更换用户名再尝试");
        }
        User updateUser = new User();
        updateUser.setUserId(user.getUserId());
        updateUser.setUserName(user.getUserName());
        updateUser.setPhoneNumber(user.getPhoneNumber());
        updateUser.setQuestion(user.getQuestion());
        updateUser.setAnswer(user.getAnswer());
        updateUser.setLastUpdatedBy(user.getUserName());
        int updateCount = userMapper.updateByPrimaryKeySelective(updateUser);
        if (updateCount > 0){
            User updatedUser = userMapper.selectByPrimaryKey(user.getUserId());
            updatedUser.setPassword("");
            return ServerResponse.createBySuccess("更新个人信息成功",updatedUser);
        }
        return ServerResponse.createByErrorMessage("更新个人信息失败");
    }


    public ServerResponse<User> getInformation(Long userId){
        User user = userMapper.selectByPrimaryKey(userId);
        if (user == null){
            return ServerResponse.createByErrorMessage("找不到当前用户");
        }
        user.setPassword(StringUtils.EMPTY);
        return ServerResponse.createBySuccess(user);

    }


    //backend
    /**
     *  
     * 校验是否为管理员
     * @author lvyufeng
     * @date 18-3-10 上午9:22
     * @param user
     * @return com.doft.common.ServerResponse
     */
    public ServerResponse checkAdminRole(User user){
        if (user != null && user.getRoleId() != EnumUserType.COMMON_USER.getCode()){
            return ServerResponse.createBySuccess();
        }
        return ServerResponse.createByError();
    }

    public List<UserManageVo> getAllUsersByType(Integer type) {
        List<User> userList;
        if (type == EnumUserType.COMMON_USER.getCode()) {
            userList = userMapper.selectAllCommonUsers();
        } else {
            userList = userMapper.selectAllAdministrators();
        }
        if (CollectionUtils.isNotEmpty(userList)) {
            return userList.stream().map(u -> new UserManageVo(u))
                    .collect(Collectors.toList());
        }
        return newArrayList();
    }

    @Transactional
    public void updateAdminInfo(User submit, User user) {
        Long id = submit.getUserId();
        if (id == null) {
            submit.setCreatedBy(String.valueOf(user.getUserId()));
            submit.setCreationTime(new Date());
            submit.setPassword(MD5Util.MD5EncodeUtf8(submit.getPassword()));
        }
        else {
            User fromDB = userMapper.selectByPrimaryKey(id);;
            if (fromDB != null) {
                if (StringUtils.isNotEmpty(submit.getUserName())) {
                    fromDB.setUserName(submit.getUserName());
                }
                if (StringUtils.isNotEmpty(submit.getPhoneNumber())) {
                    fromDB.setPhoneNumber(submit.getPhoneNumber());
                }
                if (submit.getRoleId() != null) {
                    fromDB.setRoleId(submit.getRoleId());
                }
                if (StringUtils.isNotEmpty(submit.getHeadUrl())) {
                    fromDB.setHeadUrl(submit.getHeadUrl());
                }
                submit = fromDB;
            }
        }
        submit.setIsDeletedFlag(Boolean.FALSE);
        submit.setLastUpdatedBy(String.valueOf(user.getUserId()));
        submit.setLastUpdatedTime(new Date());
        saveOrUpdateUser(submit);
    }

    @Transactional
    public void deleteAdminByAdminId(Long id, User user) {
        User fromDB = userMapper.selectByPrimaryKey(id);
        if (fromDB != null) {
            fromDB.setLastUpdatedBy(String.valueOf(user.getUserId()));
            fromDB.setLastUpdatedTime(new Date());
            fromDB.setIsDeletedFlag(Boolean.TRUE);
            saveOrUpdateUser(fromDB);
        }
    }

    @Transactional
    public void saveOrUpdateUser(User user) {
        if (user.getUserId() == null) {
            userMapper.insert(user);
        } else {
            userMapper.updateByPrimaryKey(user);
        }
    }

    public Long addedUserCount(Date date) {
        DateTime begin = new DateTime(DateTimeUtil.getZeroTime(date));
        DateTime end = new DateTime(date);
        return userMapper.countByCreatedTime(begin.toString(), end.toString());
    }

}
