<?php
namespace Admin\Controller;
use Think\Controller;
class GoodsController extends Controller {
   	    public function add()
    {
       if(IS_POST){
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
      $this->display();

    }
	  
}