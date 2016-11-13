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
    <span class="action-span1"><a href="__GROUP__">ECSHOP 管理中心</a></span>
    <span id="search_id" class="action-span1"> - <?php echo $_page_title ;?> </span>
    <div style="clear:both"></div>
</h1>


<div class="tab-div">
    <div id="tabbar-div">
        <p>
            <span class="tab-front" >通用信息</span>
            <span class="tab-back" >商品描述</span>
            <span class="tab-back" >会员价格</span>
            <span class="tab-back" >商品属性</span>
            <span class="tab-back" >商品相册</span>
        </p>
    </div>
    <div id="tabbody-div">
        <form enctype="multipart/form-data" action="/shop/index.php/Admin/Goods/add.html" method="post">
            <table width="90%" class="tab_table" align="center">

                 <tr>
                    <td class="label">所在品牌：</td>
                    <td>
                  <?php buildSelect('brand','brand_id','id','brand_name');?>
                    </td>
                </tr>

                <tr>
                    <td class="label">商品名称：</td>
                    <td><input type="text" name="goods_name" value=""size="30" />
                    <span class="require-field">*</span></td>
                </tr>
                
                 <tr>
                    <td class="label">LOGO</td>
                    <td><input type="file" name="logo" size="30" /></td>
        
                </tr>
                
                <tr>
                    <td class="label">市场售价：</td>
                    <td>
                        <input type="text" name="market_price" value="0" size="20" />
                        <span class="require-field">*</span>
                    </td>
                </tr>
                <tr>
                    <td class="label">本店售价：</td>
                    <td>
                        <input type="text" name="shop_price" value="0" size="20"/>
                        <span class="require-field">*</span>
                    </td>
                </tr>
               
                <tr>
                    <td class="label">是否上架：</td>
                    <td>
                        <input type="radio" name="is_on_sale" value="是"/ checked="checked"> 是
                        <input type="radio" name="is_on_sale" value="否"/> 否
                    </td>
                </tr>
               

                
            </table>
            <!--商品描述-->
            <table style="display: none;" width="90%" class="tab_table" align="center">
            <tr>
                    <td>
                        <textarea id="goods_desc" name="goods_desc"></textarea>
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
                        ¥<input type="text"  name="member_price[<?php echo $v['id'];?>]" size="8"/>元
                        </p> 
                        <?php endforeach;?>
                    </td>
                </tr>
            </table>
            <!--商品属性-->
            <table style="display: none;" width="90%" class="tab_table" align="center">

            </table>
            <!--商品相册-->
            <table style="display: none;" width="90%" class="tab_table" align="center">
                <tr>
                    <td>
                        <input id="btn_add_pic" type="button" value="添加一张" />
                        <hr/>
                        <ul id="ul_pic_list"></ul>
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

    $("#btn_add_pic").click(function(){
        var file='<li><input type="file" name="pic[]"/></li>';
        $("#ul_pic_list").append(file);
    });
    </script>


<div id="footer">
共执行 29 个查询，用时 0.539249 秒，Gzip 已禁用，内存占用 3.502 MB<br />
版权所有 &copy; 2005-2012 上海商派网络科技有限公司，并保留所有权利。</div>
</body>
</html>