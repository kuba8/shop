<?php
namespace Admin\Model;
use Think\Model;
class CategoryModel extends Model 
{
	protected $insertFields = array('cat_name','parent_name','parent_id');
	protected $updateFields = array('id','cat_name','parent_name','parent_id');
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

}