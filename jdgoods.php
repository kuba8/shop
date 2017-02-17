<?php
$str = file_get_contents('http://list.jd.com/list.html?cat=670,671,672&page=1');
$page_re = '/共<b>(\\d+)<\/b>页/';
preg_match($page_re, $str,$ret);
$totalPage = $ret[1];
$_li = '/<li class="gl-item">(.+)<\/li>/Us';
$_img = '/img.+src="(.+)".+/Us';
for ($i=1;$i<=$totalPage;$i++)
{
	$str = file_get_contents('http://list.jd.com/list.html?cat=670,671,672&page='.$i);
	preg_match_all($_li, $str, $li);
	foreach ($li[1] as $k => $v)
	{
		preg_match($_img, $v,$img);
		//下载图片
		$imgCode = file_get_contents('http:'.$img[1]);
		//写到本地硬盘
		file_put_contents('./jdimage/'.uniqid().'.jpg', $imgCode);
		var_dump($img);
		die;
	}
	//var_dump($li[1]);

	die;
}
