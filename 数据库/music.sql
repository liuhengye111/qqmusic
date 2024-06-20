/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50726
Source Host           : localhost:3306
Source Database       : db_music

Target Server Type    : MYSQL
Target Server Version : 50726
File Encoding         : 65001

Date: 2024-03-25 22:05:53
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for admin
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(255) DEFAULT NULL COMMENT '账号',
  `password` varchar(255) DEFAULT NULL COMMENT '密码',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='管理员';

-- ----------------------------
-- Records of admin
-- ----------------------------
INSERT INTO `admin` VALUES ('1', 'admin', '123456');

-- ----------------------------
-- Table structure for collect
-- ----------------------------
DROP TABLE IF EXISTS `collect`;
CREATE TABLE `collect` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user_id` int(11) DEFAULT NULL COMMENT '用户id',
  `type` tinyint(1) DEFAULT NULL COMMENT '收藏类型（0歌曲1歌单）',
  `song_id` int(11) DEFAULT NULL COMMENT '歌曲id',
  `song_list_id` int(11) DEFAULT NULL COMMENT '歌单id',
  `create_time` datetime DEFAULT NULL COMMENT '收藏时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=69 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='收藏';

-- ----------------------------
-- Records of collect
-- ----------------------------
INSERT INTO `collect` VALUES ('61', '33', '0', '27', null, '2024-03-15 15:56:09');
INSERT INTO `collect` VALUES ('66', '33', '0', '116', null, '2024-03-17 16:35:40');
INSERT INTO `collect` VALUES ('67', '35', '0', '116', null, '2024-03-19 21:54:22');
INSERT INTO `collect` VALUES ('68', '39', '0', '27', null, '2024-03-25 21:33:42');

-- ----------------------------
-- Table structure for comment
-- ----------------------------
DROP TABLE IF EXISTS `comment`;
CREATE TABLE `comment` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user_id` int(11) DEFAULT NULL COMMENT '用户id',
  `type` tinyint(1) DEFAULT NULL COMMENT '评论类型（0歌曲1歌单）',
  `song_id` int(11) DEFAULT NULL COMMENT '歌曲id',
  `song_list_id` int(11) DEFAULT NULL COMMENT '歌单id',
  `content` varchar(255) DEFAULT NULL COMMENT '评论内容',
  `create_time` datetime DEFAULT NULL COMMENT '收藏时间',
  `up` int(11) DEFAULT '0' COMMENT '评论点赞数',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=66 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='评论';

-- ----------------------------
-- Records of comment
-- ----------------------------
INSERT INTO `comment` VALUES ('63', '33', '1', null, '87', '很好听的歌曲', '2024-03-15 15:56:09', '0');
INSERT INTO `comment` VALUES ('64', '33', '1', null, '91', '11', '2024-03-17 16:35:40', '0');
INSERT INTO `comment` VALUES ('65', '35', '1', null, '86', '非常不错', '2024-03-19 21:54:22', '0');

-- ----------------------------
-- Table structure for consumer
-- ----------------------------
DROP TABLE IF EXISTS `consumer`;
CREATE TABLE `consumer` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `username` varchar(255) DEFAULT NULL COMMENT '账号',
  `password` varchar(255) DEFAULT NULL COMMENT '密码',
  `sex` tinyint(1) DEFAULT NULL COMMENT '性别（1男0女）',
  `phone_num` char(15) DEFAULT NULL COMMENT '电话',
  `email` char(30) DEFAULT NULL COMMENT '邮箱',
  `birth` datetime DEFAULT NULL COMMENT '生日',
  `introduction` varchar(255) DEFAULT NULL COMMENT '签名',
  `location` varchar(255) DEFAULT NULL COMMENT '地区',
  `avator` varchar(255) DEFAULT NULL COMMENT '头像',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='前端用户';

-- ----------------------------
-- Records of consumer
-- ----------------------------
INSERT INTO `consumer` VALUES ('35', 'user', '123456', '1', '18677772222', '1@qq.com', '2024-03-15 15:56:09', '一个厉害的歌手', '背景', '/userImages/17011782472001.png', '2024-03-15 15:56:09', '2024-03-15 15:56:09');
INSERT INTO `consumer` VALUES ('36', 'user2', '123456', '1', '18766665555', '2@qq.com', '2024-03-17 16:35:40', '一个非常优秀的歌手', '杭州', '/userImages/17011783001032.jpg', '2024-03-17 16:35:40', '2024-03-17 16:35:40');
INSERT INTO `consumer` VALUES ('39', '112233', '112233', '1', '18300000000', '1008@qq.com', '2024-03-12 00:00:00', '111', '山西', '/img/user.jpg', '2024-03-25 21:33:00', '2024-03-25 21:33:00');

-- ----------------------------
-- Table structure for list_song
-- ----------------------------
DROP TABLE IF EXISTS `list_song`;
CREATE TABLE `list_song` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `song_id` int(11) DEFAULT NULL COMMENT '歌曲id',
  `song_list_id` int(11) DEFAULT NULL COMMENT '歌单id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=215 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='歌单包含歌曲列表';

-- ----------------------------
-- Records of list_song
-- ----------------------------
INSERT INTO `list_song` VALUES ('213', '27', '86');
INSERT INTO `list_song` VALUES ('214', '116', '86');

-- ----------------------------
-- Table structure for rank
-- ----------------------------
DROP TABLE IF EXISTS `rank`;
CREATE TABLE `rank` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `song_list_id` int(11) NOT NULL COMMENT '歌单id',
  `consumer_id` int(11) NOT NULL COMMENT '用户id',
  `score` int(11) DEFAULT NULL COMMENT '评分',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `consumer_id` (`song_list_id`,`consumer_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='评价';

-- ----------------------------
-- Records of rank
-- ----------------------------
INSERT INTO `rank` VALUES ('38', '86', '33', '5');

-- ----------------------------
-- Table structure for singer
-- ----------------------------
DROP TABLE IF EXISTS `singer`;
CREATE TABLE `singer` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(255) DEFAULT NULL COMMENT '姓名',
  `sex` tinyint(1) DEFAULT NULL COMMENT '性别（0女1男2组合3不明）',
  `pic` varchar(255) DEFAULT NULL COMMENT '头像',
  `birth` datetime DEFAULT NULL COMMENT '生日',
  `location` varchar(255) DEFAULT NULL COMMENT '地区',
  `introduction` varchar(1600) DEFAULT NULL COMMENT '简介',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='歌手';

-- ----------------------------
-- Records of singer
-- ----------------------------
INSERT INTO `singer` VALUES ('5', 'G.E.M.邓紫棋', '0', '/img/singerPic/1701178317186猫.jpg', '1998-07-27 00:00:00', '中国上海', '成长于一个音乐世家，其母亲为上海音乐学院声乐系毕业生，外婆教唱歌，舅父拉小提琴，外公在乐团吹色士风。在家人的熏陶下，自小便热爱音乐，喜爱唱歌，与音乐结下不解之缘。G.E.M.在5岁的时候已经开始尝试作曲及填词，13岁完成了8级钢琴。G.E.M.在小学时期就读位于太子道西的中华基督教会协和小学上午校，为2003年的毕业生，同时亦为校内诗歌班成员。其英文名G.E.M.是Get Everybody Moving的缩写，象徵著她希望透过音乐让大家动起来的梦想。');

-- ----------------------------
-- Table structure for song
-- ----------------------------
DROP TABLE IF EXISTS `song`;
CREATE TABLE `song` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `singer_id` int(11) DEFAULT NULL COMMENT '歌手id',
  `name` varchar(255) DEFAULT NULL COMMENT '革命',
  `introduction` varchar(255) DEFAULT NULL COMMENT '简介',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `pic` varchar(255) DEFAULT NULL COMMENT '歌曲图片',
  `lyric` text COMMENT '歌词',
  `url` varchar(255) DEFAULT NULL COMMENT '歌曲地址',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=118 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='歌曲';

-- ----------------------------
-- Records of song
-- ----------------------------
INSERT INTO `song` VALUES ('27', '5', 'G.E.M.邓紫棋-泡沫', 'Xposed', '2024-03-15 15:56:09', '2024-03-15 15:56:09', '/img/songPic/1701178877138狗.jpg', '[00:00.00] 作曲 : G.E.M.\n[00:00.169] 作词 : G.E.M.\n[00:00.509]阳光下的泡沫 是彩色的 就像被骗的我 是幸福的\n[00:14.940]追究什么对错 你的谎言 基于你还爱我\n[00:27.819]美丽的泡沫 虽然一刹花火 你所有承诺 虽然都太脆弱\n[00:41.780]但爱像泡沫 如果能够看破 有什么难过\n[00:53.750]\n[00:57.230]早该知道泡沫 一触就破 就像已伤的心 不胜折磨\n[01:11.040]也不是谁的错 谎言再多 基于你还爱我\n[01:24.200]美丽的泡沫 虽然一刹花火 你所有承诺 虽然都太脆弱\n[01:38.800]爱本是泡沫 如果能够看破 有什么难过\n[01:50.560]\n[01:52.629]再美的花朵 盛开过就凋落 再亮眼的星 一闪过就坠落\n[02:06.650]爱本是泡沫 如果能够看破 有什么难过\n[02:20.889]为什么难过 有什么难过 为什么难过\n[02:41.650]\n[02:45.799]全都是泡沫 只一刹的花火 你所有承诺 全部都太脆弱\n[02:59.560]而你的轮廓 怪我没有看破 才如此难过\n[03:13.769]相爱的把握 要如何再搜索 相拥着寂寞 难道就不寂寞\n[03:28.820]爱本是泡沫 怪我没有看破 才如此难过\n[03:39.980]\n[03:43.829]在雨下的泡沫 一触就破 当初炽热的心 早已沉没\n[03:57.940]说什么你爱我 如果骗我 我宁愿你沉默\n[04:10.000]\n[04:10.209]\n[59:59.700]', '/song/16877835416171679030969249泡沫.mp3');
INSERT INTO `song` VALUES ('116', '5', 'G.E.M.邓紫棋-光年之外', '光年之外', '2024-03-17 16:35:40', '2024-03-17 16:35:40', '/img/songPic/1701179455581猫.jpg', '[00:01.82]光年之外 - G.E.M.邓紫棋\r\n[00:03.86]词：G.E.M. 邓紫棋\r\n[00:05.93]曲：G.E.M. 邓紫棋\r\n[00:08.01]编曲：Lupo Groinig\r\n[00:10.6]感受停在我发端的指尖\r\n[00:14.7]如何瞬间冻结时间\r\n[00:21.47]记住望着我坚定的双眼\r\n[00:25.54]也许已经没有明天\r\n[00:32.09]面对浩瀚的星海\r\n[00:34.68]我们微小得像尘埃\r\n[00:37.05]漂浮在一片无奈\r\n[00:43.03]缘分让我们相遇乱世以外\r\n[00:48.36]命运却要我们危难中相爱\r\n[00:53.83]也许未来遥远在光年之外\r\n[00:59.21]我愿守候未知里为你等待\r\n[01:03.29]我没想到为了你我能疯狂到\r\n[01:08.71]山崩海啸没有你根本不想逃\r\n[01:14.25]我的大脑为了你已经疯狂到\r\n[01:19.65]脉搏心跳没有你根本不重要\r\n[01:26.92]一双围在我胸口的臂弯\r\n[01:31.0]足够抵挡天旋地转\r\n[01:37.729996]一种执迷不放手的倔强\r\n[01:41.770004]足以点燃所有希望\r\n[01:48.46]宇宙磅礡而冷漠\r\n[01:50.979996]我们的爱微小却闪烁\r\n[01:53.45]颠簸却如此忘我\r\n[01:59.28]缘分让我们相遇乱世以外\r\n[02:04.75]命运却要我们危难中相爱\r\n[02:10.2]也许未来遥远在光年之外\r\n[02:15.71]我愿守候未知里为你等待\r\n[02:19.61]我没想到为了你我能疯狂到\r\n[02:25.12]山崩海啸没有你根本不想逃\r\n[02:30.58]我的大脑为了你已经疯狂到\r\n[02:36.11]脉搏心跳没有你根本不重要\r\n[02:42.41]也许航道以外是醒不来的梦\r\n[02:54.5]乱世以外是纯粹的相拥\r\n[03:03.36]我没想到为了你我能疯狂到\r\n[03:08.78]山崩海啸没有你根本不想逃\r\n[03:14.23]我的大脑为了你已经疯狂到\r\n[03:19.75]脉搏心跳没有你根本不重要\r\n[03:25.58]相遇乱世以外危难中相爱\r\n[03:36.52]相遇乱世以外危难中相爱\r\n[03:47.02]我没想到', '/song/1701179468969光年之外.mp3');

-- ----------------------------
-- Table structure for song_list
-- ----------------------------
DROP TABLE IF EXISTS `song_list`;
CREATE TABLE `song_list` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `title` varchar(255) DEFAULT NULL COMMENT '标题',
  `pic` varchar(255) DEFAULT NULL COMMENT '歌单图片',
  `introduction` text COMMENT '简介',
  `style` varchar(255) DEFAULT NULL COMMENT '风格',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=93 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='歌单';

-- ----------------------------
-- Records of song_list
-- ----------------------------
INSERT INTO `song_list` VALUES ('86', '华语伤感女声', '/img/songListPic/1701178331107吉他.jpg', '细心聆听那些触动你内心的华语伤感女声。', '华语');
INSERT INTO `song_list` VALUES ('87', '粤语唱片行精选', '/img/songListPic/1701178336795猫.jpg', '香港金曲精选', '粤语');
INSERT INTO `song_list` VALUES ('88', '古典音乐', '/img/songListPic/17011783563941.png', '', '欧美');
INSERT INTO `song_list` VALUES ('89', '钢琴后摇 I 初雪点地，窸窣低语', '/img/songListPic/1701178385255狗.jpg', '', '乐器');
INSERT INTO `song_list` VALUES ('90', '华语民谣，因为懂得才有共鸣', '/img/songListPic/17011783986252.png', '', '华语');
