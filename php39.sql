-- phpMyAdmin SQL Dump
-- version phpStudy 2014
-- http://www.phpmyadmin.net
--
-- 主机: localhost
-- 生成日期: 2017 年 02 月 14 日 17:01
-- 服务器版本: 5.5.40
-- PHP 版本: 5.3.29

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- 数据库: `php39`
--

-- --------------------------------------------------------

--
-- 表的结构 `p39_admin`
--

CREATE TABLE IF NOT EXISTS `p39_admin` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `username` varchar(30) NOT NULL COMMENT '用户名',
  `password` char(32) NOT NULL COMMENT '密码',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='管理员' AUTO_INCREMENT=5 ;

--
-- 转存表中的数据 `p39_admin`
--

INSERT INTO `p39_admin` (`id`, `username`, `password`) VALUES
(1, 'root', '21232f297a57a5a743894a0e4a801fc3'),
(2, 'admin', '21232f297a57a5a743894a0e4a801fc3'),
(3, 'admin1', '21232f297a57a5a743894a0e4a801fc3'),
(4, 'admin2', '21232f297a57a5a743894a0e4a801fc3');

-- --------------------------------------------------------

--
-- 表的结构 `p39_admin_role`
--

CREATE TABLE IF NOT EXISTS `p39_admin_role` (
  `admin_id` mediumint(8) unsigned NOT NULL COMMENT '管理员id',
  `role_id` mediumint(8) unsigned NOT NULL COMMENT '角色id',
  KEY `admin_id` (`admin_id`),
  KEY `role_id` (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='管理员角色';

--
-- 转存表中的数据 `p39_admin_role`
--

INSERT INTO `p39_admin_role` (`admin_id`, `role_id`) VALUES
(3, 2),
(4, 2),
(4, 3);

-- --------------------------------------------------------

--
-- 表的结构 `p39_attribute`
--

CREATE TABLE IF NOT EXISTS `p39_attribute` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `attr_name` varchar(30) NOT NULL COMMENT '属性名称',
  `attr_type` enum('唯一','可选') NOT NULL COMMENT '属性类型',
  `attr_option_values` varchar(300) NOT NULL DEFAULT '' COMMENT '属性可选值',
  `type_id` mediumint(8) unsigned NOT NULL COMMENT '所属类型Id',
  PRIMARY KEY (`id`),
  KEY `type_id` (`type_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='属性表' AUTO_INCREMENT=8 ;

--
-- 转存表中的数据 `p39_attribute`
--

INSERT INTO `p39_attribute` (`id`, `attr_name`, `attr_type`, `attr_option_values`, `type_id`) VALUES
(1, '颜色', '可选', '黑色,白色,紫色,蓝色,黄色,粉红色,金色', 1),
(4, '尺寸', '可选', '6,5,4,3,2,7', 1),
(5, '出厂日期', '唯一', '', 1),
(6, '操作系统', '可选', '安卓,苹果', 1),
(7, '防水性', '唯一', '', 1);

-- --------------------------------------------------------

--
-- 表的结构 `p39_brand`
--

CREATE TABLE IF NOT EXISTS `p39_brand` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `brand_name` varchar(30) NOT NULL COMMENT '品牌名称',
  `site_url` varchar(150) NOT NULL DEFAULT '' COMMENT '官方网址',
  `logo` varchar(150) NOT NULL DEFAULT '' COMMENT '品牌Logo图片',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='品牌' AUTO_INCREMENT=4 ;

--
-- 转存表中的数据 `p39_brand`
--

INSERT INTO `p39_brand` (`id`, `brand_name`, `site_url`, `logo`) VALUES
(1, '三星', '', 'Brand/2016-11-16/582bc55e41c16.jpg'),
(2, '苹果', '', 'Brand/2016-11-16/582bc59c3f340.jpg'),
(3, '小米', '', 'Brand/2016-11-16/582bc5a559f11.jpg');

-- --------------------------------------------------------

--
-- 表的结构 `p39_cart`
--

CREATE TABLE IF NOT EXISTS `p39_cart` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `goods_id` mediumint(8) unsigned NOT NULL COMMENT '商品Id',
  `goods_attr_id` varchar(150) NOT NULL DEFAULT '' COMMENT '商品属性Id',
  `goods_number` mediumint(8) unsigned NOT NULL COMMENT '购买的数量',
  `member_id` mediumint(8) unsigned NOT NULL COMMENT '会员Id',
  PRIMARY KEY (`id`),
  KEY `member_id` (`member_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='购物车' AUTO_INCREMENT=14 ;

--
-- 转存表中的数据 `p39_cart`
--

INSERT INTO `p39_cart` (`id`, `goods_id`, `goods_attr_id`, `goods_number`, `member_id`) VALUES
(2, 7, '9,12,15', 6, 1),
(3, 7, '9,13,15', 2, 1),
(4, 7, '10,12,15', 5, 1),
(5, 7, '9,12,16', 3, 1),
(6, 7, '11,13,15', 6, 1),
(12, 7, '10,13,16', 1, 1);

-- --------------------------------------------------------

--
-- 表的结构 `p39_category`
--

CREATE TABLE IF NOT EXISTS `p39_category` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `cat_name` varchar(30) NOT NULL COMMENT '分类名称',
  `parent_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '上级分类的Id,0:顶级分类',
  `is_floor` enum('是','否') NOT NULL DEFAULT '否' COMMENT '是否推荐楼层',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='分类' AUTO_INCREMENT=32 ;

--
-- 转存表中的数据 `p39_category`
--

INSERT INTO `p39_category` (`id`, `cat_name`, `parent_id`, `is_floor`) VALUES
(1, '家用电器', 0, '是'),
(2, '手机、数码、京东通信', 0, '是'),
(3, '电脑、办公', 0, '否'),
(4, '家居、家具、家装、厨具', 0, '否'),
(5, '男装、女装、内衣、珠宝', 0, '否'),
(6, '个护化妆', 0, '否'),
(8, '运动户外', 0, '否'),
(9, '汽车、汽车用品', 0, '否'),
(10, '母婴、玩具乐器', 0, '否'),
(11, '食品、酒类、生鲜、特产', 0, '否'),
(12, '营养保健', 0, '否'),
(13, '图书、音像、电子书', 0, '否'),
(14, '彩票、旅行、充值、票务', 0, '否'),
(17, '生活电器', 1, '否'),
(18, '厨房电器', 1, '是'),
(19, '个护健康', 1, '是'),
(21, 'iphone', 2, '否'),
(27, '洗衣机', 17, '否'),
(28, '烘干机', 17, '否'),
(29, '按摩机', 17, '否'),
(30, '五金家电', 1, '是'),
(31, '三星手机', 2, '是');

-- --------------------------------------------------------

--
-- 表的结构 `p39_comment`
--

CREATE TABLE IF NOT EXISTS `p39_comment` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `goods_id` mediumint(8) unsigned NOT NULL COMMENT '商品Id',
  `member_id` mediumint(8) unsigned NOT NULL COMMENT '会员Id',
  `content` varchar(200) NOT NULL COMMENT '内容',
  `addtime` datetime NOT NULL COMMENT '发表时间',
  `star` tinyint(3) unsigned NOT NULL COMMENT '分值',
  `click_count` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '有用的数字',
  PRIMARY KEY (`id`),
  KEY `goods_id` (`goods_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='评论' AUTO_INCREMENT=29 ;

--
-- 转存表中的数据 `p39_comment`
--

INSERT INTO `p39_comment` (`id`, `goods_id`, `member_id`, `content`, `addtime`, `star`, `click_count`) VALUES
(1, 7, 2, 'sdsd', '2017-02-14 14:59:12', 5, 0),
(2, 7, 2, 'sds', '2017-02-14 14:59:14', 5, 0),
(3, 7, 2, 'dssdsd', '2017-02-14 14:59:17', 5, 0),
(4, 7, 2, 'dsdsd', '2017-02-14 14:59:19', 5, 0),
(5, 7, 2, 'dsdsd', '2017-02-14 14:59:21', 5, 0),
(6, 7, 2, 'sdsd', '2017-02-14 14:59:23', 5, 0),
(7, 7, 2, 'dsds', '2017-02-14 14:59:26', 5, 0),
(8, 7, 2, 'dsadsaa', '2017-02-14 14:59:32', 5, 0),
(9, 7, 2, 'dsadsa', '2017-02-14 14:59:35', 5, 0),
(10, 7, 2, 'dsads', '2017-02-14 14:59:37', 5, 0),
(11, 7, 2, 'adsa', '2017-02-14 14:59:39', 5, 0),
(12, 7, 2, 'sadsaasd', '2017-02-14 14:59:42', 5, 0),
(13, 7, 2, 'fdsfds', '2017-02-14 15:00:05', 5, 0),
(14, 7, 2, 'fdsfdsfds', '2017-02-14 15:00:09', 5, 0),
(15, 7, 2, 'fdsfdsfds', '2017-02-14 15:00:12', 5, 0),
(16, 7, 2, 'fdsfdsfsd', '2017-02-14 15:00:16', 5, 0),
(17, 7, 2, 'agdgfd', '2017-02-14 15:00:20', 5, 0),
(18, 7, 2, 'gdagfg', '2017-02-14 15:00:24', 5, 0),
(19, 7, 2, 'gdsagfdg', '2017-02-14 15:00:28', 5, 0),
(20, 7, 2, 'fdsafds', '2017-02-14 15:00:41', 5, 0),
(21, 7, 2, 'fadfds', '2017-02-14 15:01:00', 5, 0),
(22, 7, 2, 'fSDFASDF', '2017-02-14 15:01:07', 5, 0),
(23, 7, 2, 'fdsfdsfds', '2017-02-14 15:01:16', 5, 0),
(24, 7, 2, 'dfsdf', '2017-02-14 15:01:20', 5, 0),
(25, 7, 2, 'fdsfds', '2017-02-14 15:01:23', 5, 0),
(26, 7, 2, 'dsdsdds', '2017-02-14 15:42:37', 5, 0),
(27, 7, 2, 'dsadsa', '2017-02-14 15:42:40', 5, 0),
(28, 7, 2, 'fewfew', '2017-02-14 15:44:05', 5, 0);

-- --------------------------------------------------------

--
-- 表的结构 `p39_comment_reply`
--

CREATE TABLE IF NOT EXISTS `p39_comment_reply` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `comment_id` mediumint(8) unsigned NOT NULL COMMENT '评论Id',
  `member_id` mediumint(8) unsigned NOT NULL COMMENT '会员Id',
  `content` varchar(200) NOT NULL COMMENT '内容',
  `addtime` datetime NOT NULL COMMENT '发表时间',
  PRIMARY KEY (`id`),
  KEY `comment_id` (`comment_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='评论回复' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- 表的结构 `p39_goods`
--

CREATE TABLE IF NOT EXISTS `p39_goods` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `goods_name` varchar(150) NOT NULL COMMENT '商品名称',
  `market_price` decimal(10,2) NOT NULL COMMENT '市场价格',
  `shop_price` decimal(10,2) NOT NULL COMMENT '本店价格',
  `goods_desc` longtext COMMENT '商品描述',
  `is_on_sale` enum('是','否') NOT NULL DEFAULT '是' COMMENT '是否上架',
  `is_delete` enum('是','否') NOT NULL DEFAULT '否' COMMENT '是否放到回收站',
  `addtime` datetime NOT NULL COMMENT '添加时间',
  `logo` varchar(150) NOT NULL DEFAULT '' COMMENT '原图',
  `sm_logo` varchar(150) NOT NULL DEFAULT '' COMMENT '小图',
  `mid_logo` varchar(150) NOT NULL DEFAULT '' COMMENT '中图',
  `big_logo` varchar(150) NOT NULL DEFAULT '' COMMENT '大图',
  `mbig_logo` varchar(150) NOT NULL DEFAULT '' COMMENT '更大图',
  `brand_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '品牌id',
  `cat_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '主分类Id',
  `type_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '类型Id',
  `promote_price` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '促销价格',
  `promote_start_date` datetime NOT NULL COMMENT '促销开始时间',
  `promote_end_date` datetime NOT NULL COMMENT '促销结束时间',
  `is_new` enum('是','否') NOT NULL DEFAULT '否' COMMENT '是否新品',
  `is_hot` enum('是','否') NOT NULL DEFAULT '否' COMMENT '是否热卖',
  `is_best` enum('是','否') NOT NULL DEFAULT '否' COMMENT '是否精品',
  `sort_num` tinyint(3) unsigned NOT NULL DEFAULT '100' COMMENT '排序的数字',
  `is_floor` enum('是','否') NOT NULL DEFAULT '否' COMMENT '是否推荐楼层',
  PRIMARY KEY (`id`),
  KEY `shop_price` (`shop_price`),
  KEY `addtime` (`addtime`),
  KEY `brand_id` (`brand_id`),
  KEY `is_on_sale` (`is_on_sale`),
  KEY `cat_id` (`cat_id`),
  KEY `id` (`id`),
  KEY `id_2` (`id`),
  KEY `id_3` (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='商品' AUTO_INCREMENT=9 ;

--
-- 转存表中的数据 `p39_goods`
--

INSERT INTO `p39_goods` (`id`, `goods_name`, `market_price`, `shop_price`, `goods_desc`, `is_on_sale`, `is_delete`, `addtime`, `logo`, `sm_logo`, `mid_logo`, `big_logo`, `mbig_logo`, `brand_id`, `cat_id`, `type_id`, `promote_price`, `promote_start_date`, `promote_end_date`, `is_new`, `is_hot`, `is_best`, `sort_num`, `is_floor`) VALUES
(1, 'note7', '7000.00', '6000.00', '', '是', '否', '2016-11-16 10:35:02', 'Goods/2016-11-16/582bc5d6cb2e6.jpg', 'Goods/2016-11-16/thumb_3_582bc5d6cb2e6.jpg', 'Goods/2016-11-16/thumb_2_582bc5d6cb2e6.jpg', 'Goods/2016-11-16/thumb_1_582bc5d6cb2e6.jpg', 'Goods/2016-11-16/thumb_0_582bc5d6cb2e6.jpg', 1, 31, 0, '0.00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '否', '否', '否', 100, '是'),
(2, 'iphone7', '8000.00', '7800.00', '', '是', '否', '2016-11-16 10:38:08', 'Goods/2016-11-16/582bc6907bbe2.jpg', 'Goods/2016-11-16/thumb_3_582bc6907bbe2.jpg', 'Goods/2016-11-16/thumb_2_582bc6907bbe2.jpg', 'Goods/2016-11-16/thumb_1_582bc6907bbe2.jpg', 'Goods/2016-11-16/thumb_0_582bc6907bbe2.jpg', 2, 0, 0, '0.00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '是', '是', '是', 100, '否'),
(3, '小米note', '3000.00', '2000.00', '<p>小米好用</p>', '是', '否', '2016-11-16 10:39:43', 'Goods/2016-11-16/582bc6ef54c8b.jpg', 'Goods/2016-11-16/thumb_3_582bc6ef54c8b.jpg', 'Goods/2016-11-16/thumb_2_582bc6ef54c8b.jpg', 'Goods/2016-11-16/thumb_1_582bc6ef54c8b.jpg', 'Goods/2016-11-16/thumb_0_582bc6ef54c8b.jpg', 3, 29, 0, '80.00', '2017-01-10 00:00:00', '2017-02-05 15:37:00', '否', '否', '是', 95, '否'),
(4, '三星冰箱', '2000.00', '1800.00', '', '是', '否', '2016-11-17 11:15:22', '', '', '', '', '', 1, 18, 0, '0.00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '否', '否', '否', 100, '否'),
(5, 'iphone8', '7000.00', '6000.00', '', '是', '否', '2016-11-18 15:30:54', 'Goods/2016-11-18/582eae2df10ca.JPG', 'Goods/2016-11-18/thumb_3_582eae2df10ca.JPG', 'Goods/2016-11-18/thumb_2_582eae2df10ca.JPG', 'Goods/2016-11-18/thumb_1_582eae2df10ca.JPG', 'Goods/2016-11-18/thumb_0_582eae2df10ca.JPG', 2, 29, 0, '60.00', '2017-01-11 00:00:00', '2017-01-20 00:00:00', '是', '否', '否', 90, '否'),
(6, '测试测试测试', '3000.00', '2800.00', '', '是', '否', '2016-12-05 10:06:48', '', '', '', '', '', 0, 18, 1, '99.00', '2017-01-13 16:52:00', '2017-01-15 16:52:00', '否', '是', '是', 100, '是'),
(7, '电动牙刷', '600.00', '3000.00', '<p>这个是个<span style="font-size:32px;color:#31859b;">香蕉<img src="http://img.baidu.com/hi/jx2/j_0069.gif" alt="j_0069.gif" /></span></p><p><img src="http://127.0.0.1/shop/Public/umeditor1_2_2-utf8-php/php/upload/20170126/14853970217356.jpg" alt="14853970217356.jpg" /></p><p></p>', '是', '否', '2017-01-16 10:57:08', 'Goods/2017-01-16/587c753c10163.jpg', 'Goods/2017-01-16/sm_587c753c10163.jpg', 'Goods/2017-01-16/mid_587c753c10163.jpg', 'Goods/2017-01-16/big_587c753c10163.jpg', 'Goods/2017-01-16/mbig_587c753c10163.jpg', 1, 29, 1, '0.00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '否', '否', '否', 100, '是'),
(8, '1122', '1131.00', '132.00', '', '是', '否', '2017-01-26 10:05:23', '', '', '', '', '', 1, 1, 0, '0.00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '否', '否', '否', 100, '否');

-- --------------------------------------------------------

--
-- 表的结构 `p39_goods_attr`
--

CREATE TABLE IF NOT EXISTS `p39_goods_attr` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `attr_value` varchar(150) NOT NULL DEFAULT '' COMMENT '属性值',
  `attr_id` mediumint(8) unsigned NOT NULL COMMENT '属性Id',
  `goods_id` mediumint(8) unsigned NOT NULL COMMENT '商品Id',
  PRIMARY KEY (`id`),
  KEY `goods_id` (`goods_id`),
  KEY `attr_id` (`attr_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='商品属性' AUTO_INCREMENT=18 ;

--
-- 转存表中的数据 `p39_goods_attr`
--

INSERT INTO `p39_goods_attr` (`id`, `attr_value`, `attr_id`, `goods_id`) VALUES
(1, '黑色', 1, 6),
(2, '紫色', 1, 6),
(3, '粉红色', 1, 6),
(4, '5', 4, 6),
(5, '3', 4, 6),
(6, '2015-10-10', 5, 6),
(7, '安卓', 6, 6),
(8, '苹果', 6, 6),
(9, '黑色', 1, 7),
(10, '白色', 1, 7),
(11, '紫色', 1, 7),
(12, '5', 4, 7),
(13, '7', 4, 7),
(14, '2015-10-10', 5, 7),
(15, '安卓', 6, 7),
(16, '苹果', 6, 7),
(17, '优秀', 7, 7);

-- --------------------------------------------------------

--
-- 表的结构 `p39_goods_cat`
--

CREATE TABLE IF NOT EXISTS `p39_goods_cat` (
  `cat_id` mediumint(8) unsigned NOT NULL COMMENT '分类id',
  `goods_id` mediumint(8) unsigned NOT NULL COMMENT '商品Id',
  KEY `goods_id` (`goods_id`),
  KEY `cat_id` (`cat_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='商品扩展分类';

--
-- 转存表中的数据 `p39_goods_cat`
--

INSERT INTO `p39_goods_cat` (`cat_id`, `goods_id`) VALUES
(30, 4),
(28, 8),
(21, 5),
(3, 5),
(19, 7);

-- --------------------------------------------------------

--
-- 表的结构 `p39_goods_number`
--

CREATE TABLE IF NOT EXISTS `p39_goods_number` (
  `goods_id` mediumint(8) unsigned NOT NULL COMMENT '商品Id',
  `goods_number` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '库存量',
  `goods_attr_id` varchar(150) NOT NULL COMMENT '商品属性表的ID,如果有多个，就用程序拼成字符串存到这个字段中',
  KEY `goods_id` (`goods_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='库存量';

--
-- 转存表中的数据 `p39_goods_number`
--

INSERT INTO `p39_goods_number` (`goods_id`, `goods_number`, `goods_attr_id`) VALUES
(6, 222, '1,4,7'),
(6, 222, '2,5,7'),
(6, 666, '1,5,8'),
(6, 555, '3,4,8'),
(5, 84, ''),
(3, 96, ''),
(7, 31, '9,12,15'),
(7, 66, '9,12,16'),
(7, 64, '9,13,15'),
(7, 66, '9,13,16'),
(7, 66, '10,12,15'),
(7, 66, '10,12,16'),
(7, 43, '10,13,15'),
(7, 62, '10,13,16'),
(7, 66, '11,12,15'),
(7, 66, '11,12,16'),
(7, 66, '11,13,15'),
(7, 66, '11,13,16');

-- --------------------------------------------------------

--
-- 表的结构 `p39_goods_pic`
--

CREATE TABLE IF NOT EXISTS `p39_goods_pic` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `pic` varchar(150) NOT NULL COMMENT '原图',
  `sm_pic` varchar(150) NOT NULL COMMENT '小图',
  `mid_pic` varchar(150) NOT NULL COMMENT '中图',
  `big_pic` varchar(150) NOT NULL COMMENT '大图',
  `goods_id` mediumint(8) unsigned NOT NULL COMMENT '商品Id',
  PRIMARY KEY (`id`),
  KEY `goods_id` (`goods_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='商品相册' AUTO_INCREMENT=10 ;

--
-- 转存表中的数据 `p39_goods_pic`
--

INSERT INTO `p39_goods_pic` (`id`, `pic`, `sm_pic`, `mid_pic`, `big_pic`, `goods_id`) VALUES
(1, 'Goods/2016-11-16/582bc5d700ca8.jpg', 'Goods/2016-11-16/thumb_2_582bc5d700ca8.jpg', 'Goods/2016-11-16/thumb_1_582bc5d700ca8.jpg', 'Goods/2016-11-16/thumb_0_582bc5d700ca8.jpg', 1),
(2, 'Goods/2016-11-16/582bc5d71740d.jpg', 'Goods/2016-11-16/thumb_2_582bc5d71740d.jpg', 'Goods/2016-11-16/thumb_1_582bc5d71740d.jpg', 'Goods/2016-11-16/thumb_0_582bc5d71740d.jpg', 1),
(3, 'Goods/2016-11-16/582bc6ef75bea.jpg', 'Goods/2016-11-16/thumb_2_582bc6ef75bea.jpg', 'Goods/2016-11-16/thumb_1_582bc6ef75bea.jpg', 'Goods/2016-11-16/thumb_0_582bc6ef75bea.jpg', 3),
(4, 'Goods/2016-11-16/582bc7fc18d0e.jpg', 'Goods/2016-11-16/thumb_2_582bc7fc18d0e.jpg', 'Goods/2016-11-16/thumb_1_582bc7fc18d0e.jpg', 'Goods/2016-11-16/thumb_0_582bc7fc18d0e.jpg', 3),
(5, 'Goods/2017-01-22/58847049ad2f4.jpg', 'Goods/2017-01-22/thumb_2_58847049ad2f4.jpg', 'Goods/2017-01-22/thumb_1_58847049ad2f4.jpg', 'Goods/2017-01-22/thumb_0_58847049ad2f4.jpg', 7),
(6, 'Goods/2017-01-22/5884704a4f32f.jpg', 'Goods/2017-01-22/thumb_2_5884704a4f32f.jpg', 'Goods/2017-01-22/thumb_1_5884704a4f32f.jpg', 'Goods/2017-01-22/thumb_0_5884704a4f32f.jpg', 7),
(7, 'Goods/2017-01-22/5884704b028c7.jpg', 'Goods/2017-01-22/thumb_2_5884704b028c7.jpg', 'Goods/2017-01-22/thumb_1_5884704b028c7.jpg', 'Goods/2017-01-22/thumb_0_5884704b028c7.jpg', 7),
(8, 'Goods/2017-01-22/5884704ba5665.jpg', 'Goods/2017-01-22/thumb_2_5884704ba5665.jpg', 'Goods/2017-01-22/thumb_1_5884704ba5665.jpg', 'Goods/2017-01-22/thumb_0_5884704ba5665.jpg', 7),
(9, 'Goods/2017-01-22/5884704c57c5c.jpg', 'Goods/2017-01-22/thumb_2_5884704c57c5c.jpg', 'Goods/2017-01-22/thumb_1_5884704c57c5c.jpg', 'Goods/2017-01-22/thumb_0_5884704c57c5c.jpg', 7);

-- --------------------------------------------------------

--
-- 表的结构 `p39_member`
--

CREATE TABLE IF NOT EXISTS `p39_member` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `username` varchar(30) NOT NULL COMMENT '用户名',
  `password` char(32) NOT NULL COMMENT '密码',
  `face` varchar(150) NOT NULL DEFAULT '' COMMENT '头像',
  `jifen` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '积分',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='会员' AUTO_INCREMENT=3 ;

--
-- 转存表中的数据 `p39_member`
--

INSERT INTO `p39_member` (`id`, `username`, `password`, `face`, `jifen`) VALUES
(1, '1', 'd2f16a25052a9f1fbc8fd0212e585701', '', 30000),
(2, '2', 'd2f16a25052a9f1fbc8fd0212e585701', '', 6000);

-- --------------------------------------------------------

--
-- 表的结构 `p39_member_level`
--

CREATE TABLE IF NOT EXISTS `p39_member_level` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `level_name` varchar(30) NOT NULL COMMENT '级别名称',
  `jifen_bottom` mediumint(8) unsigned NOT NULL COMMENT '积分下限',
  `jifen_top` mediumint(8) unsigned NOT NULL COMMENT '积分上限',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='会员级别' AUTO_INCREMENT=5 ;

--
-- 转存表中的数据 `p39_member_level`
--

INSERT INTO `p39_member_level` (`id`, `level_name`, `jifen_bottom`, `jifen_top`) VALUES
(1, '注册会员', 0, 5000),
(2, '初级会员', 5001, 10000),
(3, '高级会员', 10001, 20000),
(4, 'VIP', 20001, 16777215);

-- --------------------------------------------------------

--
-- 表的结构 `p39_member_price`
--

CREATE TABLE IF NOT EXISTS `p39_member_price` (
  `price` decimal(10,2) NOT NULL COMMENT '会员价格',
  `level_id` mediumint(8) unsigned NOT NULL COMMENT '级别Id',
  `goods_id` mediumint(8) unsigned NOT NULL COMMENT '商品Id',
  KEY `level_id` (`level_id`),
  KEY `goods_id` (`goods_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='会员价格';

--
-- 转存表中的数据 `p39_member_price`
--

INSERT INTO `p39_member_price` (`price`, `level_id`, `goods_id`) VALUES
('6000.00', 1, 1),
('5000.00', 2, 1),
('4000.00', 3, 1),
('3000.00', 4, 1),
('6000.00', 1, 1),
('5000.00', 2, 1),
('4000.00', 3, 1),
('3000.00', 4, 1),
('5555.00', 1, 8),
('3333.00', 2, 8),
('2222.00', 3, 8),
('1111.00', 4, 8),
('7800.00', 1, 2),
('6800.00', 2, 2),
('5800.00', 3, 2),
('5000.00', 4, 2),
('2000.00', 1, 3),
('1800.00', 2, 3),
('1700.00', 3, 3),
('1500.00', 4, 3),
('500.00', 1, 7),
('400.00', 2, 7),
('300.00', 3, 7),
('100.00', 4, 7);

-- --------------------------------------------------------

--
-- 表的结构 `p39_order`
--

CREATE TABLE IF NOT EXISTS `p39_order` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `member_id` mediumint(8) unsigned NOT NULL COMMENT '会员Id',
  `addtime` int(10) unsigned NOT NULL COMMENT '下单时间',
  `pay_status` enum('是','否') NOT NULL DEFAULT '否' COMMENT '支付状态',
  `pay_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '支付时间',
  `total_price` decimal(10,2) NOT NULL COMMENT '定单总价',
  `shr_name` varchar(30) NOT NULL COMMENT '收货人姓名',
  `shr_tel` varchar(30) NOT NULL COMMENT '收货人电话',
  `shr_province` varchar(30) NOT NULL COMMENT '收货人省',
  `shr_city` varchar(30) NOT NULL COMMENT '收货人城市',
  `shr_area` varchar(30) NOT NULL COMMENT '收货人地区',
  `shr_address` varchar(30) NOT NULL COMMENT '收货人详细地址',
  `post_status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '发货状态,0:未发货,1:已发货2:已收到货',
  `post_number` varchar(30) NOT NULL DEFAULT '' COMMENT '快递号',
  PRIMARY KEY (`id`),
  KEY `member_id` (`member_id`),
  KEY `addtime` (`addtime`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='定单基本信息' AUTO_INCREMENT=10 ;

--
-- 转存表中的数据 `p39_order`
--

INSERT INTO `p39_order` (`id`, `member_id`, `addtime`, `pay_status`, `pay_time`, `total_price`, `shr_name`, `shr_tel`, `shr_province`, `shr_city`, `shr_area`, `shr_address`, `post_status`, `post_number`) VALUES
(1, 2, 1486602139, '否', 0, '42600.00', '酷丫丫', '13333333333', '北京', '朝阳区', '西二旗', '关山光谷软件园', 0, ''),
(2, 2, 1486602645, '否', 0, '43000.00', '酷丫丫', '13333333333', '北京', '朝阳区', '西二旗', '关山光谷软件园', 0, ''),
(3, 2, 1486602740, '否', 0, '43000.00', '酷丫丫', '13333333333', '北京', '朝阳区', '西二旗', '关山光谷软件园', 0, ''),
(4, 2, 1486602859, '否', 0, '400.00', '酷丫丫', '13333333333', '北京', '朝阳区', '西二旗', '关山光谷软件园', 0, ''),
(5, 2, 1486604529, '否', 0, '400.00', '酷丫丫', '13333333333', '北京', '朝阳区', '西二旗', '关山光谷软件园', 0, ''),
(6, 2, 1486609498, '否', 0, '1200.00', '酷丫丫', '13333333333', '北京', '朝阳区', '西二旗', '关山光谷软件园', 0, ''),
(7, 2, 1486610057, '否', 0, '400.00', '酷丫丫', '13333333333', '北京', '朝阳区', '西二旗', '关山光谷软件园', 0, ''),
(8, 2, 1486713384, '否', 0, '400.00', '酷丫丫', '13333333333', '北京', '东城区', '西二旗', '关山光谷软件园', 0, ''),
(9, 2, 1486910378, '否', 0, '400.00', '酷丫丫', '11', '北京', '朝阳区', '西二旗', '11', 0, '');

-- --------------------------------------------------------

--
-- 表的结构 `p39_order_goods`
--

CREATE TABLE IF NOT EXISTS `p39_order_goods` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `order_id` mediumint(8) unsigned NOT NULL COMMENT '定单Id',
  `goods_id` mediumint(8) unsigned NOT NULL COMMENT '商品Id',
  `goods_attr_id` varchar(150) NOT NULL DEFAULT '' COMMENT '商品属性id',
  `goods_number` mediumint(8) unsigned NOT NULL COMMENT '购买的数量',
  `price` decimal(10,2) NOT NULL COMMENT '购买的价格',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`),
  KEY `goods_id` (`goods_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='定单商品表' AUTO_INCREMENT=25 ;

--
-- 转存表中的数据 `p39_order_goods`
--

INSERT INTO `p39_order_goods` (`id`, `order_id`, `goods_id`, `goods_attr_id`, `goods_number`, `price`) VALUES
(1, 1, 7, '9,12,15', 13, '0.00'),
(2, 1, 7, '10,13,15', 11, '0.00'),
(3, 1, 5, '', 5, '0.00'),
(4, 1, 3, '', 1, '0.00'),
(5, 1, 7, '10,13,16', 2, '0.00'),
(6, 1, 7, '9,13,15', 1, '0.00'),
(7, 2, 7, '9,12,15', 14, '0.00'),
(8, 2, 7, '10,13,15', 11, '0.00'),
(9, 2, 5, '', 5, '0.00'),
(10, 2, 3, '', 1, '0.00'),
(11, 2, 7, '10,13,16', 2, '0.00'),
(12, 2, 7, '9,13,15', 1, '0.00'),
(13, 3, 7, '9,12,15', 14, '0.00'),
(14, 3, 7, '10,13,15', 11, '0.00'),
(15, 3, 5, '', 5, '0.00'),
(16, 3, 3, '', 1, '0.00'),
(17, 3, 7, '10,13,16', 2, '0.00'),
(18, 3, 7, '9,13,15', 1, '0.00'),
(19, 4, 7, '9,12,15', 1, '0.00'),
(20, 5, 7, '9,12,15', 1, '0.00'),
(21, 6, 7, '9,12,15', 3, '0.00'),
(22, 7, 7, '9,12,15', 1, '0.00'),
(23, 8, 7, '9,12,15', 1, '0.00'),
(24, 9, 7, '10,13,15', 1, '0.00');

-- --------------------------------------------------------

--
-- 表的结构 `p39_privilege`
--

CREATE TABLE IF NOT EXISTS `p39_privilege` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `pri_name` varchar(30) NOT NULL COMMENT '权限名称',
  `module_name` varchar(30) NOT NULL DEFAULT '' COMMENT '模块名称',
  `controller_name` varchar(30) NOT NULL DEFAULT '' COMMENT '控制器名称',
  `action_name` varchar(30) NOT NULL DEFAULT '' COMMENT '方法名称',
  `parent_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '上级权限Id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='权限' AUTO_INCREMENT=39 ;

--
-- 转存表中的数据 `p39_privilege`
--

INSERT INTO `p39_privilege` (`id`, `pri_name`, `module_name`, `controller_name`, `action_name`, `parent_id`) VALUES
(1, '商品模块', '', '', '', 0),
(2, '商品列表', 'Admin', 'Goods', 'lst', 1),
(3, '添加商品', 'Admin', 'Goods', 'add', 2),
(4, '修改商品', 'Admin', 'Goods', 'edit', 2),
(5, '删除商品', 'Admin', 'Goods', 'delete', 2),
(6, '分类列表', 'Admin', 'Category', 'lst', 1),
(7, '添加分类', 'Admin', 'Category', 'add', 6),
(8, '修改分类', 'Admin', 'Category', 'edit', 6),
(9, '删除分类', 'Admin', 'Category', 'delete', 6),
(10, 'RBAC', '', '', '', 0),
(11, '权限列表', 'Admin', 'Privilege', 'lst', 10),
(12, '添加权限', 'Privilege', 'Admin', 'add', 11),
(13, '修改权限', 'Admin', 'Privilege', 'edit', 11),
(14, '删除权限', 'Admin', 'Privilege', 'delete', 11),
(15, '角色列表', 'Admin', 'Role', 'lst', 10),
(16, '添加角色', 'Admin', 'Role', 'add', 15),
(17, '修改角色', 'Admin', 'Role', 'edit', 15),
(18, '删除角色', 'Admin', 'Role', 'delete', 15),
(19, '管理员列表', 'Admin', 'Admin', 'lst', 10),
(20, '添加管理员', 'Admin', 'Admin', 'add', 19),
(21, '修改管理员', 'Admin', 'Admin', 'edit', 19),
(22, '删除管理员', 'Admin', 'Admin', 'delete', 19),
(23, '类型列表', 'Admin', 'Type', 'lst', 1),
(24, '添加类型', 'Admin', 'Type', 'add', 23),
(25, '修改类型', 'Admin', 'Type', 'edit', 23),
(26, '删除类型', 'Admin', 'Type', 'delete', 23),
(27, '属性列表', 'Admin', 'Attribute', 'lst', 23),
(28, '添加属性', 'Admin', 'Attribute', 'add', 27),
(29, '修改属性', 'Admin', 'Attribute', 'edit', 27),
(30, '删除属性', 'Admin', 'Attribute', 'delete', 27),
(31, 'ajax删除商品属性', 'Admin', 'Goods', 'ajaxDelGoodsAttr', 4),
(32, 'ajax删除商品相册图片', 'Admin', 'Goods', 'ajaxDelImage', 4),
(33, '会员管理', '', '', '', 0),
(34, '会员级别列表', 'Admin', 'MemberLevel', 'lst', 33),
(35, '添加会员级别', 'Admin', 'MemberLevel', 'add', 34),
(36, '修改会员级别', 'Admin', 'MemberLevel', 'edit', 34),
(37, '删除会员级别', 'Admin', 'MemberLevel', 'delete', 34),
(38, '品牌列表', 'Admin', 'Brand', 'lst', 1);

-- --------------------------------------------------------

--
-- 表的结构 `p39_role`
--

CREATE TABLE IF NOT EXISTS `p39_role` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `role_name` varchar(30) NOT NULL COMMENT '角色名称',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='角色' AUTO_INCREMENT=4 ;

--
-- 转存表中的数据 `p39_role`
--

INSERT INTO `p39_role` (`id`, `role_name`) VALUES
(2, '测试1'),
(3, '测试2');

-- --------------------------------------------------------

--
-- 表的结构 `p39_role_pri`
--

CREATE TABLE IF NOT EXISTS `p39_role_pri` (
  `pri_id` mediumint(8) unsigned NOT NULL COMMENT '权限id',
  `role_id` mediumint(8) unsigned NOT NULL COMMENT '角色id',
  KEY `pri_id` (`pri_id`),
  KEY `role_id` (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='角色权限';

--
-- 转存表中的数据 `p39_role_pri`
--

INSERT INTO `p39_role_pri` (`pri_id`, `role_id`) VALUES
(1, 2),
(2, 2),
(4, 2),
(31, 2),
(32, 2),
(10, 2),
(11, 2),
(12, 2),
(13, 2),
(14, 2),
(1, 3),
(2, 3),
(3, 3),
(4, 3),
(31, 3),
(32, 3),
(5, 3),
(6, 3),
(7, 3),
(8, 3),
(9, 3),
(23, 3),
(24, 3),
(25, 3),
(26, 3),
(27, 3),
(28, 3),
(29, 3),
(30, 3),
(38, 3),
(10, 3),
(11, 3),
(12, 3),
(13, 3),
(14, 3),
(15, 3),
(16, 3),
(17, 3),
(18, 3),
(19, 3),
(20, 3),
(21, 3),
(22, 3);

-- --------------------------------------------------------

--
-- 表的结构 `p39_type`
--

CREATE TABLE IF NOT EXISTS `p39_type` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `type_name` varchar(30) NOT NULL COMMENT '类型名称',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='类型' AUTO_INCREMENT=5 ;

--
-- 转存表中的数据 `p39_type`
--

INSERT INTO `p39_type` (`id`, `type_name`) VALUES
(1, '手机'),
(2, '服装'),
(3, '书'),
(4, '笔记本');

-- --------------------------------------------------------

--
-- 表的结构 `p39_yinxiang`
--

CREATE TABLE IF NOT EXISTS `p39_yinxiang` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `goods_id` mediumint(8) unsigned NOT NULL COMMENT '商品Id',
  `yx_name` varchar(30) NOT NULL COMMENT '印象名称',
  `yx_count` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT '印象的次数',
  PRIMARY KEY (`id`),
  KEY `goods_id` (`goods_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='印象' AUTO_INCREMENT=1 ;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
