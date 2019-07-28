-- phpMyAdmin SQL Dump
-- version 3.0.1.1
-- http://www.phpmyadmin.net
--
-- 服务器版本: 5.1.29
-- PHP 版本: 5.2.6

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";

-- --------------------------------------------------------

-- ----------------------------
-- Table structure for `admin`
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin` (
  `username` varchar(20) NOT NULL DEFAULT '',
  `password` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_admin
-- ----------------------------
INSERT INTO `admin` VALUES ('a', 'a'); 

CREATE TABLE IF NOT EXISTS `t_userInfo` (
  `userInfoname` varchar(20)  NOT NULL COMMENT 'userInfoname',
  `password` varchar(20)  NOT NULL COMMENT '登录密码',
  `name` varchar(20)  NOT NULL COMMENT '姓名',
  `sex` varchar(3)  NOT NULL COMMENT '性别',
  `birthday` varchar(20)  NULL COMMENT '出生日期',
  `telephone` varchar(20)  NULL COMMENT '联系电话',
  `email` varchar(40)  NULL COMMENT '邮箱地址',
  `address` varchar(60)  NULL COMMENT '用户住址',
  `userPhoto` varchar(60)  NOT NULL COMMENT '个人照片',
  PRIMARY KEY (`userInfoname`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `t_surveyInfo` (
  `paperId` int(11) NOT NULL AUTO_INCREMENT COMMENT '记录编号',
  `questionPaperName` varchar(30)  NOT NULL COMMENT '问卷名称',
  `faqiren` varchar(20)  NULL COMMENT '发起人',
  `description` varchar(100)  NULL COMMENT '问卷描述',
  `startDate` varchar(20)  NULL COMMENT '发起日期',
  `endDate` varchar(20)  NULL COMMENT '结束日期',
  `zhutitupian` varchar(60)  NOT NULL COMMENT '主题图片',
  `publishFlag` int(11) NOT NULL COMMENT '审核标志',
  PRIMARY KEY (`paperId`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS `t_questionInfo` (
  `titileId` int(11) NOT NULL AUTO_INCREMENT COMMENT '记录编号',
  `questionPaperObj` int(11) NOT NULL COMMENT '问卷名称',
  `titleValue` varchar(50)  NOT NULL COMMENT '问题内容',
  PRIMARY KEY (`titileId`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS `t_selectOption` (
  `optionId` int(11) NOT NULL AUTO_INCREMENT COMMENT '记录编号',
  `questionObj` int(11) NOT NULL COMMENT '问题信息',
  `optionContent` varchar(50)  NOT NULL COMMENT '选项内容',
  PRIMARY KEY (`optionId`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS `t_answer` (
  `answerId` int(11) NOT NULL AUTO_INCREMENT COMMENT '记录编号',
  `selectOptionObj` int(11) NOT NULL COMMENT '选项信息',
  `userObj` varchar(20)  NOT NULL COMMENT '用户',
  PRIMARY KEY (`answerId`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS `t_guestBook` (
  `guestBookId` int(11) NOT NULL AUTO_INCREMENT COMMENT '记录编号',
  `title` varchar(50)  NOT NULL COMMENT '留言标题',
  `content` varchar(200)  NOT NULL COMMENT '留言内容',
  `userObj` varchar(20)  NOT NULL COMMENT '留言人',
  `addTime` varchar(20)  NULL COMMENT '留言时间',
  PRIMARY KEY (`guestBookId`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

ALTER TABLE t_questionInfo ADD CONSTRAINT FOREIGN KEY (questionPaperObj) REFERENCES t_surveyInfo(paperId);
ALTER TABLE t_selectOption ADD CONSTRAINT FOREIGN KEY (questionObj) REFERENCES t_questionInfo(titileId);
ALTER TABLE t_answer ADD CONSTRAINT FOREIGN KEY (selectOptionObj) REFERENCES t_selectOption(optionId);
ALTER TABLE t_answer ADD CONSTRAINT FOREIGN KEY (userObj) REFERENCES t_userInfo(userInfoname);
ALTER TABLE t_guestBook ADD CONSTRAINT FOREIGN KEY (userObj) REFERENCES t_userInfo(userInfoname);


