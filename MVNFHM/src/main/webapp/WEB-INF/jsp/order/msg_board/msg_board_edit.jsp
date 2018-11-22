<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
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

							<form action="msg_board/edit.do" name="Form" id="Form" method="post">
								<input type="hidden" name="MSG_BOARD_ID" id="MSG_BOARD_ID"
									value="${pd.MSG_BOARD_ID}" />
								<div id="zhongxin" style="padding-top: 13px;">
									<table id="table_report"
										class="table table-striped table-bordered table-hover">
										<c:choose>
											<c:when test="${pd.orderType=='2' }">
												<tr>
													<td
														style="width: 75px; text-align: right; padding-top: 13px;">订单号:</td>
													<td>${pd.ORDERNO}</td>
												</tr>
												<tr>
													<td
														style="width: 75px; text-align: right; padding-top: 13px;">快递单号:</td>
													<td>${pd.ORDER_PK}</td>
												</tr>
											</c:when>
											<c:when test="${pd.orderType=='3' }">
												<tr>
													<td
														style="width: 75px; text-align: right; padding-top: 13px;">快递单号:</td>
													<td>${pd.ORDER_PK}</td>
												</tr>
												<tr>
													<td
														style="width: 75px; text-align: right; padding-top: 13px;">托盘号:</td>
													<td>${pd.PALLET_NO}</td>
												</tr>
												<tr>
													<td
														style="width: 75px; text-align: right; padding-top: 13px;">航班号:</td>
													<td>${pd.AVIATION_NO}</td>
												</tr>
											</c:when>
											<c:otherwise>
												<tr>
													<td
														style="width: 75px; text-align: right; padding-top: 13px;">订单号:</td>
													<td>${pd.ORDERNO}</td>
												</tr>
												<tr>
													<td
														style="width: 75px; text-align: right; padding-top: 13px;">下单时间:</td>
													<td>${pd.ORDER_TIME}</td>
												</tr>
											</c:otherwise>
										</c:choose>
										<tr>
											<td
												style="width: 75px; text-align: right; padding-top: 13px;">备注信息:</td>
											<td><textarea rows="6" cols="6" readonly="readonly"
													name="REMARKS" placeholder="这里输入备注信息" title="备注信息"
													style="width: 98%;" id="REMARKS">${pd.REMARKS}</textarea></td>
										</tr>

										<tr>
											<td style="text-align: center;" colspan="10"><a
												class="btn btn-mini btn-primary" onclick="save();">确认处理</a>
												<a class="btn btn-mini btn-danger"
												onclick="top.Dialog.close();">取消</a></td>
										</tr>
									</table>
								</div>
								<div id="zhongxin2" class="center" style="display: none">
									<br /> <br /> <br /> <br /> <br /> <img
										src="static/images/jiazai.gif" /><br />
									<h4 class="lighter block green">提交中...</h4>
								</div>
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
		function save() {
			$("#Form").submit();
			$("#zhongxin").hide();
			$("#zhongxin2").show();
		}

		$(function() {
			//日期框
			$('.date-picker').datepicker({
				autoclose : true,
				todayHighlight : true
			});
		});
	</script>
</body>
</html>