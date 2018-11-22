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
					
					<form action="productlib/${msg }.do" name="Form" id="Form" method="post">
						<input type="hidden" name="PRODUCTLIB_ID" id="PRODUCTLIB_ID" value="${pd.PRODUCTLIB_ID}"/>
						<div id="zhongxin" style="padding-top: 13px;">
						<table id="table_report" class="table table-striped table-bordered table-hover">
							
							<tr>
							    <td style="width:100px;text-align: right;padding-top: 13px;">产品类别:</td>
								<td><select name="PL_TYPE" id="PL_TYPE"   title="产品类别" style="width:98%;">
								      <option value="" >-请选择-</option>
								      <c:forEach  items="${productType}" var="s">
								         <option value="${s.PRODUCTMANAGER_ID }" ${pd.PL_TYPE==s.PRODUCTMANAGER_ID?'selected':''}>${s.PRO_TYPE}</option>
								      </c:forEach>
								    </select>
								</td>
								<td style="width:100px;text-align: right;padding-top: 13px;">产品代码:</td>
								<td><input type="text" name="PL_CODE" id="PL_CODE" value="${pd.PL_CODE}" maxlength="50" placeholder="这里输入产品内部代码" title="产品内部代码" style="width:98%;"/></td>
							</tr>
							
							<tr>
							    <td style="width:75px;text-align: right;padding-top: 13px;">品牌:</td>
								<td><input type="text" name="PL_BRAND" id="PL_BRAND" value="${pd.PL_BRAND}" maxlength="50" onkeydown="if(event.keyCode==32) return false" placeholder="这里输入品牌" title="品牌" style="width:98%;"/></td>
								<td style="width:75px;text-align: right;padding-top: 13px;">商品名称:</td>
								<td><input type="text" name="PL_NAME" id="PL_NAME" value="${pd.PL_NAME}" maxlength="120" onkeydown="if(event.keyCode==32) return false" placeholder="这里输入商品名称" title="商品名称" style="width:98%;"/></td>
							</tr>
							
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">规格型号 :</td>
								<td><input type="text" name="PL_SPECMODEL" id="PL_SPECMODEL" value="${pd.PL_SPECMODEL}" onkeydown="if(event.keyCode==32) return false" maxlength="120" placeholder="这里输入规格型号 " title="规格型号 " style="width:98%;"/></td>	
							    <td style="width:75px;text-align: right;padding-top: 13px;">条形码:</td>
								<td><input type="text" name="BAR_CODE" id="BAR_CODE" value="${pd.BAR_CODE}" maxlength="100" placeholder="这里输入条形码" title="条形码" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">单件重量:</td>
								<td><input type="text" onInput="clearNoNum(this)" name="PL_WEIGHT" id="PL_WEIGHT" value="${pd.PL_WEIGHT}" maxlength="32" placeholder="这里输入重量(单位kg)" title="重量" style="width:98%;"/></td>
								<td style="width:75px;text-align: right;padding-top: 13px;">单价:</td>
								<td><input type="text" onInput="clearNoNum(this)" name="PL_PRICE" id="PL_PRICE" value="${pd.PL_PRICE}" maxlength="32" placeholder="这里输入单价" title="单价" style="width:98%;"/></td>
							</tr>
							
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">生产国:</td>
								<td><input type="text" name="PL_PRO_COUNTRY" id="PL_PRO_COUNTRY" value="${pd.PL_PRO_COUNTRY}" maxlength="50" placeholder="这里输入生产国" title="生产国" style="width:98%;"/></td>
							    <td style="width:75px;text-align: right;padding-top: 13px;">HS编码:</td>
								<td><input type="text" name="PL_PRO_ENTERPRISES" id="PL_PRO_ENTERPRISES" value="${pd.PL_PRO_ENTERPRISES}" maxlength="120" placeholder="这里输入HS编码" title="HS编码" style="width:98%;"/></td>
							</tr>
			   
			   
			            <%--
					        <tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">采购国:</td>
								<td><input type="text" name="PL_PUR_COUNTRY" id="PL_PUR_COUNTRY" value="${pd.PL_PUR_COUNTRY}" maxlength="120" placeholder="这里输入采购国" title="采购国" style="width:98%;"/></td>
							    <td style="width:75px;text-align: right;padding-top: 13px;">原产国:</td>
								<td><input type="text" name="PL_ORIGIN" id="PL_ORIGIN" value="${pd.PL_ORIGIN}" maxlength="120" placeholder="这里输入原产国" title="原产国" style="width:98%;"/></td>
							</tr> 
						--%>
			
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">配料及成分说明:</td>
								<td colspan="3">
								   <textarea rows="3" cols="100" name="PL_EXPLAIN" id="PL_EXPLAIN" maxlength="255" placeholder="这里输入配料及成分说明" title="配料及成分说明">${pd.PL_EXPLAIN}</textarea>
								</td>
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
			if($("#PL_CODE").val()==""){
				$("#PL_CODE").tips({
					side:3,
		            msg:'请输入产品内部代码',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#PL_CODE").focus();
			return false;
			}
			if($("#PL_TYPE").val()==""){
				$("#PL_TYPE").tips({
					side:3,
		            msg:'请输入产品类别',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#PL_TYPE").focus();
			return false;
			}
			if($("#PL_BRAND").val()==""){
				$("#PL_BRAND").tips({
					side:3,
		            msg:'请输入品牌',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#PL_BRAND").focus();
			return false;
			}
			if($("#PL_NAME").val()==""){
				$("#PL_NAME").tips({
					side:3,
		            msg:'请输入商品名称',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#PL_NAME").focus();
			return false;
			}
			if($("#PL_WEIGHT").val()==""){
				$("#PL_WEIGHT").tips({
					side:3,
		            msg:'请输入重量',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#PL_WEIGHT").focus();
			return false;
			}
			if($("#PL_PRICE").val()==""){
				$("#PL_PRICE").tips({
					side:3,
		            msg:'请输入单价',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#PL_PRICE").focus();
			return false;
			}
			if($("#PL_PRO_COUNTRY").val()==""){
				$("#PL_PRO_COUNTRY").tips({
					side:3,
		            msg:'请输入生产国',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#PL_PRO_COUNTRY").focus();
			return false;
			}
			if($("#BAR_CODE ").val()==""){
				$("#BAR_CODE ").tips({
					side:3,
		            msg:'请输入条形码',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#BAR_CODE ").focus();
			return false;
			}
			if($("#PL_EXPLAIN").val()==""){
				$("#PL_EXPLAIN").tips({
					side:3,
		            msg:'请输入配料及成分说明',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#PL_EXPLAIN").focus();
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