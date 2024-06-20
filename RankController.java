package com.lhy.music.controller;

import com.lhy.music.common.R;
import com.lhy.music.entity.po.Rank;
import com.lhy.music.service.RankService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * 评价 控制层
 *
 * @author: ShanZhu
 * @date: 2023-11-25
 */
@RestController
@RequiredArgsConstructor
public class RankController {

    private final RankService rankService;

    /**
     * 新增评价
     *
     * @param songListId 歌单id
     * @param consumerId 用户id
     * @param score      评价
     * @return 结果
     */
    @PostMapping(value = "/rank/add")
    public R add(Integer songListId, Integer consumerId, Integer score) {
        Rank rank = new Rank();
        rank.setSongListId(songListId);
        rank.setConsumerId(consumerId);
        rank.setScore(score);

        if (rankService.insert(rank)) {
            return R.ok("评价成功");
        }

        return R.error("评价失败");
    }

    /**
     * 计算平均分
     *
     * @param songListId 歌单id
     * @return 结果
     */
    @GetMapping(value = "/rank")
    public Integer rankOfSongListId(String songListId) {
        return rankService.rankOfSongListId(Integer.parseInt(songListId));
    }

}
