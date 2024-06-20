package com.lhy.music.controller;

import com.lhy.music.common.R;
import com.lhy.music.entity.po.SongList;
import com.lhy.music.entity.vo.UploadPicVo;
import com.lhy.music.service.SongListService;
import com.lhy.music.utils.PathUtils;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.util.List;

/**
 * 歌单 控制层
 */
@RestController
@RequestMapping("/songList")
@RequiredArgsConstructor
public class SongListController {

    private final SongListService songListService;

    /**
     * 添加歌单
     *
     * @param title        标题
     * @param pic          歌单图片
     * @param introduction 简介
     * @param style        风格
     * @return 添加结果
     */
    @PostMapping(value = "/add")
    public R addSongList(
            String title,
            String pic,
            String introduction,
            String style
    ) {
        //保存到歌单的对象中
        SongList songList = new SongList();
        songList.setTitle(title);
        songList.setPic(pic);
        songList.setIntroduction(introduction);
        songList.setStyle(style);

        //添加成功
        if (songListService.insert(songList)) {
            return R.ok("添加成功");
        }

        return R.error("添加失败");
    }

    /**
     * 修改歌单
     *
     * @param id           主键
     * @param title        标题
     * @param introduction 简介
     * @param style        风格
     * @return 修改结果
     */
    @PostMapping(value = "/update")
    public R updateSongList(
            String id,
            String title,
            String introduction,
            String style
    ) {
        //保存到歌单的对象中
        SongList songList = new SongList();
        songList.setId(Integer.parseInt(id));
        songList.setTitle(title);
        songList.setIntroduction(introduction);
        songList.setStyle(style);

        //修改成功
        if (songListService.update(songList)) {
            return R.ok("修改成功");
        }
        return R.error("修改失败");
    }

    /**
     * 删除歌单
     *
     * @param id 歌单id
     * @return 删除结果
     */
    @GetMapping(value = "/delete")
    public Boolean deleteSongList(Integer id) {
        return songListService.delete(id);
    }

    /**
     * 查询歌单
     *
     * @param id 歌单id
     * @return 歌单
     */
    @GetMapping(value = "/selectByPrimaryKey")
    public SongList selectByPrimaryKey(Integer id) {
        return songListService.selectByPrimaryKey(id);
    }

    /**
     * 查询所有歌单
     *
     * @return 歌单列表
     */
    @GetMapping(value = "/allSongList")
    public List<SongList> allSongList() {
        return songListService.allSongList();
    }

    /**
     * 根据标题精确查询歌单列表
     *
     * @param title 标题
     * @return 歌单列表
     */
    @GetMapping(value = "/songListOfTitle")
    public List<SongList> songListOfName(String title) {
        return songListService.songListOfTitle(title);
    }

    /**
     * 根据标题模糊查询歌单列表
     *
     * @param title 标题
     * @return 歌单列表
     */
    @GetMapping(value = "/likeTitle")
    public List<SongList> likeTitle(String title) {
        return songListService.likeTitle("%" + title + "%");
    }

    /**
     * 根据风格模糊查询歌单列表
     *
     * @param style 歌单风格
     * @return 歌单列表
     */
    @RequestMapping(value = "/likeStyle", method = RequestMethod.GET)
    public Object likeStyle(String style) {
        return songListService.likeStyle("%" + style + "%");
    }

    /**
     * 更新歌单图片
     *
     * @param avatorFile 头像文件
     * @param id         歌单id
     * @return 更新结果
     */
    @PostMapping(value = "/updateSongListPic")
    public R<UploadPicVo> updateSongListPic(
            @RequestParam("file") MultipartFile avatorFile,
            @RequestParam("id") Integer id
    ) throws IOException {
        if (avatorFile.isEmpty()) {
            return R.error("文件上传失败");
        }

        //文件名=当前时间到毫秒+原来的文件名
        String fileName = System.currentTimeMillis() + avatorFile.getOriginalFilename();
        //文件路径
        String filePath = PathUtils.getClassLoadRootPath() + "/img/songListPic/";
        //如果文件路径不存在，新增该路径
        File file1 = new File(filePath);
        if (!file1.exists()) {
            file1.mkdir();
        }
        //实际的文件地址
        File dest = new File(filePath + fileName);
        //存储到数据库里的相对文件地址
        String storeAvatorPath = "/img/songListPic/" + fileName;

        avatorFile.transferTo(dest);
        SongList songList = new SongList();
        songList.setId(id);
        songList.setPic(storeAvatorPath);

        //更新歌单
        if (songListService.update(songList)) {
            UploadPicVo uploadPicVo = new UploadPicVo();
            uploadPicVo.setPic(storeAvatorPath);
            return R.ok("上传成功", uploadPicVo);
        }

        return R.error("上传失败");
    }

}
