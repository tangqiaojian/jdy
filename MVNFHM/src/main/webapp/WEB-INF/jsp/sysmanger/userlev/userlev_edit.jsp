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
					
					<form action="userlev/${msg }.do" name="Form" id="Form" method="post">
						<input type="hidden" name="USERLEV_ID" id="USERLEV_ID" value="${pd.USERLEV_ID}"/>
						<div id="zhongxin" style="padding-top: 13px;">
						<table id="table_report" class="table table-striped table-bordered table-hover">
							<tr>
								<td style="width:100px;text-align: right;padding-top: 13px;">等级名称:</td>
								<td><input type="text" name="LEV_NAME" id="LEV_NAME" value="${pd.LEV_NAME}" maxlength="50" placeholder="这里输入等级名称" title="等级名称" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:100px;text-align: right;padding-top: 13px;">等级消费金额:</td>
								<td>
								   <input type="text" onInput="clearNoNum(this)" name="LEV_PRICE_MIN" id="LEV_PRICE_MIN" value="${pd.LEV_PRICE_MIN}" maxlength="32" placeholder="这里输入等级消费金额(低)" title="等级消费金额(低)" style="width:40%;"/>
								    -
								   <input type="text" onInput="clearNoNum(this)" name="LEV_PRICE_MAX" id="LEV_PRICE_MAX" value="${pd.LEV_PRICE_MAX}" maxlength="32" placeholder="这里输入等级消费金额(高)" title="等级消费金额(高)" style="width:40%;"/>
								</td>
							</tr>
							<tr>
								<td style="width:100px;text-align: right;padding-top: 13px;">折扣:</td>
								<td><input type="text" onInput="clearNoNum(this)" name="DISCOUNT" id="DISCOUNT" value="${pd.DISCOUNT}" maxlength="32" placeholder="这里输入折扣" title="折扣" style="width:90%;"/>折</td>
							</tr>
							<tr>
								<td style="text-align: center;" colspan="10">
									<a class="btn btn-mini btn-primary" onclick="save();">保存</a>
									<a class="btn btn-mini btn-danger" onclick="top.Dialog.close();">取消</a>
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
	<!-- 下拉框 -->
	<script src="static/ace/js/chosen.jquery.js"></script>
	<!-- 日期框 -->
	<script src="static/ace/js/date-time/bootstrap-datepicker.js"></script>
	<!--提示框-->
	<script type="text/javascript" src="static/js/jquery.tips.js"></script>
		<script type="text/javascript">
		$(top.hangge());
		//保存
		function save(){
			if($("#LEV_NAME").val()==""){
				$("#LEV_NAME").tips({
					side:3,
		            msg:'请输入等级名称',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#LEV_NAME").focus();
			return false;
			}
			if($("#LEV_PRICE_MIN").val()==""){
				$("#LEV_PRICE_MIN").tips({
					side:3,
		            msg:'请输入等级消费金额(低)',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#LEV_PRICE_MIN").focus();
			return false;
			}
			if($("#LEV_PRICE_MAX").val()==""){
				$("#LEV_PRICE_MAX").tips({
					side:3,
		            msg:'请输入等级消费金额(高)',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#LEV_PRICE_MAX").focus();
			return false;
			}
			if($("#DISCOUNT").val()==""){
				$("#DISCOUNT").tips({
					side:3,
		            msg:'请输入折扣',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#DISCOUNT").focus();
			return false;
			}
			if($("#CREATEBY").val()==""){
				$("#CREATEBY").tips({
					side:3,
		            msg:'请输入创建人',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#CREATEBY").focus();
			return false;
			}
			if($("#CREATETIME").val()==""){
				$("#CREATETIME").tips({
					side:3,
		            msg:'请输入创建时间',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#CREATETIME").focus();
			return false;
			}
			if($("#UPDATEBY").val()==""){
				$("#UPDATEBY").tips({
					side:3,
		            msg:'请输入修改人',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#UPDATEBY").focus();
			return false;
			}
			if($("#UPDATETIME").val()==""){
				$("#UPDATETIME").tips({
					side:3,
		            msg:'请输入修改时间',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#UPDATETIME").focus();
			return false;
			}
			$("#Form").submit();
			$("#zhongxin").hide();
			$("#zhongxin2").show();
		}
		
		function clearNoNum(obj){
	        obj.value = obj.value.replace(/[^\d.]/g,"");  //清除“数字”和“.”以外的字符  
		    obj.value = obj.value.replace(/\.{2,}/g,"."); //只保留第一个. 清除多余的  
		    obj.value = obj.value.replace(".","$#$").replace(/\./g,"").replace("$#$","."); 
		    obj.value = obj.value.replace(/^(\-)*(\d+)\.(\d\d).*$/,'$1$2.$3');//只能输入两个小数  
		    if(obj.value.indexOf(".")< 0 && obj.value !=""){//以上已经过滤，此处控制的是如果没有小数点，首位不能为类似于 01、02的金额 
		        obj.value= parseFloat(obj.value); 
		    } 
       }
	
	   function  clearNoIntNum(obj){
		    obj.value = obj.value.replace(/[^\d.]/g,"");	
	   }
		
		$(function() {
			//日期框
			$('.date-picker').datepicker({autoclose: true,todayHighlight: true});
		});
		</script>
</body>
</html>