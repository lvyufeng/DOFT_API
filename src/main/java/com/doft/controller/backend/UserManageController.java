package com.doft.controller.backend;

import com.doft.common.Const;
import com.doft.common.ServerResponse;
import com.doft.common.constant.EnumUserType;
import com.doft.pojo.User;
import com.doft.service.IUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;


/**
 * @author lvyufeng
 * @date 18-3-9 下午2:43
 * @classname UserManageController
 */
@Controller
@CrossOrigin
@RequestMapping("/doft/manage/user")
public class UserManageController {

    @Autowired
    private IUserService iUserService;

    @ResponseBody
    @RequestMapping(value = "/login.do",method = RequestMethod.POST)
    public ServerResponse<User> login(String username, String password, HttpSession session){
        ServerResponse<User> response = iUserService.loginBackend(username,password);
        if (response.isSuccess()){
            User user = response.getData();
            if (user.getRoleId() == EnumUserType.ADMINISTRATOR.getCode()
                    || user.getRoleId() == EnumUserType.SUPER_ADMINISTRATOR.getCode()){
                session.setAttribute(Const.CURRENT_USER, user);
                return response;
            }else{
                return ServerResponse.createByErrorMessage("不是管理员，无法登录");
            }
        }

        return response;
    }


}
