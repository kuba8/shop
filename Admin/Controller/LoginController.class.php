<?php
namespace Admin\Controller;
use Think\Controller;
class LoginController extends Controller 
{
   public function chkcode(){
    $Verify = new \Think\Verify(array(
        'fontSize' => 30,
        'length' => 2,
        'useNoise' => TRUE,
        ));
    $Verify->entry();
   }

   public function login(){
		$this->display();
   }
}
