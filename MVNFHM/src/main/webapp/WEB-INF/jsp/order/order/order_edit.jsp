<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
<base href="<%=basePath%>">
<!-- 下拉框 -->
<link rel="stylesheet" href="static/ace/css/chosen.css" />
<!-- jsp文件头和头部 -->
<%@ include file="../../system/index/top.jsp"%>
<!-- 日期框 -->
<link rel="stylesheet" href="static/ace/css/datepicker.css" />
<style>
.m_input {
    width: 90%;
    line-height: 28px;
    border:solid 1px #CCC;
}

.barCode{
    width: 50%;
    line-height: 28px;
    border:solid 1px #CCC;
}

</style>
</head>
<body class="no-skin">

	<!-- /section:basics/navbar.layout -->
	<div class="main-container" id="main-container">
		<!-- /section:basics/sidebar -->
		<div class="main-content">
			<div class="main-content-inner">
				<div class="page-content">
					<div class="row">
						<div class="col-xs-12">
							   
					  
					   <form action="order/${msg }.do" name="Form" id="Form" method="post">
						  <input type="hidden" name="ORDER_ID" id="ORDER_ID" value="${pd.ORDER_ID}"/>
						     <div id="zhongxin" style="padding-top: 13px;">
						      <table id="table_report" class="table table-striped table-bordered table-hover">
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">寄件人:</td>
								<td>
						           <span class="input-icon input-icon-right">
										<input name="SENDER" id="SENDER" value="${pd.SENDER}" id="form-field-icon-2" type="text" readonly="readonly">
                                         
                                        <!-- 寄件人详细信息JSON串 -->										
										<input type="hidden" id="SENDERSTR" name="SENDERSTR" value='${pd.SENDERSTR }'>
										<i class="ace-icon fa fa-users black"></i>
								   </span>
								</td>
								
								<td style="width:75px;text-align: right;padding-top: 13px;">收件人:</td>
								<td>
								   <span class="input-icon input-icon-right">
										<input name="ADDRESSEE" id="ADDRESSEE" value="${pd.ADDRESSEE}"  id="form-field-icon-2" type="text" readonly="readonly">
										
										<!-- 收件人详细信息JSON串 -->
										<input type="hidden" id="ADDRESSEESTR"  name="ADDRESSEESTR" value='${pd.ADDRESSEESTR }'>
										<i class="ace-icon fa fa-users black"></i>
								   </span>
								</td>
							</tr>
							
						</table>
						
					   
					    <input type="hidden" id="jsonStr" name="jsonStr" >
						
						</div>
						<div id="zhongxin2" class="center" style="display:none"><br/><br/><br/><br/><br/><img src="static/images/jiazai.gif" /><br/><h4 class="lighter block green">提交中...</h4></div>
					</form>
					</div>
					
				<div class="col-xs-12">
					          <div id="zhongxin" style="padding-top: 13px;">
								  <form action="javaScript:void(0)" id="form1">
								   <table id="table_report_3_1" class="table table-striped table-bordered table-hover" style="width: 48%;float: left;">
										<tr>
											<td style="width: 20%" >类别</td>
											<td style="width: 20%" >
											    <select  class="chosen-select form-control" name="PA_TYPE" id="PA_TYPE" data-placeholder="请选择类别" style="vertical-align:top;width: 120px;">
											        <option value=""></option>
											        <c:forEach items="${pd.products }" var="p">
											          <option value="${p.PRO_TYPE }" class="${p.PRODUCTMANAGER_ID }"  >${p.PRO_TYPE }</option>
											        </c:forEach>
											    </select>
											</td>
											
											<td style="width: 20%">品牌</td>
											<td style="width: 20%">
											    <select class="chosen-select form-control" name="PA_BRAND" id="PA_BRAND" data-placeholder="请选择品牌" style="vertical-align:top;width: 120px;" >
											        <option value=""></option>
											    </select>
										   </td>
										</tr>
										<tr>
											<td>品名</td>
											<td>
											  <div style="width: 90%">
											   <select name="PA_PM" class="chosen-select form-control" id="PA_PM"  data-placeholder="请选择品名" style="vertical-align:top;width: 120px;">
											       <option value=""></option>
											    </select>
											    </div>
											</td>
											
											<td>规格</td>
											<td>
											   <div style="width: 90%">
											   <select name="PA_SPEC" id="PA_SPEC" class="chosen-select form-control" data-placeholder="请选择规格" style="vertical-align:top;width: 120px;">
											       <option value=""></option>
											    </select>
											    </div>
											</td>	
										</tr>
										
										<tr>
										    <td>数量</td>
											<td><input name="PA_COUNT" id="PA_COUNT" class="m_input" placeholder="(自填)" onInput="clearNoIntNum(this)" ></td>
											<td colspan="2" style="text-align: center;"><a class="btn btn-mini btn-primary" onclick="save_ParcelArticles_1()">确认新增</a></td>
										</tr>
										
										<tr>
											<td colspan="4"><input class="barCode" id="barCode" placeholder="(获取焦点扫描条形码)"></td>
										</tr>
										
							       </table>
							    </form>
				       
				      
							    <form action="javaScript:void(0)" id="form2">
							       <table id="table_report_3_2" class="table table-striped table-bordered table-hover" style="width: 48%;float: left;margin-left: 2%">
										<tr>
											<td colspan="4">自定义商品</td>
										</tr>
										<tr>
											<td style="width: 15%">类别</td>
											<td>
											   <select name="PA_TYPE" id="PA_TYPE_2" class="chosen-select form-control" data-placeholder="请选择类别" style="vertical-align:top;width: 100px;">
											         <option value=""></option>
											        <c:forEach items="${pd.products }" var="p">
											          <option value="${p.PRO_TYPE }">${p.PRO_TYPE }</option>
											        </c:forEach>
											    </select>
									        </td>
											
											<td style="width: 15%">品牌</td>
											<td><input name="PA_BRAND" id="PA_BRAND_2"  class="m_input" placeholder="(自填)"></td>
										</tr>
										<tr>
											<td>品名</td>
											<td><input name="PA_PM" id="PA_PM_2"   class="m_input" placeholder="(自填)"></td>
											
											<td>规格</td>
											<td><input name="PA_SPEC" id="PA_SPEC_2"  class="m_input" placeholder="(自填)"></td>
										</tr>
										<tr>
											<td>数量</td>
											<td><input name="PA_COUNT" id="PA_COUNT_2"  class="m_input" placeholder="(自填)" onInput="clearNoIntNum(this)"></td>
											
											<td>单价</td>
											<td><input name="PA_PRICE" id="PA_PRICE_2" class="m_input" placeholder="(自填)" onInput="clearNoNum(this)" ></td>
										</tr>
										
										<tr>	
											<!-- <td>重量</td>
											<td><input id="PA_WEIGHT_2" name="PA_WEIGHT"  class="m_input" onInput="clearNoNum(this)"  placeholder="(自填,单位kg)"></td> -->
									
										    <td colspan="4" style="text-align: center;"><a class="btn btn-mini btn-primary" onclick="save_ParcelArticles_2()">确认新增</a></td>
										    
										</tr>
							       </table>
					   </form>
				       
				        
					    <table id="table_report_2" class="table table-striped table-bordered table-hover">
							<tr>
								<td style="text-align: left;padding-top: 13px;" colspan="6"><strong>寄件物品信息</strong></td>
							</tr>
							<tr>
								<td>类型</td>
								<td>品牌</td>
								<td>品名</td>
								<td>规格</td>
						        <td>数量</td>
							    <td>操作</td>
							</tr>
						</table>  
				       
				     </div>
				    </div>
					

				
				   <div class="col-xs-12">
					 <div id="zhongxin" style="padding-top: 13px;">
					   <table id="table_report_4" class="table table-striped table-bordered table-hover">
							<tr>
								<td style="text-align: center;" colspan="10">
									<a class="btn btn-mini btn-primary" onclick="save();">修改订单</a>
								</td>
							</tr>
				      </table>
				     </div>
				    </div>
							   
							   
						
					
						</div>
						<!-- /.col -->
					</div>
					<!-- /.row -->
				</div>
				<!-- /.page-content -->
			</div>
		</div>
		<!-- /.main-content -->

		<!-- 返回顶部 -->
		<a href="#" id="btn-scroll-up" class="btn-scroll-up btn btn-sm btn-inverse">
			<i class="ace-icon fa fa-angle-double-up icon-only bigger-110"></i>
		</a>

	</div>
	<!-- /.main-container -->

	<!-- basic scripts -->
	<!-- 页面底部js¨ -->
	<%@ include file="../../system/index/foot.jsp"%>
	<!-- ace scripts -->
	<script src="static/ace/js/ace/ace.js"></script>
	
	
	<!--jquery需要引入的文件-->
    <script src="static/js/jquery-3.2.1.js"></script>
    <!--ajax提交表单需要引入jquery.form.js-->
    <script type="text/javascript" src="static/js/jquery.form.js"></script>
    
    <script type="text/javascript" src="static/czzx/js/layer.js"></script>
    <!-- 下拉框 -->
	<script src="static/ace/js/chosen.jquery.js"></script>
    <!-- 日期框 -->
	<script src="static/ace/js/date-time/bootstrap-datepicker.js"></script>
	<!--提示框-->
	<script type="text/javascript" src="static/js/jquery.tips.js"></script>
    
	<script type="text/javascript">
		$(top.hangge());//关闭加载状态
		//检索
		function tosearch(){
			top.jzts();
			$("#Form").submit();
		}
		
		
		function clearNoNum(obj){
		        //先把非数字的都替换掉，除了数字和.
		        obj.value = obj.value.replace(/[^\d.]/g,"");
		        //必须保证第一个为数字而不是.
		        obj.value = obj.value.replace(/^\./g,"");
		        //保证只有出现一个.而没有多个.
		        obj.value = obj.value.replace(/\.{2,}/g,".");
		        //保证.只出现一次，而不能出现两次以上
		        obj.value = obj.value.replace(".","$#$").replace(/\./g,"").replace("$#$",".");
		        //保证 数字整数位不大于8位
		        if(100000000<=parseFloat(obj.value))
		            obj.value = "";
	    }
		
		function  clearNoIntNum(obj){
			 obj.value = obj.value.replace(/[^\d.]/g,"");	
		}
		
		$(function() {
		
			//日期框
			$('.date-picker').datepicker({
				autoclose: true,
				todayHighlight: true
			});
			
			//下拉框
			if(!ace.vars['touch']) {
				$('.chosen-select').chosen({allow_single_deselect:true}); 
				$(window)
				.off('resize.chosen')
				.on('resize.chosen', function() {
					$('.chosen-select').each(function() {
						 var $this = $(this);
						 $this.next().css({'width': $this.parent().width()});
					});
				}).trigger('resize.chosen');
				$(document).on('settings.ace.chosen', function(e, event_name, event_val) {
					if(event_name != 'sidebar_collapsed') return;
					$('.chosen-select').each(function() {
						 var $this = $(this);
						 $this.next().css({'width': $this.parent().width()});
					});
				});
				$('#chosen-multiple-style .btn').on('click', function(e){
					var target = $(this).find('input[type=radio]');
					var which = parseInt(target.val());
					if(which == 2) $('#form-field-select-4').addClass('tag-input-style');
					 else $('#form-field-select-4').removeClass('tag-input-style');
				});
			}
			
			
			//复选框全选控制
			var active_class = 'active';
			$('#simple-table > thead > tr > th input[type=checkbox]').eq(0).on('click', function(){
				var th_checked = this.checked;//checkbox inside "TH" table header
				$(this).closest('table').find('tbody > tr').each(function(){
					var row = this;
					if(th_checked) $(row).addClass(active_class).find('input[type=checkbox]').eq(0).prop('checked', true);
					else $(row).removeClass(active_class).find('input[type=checkbox]').eq(0).prop('checked', false);
				});
			});
		});
		
		//新增
		function add(){
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="新增";
			 diag.URL = '<%=basePath%>order/goAdd.do';
			 diag.Width = 1000;
			 diag.Height = 600;
			 diag.Modal = true;				//有无遮罩窗口
			 diag. ShowMaxButton = true;	//最大化按钮
		     diag.ShowMinButton = true;		//最小化按钮
			 diag.CancelEvent = function(){ //关闭事件
				 if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
					 if('${page.currentPage}' == '0'){
						 tosearch();
					 }else{
						 tosearch();
					 }
				}
				diag.close();
			 };
			 diag.show();
		}
		
		
		  //------------------------------------------------------------------------------------------------------------------//
			
		    window.onload = function(e) {
			    var code = "";
	    		var lastTime,nextTime;
	    		var lastCode,nextCode;
	    		document.onKeyPress = function(e) {
	    			nextCode = e.which;
	    			nextTime = new Date().getTime();
	    		
	    			if(lastCode == null && lastTime == null) {
	    				
	    			} if(lastCode != null && lastTime != null && nextTime - lastTime <= 30) {
	    				code += String.fromCharCode(code);
	    				$("#barCode").val(code);
	    			} else if(lastCode != null && lastTime != null && nextTime - lastTime > 1000) {
	    				code = "";//超时清空
	    			}
	    			lastCode = nextCode;
	    			lastTime = nextTime;
	    		};
	    		
	    		$(this).keypress(function(e) {
	    			if(e.which == 13) {
	    				var barcode = $("#barCode").val();
	    				if(barcode != ""){
	    					var index=layer.open({
	    						type: 2,
	    			            title: '产品信息',
	    			            shadeClose: true,
	    			            shade: 0.3,
	    			            maxmin: true, //开启最大化最小化按钮
	    			            area: ['820px', '400px'],
	    			            content: "<%=basePath%>productlib/getByBarCode.do?barCode="+barcode,
	    			            offset:'auto'
	    					});
	    			   }
	    			}
	    		});
	    	}
		  	
		  	
	    //------------------------------------------------------------------------------------------------------------------//
		
		
		//删除
		function del(Id){
			bootbox.confirm("确定要删除吗?", function(result) {
				if(result) {
					top.jzts();
					var url = "<%=basePath%>order/delete.do?ORDER_ID="+Id+"&tm="+new Date().getTime();
					$.get(url,function(data){
						tosearch();
					});
				}
			});
		}
		
		//修改
		function edit(Id){
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="编辑";
			 diag.URL = '<%=basePath%>order/goEdit.do?ORDER_ID='+Id;
			 diag.Width = 1000;
			 diag.Height = 600;
			 diag.Modal = true;				//有无遮罩窗口
			 diag. ShowMaxButton = true;	//最大化按钮
		     diag.ShowMinButton = true;		//最小化按钮 
			 diag.CancelEvent = function(){ //关闭事件
				 if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
					 tosearch();
				
				 }
				diag.close();
			 };
			 diag.show();
		}
				
		
		var myArray=new Array();
		//初始化 数据库数据
	    $(function(){
	    	var  paStr='${pd.PaStr}';
	    	if(paStr!=null && paStr!=''){
	    		var arr=eval(paStr);
	    		console.log(arr);
	    		var str="";
	    		$.each(arr,function(idx,obj){
	    			var timestamp=new Date().getTime();
	    			var o=new Object();
	    			o.PA_TYPE=obj.pA_TYPE;
	    			o.PA_BRAND=obj.pA_BRAND;
	    			o.PA_PM=obj.pA_PM;
	    		    o.PA_COUNT=obj.pA_COUNT;
	    		    o.PA_SPEC=obj.pA_SPEC;
	    		    o.PA_PRICE=obj.pA_PRICE;
	    		    o.PA_WEIGHT=obj.pA_WEIGHT;
	    		    o.ID=obj.pARCELARTICLES_ID;
	    			myArray.push(o);
	               
	    			str+="<tr class='wp'><td>"+obj.pA_TYPE+"</td><td>"+obj.pA_PM+"</td><td>"+obj.pA_COUNT+"</td>";
	    			str+="<td><a href='javaScript:void(0)' class='delPA' id="+obj.pARCELARTICLES_ID+" >删除</a></td></tr>";
	    		});
	    		console.log(myArray);
    		    $("#table_report_2").append(str);
	    	}
	    });
		
		
		//保存
		function save(){
			if(!confirm("确认修改该订单?")){
				return false;
			}			
			if($("#STOREID").val()==""){
				$("#STOREID").tips({
					side:3,
		            msg:'请选择默认门店',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#STOREID").focus();
			return false;
			}
			if($("#SENDER").val()==""){
				$("#SENDER").tips({
					side:3,
		            msg:'请输入寄件人',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#SENDER").focus();
			return false;
			}
			if($("#ADDRESSEE").val()==""){
				$("#ADDRESSEE").tips({
					side:3,
		            msg:'请输入收件人',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#ADDRESSEE").focus();
			return false;
			}
			
			
	        //转换物品信息为json字符串
			if(myArray.length>0){
				$("#jsonStr").val(JSON.stringify(myArray));
			}else{
				layer.msg('请添加寄件物品信息', {
        	        time: 2000, 
        	    });
				return false;
			}
			
			
			$("#Form").ajaxSubmit({
		          beforeSubmit:function () {
		            // alert("我在提交表单之前被调用！");
		          },
		          success:function (data) {
		                if(data.flag){
		                	//跳转到详情页
		                	window.location.href = '<%=basePath%>order/order_1_details.do?ORDER_ID=${pd.ORDER_ID}';
		                }else{
		                	layer.msg('提交失败', {
	                	        time: 2000, 
	                	    });
		                }
		          }
		   });
		}
		
	
		
		
		 //********************************************以下动态添加物品***************************************//
		
		
		function save_ParcelArticles_1(){
			if($("#PA_TYPE").val()==""){
				$("#PA_TYPE").tips({
					side:3,
		            msg:'请选择类别',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#PA_TYPE").focus();
			  return false;
			}
			
			if($("#PA_BRAND").val()==""){
				$("#PA_BRAND").tips({
					side:3,
		            msg:'请选择品牌',
		            bg:'#PA_BRAND',
		            time:2
		        });
				$("#PA_BRAND").focus();
			return false;
			}
			
			if($("#PA_PM").val()==""){
				$("#PA_PM").tips({
					side:3,
		            msg:'请选择品名',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#PA_PM").focus();
			return false;
			}

			if($("#PA_SPEC").val()==""){
				$("#PA_SPEC").tips({
					side:3,
		            msg:'请选择规格',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#PA_SPEC").focus();
			return false;
			}
			
			var r = /^[0-9]*[1-9][0-9]*$/;
			
			if($("#PA_COUNT").val()==""){
				$("#PA_COUNT").tips({
					side:3,
		            msg:'请填写数量',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#PA_COUNT").focus();
			 return false;
			}
			if(!r.test($("#PA_COUNT").val())){
				$("#PA_COUNT").tips({
					side:3,
		            msg:'数量请填写正整数',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#PA_COUNT").focus();
			  return false;
			}

			var PA_SPEC = $("#PA_SPEC").find("option:selected").attr("class");
			var o=JSON.parse(PA_SPEC);
			
			var obj=new Object();
			var timestamp=new Date().getTime();
			
			obj.PA_TYPE=$("#PA_TYPE").val();   //类型
			obj.PA_BRAND=$("#PA_BRAND").val();    //品牌
			obj.PA_PM=$("#PA_PM").val();       //品名
			obj.PA_WEIGHT=o.PL_WEIGHT;         //重量  PL_WEIGHT (公斤)
			obj.PA_SPEC= $("#PA_SPEC").val()   //规格  PA_SPEC
			obj.PA_PRICE =o.PL_PRICE;          //单价  PL_PRICE 
		    obj.PA_COUNT=$("#PA_COUNT").val(); //数量
		    obj.BAR_CODE= o.BAR_CODE;          // 条形码
		    obj.PL_CODE= o.PL_CODE;            //商品内部代码
		    obj.ID=timestamp;
			console.log(obj);
			myArray.push(obj);
		    
		    //拼接字符串
			var str="<tr class='wp'><td>"+$("#PA_TYPE").val()+"</td><td>"+$("#PA_BRAND").val()+"</td><td>"+$("#PA_PM").val()+"</td><td>"+$("#PA_SPEC").val()+"</td><td>"+$("#PA_COUNT").val()+"</td>";
			str+="<td><a href='javaScript:void(0)' class='delPA' id="+timestamp+" >删除</a></td></tr>";
			console.log(myArray);
		    $("#table_report_2").append(str);
		    
            $('#form1')[0].reset();
            
            $("#PA_BRAND").html("<option value=''></option>");
			$("#PA_PM").html("<option value=''></option>");
			$("#PA_SPEC").html("<option value=''></option>");
            $("#PA_TYPE").trigger("chosen:updated");
            $("#PA_BRAND").trigger("chosen:updated");
			$("#PA_PM").trigger("chosen:updated");
			$("#PA_SPEC").trigger("chosen:updated");
		}
		
	   
		function save_ParcelArticles_2(){
			if($("#PA_TYPE_2").val()==""){
				$("#PA_TYPE_2").tips({
					side:3,
		            msg:'请选择产品类型',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#PA_TYPE_2").focus();
			  return false;
			}
			
			if($("#PA_BRAND_2").val()==""){
				$("#PA_BRAND_2").tips({
					side:3,
		            msg:'请选择品牌',
		            bg:'#PA_BRAND',
		            time:2
		        });
				$("#PA_BRAND_2").focus();
			return false;
			}
			
			if($("#PA_PM_2").val()==""){
				$("#PA_PM_2").tips({
					side:3,
		            msg:'请选择产品规格',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#PA_PM_2").focus();
			return false;
			}
			
			if($("#PA_COUNT_2").val()==""){
				$("#PA_COUNT_2").tips({
					side:3,
		            msg:'请填写数量',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#PA_COUNT_2").focus();
			return false;
			}
			if($("#PA_SPEC_2").val()==""){
				$("#PA_SPEC_2").tips({
					side:3,
		            msg:'请填写规格',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#PA_SPEC_2").focus();
			return false;
			}
			if($("#PA_PRICE_2").val()==""){
				$("#PA_PRICE_2").tips({
					side:3,
		            msg:'请填写单价',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#PA_PRICE_2").focus();
			return false;
			}
	/* 		if($("#PA_WEIGHT_2").val()==""){
				$("#PA_WEIGHT_2").tips({
					side:3,
		            msg:'请填写净重',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#PA_WEIGHT_2").focus();
			return false;
			} */
			
			var obj=new Object();
			var timestamp=new Date().getTime();
			
			obj.PA_TYPE=$("#PA_TYPE_2").val(); //类型
			obj.PA_BRAND=$("#PA_BRAND_2").val();  //品牌
			obj.PA_PM=$("#PA_PM_2").val();        //品名
		    obj.PA_COUNT=$("#PA_COUNT_2").val(); //数量
		    obj.PA_SPEC=$("#PA_SPEC_2").val();   //规格  PA_SPEC
		    obj.PA_PRICE=$("#PA_PRICE_2").val(); //单价  PL_PRICE      
		/* 	obj.PA_WEIGHT=$("#PA_WEIGHT_2").val(); //重量  PL_WEIGHT (公斤) */
		    obj.ID=timestamp;
			
			myArray.push(obj);
		    //拼接字符串
			var str="<tr class='wp'><td>"+$("#PA_TYPE_2").val()+"</td><td>"+$("#PA_BRAND_2").val()+"</td><td>"+$("#PA_PM_2").val()+"</td><td>"+$("#PA_SPEC_2").val()+"</td><td>"+$("#PA_COUNT_2").val()+"</td>";
			str+="<td><a href='javaScript:void(0)' class='delPA' id="+timestamp+" >删除</a></td></tr>";
			console.log(myArray);
		    $("#table_report_2").append(str);
			$('#form2')[0].reset();	
			$("#PA_TYPE_2").trigger("chosen:updated");
		}
	   
	
		
		$(function(){
			//删除元素
			$(document).on("click", ".delPA", function(){ 
				var id=$(this).attr("id");
			      var o;
				  $.each(myArray,function(idx,obj){
						if(obj.ID==id){
							o=obj;
							return false;
						}					
				  });
				  if(o!=null){
					   myArray.splice(jQuery.inArray(o ,myArray),1); 
					   //移除表格tr
					   $(this).parent().parent().remove();
					   console.log(myArray);
				  } 
			});
			
			
			//弹出寄件人 收货人 选择框
			$("#SENDER").on("click", function() {
				var index=layer.open({
					type: 2,
		            title: '选择寄件人',
		            shadeClose: true,
		            shade: 0.3,
		            maxmin: true, //开启最大化最小化按钮
		            area: ['820px', '400px'],
		            content: "<%=basePath%>mail_addr/toChoose.do?M_TYPE=0",
		            offset:'auto'
				   //这里content是一个DOM，这个元素要放在body根节点下
				});
			});		
			
			
			$("#ADDRESSEE").on("click", function() {
				var index=layer.open({
					type: 2,
		            title: '选择收件人',
		            shadeClose: true,
		            shade: 0.3,
		            maxmin: true, //开启最大化最小化按钮
		            area: ['820px', '400px'],
		            content: "<%=basePath%>mail_addr/toChoose.do?M_TYPE=1",
		            offset:'auto'
				   //这里content是一个DOM，这个元素要放在body根节点下
				});
			});			
		});
        
			    	
<%-- 		//初始品牌
		$(function() {
			$.ajax({
				type: "POST",
				url: '<%=basePath%>productlibrary/getLevels.do?tm='+new Date().getTime(),
		    	data: {},
				dataType:'json',
				cache: false,
				success: function(data){
					$("#PA_BRAND").html("<option value=''>请选择</option>");
					 $.each(data.list, function(i, dvar){
							$("#PA_BRAND").append("<option id="+dvar.PRODUCTLIBRARY_ID+" value="+dvar.BP_NAME+">"+dvar.BP_NAME+"</option>");
					 });
				}
			});
			
			$("#PA_BRAND").change(function(){
				var  id=$(this).find("option:selected").attr("id");//选中的文本
			    if(id=='undefined'){
			    	 $("#PA_PM").html("<option value=''>-请选择-</option>");
			    }else{
			    	changeBrand(id);	
			    }
			});
			
		});
		
		
		//第一级值改变事件(初始第二级)
		function changeBrand(value){
			$.ajax({
				type: "POST",
				url: '<%=basePath%>productlibrary/getLevels.do?tm='+new Date().getTime(),
		    	data: {PRODUCTLIBRARY_ID:value},
				dataType:'json',
				cache: false,
				success: function(data){
					 $("#PA_PM").html("<option value=''>-请选择-</option>");
					 $.each(data.list, function(i, dvar){
							$("#PA_PM").append("<option value="+dvar.BP_NAME+">"+dvar.BP_NAME+"</option>");
					 });
				}
			});
		} --%>
		
		
		  $(function() {			
				//大类改变事件
				$("#PA_TYPE").change(function(){
					//初始化品牌 品名 类型
					$("#PA_BRAND").html("<option value=''></option>");
					$("#PA_PM").html("<option value=''></option>");
					$("#PA_SPEC").html("<option value=''></option>");
					
					$("#PA_BRAND").trigger("chosen:updated");
					$("#PA_PM").trigger("chosen:updated");
					$("#PA_SPEC").trigger("chosen:updated");
					var value = $(this).find("option:selected").attr("class");
					if(value!=null && value!=''){
						$.ajax({
							type: "POST",
							url: '<%=basePath%>productlib/getBrand.do?tm='+new Date().getTime(),
					    	data: {PL_TYPE:value},
							dataType:'json',
							cache: false,
							success: function(data){
								 $("#PA_BRAND").html("<option value=''></option>");
								 $.each(data.list, function(i, dvar){
										$("#PA_BRAND").append("<option value="+dvar+">"+dvar+"</option>");
								 });
								 $("#PA_BRAND").trigger("chosen:updated");
							}
						});	
					}
				});
				// 品牌改变事件
				$("#PA_BRAND").change(function(){
					//初始化品牌 品名 类型
					$("#PA_PM").html("<option value=''></option>");
					$("#PA_SPEC").html("<option value=''></option>");
					
					$("#PA_PM").trigger("chosen:updated");
					$("#PA_SPEC").trigger("chosen:updated");
					
					var PL_TYPE = $("#PA_TYPE").find("option:selected").attr("class");
					var PL_BRAND = $(this).val();
					if(PL_BRAND !=null && PL_BRAND !=''){
						$.ajax({
							type: "POST",
							url: '<%=basePath%>productlib/getPlName.do?tm='+new Date().getTime(),
					    	data: {"PL_TYPE":PL_TYPE,"PL_BRAND":PL_BRAND},
							dataType:'json',
							cache: false,
							success: function(data){
								 $("#PA_PM").html("<option value=''></option>");
								 $.each(data.list, function(i, dvar){
										$("#PA_PM").append("<option value="+dvar+">"+dvar+"</option>");
								 });
								 $("#PA_PM").trigger("chosen:updated");
							}
						});	
					}
				});
				
				//品名改变
				$("#PA_PM").change(function(){
					//初始化品牌 品名 类型
					$("#PA_SPEC").html("<option value=''></option>");
					$("#PA_SPEC").trigger("chosen:updated");
					
					var PL_TYPE = $("#PA_TYPE").find("option:selected").attr("class");
					var PL_BRAND = $("#PA_BRAND").val();
					var PA_PM = $("#PA_PM").val();

					if(PA_PM !=null && PA_PM !=''){
						$.ajax({
							type: "POST",
							url: '<%=basePath%>productlib/selectPro.do?tm='+new Date().getTime(),
					    	data: {"PL_TYPE":PL_TYPE,"PL_BRAND":PL_BRAND,"PL_NAME":PA_PM},
							dataType:'json',
							cache: false,
							success: function(data){
								 $("#PA_SPEC").html("<option value=''></option>");
								 $.each(data.list, function(i, dvar){
										$("#PA_SPEC").append("<option class='"+dvar.p_jsonStr+"'  value="+dvar.PL_SPECMODEL+">"+dvar.PL_SPECMODEL+"</option>");
								 });
								 $("#PA_SPEC").trigger("chosen:updated");
							}
						});	
					}
				});
						
			});
	</script>


</body>
</html>