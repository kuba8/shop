<?php
namespace Admin\Model;
use Think\Model;
class CategoryModel extends Model 
{
	protected $insertFields = array('cat_name','parent_name','parent_id','is_floor');
	protected $updateFields = array('id','cat_name','parent_name','parent_id','is_floor');
	protected $_validate = array(
		array('cat_name', 'require', '分类名称不能为空！', 1, 'regex', 3),
	);
	public function getChildren($catId)
	{
		//取出所有的分类
		$data=$this->select();
		//递归挑出子分类的ID
		return $this->_getChildren($data,$catId,TRUE);
	}

	private function _getChildren($data,$catId,$isClear = FALSE)
	{
		static $_ret=array();
		if($isClear)
			$_ret=array();
		foreach ($data as $k => $v) {
			if($v['parent_id']==$catId)
			{
				$_ret[]=$v['id'];
				$this->_getChildren($data,$v['id']);
			}
		}
		return $_ret;
	}

	public function getTree()
	{
		$data=$this->select();
		return $this->_getTree($data);
	}

	private function _getTree($data,$parent_id=0,$level=0)
	{
		static $_ret=array();
		foreach ($data as $k => $v) {
			if($v['parent_id']==$parent_id)
			{
				$v['level']=$level;
				$_ret[]=$v;
				$this->_getTree($data,$v['id'],$level+1);
			}
		}
		return $_ret;
	}

	protected function _before_delete($option)
	{
		$children=$this->getChildren($option['where']['id']);
		if($children)
		{
			$children=implode(',', $children);
			$Model=new \Think\Model;
			$Model->table('__CATEGORY__')->delete($children);
		}
		}

	public function getNavData(){
		//先从缓存取出数据
		$catData = S('catData');
		if(!$catData)
	{
		$all = $this->select();
		$ret = array();
		foreach ($all as $k => $v) 
		{
			if($v['parent_id']==0)
			{	
				foreach ($all as $k1 => $v1)
				 {
					if($v1['parent_id']==$v['id'])
					{
						foreach ($all as $k2 => $v2) 
						{
							if($v2['parent_id']==$v1['id'])
							{
								$v1['children'][]=$v2;
							}
						}
						$v['children'][]=$v1;
				}
			   }
				$ret[]=$v;
			}
		}
		S('catData',$ret,86400);
		return $ret;
	}
		else
		return $catData;

	}

	public function floorData()
	{
		$floorData = S('floorData');
		if($floorData)
			return $floorData;
		else
		{
		$goodsModel = D('Admin/Goods');
		$ret =$this->where(array(
			'parent_id'=>array('eq',0),
			'is_floor'=>array('eq','是'),
			))->select();

		foreach ($ret as $k => $v)
		 {
		 	$goodsId = $goodsModel->getGoodsIdByCatId($v['id']);
		 	$ret[$k]['brand']=$goodsModel->alias('a')
		 	->join('LEFT JOIN __BRAND__ b ON a.brand_id=b.id')
		 	->field('DISTINCT brand_id,b.brand_name,b.logo')
		 	->where(array(
		 		'a.id'=>array('in',$goodsId),
		 		'a.brand_id'=>array('neq',0),
		 		))->select();

			$ret[$k]['subCat'] = $this->where(array(
				'parent_id'=>array('eq',$v['id']),
				'is_floor'=>array('eq','否'),
				))->select();
		

		 
			$ret[$k]['recSubCat'] = $this->where(array(
				'parent_id'=>array('eq',$v['id']),
				'is_floor'=>array('eq','是'),
				))->select();

			foreach ($ret[$k]['recSubCat'] as $k1 => &$v1) {
				
				$gids = $goodsModel->getGoodsIdByCatId($v1['id']);
				var_dump($gids);
				$v1['goods'] = $goodsModel->field('id,mid_logo,goods_name,shop_price')->where(array(
					'is_on_sale'=>array('eq','是'),
					'is_floor'=>array('eq','是'),
					'id'=>array('in',$gids),
					//'id'=>array('in',('3,4,5,6')),
					))->order('sort_num ASC')->limit(8)->select();

			}
		}
		S('floorData',$ret,86400);
		return $ret;
	}
	}


	public function parentPath($catId){
		static $ret = array();
		$info = $this->field('id,cat_name,parent_id')->find($catId);
		$ret[] = $info;
		if($info['parent_id']>0)
			$this->parentPath($info['parent_id']);
		return $ret;
	}

	public function getSearchConditionByCatId($catId)
	{
		$ret =array();
		$goodsModel = D('Admin/Goods');
		//先取出这个分类下所有商品的id
		$goodsId = $goodsModel->getGoodsIdByCatId($catId);
		//根据商品ID取出品牌ID再连品牌表取出品牌名称
		$ret['brand']=$goodsModel->alias('a')
		 	->field('DISTINCT brand_id,b.brand_name,b.logo')
		 	->join('LEFT JOIN __BRAND__ b ON a.brand_id=b.id')
		 	->where(array(
		 		'a.id'=>array('in',$goodsId),
		 		'a.brand_id'=>array('neq',0),
		 		))->select();

		 $sectionCount = 6;
		 //取出这个分类下的最大和最小价格
		 $priceInfo = $goodsModel->field('MAX(shop_price) max_price,MIN(shop_price) min_price')
		 ->where(array(
		 	'id'=>array('in',$goodsId),
		 	))->find();
		 //var_dump($priceInfo);
		 //最大价和最小价的区间
		 $priceSection = $priceInfo['max_price'] - $priceInfo['min_price'];
		 //var_dump($priceSection);
		 //分类下商品的数量
		 $goodsCount = count($goodsId);
		 //只有商品数量有这些时才分段
		 if($priceSection < 100)
		 	$sectionCount = 2;
		 elseif ($priceSection < 1000)
		 	$sectionCount = 4;
		 elseif ($priceSection < 10000)
		 	$sectionCount = 6;
		 else
		 	$sectionCount = 7;
		 //根据这些段数划分范围
		 $pricePerSection = ceil($priceSection / $sectionCount);
		 $price = array();
		 $firstPrice = 0;
		 //循环每个段
		 for ($i=0; $i < $sectionCount; $i++) 
		 { 
		 		$_tmpEnd = $firstPrice+$pricePerSection;
		 		$_tmpEnd = ((ceil($_tmpEnd/100)) *100 -1);
		 		$price[] = $firstPrice . '-' . $_tmpEnd;
		 		$firstPrice = $_tmpEnd+1;	
		 }
		 $ret['price'] = $price;

		 $gaModel = D('goods_attr');
		 $gaData=$gaModel->alias('a')
		 	->field('DISTINCT a.attr_id,a.attr_value,b.attr_name')
		 	->join('LEFT JOIN __ATTRIBUTE__ b ON a.attr_id=b.id')
		 	->where(array(
		 		'a.goods_id'=>array('in',$goodsId),
		 		))->select();
		 	//var_dump($gaData);
		 	$_gaData = array();
		 	foreach ($gaData as $k => $v)
		 	{
		 		$_gaData[$v['attr_name']][]=$v;
		 	}

		 	$ret['gaData'] = $_gaData;
		 return $ret;

	}

}