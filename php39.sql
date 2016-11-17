-- phpMyAdmin SQL Dump
-- version phpStudy 2014
-- http://www.phpmyadmin.net
--
-- 主机: localhost
-- 生成日期: 2016 年 11 月 17 日 17:15
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
-- 表的结构 `p39_category`
--

CREATE TABLE IF NOT EXISTS `p39_category` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `cat_name` varchar(30) NOT NULL COMMENT '分类名称',
  `parent_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '上级分类的Id,0:顶级分类',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='分类' AUTO_INCREMENT=27 ;

--
-- 转存表中的数据 `p39_category`
--

INSERT INTO `p39_category` (`id`, `cat_name`, `parent_id`) VALUES
(1, '家用电器', 0),
(2, '手机、数码、京东通信', 0),
(3, '电脑、办公', 0),
(4, '家居、家具、家装、厨具', 0),
(5, '男装、女装、内衣、珠宝', 0),
(6, '个护化妆', 0),
(8, '运动户外', 0),
(9, '汽车、汽车用品', 0),
(10, '母婴、玩具乐器', 0),
(11, '食品、酒类、生鲜、特产', 0),
(12, '营养保健', 0),
(13, '图书、音像、电子书', 0),
(14, '彩票、旅行、充值、票务', 0),
(15, '理财、众筹、白条、保险', 0),
(17, '生活电器', 1),
(18, '厨房电器', 1),
(19, '个护健康', 1),
(20, '五金家装', 1),
(21, 'iphone', 2),
(23, 'aaaaaaaa', 0),
(24, '大家电', 0),
(25, '洗衣机', 0),
(26, '水管', 20);

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
  PRIMARY KEY (`id`),
  KEY `shop_price` (`shop_price`),
  KEY `addtime` (`addtime`),
  KEY `brand_id` (`brand_id`),
  KEY `is_on_sale` (`is_on_sale`),
  KEY `cat_id` (`cat_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='商品' AUTO_INCREMENT=5 ;

--
-- 转存表中的数据 `p39_goods`
--

INSERT INTO `p39_goods` (`id`, `goods_name`, `market_price`, `shop_price`, `goods_desc`, `is_on_sale`, `is_delete`, `addtime`, `logo`, `sm_logo`, `mid_logo`, `big_logo`, `mbig_logo`, `brand_id`, `cat_id`) VALUES
(1, 'note7', '7000.00', '6000.00', '', '是', '否', '2016-11-16 10:35:02', 'Goods/2016-11-16/582bc5d6cb2e6.jpg', 'Goods/2016-11-16/thumb_3_582bc5d6cb2e6.jpg', 'Goods/2016-11-16/thumb_2_582bc5d6cb2e6.jpg', 'Goods/2016-11-16/thumb_1_582bc5d6cb2e6.jpg', 'Goods/2016-11-16/thumb_0_582bc5d6cb2e6.jpg', 1, 0),
(2, 'iphone7', '8000.00', '7800.00', '', '是', '否', '2016-11-16 10:38:08', 'Goods/2016-11-16/582bc6907bbe2.jpg', 'Goods/2016-11-16/thumb_3_582bc6907bbe2.jpg', 'Goods/2016-11-16/thumb_2_582bc6907bbe2.jpg', 'Goods/2016-11-16/thumb_1_582bc6907bbe2.jpg', 'Goods/2016-11-16/thumb_0_582bc6907bbe2.jpg', 2, 0),
(3, '小米note', '3000.00', '2000.00', '<p>小米好用</p>', '是', '否', '2016-11-16 10:39:43', 'Goods/2016-11-16/582bc6ef54c8b.jpg', 'Goods/2016-11-16/thumb_3_582bc6ef54c8b.jpg', 'Goods/2016-11-16/thumb_2_582bc6ef54c8b.jpg', 'Goods/2016-11-16/thumb_1_582bc6ef54c8b.jpg', 'Goods/2016-11-16/thumb_0_582bc6ef54c8b.jpg', 3, 2),
(4, '三星冰箱', '2000.00', '1800.00', '', '是', '否', '2016-11-17 11:15:22', '', '', '', '', '', 1, 17);

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='商品相册' AUTO_INCREMENT=5 ;

--
-- 转存表中的数据 `p39_goods_pic`
--

INSERT INTO `p39_goods_pic` (`id`, `pic`, `sm_pic`, `mid_pic`, `big_pic`, `goods_id`) VALUES
(1, 'Goods/2016-11-16/582bc5d700ca8.jpg', 'Goods/2016-11-16/thumb_2_582bc5d700ca8.jpg', 'Goods/2016-11-16/thumb_1_582bc5d700ca8.jpg', 'Goods/2016-11-16/thumb_0_582bc5d700ca8.jpg', 1),
(2, 'Goods/2016-11-16/582bc5d71740d.jpg', 'Goods/2016-11-16/thumb_2_582bc5d71740d.jpg', 'Goods/2016-11-16/thumb_1_582bc5d71740d.jpg', 'Goods/2016-11-16/thumb_0_582bc5d71740d.jpg', 1),
(3, 'Goods/2016-11-16/582bc6ef75bea.jpg', 'Goods/2016-11-16/thumb_2_582bc6ef75bea.jpg', 'Goods/2016-11-16/thumb_1_582bc6ef75bea.jpg', 'Goods/2016-11-16/thumb_0_582bc6ef75bea.jpg', 3),
(4, 'Goods/2016-11-16/582bc7fc18d0e.jpg', 'Goods/2016-11-16/thumb_2_582bc7fc18d0e.jpg', 'Goods/2016-11-16/thumb_1_582bc7fc18d0e.jpg', 'Goods/2016-11-16/thumb_0_582bc7fc18d0e.jpg', 3);

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
('7800.00', 1, 2),
('6800.00', 2, 2),
('5800.00', 3, 2),
('5000.00', 4, 2),
('2000.00', 1, 3),
('1800.00', 2, 3),
('1700.00', 3, 3),
('1500.00', 4, 3),
('2000.00', 1, 3),
('1800.00', 2, 3),
('1700.00', 3, 3),
('1500.00', 4, 3),
('2000.00', 1, 3),
('1800.00', 2, 3),
('1700.00', 3, 3),
('1500.00', 4, 3),
('2000.00', 1, 3),
('1800.00', 2, 3),
('1700.00', 3, 3),
('1500.00', 4, 3);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
