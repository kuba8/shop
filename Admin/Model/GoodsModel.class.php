<?
namespace Admin\Model;
use Think\Model;
class GoodsModel extends Model
{
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
   			 	 //echo "<pre>";
			//var_dump($data); die;
				// echo "</pre>";
      		  
    }


		}
	
		//var_dump($option); die;
		//获取当前时间
		$data['addtime']=date('Y-m-d H:i:s',time());
		
		$data['goods_desc'] = removeXSS($_POST['goods_desc']);
	}


}

