<?php if (!defined('THINK_PATH')) exit();?><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>ECSHOP 管理中心 - 商品列表 </title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="/shop/Public/Admin/Styles/general.css" rel="stylesheet" type="text/css" />
<link href="/shop/Public/Admin/Styles/main.css" rel="stylesheet" type="text/css" />
</head>
<body>
<h1>
    <span class="action-span"><a href="<?php echo $_page_btn_link ;?>"><?php echo $_page_btn_name ;?></a></span>
    <span class="action-span1"><a href="<?php echo U('Index/index');?>">ECSHOP 管理中心</a></span>
    <span id="search_id" class="action-span1"> - <?php echo $_page_title ;?> </span>
    <div style="clear:both"></div>
</h1>


<style type="text/css">
    #ul_pic_list li{margin: 5px;list-style-type: none;}
    #old_pic_list li{float: left;width: 150px;height: 150px;margin: 5px;list-style-type: none;}
    #cat_list {background: #EEE;margin: 0;}
    #cat_list li{margin: 5px;}
</style>
<div class="tab-div">
    <div id="tabbar-div">
        <p>
            <span class="tab-front" id="general-tab">通用信息</span>
            <span class="tab-back" >商品描述</span>
            <span class="tab-back" >会员价格</span>
            <span class="tab-back" >商品属性</span>
            <span class="tab-back" >商品相册</span>
        </p>
    </div>
    <div id="tabbody-div">
        <form enctype="multipart/form-data" action="/shop/index.php/Admin/Goods/edit/id/6.html" method="post">

     <input type="hidden" name="id" value="<?php echo I('get.id');?>" />

            <table width="90%" class="tab_table" align="center">

                <tr>
                <td class="label">主分类：</td>
                <td>
                   <select name="cat_id">
                     <option value="">选择分类</option>
                     <?php foreach($catData as $k => $v) : if($v['id']==$data['cat_id']) $select='selected="selected"'; else $select=''; ?>
                        <option <?php echo $select;?> value="<?php echo $v['id'];?>"><?php echo str_repeat('-',8*$v['level']) . $v['cat_name'];?>
                            
                        </option>
                     <?php endforeach;?>  
                   </select>
                   <span class="require-field">*</span></td>
                
            </tr>
                    
           <tr>
                <td class="label">扩展分类：<input onclick="$('#cat_list').append($('#cat_list').find('li').eq(0).clone());" type="button" id="btn_add_cat" value="添加一个" /></td>
                <td>
                <ul id="cat_list">
                <?php if($gcData):?>
                <?php foreach($gcData as $k1 => $v1):?>
                <li>
                   <select name="ext_cat_id[]">
                     <option value="" >选择分类</option>
                     <?php foreach($catData as $k => $v) : if($v['id']==$v1['cat_id']) $select='selected="selected"'; else $select=''; ?>
                        <option <?php echo $select; ?> value="<?php echo $v['id'];?>"><?php echo str_repeat('-',8*$v['level']) . $v['cat_name'];?>
                            
                        </option>
                     <?php endforeach;?>  
                   </select>
            </li>
         <?php endforeach;?>

     <?php else:?>
           <li>
                   <select name="ext_cat_id[]">
                     <option value="" >选择分类</option>
                     <?php foreach($catData as $k => $v) :?>
                        <option <?php echo $select; ?> value="<?php echo $v['id'];?>"><?php echo str_repeat('-',8*$v['level']) . $v['cat_name'];?>
                            
                        </option>
                     <?php endforeach;?>  
                   </select>
            </li>
     <?php endif;?>
            </ul>
            </td>
            </tr>


                <tr>
                    <td class="label">所在品牌：</td>
                    <td>
                        <?php buildSelect('brand','brand_id','id','brand_name',$data['brand_id']);?>
                    </td>
                </tr>

                <tr>
                    <td class="label">商品名称：</td>
                    <td><input type="text" name="goods_name" value="<?php echo $data['goods_name'];?>"size="30" />
                    <span class="require-field">*</span></td>
                </tr>
                
                 <tr>
                    <td class="label">LOGO</td>
                    <td>
                    <?php showImage($data['mid_logo']); ?>
                    <input type="file" name="logo" size="30" /></td>
        
                </tr>
                
                <tr>
                    <td class="label">市场售价：</td>
                    <td>
                        <input type="text" name="market_price" value="<?php echo $data['market_price'];?>" size="20" />
                        <span class="require-field">*</span>
                    </td>
                </tr>
                <tr>
                    <td class="label">本店售价：</td>
                    <td>
                        <input type="text" name="shop_price" value="<?php echo $data['shop_price'];?>" size="20"/>
                        <span class="require-field">*</span>
                    </td>
                </tr>
               
                <tr>
                    <td class="label">是否上架：</td>
                    <td>
                        <input type="radio" name="is_on_sale" value="是" <?php if($data['is_on_sale'] == '是' ) echo' checked="checked"'?>/> 是
                        <input type="radio" name="is_on_sale" value="否" <?php if($data['is_on_sale'] == '否' ) echo' checked="checked"'?>/> 否
                    </td>
                </tr>
               
            </table>

            <!--商品描述-->
            <table style="display: none;" width="90%" class="tab_table" align="center">
            <tr>
                   <td>
                        <textarea id="goods_desc" name="goods_desc"><?php echo $data['goods_desc'];?> </textarea>
                    </td>
                </tr>
            </table>
            <!--会员价格-->
            <table style="display: none;" width="90%" class="tab_table" align="center">
              <tr>
                   
                    <td>
                        <?php foreach ($mlData as $k=>$v):?>
                        <p>
                        <strong><?php echo $v['level_name'];?> </strong>: 
                        ¥<input value="<?php echo $mpData[$v['id']];?>" type="text"  name="member_price[<?php echo $v['id'];?>]" size="8"/>元
                        </p> 
                        <?php endforeach;?>
                    </td>
                </tr>
            </table>
            <!--商品属性-->
            <table style="display: none;" width="90%" class="tab_table" align="center">
              <tr>
                    <td>
                        商品类型：<?php buildSelect('Type','type_id','id','type_name',$data['type_id']);?>
                    </td>
                </tr>
                <tr>
                    <td>
                        <ul id='attr_list'>
                         <?php
 $attrId=array(); foreach($gaData as $k =>$v): if(in_array($v['attr_id'],$attrId)) $opt='-'; else { $opt='+'; $attrId[]=$v['attr_id']; } ?>                   
                           <li>
                               <input type="hidden" name="goods_attr_id[]" value="<?php echo $v['id'];?>" />
                               <?php if($v['attr_type']=='可选'):?>
                                <a onclick="addNewAttr(this);" href="#">[<?php echo $opt;?>]</a>
                               <?php endif;?>
                               <?php echo $v['attr_name'];?>
                               <?php if($v['attr_option_values']): $attr=explode(',',$v['attr_option_values']); ?>
                                <select name="attr_value[<?php echo $v['attr_id'];?>][]">
                                    <option value="">请选择</option>
                                    <?php foreach ($attr as $k1=>$v1): if($v1==$v['attr_value']) $select='selected="selected"'; else $select=''; ?>
                                    <option <?php echo $select;?> value="<?php echo $v1;?>"> <?php echo $v1;?></option>
                                <?php endforeach;?>
                                </select>
                            <?php else:?>
                                <input type="text" name="attr_value[<?php echo $v['attr_id'];?>][]" value="<?php echo $v['attr_value'];?>" />
                            <?php endif;?>
                                
                           </li>
                         <?php endforeach;?>   

                        </ul>
                    </td>
                </tr>
            </table>
            <!--商品相册-->
            <table style="display: none;" width="90%" class="tab_table" align="center">
            <tr>
                <td>
                    <input id="btn_add_pic" type="button" value="添加一张" />
                    <hr />
                    <ul id="ul_pic_list"></ul>
                    <hr/>
                    <ul id="old_pic_list">
                        <?php foreach($gpData as $k=>$v):?>
                            <li>
                                <input pic_id="<?php echo $v['id'];?>" class="btn_del_pic" type="button" value="删除" /><br />
                                <?php showImage($v['mid_pic'],150)?>
                            </li>
                         <?php endforeach;?>   
                    </ul>
                </td>
            </tr>
            </table>


            <div class="button-div">
                <input type="submit" value=" 确定 " class="button"/>
                <input type="reset" value=" 重置 " class="button" />
            </div>
        </form>
    </div>
</div>


 <link href="/shop/Public/umeditor1_2_2-utf8-php/themes/default/css/umeditor.css" type="text/css" rel="stylesheet">
    <script type="text/javascript" src="/shop/Public/umeditor1_2_2-utf8-php/third-party/jquery.min.js"></script>
    <script type="text/javascript" charset="utf-8" src="/shop/Public/umeditor1_2_2-utf8-php/umeditor.config.js"></script>
    <script type="text/javascript" charset="utf-8" src="/shop/Public/umeditor1_2_2-utf8-php/umeditor.min.js"></script>
    <script type="text/javascript" src="/shop/Public/umeditor1_2_2-utf8-php/lang/zh-cn/zh-cn.js"></script>
    <script type="text/javascript">
        UM.getEditor('goods_desc',{
            initialFrameWidth:"100%" ,
            initialFrameHeight:350 
        });

   $("#tabbar-div p span").click(function(){
        var i=$(this).index();
        $(".tab_table").hide();
        $(".tab_table").eq(i).show();
        $(".tab-front").removeClass("tab-front").addClass("tab-back");
        $(this).removeClass("tab-back").addClass("tab-front");
    });

   // 添加一张
$("#btn_add_pic").click(function(){
    var file = '<li><input type="file" name="pic[]" /></li>';
    $("#ul_pic_list").append(file);
});

// 删除图片
$(".btn_del_pic").click(function(){
    if(confirm('确定要删除吗？'))
    {
        // 先选中删除按钮所在的li标签
        var li = $(this).parent();
        // 从这个按钮上获取pic_id属性
        var pid = $(this).attr("pic_id");
        /**
        php中的大U函数三个参数：
        U('ajaxDelPic')                    ==>   /index.php/Admin/Goods/ajaxDelPic.html
        U('ajaxDelPic?id=1')                  ==>   /index.php/Admin/Goods/ajaxDelPic/id/1.html
        U('ajaxDelPic', array('id'=>1))      ==>   /index.php/Admin/Goods/ajaxDelPic/id/1.html
        U('ajaxDelPic', array('id'=>1), FALSE)      ==>   /index.php/Admin/Goods/ajaxDelPic/id/1
        **/ 
        $.ajax({
            type : "GET",
            url : "<?php echo U('ajaxDelPic', '', FALSE); ?>/picid/"+pid,
            success : function(data)
            {
                // 把图片从页面中删除掉
                li.remove();
            }
        });
    }
});

    $("select[name=type_id]").change(function(){
        var typeId=$(this).val();
        if(typeId>0)
        {
            $.ajax({
                type:"GET",
                url:"<?php echo U('ajaxGetAttr','',FALSE);?>/type_id/"+typeId,
                dataType:"json",
                success:function(data)
                {
                    var li="";
                    $(data).each(function(k,v){
                        li +='<li>';
                        if(v.attr_type=='可选')
                            li+='<a onclick="addNewAttr(this);" href="#">[+]</a>';
                        li+=v.attr_name+'：';
                        if(v.attr_option_values=="")
                            li+='<input type="text" name="attr_value['+v.id+'][]"/>';
                        else
                        {
                            li+='<select name="attr_value['+v.id+'][]"><option value="">请选择...</option>';
                            var _attr=v.attr_option_values.split(',');
                            for(var i=0;i<_attr.length;i++)
                            {
                                li+='<option value="'+_attr[i]+'">';
                                li+=_attr[i];
                                li+='</option>';
                            }
                            li+='</select>';
                        }
                        li+='</li>'
                    });
                    $("#attr_list").html(li);
                }
            });
        }
        else
            $("#attr_list").html("");
        });

        function addNewAttr(a)
        {
            var li = $(a).parent();
            if($(a).text()=='[+]')
            {
                var newLi = li.clone();
                newLi.find("option:selected").removeAttr("selected");
                newLi.find("input[name='goods_attr_id[]']").val("");
                newLi.find("a").text('[-]');
                li.after(newLi);
            }
            else
               {
                var gaid=li.find("input[name='goods_attr_id[]']").val();
                if(gaid=='')
                    li.remove();
                else
                {
                    if(confirm('如果删除了这个属性，那么相关的库存量数据也会被一起删除，确定要删除吗？'))
                    {
                        $.ajax({
                             type:"GET",
                             url:"<?php echo U('ajaxDelAttr?goods_id='.$data['id'],'',FALSE);?>/gaid/"+gaid,
                               success:function(data)

                    {   
                        li.remove();
                    }
                });
                }
               }
        }}
    </script>
    </script>


<div id="footer">
共执行 29 个查询，用时 0.539249 秒，Gzip 已禁用，内存占用 3.502 MB<br />
版权所有 &copy; 2005-2012 上海商派网络科技有限公司，并保留所有权利。</div>
</body>
</html>