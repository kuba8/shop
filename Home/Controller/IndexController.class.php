<?php
namespace Home\Controller;
class IndexController extends NavController {

    public function displayHistory()
    {
        $id = I('get.id');
        $data = isset($_COOKIE['display_history']) ? unserialize($_COOKIE['display_history']) : array();
        array_unshift($data, $id);
        $data = array_unique($data);
        if(count($data)>5)
            $data = array_slice($data, 0,5);
        setcookie('display_history',serialize($data),time()+30*86400,'/');
        $goodsModel = D('Goods');
        $data = implode(',', $data);
        $gData = $goodsModel->field('id,mid_logo,goods_name')->where(array(
            'id'=>array('in',$data),
            'is_on_sale'=>array('eq','是'),
            ))->order("FIELD(id,$data)")->select();
        echo json_encode($gData);
    }

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