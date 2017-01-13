-- phpMyAdmin SQL Dump
-- version phpStudy 2014
-- http://www.phpmyadmin.net
--
-- 主机: localhost
-- 生成日期: 2017 年 01 月 13 日 17:43
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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='属性表' AUTO_INCREMENT=7 ;

--
-- 转存表中的数据 `p39_attribute`
--

INSERT INTO `p39_attribute` (`id`, `attr_name`, `attr_type`, `attr_option_values`, `type_id`) VALUES
(1, '颜色', '可选', '黑色,白色,紫色,蓝色,黄色,粉红色,金色', 1),
(4, '尺寸', '可选', '6,5,4,3,2,7', 1),
(5, '出厂日期', '唯一', '', 1),
(6, '操作系统', '可选', '安卓,苹果', 1);

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='分类' AUTO_INCREMENT=30 ;

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
(17, '生活电器', 1),
(18, '厨房电器', 1),
(19, '个护健康', 1),
(21, 'iphone', 2),
(27, '洗衣机', 17),
(28, '烘干机', 17),
(29, '按摩机', 17);

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
  PRIMARY KEY (`id`),
  KEY `shop_price` (`shop_price`),
  KEY `addtime` (`addtime`),
  KEY `brand_id` (`brand_id`),
  KEY `is_on_sale` (`is_on_sale`),
  KEY `cat_id` (`cat_id`),
  KEY `id` (`id`),
  KEY `id_2` (`id`),
  KEY `id_3` (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='商品' AUTO_INCREMENT=7 ;

--
-- 转存表中的数据 `p39_goods`
--

INSERT INTO `p39_goods` (`id`, `goods_name`, `market_price`, `shop_price`, `goods_desc`, `is_on_sale`, `is_delete`, `addtime`, `logo`, `sm_logo`, `mid_logo`, `big_logo`, `mbig_logo`, `brand_id`, `cat_id`, `type_id`, `promote_price`, `promote_start_date`, `promote_end_date`, `is_new`, `is_hot`, `is_best`) VALUES
(1, 'note7', '7000.00', '6000.00', '', '是', '否', '2016-11-16 10:35:02', 'Goods/2016-11-16/582bc5d6cb2e6.jpg', 'Goods/2016-11-16/thumb_3_582bc5d6cb2e6.jpg', 'Goods/2016-11-16/thumb_2_582bc5d6cb2e6.jpg', 'Goods/2016-11-16/thumb_1_582bc5d6cb2e6.jpg', 'Goods/2016-11-16/thumb_0_582bc5d6cb2e6.jpg', 1, 0, 0, '0.00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '否', '否', '否'),
(2, 'iphone7', '8000.00', '7800.00', '', '是', '否', '2016-11-16 10:38:08', 'Goods/2016-11-16/582bc6907bbe2.jpg', 'Goods/2016-11-16/thumb_3_582bc6907bbe2.jpg', 'Goods/2016-11-16/thumb_2_582bc6907bbe2.jpg', 'Goods/2016-11-16/thumb_1_582bc6907bbe2.jpg', 'Goods/2016-11-16/thumb_0_582bc6907bbe2.jpg', 2, 0, 0, '0.00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '否', '否', '否'),
(3, '小米note', '3000.00', '2000.00', '<p>小米好用</p>', '是', '否', '2016-11-16 10:39:43', 'Goods/2016-11-16/582bc6ef54c8b.jpg', 'Goods/2016-11-16/thumb_3_582bc6ef54c8b.jpg', 'Goods/2016-11-16/thumb_2_582bc6ef54c8b.jpg', 'Goods/2016-11-16/thumb_1_582bc6ef54c8b.jpg', 'Goods/2016-11-16/thumb_0_582bc6ef54c8b.jpg', 3, 2, 0, '80.00', '2017-01-10 00:00:00', '2017-01-30 00:00:00', '否', '否', '否'),
(4, '三星冰箱', '2000.00', '1800.00', '', '是', '否', '2016-11-17 11:15:22', '', '', '', '', '', 1, 17, 0, '0.00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '否', '否', '否'),
(5, 'iphone8', '7000.00', '6000.00', '', '是', '否', '2016-11-18 15:30:54', 'Goods/2016-11-18/582eae2df10ca.JPG', 'Goods/2016-11-18/thumb_3_582eae2df10ca.JPG', 'Goods/2016-11-18/thumb_2_582eae2df10ca.JPG', 'Goods/2016-11-18/thumb_1_582eae2df10ca.JPG', 'Goods/2016-11-18/thumb_0_582eae2df10ca.JPG', 2, 2, 0, '60.00', '2017-01-11 00:00:00', '2017-01-20 00:00:00', '否', '否', '否'),
(6, '测试测试测试', '0.00', '0.00', '', '是', '否', '2016-12-05 10:06:48', '', '', '', '', '', 0, 0, 1, '99.00', '2017-01-13 16:52:00', '2017-01-15 16:52:00', '否', '是', '是');

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='商品属性' AUTO_INCREMENT=9 ;

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
(8, '苹果', 6, 6);

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
(21, 5),
(3, 5);

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
(6, 555, '3,4,8');

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
('1500.00', 4, 3),
('2000.00', 1, 3),
('1800.00', 2, 3),
('1700.00', 3, 3),
('1500.00', 4, 3),
('2000.00', 1, 3),
('1800.00', 2, 3),
('1700.00', 3, 3),
('1500.00', 4, 3);

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

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
