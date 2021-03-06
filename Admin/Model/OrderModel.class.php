<?php
namespace Admin\Model;
use Think\Model;
class OrderModel extends Model 
{
	//下单时允许表单的字段
	protected $insertFields = array('shr_name','shr_tel','shr_province','shr_city','shr_area','shr_address');
	//下单时的表单验证规则
	protected $_validate = array(
		array('shr_name', 'require', '收货人姓名不能为空！', 1, 'regex', 3),
		array('shr_tel', 'require', '收货人电话不能为空！', 1, 'regex', 3),
		array('shr_province', 'require', '所在省不能为空！', 1, 'regex', 3),
		array('shr_city', 'require', '所在城市不能为空！', 1, 'regex', 3),
		array('shr_area', 'require', '所在地区不能为空！', 1, 'regex', 3),
		array('shr_address', 'require', '详细地址不能为空！', 1, 'regex', 3),
	);

		public function search($pageSize = 20)
	{
		/*************************** 搜索 ***********************/
		$memberId = session('m_id');
		$where['member_id'] = array('eq',$memberId);
		$noPayCount = $this->where(array(
				'member_id' => array('eq',$memberId),
				'pay_status' => array('eq','否'),
			))->count();

		//echo $this->getLastSql();die;
		/************************ 翻页 ***************************/
		$count = $this->alias('a')->where($where)->count();
		$page = new \Think\Page($count, $pageSize);
		// 配置翻页的样式
		$page->setConfig('prev', '上一页');
		$page->setConfig('next', '下一页');
		$data['page'] = $page->show();
		/*********************** 取数据 ***************************/
		$data['data'] = $this->alias('a')
		->field('a.id,a.shr_name,a.total_price,a.addtime,a.pay_status,GROUP_CONCAT(DISTINCT c.sm_logo) logo')
		->join('LEFT JOIN __ORDER_GOODS__ b ON a.id=b.order_id
				LEFT JOIN __GOODS__ c ON b.goods_id=c.id')	
		->where($where)
		->group('a.id')
		->limit($page->firstRow.','.$page->listRows)
		->select();
		//echo $this->getLastSql();
		$data['noPayCount'] = $noPayCount;
		return $data;
	}

	// 添加前
	protected function _before_insert(&$data, &$option)
	{
		$memberId = session('m_id');
		if(!$memberId)
		{
			$this->error = '必须先登录!' ;
			return FALSE;
		}
		//购物车中是否有商品
		$cartModel = D('Cart');
		$option['goods'] = $goods = $cartModel->cartList();
		if(!$goods)
		{
			$this->error = '购物车中没有商品，无法下单!' ;
			return FALSE;
		}
		//$this->fp = fopen('./order.lock');
		//flock($this->fp, LOCK_EX);


		//循环购物车中的商品检查库存量并且计算商品总价
		$gnModel = D('goods_number');
		$total_price = 0;
		foreach ($goods as $k => $v)
		{
			$gnNumber = $gnModel->field('goods_number')->where(array(
					'goods_id' => $v['goods_id'],
					'goods_attr_id' => $v['goods_attr_id'],
				))->find();
			if($gnNumber['goods_number'] < $v['goods_number'])
			{
				$this->error = '下单失败，原因：商品：<strong>'.$v['goods_name'].'</strong>库存量不足!' ;
				return FALSE;
			}
			$total_price += $v['price'] * $v['goods_number'];
		}
		//把其他信息补到订单中
		$data['total_price'] = $total_price;
		$data['member_Id'] = $memberId;
		$data['addtime'] = time();
		//开启事务
		$this->startTrans();
	}
	//添加后
	protected function _after_insert($data, $option)
	{
		$ogModel = D('order_goods');
		$gnModel = D('goods_number');
		foreach ($option['goods'] as $k => $v) {
			$ret = $ogModel->add(array(
				'order_id' => $data['id'],
				'goods_id' => $v['goods_id'],
				'goods_attr_id' => $v['goods_attr_id'],
				'goods_number' => $v['goods_number'],
				'peice' => $v['price'],
				));
			if(!$ret)
			{
				$this->rollback();
				return FALSE;
			}
			//减库存
			$ret = $gnModel->where(array(
					'goods_id'=>$v['goods_id'],
					'goods_attr_id'=>$v['goods_attr_id'],
				))->setDec('goods_number',$v['goods_number']);
			if(FALSE === $ret)
			{
				$this->rollback();
				return FALSE;
			}
		}

		$this->commit();

		//flock($this->fp, LOCK_UN);
		//fclose($this->fp);

		// 清空购物车
		$cartModel = D('Cart');
		$cartModel->clear();
	}

}