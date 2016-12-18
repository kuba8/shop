<?php
namespace Admin\Controller;
use Think\Controller;
class BaseController extends Controller 
{
    public function __construct()
    {
        parent::__construct();
        if(!session('id'))
            $this->error('必须先登录!',U('Login/login'));
        if(CONTROLLER_NAME=='Index')
        	return TRUE;
        $priModel = D('Privilege');
        if(!$priModel->chkPri())
        	$this->error('无权访问!');
    }
}