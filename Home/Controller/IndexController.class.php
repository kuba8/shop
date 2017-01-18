<?php
namespace Home\Controller;
class IndexController extends NavController {

    public function index(){

        $file = uniqid();
        file_put_contents('./piao/'.$file, 'abc');

        $goodsModel = D('Admin/Goods');
        $goods1 = $goodsModel->getPromoteGoods();
        $goods2 = $goodsModel->getRecGoods('is_new');
        $goods3 = $goodsModel->getRecGoods('is_hot');
        $goods4 = $goodsModel->getRecGoods('is_best');

        $catModel = D('Admin/Category');
        $floorData = $catModel->floorData();
        //var_dump($floorData);

        $this->assign(array(
            'goods1' => $goods1,
            'goods2' => $goods2,
            'goods3' => $goods3,
            'goods4' => $goods4,
            'floorData' => $floorData,
            ));
        //var_dump($goods3);
    	$this->assign(array(
    		'_show_nav'=>1,
    		'_page_keywords'=>'首页',
    		'_page_description'=>'首页',
    		'_page_title'=>首页,
    		));
        $this->display();
    }

    public function goods(){

        $id = I('get.id');
        $gModel = D('Goods');
        $info = $gModel->find($id);
        $catModel = D('Admin/Category');
        $catPath = $catModel->parentPath($info['cat_id']);

        var_dump($catPath);

        $this->assign(array(
            'info'=>$info,
            'catPath'=>$catPath,
            ));

    	$this->assign(array(
    		'_show_nav'=>0,
    		'_page_keywords'=>'商品详情页',
    		'_page_description'=>'商品详情页',
    		'_page_title'=>商品详情页,
    		));
    	$this->display();
    }
}