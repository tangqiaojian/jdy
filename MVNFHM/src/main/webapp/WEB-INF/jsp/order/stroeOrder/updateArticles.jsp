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
					
					<form action="storeOrder/${msg }.do" name="Form" id="Form" method="post">

						<input type="hidden" name="PARCELARTICLES_ID" id="PARCELARTICLES_ID" value="${pd.PARCELARTICLES_ID}"/>
						
						<div id="zhongxin" style="padding-top: 13px;">
						<table id="table_report" class="table table-striped table-bordered table-hover">
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">类型:</td>
								<td>
								    <select name="PA_TYPE" id="PA_TYPE" class="chosen-select form-control" data-placeholder="请选择类别" style="vertical-align:top;width: 100px;">
											         <option value=""></option>
											   <c:forEach items="${products }" var="p">
											          <option value="${p.PRO_TYPE }" ${pd.PA_TYPE==p.PRO_TYPE?'selected':''} }>${p.PRO_TYPE }</option>
											   </c:forEach>
						             </select>
								</td>
							</tr>
							
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">品牌:</td>
								<td><input type="text" name="PA_BRAND" id="PA_BRAND" value="${pd.PA_BRAND}" maxlength="50" placeholder="这里输入品牌" title="品牌" style="width:98%;"/></td>
							</tr>
							
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">品名:</td>
								<td><input type="text" name="PA_PM" id="PA_PM" value="${pd.PA_PM}" maxlength="50" placeholder="这里输入品名" title="品名" style="width:98%;"/>
								</td>
							</tr>
							
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">规格:</td>
								<td><input type="text" name="PA_SPEC" id="PA_SPEC"  value="${pd.PA_SPEC}" maxlength="50" placeholder="这里输入规格" title="规格" style="width:98%;"/></td>
							</tr>
							
							
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">数量:</td>
								<td><input type="text" name="PA_COUNT" id="PA_COUNT" onInput="clearNoIntNum(this)" value="${pd.PA_COUNT}" maxlength="50" placeholder="这里输入数量" title="数量" style="width:98%;"/></td>
							</tr>
							
							
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">单价:</td>
								<td><input type="text" name="PA_PRICE" id="PA_PRICE" onInput="clearNoNum(this)" value="${pd.PA_PRICE}" maxlength="50" placeholder="这里输入单价" title="单价" style="width:98%;"/></td>
							</tr>
							
								
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">条形码:</td>
								<td><input type="text" name="BAR_CODE" id="BAR_CODE" value="${pd.BAR_CODE}" maxlength="50" placeholder="这里输入条形码" title="条形码" style="width:98%;"/></td>
							</tr>
							
							<tr>
								<td style="text-align: center;" colspan="10">
									<a class="btn btn-mini btn-primary" onclick="save();">保存</a>
								</td>
							</tr>
						</table>
						</div>
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
		
		
		function save(){
			
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
		            msg:'请填写品牌',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#PA_BRAND").focus();
			return false;
			}
			
			if($("#PA_PM").val()==""){
				$("#PA_PM").tips({
					side:3,
		            msg:'请填写品名',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#PA_PM").focus();
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
			
			if($("#PA_PRICE").val()==""){
				$("#PA_PRICE").tips({
					side:3,
		            msg:'请输入单价',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#PA_PRICE").focus();
			return false;
			}
						
			
			$("#Form").ajaxSubmit({
		          beforeSubmit:function () {
		            // alert("我在提交表单之前被调用！");
		        	   var index = layer.load(1, {
		        		  shade: [0.1,'#fff'] //0.1透明度的白色背景
		        	  });
		          },
		          success:function (data) {
		        	  if(data){
		        		  parent.tosearch(); 
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
			//$('.date-picker').datepicker({autoclose: true,todayHighlight: true});
			
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
	
			
		});
		</script>
</body>
</html>