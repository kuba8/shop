<?php
namespace Home\Controller;
class SearchController extends NavController

{

    public function cat_search()
    {
    	$catId = I('get.cat_id');
    	$catModel = D('Admin/Category');
    	$searchFilter = $catModel->getSearchConditionByCatId($catId);
    	//var_dump($searchFilter);
        //取出商品和翻页
        $goodsModel = D('Admin/Goods');
        $data=$goodsModel->cat_search($catId);
        var_dump($data);
     
    	$this->assign(array(
            'page'=>$data['page'],
            'data'=>$data['data'],
    		'searchFilter'=>$searchFilter,
    		'_page_keywords'=>'分类搜索页',
    		'_page_description'=>'分类搜索页',
    		'_page_title'=>'分类搜索页',
    		));
        $this->display();
    }

 
}