package com.lhy.music.controller;

import com.lhy.music.common.R;
import com.lhy.music.service.AdminService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;

/**
 * 后台管理 控制层
 *
 * @author: ShanZhu
 * @date: 2023-11-25
 */
@RestController
@RequiredArgsConstructor
public class AdminController {

    private final AdminService adminService;

    /**
     * 获取登录状态
     *
     * @param name     账号名
     * @param password 密码
     * @param session  session
     * @return 登录结果
     */
    @RequestMapping(value = "/admin/login/status", method = RequestMethod.POST)
    public R loginStatus(String name, String password, HttpSession session) {
        //验证账号密码
        if (adminService.verifyPassword(name, password)) {
            //session放入用户名
            session.setAttribute("name", name);
            return R.ok("登录成功");
        }
        return R.error("用户名或密码错误");
    }

    /**
     * 打包项目接口
     *
     * @return modelAndView
     */
    @GetMapping(value = "/manage")
    public ModelAndView index() {
        return new ModelAndView("/src/main/resources/static/screenIndex/index.html");
    }

}
