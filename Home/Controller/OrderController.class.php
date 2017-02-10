<?php
namespace Home\Controller;
use Think\Controller;
class OrderController extends Controller {

    public function add()
    {
        $memberId = session('m_id');
        if(!$memberId)
        {
            session('returnUrl',U('Order/add'));
            redirect(U('Member/login'));
        }
        if(IS_POST)
        {
            //die;
           // var_dump($_POST);die;
            $OrderModel = D('Admin/Order');
            if($OrderModel->create(I('post.'),1))
            {
                if($orderId = $OrderModel->add())
                {
                    $this->success('下单成功',U('order_success?order_id='.$orderId));
                    exit;
                }
            }
            $this->error('添加失败，原因：'.$OrderModel->getError());
        }

            // 先取出购物车中所有的商品
        $cartModel = D('Cart');
        $data = $cartModel->cartList();

            $this->assign(array(
            'data' => $data,
            '_page_title' => '定单确认页',
            '_page_keywords' => '定单确认页',
            '_page_description' => '定单确认页',
            ));
        $this->display();
    }

    public function order_success()
    {
        //$btn = makeAlipayBtn(I('get.order_id'));
        // 设置页面信息
        $this->assign(array(
            'btn' => $btn,
            '_page_title' => '下单成功',
            '_page_keywords' => '下单成功',
            '_page_description' => '下单成功',
        ));
        $this->display();
    }

}