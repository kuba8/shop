<?php
namespace Home\Model;
use Think\Model;
class CartModel extends Model 
{
	//加入购物车时允许接收的字段
	protected $insertFields = array('goods_id','goods_attr_id','goods_number');
	//加入购物车时的表单验证规则
	protected $_validate = array(
		array('goods_id', 'require', '必须选择商品', 1),
		array('goods_number', 'chkGoodsNumber', '库存量不足', 1,'callback'),
	);

	public function chkGoodsNumber($goodsNumber)
	{
		//选择商品属性id
		$gaid = I('post.goods_attr_id');
		sort($gaid,SORT_NUMERIC);
		$gaid = (string)implode(',', $gaid);
		//取出库存量
		$gnModel = D('goods_number');
		$gn = $gnModel->field('goods_number')->where(array(
				'goods_id' => I('post.goods_id'),
				'goods_attr_id' => $gaid,
			))->find();
		//echo $this->getLastSql();die;
		//返回库存量是否够
		return ($gn['goods_number'] >= $goodsNumber);
	}

	public function add()
	{
		$memberId = session('m_id');
		sort($this->goods_attr_id,SORT_NUMERIC);
		$this->goods_attr_id = (string)implode(',', $this->goods_attr_id);
		//判断有没有登录
		if($memberId)
		{
			$goodsNumber = $this->goods_number;
			$has = $this->field('id')->where(array(
					'member_id' => $memberId,
					'goods_id' => $this->goods_id,
					'goods_attr_id' => $this->goods_attr_id,
				))->find();
			if($has)
			{
				$this->where(array(
						'id' => array('eq',$has['id']),
					))->setInc('goods_number',$goodsNumber);
			//echo $this->getLastSql();die;
			}
			else
				parent::add(array(
						'member_id' => $memberId,
						'goods_id' => $this->goods_id,
						'goods_attr_id' => $this->goods_attr_id,
						'goods_number' => $this->goods_number,
					));
		}
		else
		{
			//从cookie中取出购物车的一维数组
			$cart = isset($_COOKIE['cart']) ? unserialize($_COOKIE['cart']):array();
			$key = $this->goods_id.'-'.$this->goods_attr_id;
			if(isset($cart[$key]))
				$cart[$key] += $this->goods_number;
			else
				$cart[$key] = $this->goods_number;
			setcookie('cart',serialize($cart),time()+30*86400,'/');
		}
		return TRUE;
	}

	public function moveDataToDb()
	{
		$memberId = session('m_id');
		if($memberId)
		{
			$cart = isset($_COOKIE['cart']) ? unserialize($_COOKIE['cart']):array();
			foreach ($cart as $k => $v)
		{
			$_k = explode('-', $k);
			$has = $this->field('id')->where(array(
					'member_id' => $memberId,
					'goods_id' => $_k[0],
					'goods_attr_id' => $_k[1],
				))->find();
			if($has)
			{
				$this->where(array(
						'id' => array('eq',$has['id']),
					))->setInc('goods_number',$v);
			}
			else
				parent::add(array(
						'member_id' => $memberId,
						'goods_id' => $_k[0],
						'goods_attr_id' => $_k[1],
						'goods_number' => $v,
					));
		}
		setcookie('cart','',time()-1,'/');
		}		
	}

	public function cartList()
	{
		$memberId = session('m_id');
		if($memberId)
			$data = $this->where(array(
					'member_id'=>array('eq',$memberId)
				))->select();
		else
		{
			$_data = isset($_COOKIE['cart']) ? unserialize($_COOKIE['cart']):array();
			$data = array();
			foreach ($_data as $k => $v)
			{
				$_k = explode('-',$k);
				$data[] = array(
					'goods_id' => $_k[0],
					'goods_attr_id' => $_k[1],
					'goods_number' => $v,
					);
			}
		}

		$gModel = D('Admin/Goods');
		$gaModel = D('goods_attr');
		foreach ($data as $k => &$v)
		{
			$info = $gModel->field('goods_name,mid_logo')->find($v['goods_id']);
			$v['goods_name'] = $info['goods_name'];
			$v['mid_logo'] = $info['mid_logo'];
			$v['price'] = $gModel->getMemberPrice($v['goods_id']);
			if($v['goods_attr_id'])
				$v['gaData'] = $gaModel->alias('a')
									   ->field('a.attr_value,b.attr_name')
									   ->join('__ATTRIBUTE__ b ON a.attr_id=b.id')
									   ->where(array(
									   		'a.id'=>array('in',$v['goods_attr_id'])
									   	))->select();

		}
	
		return $data;
	}

	// 清空购物车
	public function clear()
	{
		$this->where(array(
			'member_id' => array('eq', session('m_id')),
		))->delete();
	}


}

