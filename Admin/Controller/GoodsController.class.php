<?php
namespace Admin\Controller;
use Think\Controller;
class GoodsController extends Controller {

      public function ajaxDelAttr()
      {
        $goodsId=addslashes(I('get.goods_id'));
        $gaid=addslashes(I('get.gaid'));
        $gaModel=D('goods_attr');
        $gaModel->delete($gaid);
        //删除相关库存量数据
        //$gnModel=D('goods_number');
        //$gnModel->where(array(
           // 'goods_id'=>array('EXP',"=$goodsId AND FIND_IN_SET($gaid,attr_list)"),
        // ))->delete();
      }

      public function ajaxGetAttr()
      {
        $typeId=I('get.type_id');
        $attrModel=D('Attribute');
        $attrData=$attrModel->where(array(
          'type_id'=>array('eq',$typeId),
          ))->select();
        echo json_encode($attrData);
      }

      public function ajaxDelPic()
      {
        $picId=I('get.picid');
        $gpModel=D('goods_pic');
        $pic=$gpModel->field('pic,sm_pic,mid_pic,big_pic')->find($picId);
        deleteImage($pic);
        $gpModel->delete($picId);
      }

      public function goods_number()
      {
        header('Content-Type:text/html;charset=utf8');
        $id =I('get.id');
        $gnModel=D('goods_number');
        if(IS_POST)
        {
          //var_dump($_POST);die;
          $gaid=I('post.goods_attr_id');
          $gn=I('post.goods_number');
          $gaidCount=count($gaid);
          $gnCount=count($gn);
          $rate=$gaidCount/$gnCount;
          $_i=0;
          foreach ($gn as $k => $v) {
            $_goodsAttrId=array();
            for($i=0;$i<$rate;$i++)
            {
              $_goodsAttrId[]=$gaid[$_i];
              $_i++;
            }
            sort($_goodsAttrId,SORT_NUMERIC);
            $_goodsAttrId=(string)implode(',',$_goodsAttrId);
            $gnModel->add(array(
              'goods_id'=>$id,
              'goods_attr_id'=>$_goodsAttrId,
              'goods_number'=>$v,
              ));
          }
        }
        $gaModel=D('goods_attr');
        $gaData=$gaModel->alias('a')
        ->field('a.*,b.attr_name')
        ->join('LEFT JOIN __ATTRIBUTE__ b ON a.attr_id=b.id')
        ->where(array(
          'a.goods_id'=>array('eq',$id),
          'b.attr_type'=>array('eq','可选'),
          ))->select();

        $_gaData=array();
        foreach ($gaData as $k => $v) 
        {
          $_gaData[$v['attr_name']][]=$v;
        }
        //取出这件商品已经设置过的库存量
        $gnData=$gnModel->where(array(
          'goods_id'=>$id,
          ))->select();
        var_dump($gnData);

        $this->assign(array(
        'gnData'=>$gnData,
        'gaData'=>$_gaData,
        '_page_title'=>'库存量',
        '_page_btn_name'=>'返回列表',
        '_page_btn_link'=>U('lst'),
        ));

       $this->display();
      }


   	    public function add()
    {
      $model = D('Category');
       if(IS_POST){
       
        // var_dump($_POST);die;
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
      $catData=$model->getTree();
        $this->assign(array(
        'catData'=>$catData,
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
       $model = D('Category');
       $catData=$model->getTree();
       //取出扩展分类ID
       $gcModel=D('goods_cat');
       $gcData=$gcModel->field('cat_id')->where(array(
        'goods_id'=>array('eq',$id),
        ))->select();
       //取出当前类型下所有的属性
       $attrModel=D('Attribute');
       $attrData=$attrModel->alias('a')
       ->field('a.id attr_id,a.attr_name,a.attr_type,a.attr_option_values,b.attr_value,b.id')
       ->join('LEFT JOIN __GOODS_ATTR__ b ON (a.id=b.attr_id AND b.goods_id='.$id.')')
       ->where(array(
        'a.type_id'=>array('eq',$data[type_id]),
        ))->select();

       //var_dump($attrData);

       $this->assign(array(
        'gaData'=>$attrData,
        'gcData'=>$gcData,
        'catData'=>$catData,
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
      $catModel=D('Category');
      $catData=$catModel->getTree();
      //$this->assign($data);

      $this->assign('data', $data['data']);
      $this->assign('page', $data['page']);
      $this->assign(array(
        'catData'=>$catData,
        '_page_title'=>'商品列表',
        '_page_btn_name'=>'添加新商品',
        '_page_btn_link'=>U('add'),
        ));
      $this->display();

    }
	  
}