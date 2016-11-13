<?php
namespace Admin\Controller;
use Think\Controller;
class GoodsController extends Controller {

      public function ajaxDelPic()
      {
        $picId=I('get.picid');
        $gpModel=D('goods_pic');
        $pic=$gpModel->field('pic,sm_pic,mid_pic,big_pic')->find($picId);
        deleteImage($pic);
        $gpModel->delete($picId);
      }



   	    public function add()
    {
       if(IS_POST){
       
         //var_dump($_FILES);die;
        $model=D('goods');
       if($model->create(I('post.'),1))
       {
        if($model->add())
        {
          $this->success('操作成功!',U('lst'));
          exit;
        }
       }
       //假如失败
        $error=$model->getError();
        $this->error($error);
       }

       //取出所有品牌
       $brandModel = D('brand');
       $brandData = $brandModel->select();

       //取出所有的会员级别
       $mlModel=D('member_level');
       $mlData=$mlModel->select();

        $this->assign(array(
        'mlData'=>$mlData,
        'brandData'=>$brandData,
        '_page_title'=>'添加新商品',
        '_page_btn_name'=>'商品列表',
        '_page_btn_link'=>U('lst'),
        ));

       $this->display();
	  }

    public function edit()
    {
     
    $id=I('get.id');
    $model=D('goods');
       if(IS_POST){
       if($model->create(I('post.'),2))
       {
        if(FALSE!==$model->save())
        {
          $this->success('操作成功!',U('lst'));
          exit;
        }
       }
       //假如失败
        $error=$model->getError();
        $this->error($error);
       }
       $data=$model->find($id);
       $this->assign('data',$data);
       //取出所有品牌
       $brandModel = D('brand');
       $brandData = $brandModel->select();
        //取出所有的会员级别
       $mlModel=D('member_level');
       $mlData=$mlModel->select();
        //取出设置好的会员价格
       $mpModel=D('member_price');
       $mpData=$mpModel->where(array(
        'goods_id'=>array('eq',$id),
        ))->select();
       //把二维数组转成一维数组: level_id=>price
       $_mpData=array();
       foreach ($mpData as $k => $v) {
         $_mpData[$v['level_id']]=$v['price'];
       }
       //取出相册中的图片
       $gpModel=D('goods_pic');
       $gpData=$gpModel->field('id,mid_pic')->where(array(
        'goods_id'=>array('eq',$id),
        ))->select();
       //var_dump($mpData);
       //var_dump($_mpData);
       $this->assign(array(
        'mlData'=>$mlData,
        'mpData'=>$_mpData,
        'gpData'=>$gpData,
        'brandData'=>$brandData,
        '_page_title'=>'修改商品',
        '_page_btn_name'=>'商品列表',
        '_page_btn_link'=>U('lst'),
        ));
       $this->display();
    }

    public function delete()
    {
     
    $id=I('get.id');
    $model=D('goods');
    if(FALSE!==$model->delete($id))
      $this->success('删除成功',U('lst'));
    else 
      $this->error('删除失败的原因：',$model->getError);

}
    //商品列表页
    public function lst()
    {
      $model=D('goods');
      $data=$model->search();
      //$this->assign($data);

      $this->assign('data', $data['data']);
      $this->assign('page', $data['page']);
      $this->assign(array(
        '_page_title'=>'商品列表',
        '_page_btn_name'=>'添加新商品',
        '_page_btn_link'=>U('add'),
        ));
      $this->display();

    }
	  
}