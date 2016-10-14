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


	protected function _before_insert(&$date,$option){
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

   			 	 echo "<pre>";
			var_dump($info); die;
				 echo "</pre>";
      		  
    }


		}
	
		//var_dump($option); die;
		//获取当前时间
		//$date['addtime']=date('Y-m-d H:i:s',time());
		
		$date['goods_desc'] = removeXSS($_POST['goods_desc']);
	}


}

