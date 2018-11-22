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
					
						<div id="zhongxin" style="padding-top: 13px;">
						<table id="table_report" class="table table-striped table-bordered table-hover">
							<tr>
							   <td width="15%">${fn:substring(order.CREATETIME, 0, 10)}</td>
							   <td colspan="2">订单号：${order.ORDERNO }</td>
							   <td>默认揽收门店:${order.STORENAME }</td>
							   <td>
							      <c:choose>
							        <c:when test="${pd.readyOnly==1 }">
							        
							        </c:when>
							        <c:otherwise>
							           <a class="btn btn-mini btn-primary" href="order/goEdit.do?ORDER_ID=${order.ORDER_ID }">修改订单</a>
							        </c:otherwise>
							      
							      </c:choose>
							   
							      
							   </td>
							   
							</tr>
							
							<tr>
							   <td><strong>寄件人信息</strong></td>
							   <td>姓名：${sender.sENDER }</td>
							   <td>电话：${sender.pHONE }</td>
							   <td colspan="2"> 联系地址：${sender.s_ADDRESS } ${sender.d_ADDRESS }</td>
							</tr>
							
							<tr>
							   <td><strong>收件人信息</strong></td>
							   <td>姓名：${adderssee.SENDER }</td>
							   <td>电话：${adderssee.PHONE }</td>
							   <td colspan="2">
							     
							      收件地址：${fn:replace(adderssee.S_ADDRESS, ',', '')}${adderssee.D_ADDRESS }
							 </td>
							</tr>
						</table>
						
						
						<table id="table_report" class="table table-striped table-bordered table-hover">
							<tr>
							   <td colspan="5">寄件物品信息</td>
							</tr>
							
							<c:forEach items="${order.parcelArticles }" var="pa">
							<tr>
							   <td>${pa.PA_TYPE }</td>
							   <td>${pa.PA_BRAND }</td>
							   <td>${pa.PA_PM }</td>
							   <td>${pa.PA_SPEC }</td>
							   <td>${pa.PA_COUNT }件</td>
							</tr>
							</c:forEach>
							
						</table>
						
						
						
						</div>
						<div id="zhongxin2" class="center" style="display:none"><br/><br/><br/><br/><br/><img src="static/images/jiazai.gif" /><br/><h4 class="lighter block green">提交中...</h4></div>

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
		
		$(function() {
			//日期框
			$('.date-picker').datepicker({autoclose: true,todayHighlight: true});
		});
		</script>
</body>
</html>