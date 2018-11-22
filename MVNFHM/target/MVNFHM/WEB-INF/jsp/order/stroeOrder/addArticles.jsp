<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
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
	<style type="text/css">
	 .m_input{
	  width: 100%;
	  line-height: 25px;
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
					
					  <form action="storeOrder/save.do" name="Form" id="Form" method="post">
					      <input id="ORDERID" name="ORDERID" type="hidden" value="${pd.ORDER_ID}">
					      <input type="hidden" id="PA_WEIGHT" name="PA_WEIGHT" >
						  <input type="hidden" id="BAR_CODE" name="BAR_CODE" >
						  <input type="hidden" id="PA_PRICE" name="PA_PRICE" >
						 
						  <table id="table_report_3_1" class="table table-striped table-bordered table-hover">
										<tr>
											<td>类别</td>
											<td>
											    <select  class="chosen-select form-control" name="PA_TYPE" id="PA_TYPE" data-placeholder="请选择类别" >
											        <option value=""></option>
											        <c:forEach items="${pd.products }" var="p">
											          <option value="${p.PRO_TYPE }" class="${p.PRODUCTMANAGER_ID }"  >${p.PRO_TYPE }</option>
											        </c:forEach>
											    </select>
											</td>
										</tr>
										<tr>
										  <td style="width: 20%">品牌</td>
											<td>
											    <select class="chosen-select form-control" name="PA_BRAND" id="PA_BRAND" data-placeholder="请选择品牌"  >
											        <option value=""></option>
											    </select>
										   </td>	
										</tr>
										
										<tr>
											<td>品名</td>
											<td>
											   <select name="PA_PM" class="chosen-select form-control" id="PA_PM"  data-placeholder="请选择品名" >
											       <option value=""></option>
											    </select>
											</td>
										</tr>
										
										<tr>
										    <td>规格</td>
											<td>
											   <select name="PA_SPEC" id="PA_SPEC" class="chosen-select form-control" data-placeholder="请选择规格" >
											       <option value=""></option>
											    </select>
											</td>	
										
										</tr>
										
										<tr>
										    <td>数量</td>
											<td><input name="PA_COUNT" id="PA_COUNT" class="m_input" placeholder="(自填)" onInput="clearNoIntNum(this)" ></td>
										</tr>
										<tr>
											<td colspan="2" style="text-align: center;"><a class="btn btn-mini btn-primary" onclick="save_ParcelArticles_1()">确认新增</a></td>
										</tr>
							  <tr>
								  <td colspan="2">
									  <input class="barCode m_input" id="barCode" placeholder="(获取焦点扫描条形码)" style="width: 100%">
								  </td>
							  </tr>
							</table>
					
						<div id="zhongxin2" class="center" style="display:none"><br/><br/><br/><br/><br/><img src="static/images/jiazai.gif" /><br/><h4 class="lighter block green">提交中...</h4></div>
					</form>
					</div>
					<!-- /.col -->
				</div>
				<!-- /.row -->
			</div>
			<!-- /.page-content -->
		</div>
	</div>
	<!-- /.main-content -->
</div>
<!-- /.main-container -->


	<!-- 页面底部js¨ -->
	<%@ include file="../../system/index/foot.jsp"%>
	<!--jquery需要引入的文件-->
    <script src="static/js/jquery-3.2.1.js"></script>
	<!-- 下拉框 -->
	<script src="static/ace/js/chosen.jquery.js"></script>
	<!-- 日期框 -->
	<script src="static/ace/js/date-time/bootstrap-datepicker.js"></script>
	
	<script type="text/javascript" src="static/czzx/js/layer.js"></script>
	<!--提示框-->
	<script type="text/javascript" src="static/js/jquery.tips.js"></script>
	<script src="static/distpicker/js/distpicker.data.js"></script>
	<script src="static/distpicker/js/distpicker.js"></script>
	<script src="static/distpicker/js/main.js"></script>
	<!--ajax提交表单需要引入jquery.form.js-->
    <script type="text/javascript" src="static/js/jquery.form.js"></script>
		<script type="text/javascript">

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
                        var ORDERID = $("#ORDERID").val();
                        if(barcode != ""){
                            top.jzts();
                            var diag = new top.Dialog();
                            diag.Drag = true;
                            diag.Title = "选择类型";
                            diag.URL = "<%=basePath%>productlib/getByBarCode2.do?barCode="+barcode+"&ORDERID="+ORDERID;
                            diag.Width = 820;
                            diag.Height = 400;
                            diag.Modal = true;				//有无遮罩窗口
                            diag.ShowMaxButton = true;	//最大化按钮
                            diag.ShowMinButton = true;		//最小化按钮
                            diag.CancelEvent = function () { //关闭事件
                                layer.closeAll();
                                diag.close();
                                top.Dialog.close();
                                parent.tosearch();
                            };
                            diag.show();

                        }
                    }
                });
            }


            //------------------------------------------------------------------------------------------------------------------//
		$(top.hangge());
		//保存
		
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
		            bg:'#AE81FF',
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
			
			if($("#PA_COUNT").val()==""){
				$("#PA_COUNT").tips({
					side:3,
		            msg:'请输入数量',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#PA_COUNT").focus();
			return false;
			}
		
			var PA_SPEC = $("#PA_SPEC").find("option:selected").attr("class");
			var o=JSON.parse(PA_SPEC);
					     
		    $("#PA_WEIGHT").val(o.PL_WEIGHT);
		    $("#PA_PRICE").val(o.PL_PRICE);
		    $("#BAR_CODE").val(o.BAR_CODE);
		
			$("#Form").ajaxSubmit({
		          beforeSubmit:function () {
		            // alert("我在提交表单之前被调用！");
		        	   var index = layer.load(1, {
		        		  shade: [0.1,'#fff'] //0.1透明度的白色背景
		        	  });
		          },
		          success:function (data) {
		        	  if(data){
                          top.Dialog.close();
		                }else{
		                	layer.msg('提交失败', {
	                	        time: 2000, 
	                	 });
		                }
		          }
		   });
			
		}
		$(function() {
			//日期框
			
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
			
		});
		</script>
</body>
</html>