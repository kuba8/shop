<?php
namespace Admin\Model;
use Think\Model;
class MemberModel extends Model 
{
	protected $insertFields = array('username','password','cpassword','chkcode','must_click');
	protected $updateFields = array('id','username','password','cpassword');
	protected $_validate = array(
		array('must_click', 'require', '必须同意注册协议！', 1, 'regex', 3),
		array('username', 'require', '用户名不能为空！', 1, 'regex', 3),
		array('username', '1,30', '用户名的值最长不能超过 30 个字符！', 1, 'length', 3),
		array('password', 'require', '密码不能为空！', 1, 'regex', 1),
		array('password', '6,20', '密码的值最长不能超过 6-20 个字符！', 1, 'length', 3),
		array('password', 'cpassword', '两次密码输入不一致！', 1, 'confirm', 3),
		array('username', '', '用户名已存在！', 1, 'unique', 3),
		array('chkcode', 'require', '验证码不能为空！', 1, 'regex', 1),
		array('chkcode', 'check_verify', '验证码不正确！', 1, 'callback'),

	);

	public $_login_validate = array(
		array('username', 'require', '用户名不能为空！', 1),
		array('password', 'require', '密码不能为空！', 1),
		array('chkcode', 'require', '验证码不能为空！', 1),
		array('chkcode', 'check_verify', '验证错误！', 1, 'callback'),
	);

	public function login()
	{
		$username=$this->username;
		$password=$this->password;
		$user=$this->where(array(
			'username'=>array('eq',$username),
			))->find();
		if(user)
		{
			if($user['password']==md5($password))
			{
				//登录成功存session
				session('m_id',$user['id']);
				session('m_username',$user['username']);
				//计算当前会员级别ID并存session
				$mlModel = D('member_level');
				$levelId = $mlModel->field('id')->where(array(
						'jifen_bottom'=>array('elt',$user['jifen']),
						'jifen_top'=>array('egt',$user['jifen']),
					))->find();
				session('level_id',$levelId['id']);
				return TRUE;
			}
			else
			{
				$this->error='密码不正确';
				return FALSE;
			}
		}
	else
			{
				$this->error='用户名不存在';
				return FALSE;
			}	
	}

	public function logout()
	{
		session(null);
	}

	function check_verify($code, $id = '')
	{
    	$verify = new \Think\Verify();
    	return $verify->check($code, $id);
	}

	
	// 添加前
	protected function _before_insert(&$data, $option)
	{
		$data['password']=md5($data['password']);
	}
	
	

	/************************************ 其他方法 ********************************************/
}