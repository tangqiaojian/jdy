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
						
						<div class="tabbable">
						<ul class="nav nav-tabs" id="myTab">
						       <c:forEach items="${parcels }" var="var" varStatus="idx">
						         <c:choose>
						            <c:when test="${idx.index==0}">
						                <li class="active"><a data-toggle="tab" href="#_${var.PARCEL_ID }"><i class="green icon-home bigger-110"></i>快递单号:${var.LOGISTICS }</a></li>
						            </c:when>
						            <c:otherwise> 
						                <li><a data-toggle="tab" href="#_${var.PARCEL_ID }"><i class="green icon-cog bigger-110"></i>快递单号: ${var.LOGISTICS }</a></li>
						            </c:otherwise>
						         </c:choose>
						       </c:forEach>     
				        </ul>
				        
						
						<div class="tab-content">
    
                                <c:forEach items="${parcels }" var="var" varStatus="idx">
                                 
						         <c:choose>
						            <c:when test="${idx.index==0}">
						                <div id="_${var.PARCEL_ID }" class="tab-pane in active">

											   <table id="table_report"
															class="table table-striped table-bordered table-hover">
															<tr>
																<td width="15%">${fn:substring(var.order.CREATETIME, 0, 10)}</td>
																<td colspan="2">订单号：${var.order.ORDERNO }</td>
																<td colspan="2">默认揽收门店:${empty var.order.STORENAME?"外部excel导入":var.order.STORENAME }</td>
															</tr>

															<tr>
																<td><strong>寄件人信息</strong></td>
																<td>姓名：${var.sender.sENDER }</td>
																<td colspan="2">电话：${var.sender.pHONE }</td>
																<td colspan="3">联系地址：${var.sender.s_ADDRESS }
																	${var.sender.d_ADDRESS }</td>
															</tr>

															<tr>
																<td><strong>收件人信息</strong></td>
																<td>姓名：${var.addressee.SENDER }</td>
																<td colspan="2">电话：${var.addressee.PHONE }</td>
																<td colspan="3">联系地址：${fn:replace(var.addressee.S_ADDRESS,',','') } ${var.addressee.D_ADDRESS }</td>
															</tr>
											    </table>


														<table id="table_report_2"
												class="table table-striped table-bordered table-hover">
												<tr>
													<c:choose>
													    <c:when test="${not empty var.LOGISTICS}">
													     <td>寄件物品信息</td>
													     <td>运单(${var.COURIER})单号:${var.LOGISTICS }</td>
													     <td><a class="ckwlxx" href="javascript:void(0);" PARCEL_ID="${var.PARCEL_ID }">[查看物流]</a>							     
													         <a href="javascript:void(0);"onclick="printFaceSheet('${var.PARCEL_ID}');">
													              [打印面单]		
													         </a>
													     </td>
													    </c:when>
													    <c:otherwise>
													      <td colspan="3">寄件物品信息</td>
													    </c:otherwise>
													</c:choose>
												</tr>
                                                
                                                 <c:forEach items="${var.parcelArticles }" var="pa">
													  <tr>
														 <td>${pa.PA_TYPE }</td>
														 <td>${pa.PA_PM }</td>
														 <td>${pa.PA_COUNT }件</td>
													 </tr>
												</c:forEach>
												<tr>
													<td colspan="3" style="text-align: right;">
													      <c:if test="${not empty var.reweighting }">二次称重: ${var.reweighting } (KG)</c:if> &nbsp;&nbsp;&nbsp;&nbsp;重量: ${var.WEIGHT } (磅)  &nbsp;&nbsp;&nbsp;&nbsp;  共计:${var.parcelArticlesCount} 件&nbsp;&nbsp;&nbsp;&nbsp; 运费 ${var.TOTAL_COST }元&nbsp;&nbsp;&nbsp;&nbsp; 
													</td>
												</tr>
											</table>
						                </div>
						            </c:when>
						            
				
						            
						            <c:otherwise> 
						                  
						                  <div id="_${var.PARCEL_ID }" class="tab-pane">
						                     
						                      <table id="table_report"
															class="table table-striped table-bordered table-hover">
															<tr>
																<td width="15%">${fn:substring(var.order.CREATETIME, 0, 10)}</td>
																<td colspan="2">订单号：${var.order.ORDERNO }</td>
																<td colspan="2">默认揽收门店:${empty var.order.STORENAME?"外部excel导入":var.order.STORENAME }</td>
															</tr>

															<tr>
																<td><strong>寄件人信息</strong></td>
																<td>姓名：${var.sender.sENDER }</td>
																<td colspan="2">电话：${var.sender.pHONE }</td>
																<td colspan="3">联系地址：${var.sender.s_ADDRESS }
																	${var.sender.d_ADDRESS }</td>
															</tr>

															<tr>
																<td><strong>收件人信息</strong></td>
																<td>姓名：${var.addressee.SENDER }</td>
																<td colspan="2">电话：${var.addressee.PHONE }</td>
																<td colspan="3">联系地址：${fn:replace(var.addressee.S_ADDRESS,',','') } ${var.addressee.D_ADDRESS }</td>
															</tr>
											 </table>
						                     
						                     
						                     <table id="table_report_3"
												class="table table-striped table-bordered table-hover">
												<tr>
													<c:choose>
													    <c:when test="${not empty var.LOGISTICS}">
													     <td>寄件物品信息</td>
													     <td> 运单(${var.COURIER})单号:${var.LOGISTICS }</td>
													     <td><a class="ckwlxx" href="javascript:void(0);" PARCEL_ID="${var.PARCEL_ID }">[查看物流]</a>
													         <a href="javascript:void(0);"onclick="printFaceSheet('${var.PARCEL_ID}');">
													              [打印面单]		
													         </a>
													     
													     </td>
													    </c:when>
													    <c:otherwise>
													      <td colspan="3">寄件物品信息</td>
													    </c:otherwise>
													</c:choose> 

												</tr>
												<c:forEach items="${var.parcelArticles }" var="pa">
													<tr>
														<td>${pa.PA_TYPE }</td>
														<td>${pa.PA_PM }</td>
														<td>${pa.PA_COUNT }件</td>
													</tr>
												</c:forEach>
												<tr>
													<td colspan="3" style="text-align: right;">
													          <c:if test="${not empty var.reweighting }">二次称重: ${var.reweighting } (KG)</c:if> &nbsp;&nbsp;&nbsp;&nbsp;重量: ${var.WEIGHT } (磅)  &nbsp;&nbsp;&nbsp;&nbsp;  共计:${var.parcelArticlesCount} 件&nbsp;&nbsp;&nbsp;&nbsp; 运费 ${var.TOTAL_COST }元&nbsp;&nbsp;&nbsp;&nbsp; 
													</td>
												</tr>
											</table> 		
						                 </div>   
						            </c:otherwise>
						            
						         </c:choose>
						       </c:forEach>  
                                        
		
                         </div>
						
				        </div>	
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
	
     <script type="text/javascript" src="static/czzx/js/layer.js"></script>
	<!--提示框-->
	<script type="text/javascript" src="static/js/jquery.tips.js"></script>
	<script type="text/javascript">
		$(top.hangge());
		
		$(function() {
			//日期框
			$('.date-picker').datepicker({autoclose: true,todayHighlight: true});
			
			$(".ckwlxx").click(function(){
				var PARCEL_ID = $(this).attr("PARCEL_ID");
				var index=layer.open({
				    type: 2,
		            title: '物流信息',
		            shadeClose: true,
		            shade: 0.3,
		            maxmin: true, //开启最大化最小化按钮
		            area: ['800px', '400px'],
		            content: "<%=basePath%>parcel/logistics_information.do?PARCEL_ID="+PARCEL_ID,
		            offset:'auto'
				   //这里content是一个DOM，这个元素要放在body根节点下
			  });	
		   });
		
		});
		
		//详情
		function details(Id){
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="";
			 diag.URL = '<%=basePath%>HqWarehouse/details_2.do?PALLET_NO='+Id;
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
		
		
		// 面单预览
		function printFaceSheet(PARCEL_ID){
			if(PARCEL_ID!=null && PARCEL_ID!=''){
				var index=layer.open({
				    type: 2,
		            title: '打印面单',
		            shadeClose: true,
		            shade: 0.3,
		            maxmin: true, //开启最大化最小化按钮
		            area: ['480px', '700px'],
		            content: "<%=basePath%>parcel/printFaceSheet.do?PARCEL_ID="+PARCEL_ID,
		            offset:'auto'
				   //这里content是一个DOM，这个元素要放在body根节点下
			   });	
			}
		}

	</script>
</body>
</html>