<?php
namespace Admin\Controller;
use Think\Controller;
class CategoryController extends BaseController 
{
  
    public function lst()
    {
    	$model = D('Category');
    	$data = $model->getTree();
    
		// 设置页面中的信息
		$this->assign(array(
            'data' => $data,
			'_page_title' => '分类列表',
			'_page_btn_name' => '添加新分类',
			'_page_btn_link' => U('add'),
		));
    	$this->display();
    }


     public function add()
    {
        $model = D('Category');
        if(IS_POST)
        {
            
            if($model->create(I('post.'), 1))
            {
                if($id = $model->add())
                {
                    $this->success('添加成功！', U('lst?p='.I('get.p')));
                    exit;
                }
            }
            $this->error($model->getError());
        }
            $catData=$model->getTree();

        // 设置页面中的信息
        $this->assign(array(
            'catData' => $catData,
            '_page_title' => '添加分类',
            '_page_btn_name' => '分类列表',
            '_page_btn_link' => U('lst'),
        ));
        $this->display();
    }

    public function delete()
    {
     
    $id=I('get.id');
    $model=D('Category');
    if(FALSE!==$model->delete($id))
      $this->success('删除成功',U('lst'));
    else 
      $this->error('删除失败的原因：',$model->getError());

}

   public function edit()
    {
        $id = I('get.id');
        $model = D('Category');
        if(IS_POST)
        {
            if($model->create(I('post.'), 2))
            {
                if($model->save() !== FALSE)
                {
                    $this->success('修改成功！', U('lst', array('p' => I('get.p', 1))));
                    exit;
                }
            }
            $this->error($model->getError());
        }
        $data = $model->find($id);
        $catData=$model->getTree();
        $children=$model->getChildren($id);
        $this->assign('data', $data);

        // 设置页面中的信息
        $this->assign(array(
            'catData' => $catData,
            'children' => $children,
            '_page_title' => '修改分类',
            '_page_btn_name' => '分类列表',
            '_page_btn_link' => U('lst'),
        ));
        $this->display();
    }


}