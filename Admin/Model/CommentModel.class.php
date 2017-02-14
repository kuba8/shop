<?php
namespace Admin\Model;
use Think\Model;
class CommentModel extends Model 
{
	protected $insertFields = array('star','content','goods_id');
	protected $_validate = array(
		array('goods_id', 'require', '参数错误!', 1),
		array('star', '1,2,3,4,5', '分值只能是1-5之间的数字!', 1, 'in'),
		array('content', '1,200', '内容必须是1-200个字符!', 1, 'length'),
	);

	public function search($goodsId,$pageSize=5)
	{
		$where['a.goods_id'] = array('eq',$goodsId);
		//取出总的记录数
		$count = $this->alias('a')->where($where)->count();
		//计算总的页数
		$pageCount = ceil($count/$pageSize);
		//获取当前页
		$currentPage = max(1,(int)I('get.p',1));
		//计算limit上的第一个参数：偏移量
		$offset = ($currentPage-1)*$pageSize;
		//取数据
		$data = $this->alias('a')
		->field('a.content,a.addtime,a.star,a.click_count,b.face,b.username,COUNT(c.id) reply_count')
		->join('LEFT JOIN __MEMBER__ b ON a.member_id=b.id
				LEFT JOIN __COMMENT_REPLY__ c ON a.id=c.comment_id')
		->where($where)
		->order('a.id DESC')
		->limit("$offset,$pageSize")
		->group('a.id')
		->select();

		return array(
			'data' => $data,
			'pageCount'=> $pageCount,
			);
	}

	// 添加前
	protected function _before_insert(&$data, $option)
	{
		$memberId = session('m_id');
		if(!$memberId)
		{
			$this->error = '必须先登录!';
			return FALSE;
		}
			$data['member_id'] = $memberId;
			$data['addtime'] = date('Y-m-d H:i:s');
	}

}