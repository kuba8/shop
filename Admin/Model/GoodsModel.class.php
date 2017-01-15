<?
namespace Admin\Model;
use Think\Model;
class GoodsModel extends Model
{
  protected $insertFields='goods_name,market_price,shop_price,is_on_sale,goods_desc,brand_id,cat_id,type_id,promote_price,promote_start_date,promote_end_date,is_new,is_best,is_hot,sort_num,is_floor';
	protected $updateFields='id,goods_name,market_price,shop_price,is_on_sale,goods_desc,brand_id,cat_id,type_id,promote_price,promote_start_date,promote_end_date,is_new,is_best,is_hot,sort_num,is_floor';


  //定义验证规则
	protected $_validate = array(
		array('goods_name','require','商品名称不能为空!',1),
		array('market_price','currency','市场价格必须是货币类型!',1),
		array('shop_price','currency','本店价格必须是货币类型!',1),
		);


	protected function _before_insert(&$data,$option){
		// echo "<pre>";
		//var_dump($_FILES); die;
		// echo "</pre>";
		
		

		  if($_FILES['logo']['error'] == 0)
    {
      $ret = uploadOne('logo', 'Goods', array(
        array(700, 700),
        array(350, 350),
        array(130, 130),
        array(50, 50),
      ));
      $data['logo'] = $ret['images'][0];
      $data['mbig_logo'] = $ret['images'][1];
      $data['big_logo'] = $ret['images'][2];
      $data['mid_logo'] = $ret['images'][3];
      $data['sm_logo'] = $ret['images'][4];
  }


		
	
		//var_dump($option); die;
		//获取当前时间
		$data['addtime']=date('Y-m-d H:i:s',time());
		
		$data['goods_desc'] = removeXSS($_POST['goods_desc']);
	}

  protected function _before_update(&$data,$option){

    //$id=I('get.id');
    $id=$option['where']['id'];
    //修改商品属性
    $gaid=I('post.goods_attr_id');
    $attrValue=I('post.attr_value');
    $gaModel=D('goods_attr');
    $_i=0;
    foreach ($attrValue as $k => $v) {
      foreach ($v as $k1 => $v1) {
        if($gaid[$_i]=='')
          $gaModel->add(array(
            'goods_id'=>$id,
            'attr_id'=>$k,
            'attr_value'=>$v1,
            ));
        else
          $gaModel->where(array(
            'id'=>array('eq',$gaid[$_i]),
            ))->setField('attr_value',$v1);
        $_i++;
      }
    }

    //处理扩展分类
    $ecid=I('post.ext_cat_id');
    $gcModel=D('goods_cat');
    $gcModel->where(array(
      'goods_id'=>array('eq',$id),
      ))->delete();
    if($ecid)
    {
      foreach ($ecid as $k => $v) {
       if(empty($v))
        continue;
        $gcModel->add(array(
          'cat_id'=>$v,
          'goods_id'=>$id,
          ));
      }
    }
    //处理图片
    if(isset($_FILES['pic'])){
        $pics=array();
        foreach ($_FILES['pic']['name'] as $k => $v) {
         $pics[]=array(
          'name'=>$v,
          'type'=>$_FILES['pic']['type'][$k],
          'tmp_name'=>$_FILES['pic']['tmp_name'][$k],
          'error'=>$_FILES['pic']['error'][$k],
          'size'=>$_FILES['pic']['size'][$k],
          );
       }
       $_FILES=$pics;
       $gpModel = D('goods_pic');

       // 循环每个上传
      foreach ($pics as $k => $v)
      {
        if($v['error'] == 0)
        {
          $ret = uploadOne($k, 'Goods', array(
            array(650, 650),
            array(350, 350),
            array(50, 50),
          ));
          if($ret['ok'] == 1)
          {
            $gpModel->add(array(
              'pic' => $ret['images'][0],
              'big_pic' => $ret['images'][1],
              'mid_pic' => $ret['images'][2],
              'sm_pic' => $ret['images'][3],
              'goods_id' => $id,
            ));
          }
        }
      }

    }


    //处理会员价格
    $mp=I('post.member_price');
    $mpModel=D('member_price');
    $mpModel->where(array(
      'goods_id'=>array('eq','$id'),
      ))->delete();
    foreach ($mp as $k => $v) {

      $_v=(float)$v;
      if($_v>0)
      {
      $mpModel->add(array(
        'price'=>$v,
        'level_id'=>$k,
        'goods_id'=>$id,
        ));
    }
  }



    if($_FILES['logo']['error']==0){

       $upload = new \Think\Upload();// 实例化上传类
         $upload->maxSize   =     1024*1024 ;// 设置附件上传大小
         $upload->exts      =     array('jpg', 'gif', 'png', 'jpeg');// 设置附件上传类型
          $upload->rootPath  =     './Public/Uploads/'; // 设置附件上传根目录
          $upload->savePath  =     'Goods/'; // 设置附件上传（子）目录
    // 上传文件 
          $info   =   $upload->upload();

          if(!$info) {// 上传错误提示错误信息
             $this->error=$upload->getError();
             return FALSE;
         }else{// 上传成功
            
            $logo = $info['logo']['savepath'] . $info['logo']['savename'] ;
            $mbiglogo = $info['logo']['savepath'] . 'mbig_' .$info['logo']['savename'] ;
            $biglogo = $info['logo']['savepath'] . 'big_' .$info['logo']['savename'] ;
            $midlogo = $info['logo']['savepath'] . 'mid_' .$info['logo']['savename'] ;
            $smlogo = $info['logo']['savepath'] . 'sm_' .$info['logo']['savename'] ;
            $image = new \Think\Image(); 
            $image->open('./Public/Uploads/' . $logo);
            $image->thumb(700, 700)->save('./Public/Uploads/' . $mbiglogo);
            $image->thumb(350, 350)->save('./Public/Uploads/' . $biglogo);
            $image->thumb(130, 130)->save('./Public/Uploads/' . $midlogo);
            $image->thumb(50, 50)->save('./Public/Uploads/' . $smlogo);

            $data['logo']=$logo;
            $data['mbig_logo']=$mbiglogo;
            $data['big_logo']=$biglogo;
            $data['mid_logo']=$midlogo;
            $data['sm_logo']=$smlogo;

            $oldLogo=$this->field('logo,mbig_logo,big_logo,mid_logo,sm_logo')->find($id);
            deleteImage($oldLogo);
           //echo "<pre>";
      //var_dump($data); die;
        // echo "</pre>";
            
    }


    }
  
    //var_dump($option); die;
    //获取当前时间
    //$data['addtime']=date('Y-m-d H:i:s',time());
    
    $data['goods_desc'] = removeXSS($_POST['goods_desc']);
  }


protected function _before_delete($option){
 $id=$option['where']['id'];

 $gnModel=D('goods_number');
 $gnModel->where(array(
    'goods_id'=>array('eq',$id),
  ))->delete();

 $gaModel=D('goods_attr');
 $gaModel->where(array(
  'goods_id'=>array('eq',$id),
  ))->delete();

 $oldLogo=$this->field('logo,mbig_logo,big_logo,mid_logo,sm_logo')->find($id);
deleteImage($oldLogo);
  //删除扩展分类
  $gcModel=D('goods_cat');
  $gcModel->where(array(
    'goods_id'=>array('eq',$id),
    ))->delete();

//删除会员价格
  $mpModel=D('member_price');
  $mpModel->where(array(
    'goods_id'=>array('eq',$id),))->delete();
  //删除相册中的图片
  $gpModel=D('goods_pic');
  $pics=$gpModel->field('pic,sm_pic,mid_pic,big_pic')->where(array(
    'goods_id'=>array('eq',$id),
    ))->select();
  foreach ($pics as $k => $v) {
    deleteImage($v);
    $gpModel->where(array(
      'goods_id'=>array('eq',$id),
      ))->delete();
  }

}

protected function _after_insert(&$data,$option){

    $attrValue=I('post.attr_value');
    $gaModel=D('goods_attr');
    foreach ($attrValue as $k => $v) {
      $v=array_unique($v);
      foreach ($v as $k1 => $v1) {
        $gaModel->add(array(
          'goods_id'=>$data['id'],
          'attr_id'=>$k,
          'attr_value'=>$v1,
          ));
      }
    }

    $ecid=I('post.ext_cat_id');
    if($ecid)
    {
      $gcModel=D('goods_cat');
      foreach ($ecid as $k => $v) {
       if(empty($v))
        continue;
        $gcModel->add(array(
          'cat_id'=>$v,
          'goods_id'=>$data['id'],
          ));
      }
    }

    if(isset($_FILES['pic'])){
        $pics=array();
        foreach ($_FILES['pic']['name'] as $k => $v) {
         $pics[]=array(
          'name'=>$v,
          'type'=>$_FILES['pic']['type'][$k],
          'tmp_name'=>$_FILES['pic']['tmp_name'][$k],
          'error'=>$_FILES['pic']['error'][$k],
          'size'=>$_FILES['pic']['size'][$k],
          );
       }
       $_FILES=$pics;
       $gpModel = D('goods_pic');

       // 循环每个上传
      foreach ($pics as $k => $v)
      {
        if($v['error'] == 0)
        {
          $ret = uploadOne($k, 'Goods', array(
            array(650, 650),
            array(350, 350),
            array(50, 50),
          ));
          if($ret['ok'] == 1)
          {
            $gpModel->add(array(
              'pic' => $ret['images'][0],
              'big_pic' => $ret['images'][1],
              'mid_pic' => $ret['images'][2],
              'sm_pic' => $ret['images'][3],
              'goods_id' => $data['id'],
            ));
          }
        }
      }



    }

    $mp=I('post.member_price');
    $mpModel=D('member_price');
    foreach ($mp as $k => $v) {

      $_v=(float)$v;
      if($_v>0)
      {
      $mpModel->add(array(
        'price'=>$v,
        'level_id'=>$k,
        'goods_id'=>$data['id'],
        ));
    }
  }
}

  public function getGoodsIdByCatId($catId)
  {
    $catModel=D('category');
    $children=$catModel->getChildren($catId);
    $children[]=$catId;
    $gids=$this->field('id')->where(array(
      'cat_id'=>array('IN',$children),
      ))->select();

    $gcModel=D('goods_cat');
    $gids1=$gcModel->field('DISTINCT goods_id id')->where(array(
      'cat_id'=>array('IN',$children),
      ))->select();
 
    if($gids&&$gids1)
      $gids=array_merge($gids,$gids1);
    elseif($gids1)
      $gids=$gids1;

    $id=array();
    foreach ($gids as $k => $v) {
      if(!in_array($v['id'],$id))
        $id[]=$v['id'];
    }

    return $id;

  }

  public function search($perpage=2){

   /********************搜索*****************/
    $where=array();
    $gn=I('get.gn');
    if($gn)
      $where['a.goods_name']=array('like',"%$gn%");

    $fp=I('get.fp');
    $tp=I('get.tp');
    if($fp && $tp)
      $where['shop_price']=array('between',array($fp,$tp));
    elseif ($fp)
      $where['shop_price']=array('egt',$fp);
    elseif ($tp)
      $where['shop_price']=array('elt',$tp);

    $ios=I('get.ios');
    if($ios)
      $where['a.is_on_sale']=array('eq',$ios);

    $fa=I('get.fa');
    $ta=I('get.ta');
    if($fa && $ta)
      $where['a.addtime']=array('between',array($fa,$ta));
    elseif ($fa)
      $where['a.addtime']=array('egt',$fa);
    elseif ($ta)
      $where['a.addtime']=array('elt',$ta);
    //品牌
    $brandId=I('get.brand_id');
    if($brandId)
      $where['a.brand_id']=array('eq',$brandId);

    $catId=I('get.cat_id');
    if($catId)
    {
     $gids=$this->getGoodsIdByCatId($catId);
     //var_dump($gids); die;
      $where['a.id']=array('IN',$gids);
    }


    /********************排序*****************/
    $orderby='a.id';
    $orderway='desc';
    $odby=I('get.odby');
    if($odby){
      if($odby=='id_asc')
        $orderway='asc';
      elseif($odby=='price_desc')
        $orderby='shop_price';
       elseif($odby=='price_asc'){
        $orderby='shop_price';
        $orderway='asc';}
    }


    /********************翻页*****************/
    $count=$this->alias('a')->where($where)->count();
    $PageObj= new \Think\Page($count,$perpage);

    $PageObj->setConfig('next','下一页');
    $PageObj->setConfig('prev','上一页');

    $Pagestring = $PageObj->show();

    //取某一页数据
    $data = $this->alias('a')->order("$orderby $orderway")
    ->field('a.*,b.brand_name,c.cat_name,GROUP_CONCAT(e.cat_name SEPARATOR "<br />") ext_cat_name')
    ->join('LEFT JOIN __BRAND__ b ON a.brand_id=b.id')
    ->join('LEFT JOIN __CATEGORY__ c ON a.cat_id=c.id')
    ->join('LEFT JOIN __GOODS_CAT__ d ON a.id=d.goods_id')
    ->join('LEFT JOIN __CATEGORY__ e ON d.cat_id=e.id')
    ->where($where)
    ->limit($PageObj->firstRow.','.$PageObj->listRows)
    ->group('a.id')
    ->select();

    //返回数据
    return array(
      'data'=>$data,
      'page'=>$Pagestring,
    );

  }

  public function getPromoteGoods($limit = 5)
  {
    $today = date('Y-m-d H:i');
    return $this->field('id,goods_name,mid_logo,promote_price')
    ->where(array(
      'is_on_sale'=>array('eq','是'),
      'promote_price'=>array('gt',0),
      'promote_start_date'=>array('elt',$today),
      'promote_end_date'=>array('egt',$today),
      ))
    ->limit($limit)
    ->order('sort_num ASC')
    ->select();
  }

  public function getRecGoods($recType,$limit = 5)
  {
    return $this->field('id,goods_name,mid_logo,promote_price,shop_price')
    ->where(array(
      'is_on_sale'=>array('eq','是'),
      //'$recType'=>array('eq','是'),  用单引号就出错，单引号内部变量不会执行
      "$recType"=>array('eq','是'),
      ))
    ->limit($limit)
    ->order('sort_num ASC')
    ->select();
  }

}

