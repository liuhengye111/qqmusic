package com.lhy.music.controller;

import cn.hutool.core.date.DatePattern;
import cn.hutool.core.date.DateTime;
import cn.hutool.core.date.DateUtil;
import cn.hutool.core.util.StrUtil;
import com.lhy.music.common.R;
import com.lhy.music.entity.po.Consumer;
import com.lhy.music.entity.vo.ConsumerLoginVo;
import com.lhy.music.entity.vo.UploadConsumerPicVo;
import com.lhy.music.service.ConsumerService;
import com.lhy.music.utils.PathUtils;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.util.List;

/**
 * 前台用户相关 控制层
 *
 * @author: ShanZhu
 * @date: 2023-11-25
 */
@RestController
@RequestMapping("/consumer")
@RequiredArgsConstructor
public class ConsumerController {

    private final ConsumerService consumerService;

    /**
     * 添加前台用户
     *
     * @param username     账号
     * @param password     密码
     * @param sex          性别
     * @param phoneNum     手机号
     * @param email        电子邮箱
     * @param birth        生日
     * @param introduction 签名
     * @param location     地区
     * @param avator       头像地址
     * @return 添加结果
     */
    @PostMapping(value = "/add")
    public R addConsumer(
            String username, String password, Byte sex, String phoneNum, String email,
            String birth, String introduction, String location, String avator
    ) {
        //用户名、密码为空
        if (StrUtil.isBlank(username) || StrUtil.isBlank(password)) {
            return R.error("用户名或密码不能为空");
        }

        //已经存在用户名
        Consumer existConsumer = consumerService.getByUsername(username);
        if (existConsumer != null) {
            return R.error("用户名已存在");
        }

        //把生日转换成Date格式
        DateTime birthDate = DateUtil.parse(birth, DatePattern.NORM_DATE_PATTERN);

        //保存到前端用户的对象中
        Consumer consumer = new Consumer();
        consumer.setUsername(username);
        consumer.setPassword(password);
        consumer.setSex(sex);
        consumer.setPhoneNum(phoneNum);
        consumer.setEmail(email);
        consumer.setBirth(birthDate);
        consumer.setIntroduction(introduction);
        consumer.setLocation(location);
        consumer.setAvator(avator);

        //保存成功
        if (consumerService.insert(consumer)) {
            return R.ok("添加成功");
        }
        return R.error("添加失败");
    }

    /**
     * 修改前台用户
     *
     * @param id           用户id
     * @param username     账号
     * @param password     密码
     * @param sex          性别
     * @param phoneNum     手机号
     * @param email        电子邮箱
     * @param birth        生日
     * @param introduction 签名
     * @param location     地区
     * @return 添加结果
     */
    @PostMapping(value = "/update")
    public R updateConsumer(
            String id, String username, String password, Byte sex, String phoneNum,
            String email, String birth, String introduction, String location
    ) {
        if (StrUtil.isBlank(username) || StrUtil.isBlank(password)) {
            return R.error("用户名或密码不能为空");
        }

        //把生日转换成Date格式
        DateTime birthDate = DateUtil.parse(birth, DatePattern.NORM_DATE_PATTERN);

        //保存到前端用户的对象中
        Consumer consumer = new Consumer();
        consumer.setId(Integer.parseInt(id));
        consumer.setUsername(username);
        consumer.setPassword(password);
        consumer.setSex(sex);
        consumer.setPhoneNum(phoneNum);
        consumer.setEmail(email);
        consumer.setBirth(birthDate);
        consumer.setIntroduction(introduction);
        consumer.setLocation(location);

        //保存成功
        if (consumerService.update(consumer)) {
            return R.ok("修改成功");
        }
        return R.error("修改失败");
    }

    /**
     * 删除前台用户
     *
     * @param id 用户id
     * @return 删除结果
     */
    @GetMapping(value = "/delete")
    public Boolean deleteConsumer(Integer id) {
        return consumerService.delete(id);
    }

    /**
     * 查询前台用户
     *
     * @param id 主键id
     * @return 前台用户
     */
    @GetMapping(value = "/selectByPrimaryKey")
    public Consumer selectByPrimaryKey(Integer id) {
        return consumerService.selectByPrimaryKey(id);
    }

    /**
     * 查询所有前台用户
     *
     * @return 前台用户
     */
    @GetMapping(value = "/allConsumer")
    public List<Consumer> allConsumer() {
        return consumerService.allConsumer();
    }

    /**
     * 更新前台用户头像
     *
     * @param avatorFile 头像文件
     * @param id         用户id
     * @return 上传结果
     */
    @PostMapping(value = "/updateConsumerPic")
    public R<UploadConsumerPicVo> updateConsumerPic(
            @RequestParam("file") MultipartFile avatorFile,
            @RequestParam("id") Integer id
    ) throws IOException {
        if (avatorFile.isEmpty()) {
            return R.error("文件上传失败");
        }

        //文件名=当前时间到毫秒+原来的文件名
        String fileName = System.currentTimeMillis() + avatorFile.getOriginalFilename();
        //文件路径
        String filePath = PathUtils.getClassLoadRootPath() + "/userImages/";
        //如果文件路径不存在，新增该路径
        File file1 = new File(filePath);
        if (!file1.exists()) {
            file1.mkdir();
        }

        //实际的文件地址
        File dest = new File(filePath + fileName);
        //存储到数据库里的相对文件地址
        String storeAvatorPath = "/userImages/" + fileName;
        avatorFile.transferTo(dest);
        Consumer consumer = new Consumer();
        consumer.setId(id);
        consumer.setAvator(storeAvatorPath);

        UploadConsumerPicVo uploadConsumerPicVo = new UploadConsumerPicVo();
        uploadConsumerPicVo.setAvator("/userImages/" + fileName);
        //更新前端用户
        if (consumerService.update(consumer)) {
            return R.ok("上传成功", uploadConsumerPicVo);
        }

        return R.error("上传失败");
    }

    /**
     * 前台用户登录
     *
     * @param username 用户名
     * @param password 用户密码
     * @return 登录用户信息
     */
    @PostMapping(value = "/login")
    public R<ConsumerLoginVo> login(String username, String password) {
        if (StrUtil.isBlank(username) || StrUtil.isBlank(password)) {
            return R.error("用户名或者密码不能为空");
        }

        //保存到前端用户的对象中
        Consumer consumer = new Consumer();
        consumer.setUsername(username);
        consumer.setPassword(password);

        //验证成功
        if (consumerService.verifyPassword(username, password)) {
            ConsumerLoginVo consumerLoginVo = new ConsumerLoginVo();
            consumerLoginVo.setUserMsg(consumerService.getByUsername(username));
            return R.ok("登录成功", consumerLoginVo);
        }

        return R.error("用户名或密码错误");
    }

}
