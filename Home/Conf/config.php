<?php
return array(
	'HTML_CACHE_ON'     =>    FALSE, // 开启静态缓存
	'HTML_CACHE_TIME'   =>    60,   // 全局静态缓存有效期（秒）
	'HTML_FILE_SUFFIX'  =>    '.shtml', // 设置静态缓存文件后缀
	'HTML_CACHE_RULES'  =>     array(  // 定义静态缓存规则
     // 定义格式1 数组方式
     'index:index'    =>     array('index', '86400', ), 
     'index:goods'    =>     array('goods-{id}', '86400', ), 
 
)
);