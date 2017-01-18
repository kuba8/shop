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

}