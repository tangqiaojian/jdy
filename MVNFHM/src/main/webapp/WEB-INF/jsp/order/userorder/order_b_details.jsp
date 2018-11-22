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
							   <td colspan="2">默认揽收门店:${empty order.STORENAME?"外部excel导入":order.STORENAME }</td>
							   <td>运费: ${order.FREIGHT }元 &nbsp;<c:if test="${not empty order.DISCOUNT }">(${order.DISCOUNT }折)</c:if></td>
							   <td>
							       <a href="javaScript:void(0)" id="kdjd" ORDER_ID="${order.ORDER_ID }">处理进度</a>
							   </td>
							</tr>
							
							<tr>
							   <td><strong>寄件人信息</strong></td>
							   <td>姓名：${sender.sENDER }</td>
							   <td colspan="2">电话：${sender.pHONE }</td>
							   <td colspan="3">联系地址：${sender.s_ADDRESS } ${sender.d_ADDRESS }</td>
							</tr>
							
							<tr>
							   <td><strong>收件人信息</strong></td>
							   <td>姓名：${adderssee.SENDER }</td>
							   <td colspan="2">电话：${adderssee.PHONE }</td>
							   <td colspan="3">联系地址：${fn:replace(adderssee.S_ADDRESS,',','') } ${adderssee.D_ADDRESS }</td>
							</tr>
						  
						  <c:if test="${pd.dy==1}">
							<tr style="text-align: right;">
							  <td colspan="9">
								  <a href="javascript:void(0);" onclick="printFaceSheet_store('${order.ORDER_ID}');"> [打印面单收据] &nbsp; </a>
							  </td>
							</tr>
						   </c:if>
						   
						</table>
						
						
						
						<div class="tabbable">
						
						<ul class="nav nav-tabs" id="myTab">
						       <c:forEach items="${order.parcels }" var="var" varStatus="idx">
						         <c:choose>
						            <c:when test="${idx.index==0}">
						                <li class="active"><a data-toggle="tab" href="#_${var.PARCEL_ID }"><i class="green icon-home bigger-110"></i>${var.PACK_NAME }</a></li>
						            </c:when>
						            <c:otherwise> 
						                <li><a data-toggle="tab" href="#_${var.PARCEL_ID }"><i class="green icon-cog bigger-110"></i>${var.PACK_NAME }</a></li>
						            </c:otherwise>
						         </c:choose>
						       </c:forEach>     
				        </ul>
				        
						
						<div class="tab-content">
                                
                                <c:forEach items="${order.parcels }" var="var" varStatus="idx">
                                 
						         <c:choose>
						            <c:when test="${idx.index==0}">
						                <div id="_${var.PARCEL_ID }" class="tab-pane in active">
						                    
						                  <table id="table_report_2"
												class="table table-striped table-bordered table-hover">
												
												<tr>
													<c:choose>
													    <c:when test="${not empty var.LOGISTICS}">
													     <td>寄件物品信息</td>
													     <td colspan="2">运单(${var.COURIER})单号:${var.LOGISTICS }</td>
													     <td colspan="2"><a class="ckwlxx" href="javascript:void(0);" PARCEL_ID="${var.PARCEL_ID }">[查看物流]</a>
													         <c:if test="${pd.dy==1}">
													              <a href="javascript:void(0);"onclick="printFaceSheet('${var.PARCEL_ID}');">
													                 [打印面单]		
													              </a>
													          </c:if>  											     
													     </td>
													    </c:when>
													    <c:otherwise>
													      <td colspan="3">寄件物品信息</td>
													      <td colspan="2" PARCEL_ID="${var.PARCEL_ID }" class="againGetWaybillNo"><a href="JavaScript:void(0);">重新获取单号</a></td>
													    </c:otherwise>
													</c:choose>
												</tr>
												
												<c:forEach items="${order.parcelArticles }" var="pa">
													<c:if test="${fn:indexOf(var.GOODS_PK, pa.PARCELARTICLES_ID)!=-1}">
														  <tr>
															   <td>${pa.PA_TYPE }</td>
															   <td>${pa.PA_BRAND }</td>
															   <td>${pa.PA_PM }</td>
															   <td>${pa.PA_SPEC }</td>
															   <td>${pa.PA_COUNT }件</td>
														 </tr>
													</c:if>
												</c:forEach>
												<tr>
													<td colspan="5" style="text-align: right;">
													      共计:${var.parcelArticlesCount} 件&nbsp;&nbsp;&nbsp;&nbsp; 重量: ${var.WEIGHT } (磅)  &nbsp;&nbsp;&nbsp;&nbsp; 运费 ${var.TOTAL_COST }元&nbsp;&nbsp;&nbsp;&nbsp; 
													</td>
												</tr>
											</table>
											
											
											<c:if test="${_username == order.CREATEBY }">
											
											 <table id="table_report_4" class="table table-striped table-bordered table-hover" style="margin-top: 20px">

															<c:if test="${not empty var.msgBoards }">
																<c:forEach items="${var.msgBoards }" var="mb">
																	<tr>
																		<td>${mb.CREATETIME }</td>
																		<td>${mb.REMARKS }</td>
																		<td>处理情况:${mb.STATE=='0'?'待处理':'已处理' }</td>
																	</tr>
																</c:forEach>
															</c:if>

															
															<tr style="text-align: right;">
																	<td colspan="3">
																	    <input style="color: red;" PARCEL_ID="${var.PARCEL_ID }" LOGISTICS=${var.LOGISTICS }  class="ycxxbb" type="button" value="异常信息报备">
																	</td>
														  </tr>
											 </table>
											  
											 </c:if>

						                </div>
						            </c:when>
						            
				
						            
						            <c:otherwise> 
						                  
						                  <div id="_${var.PARCEL_ID }" class="tab-pane">
						                     
						                     <table id="table_report_3"
												class="table table-striped table-bordered table-hover">
												<tr>
													
													
													<c:choose>
													    <c:when test="${not empty var.LOGISTICS}">
													     <td>寄件物品信息</td>
													     <td colspan="2"> 运单(${var.COURIER})单号:${var.LOGISTICS }</td>
													     <td colspan="2"><a class="ckwlxx" href="javascript:void(0);" PARCEL_ID="${var.PARCEL_ID }">[查看物流]</a> 
													          <c:if test="${pd.dy==1}">
													              <a href="javascript:void(0);"onclick="printFaceSheet('${var.PARCEL_ID}');">
													                 [打印面单]		
													              </a>
													          </c:if> 
													     </td>
													    </c:when>
													    <c:otherwise>
													      <td colspan="3">寄件物品信息</td>
													      <td colspan="2" PARCEL_ID="${var.PARCEL_ID }" class="againGetWaybillNo"><a href="JavaScript:void(0);">重新获取单号</a></td>
													    </c:otherwise>
													</c:choose>
													
													
													
												</tr>
												<c:forEach items="${order.parcelArticles }" var="pa">
													<c:if test="${fn:indexOf(var.GOODS_PK, pa.PARCELARTICLES_ID)!=-1}">
													<tr>
														      <td>${pa.PA_TYPE }</td>
															   <td>${pa.PA_BRAND }</td>
															   <td>${pa.PA_PM }</td>
															   <td>${pa.PA_SPEC }</td>
															   <td>${pa.PA_COUNT }件</td>
													</tr>
													</c:if>
												</c:forEach>
												<tr>
													<td colspan="5" style="text-align: right;">
													          共计:${var.parcelArticlesCount}  件&nbsp;&nbsp;&nbsp;&nbsp; 重量: ${var.WEIGHT } (磅)  &nbsp;&nbsp;&nbsp;&nbsp; 运费: ${var.TOTAL_COST }元 &nbsp;&nbsp;&nbsp;&nbsp; 
													</td>
												</tr>
											</table>

											<table id="table_report_4" class="table table-striped table-bordered table-hover" style="margin-top: 20px">

															<c:if test="${_username == order.CREATEBY }">
																
																<c:if test="${not empty msgBoards }">
																<c:forEach items="${msgBoards }" var="mb">
																	<tr>
																		<td>${mb.CREATETIME }</td>
																		<td>${mb.REMARKS }</td>
																		<td>处理情况:${mb.STATE=='0'?'待处理':'已处理' }</td>
																	</tr>
																</c:forEach>
															    </c:if>
									
																<tr style="text-align: right;">
																	<td colspan="3">
																	   <input style="color: red;" PARCEL_ID="${var.PARCEL_ID }" LOGISTICS=${var.LOGISTICS }  class="ycxxbb" type="button" value="异常信息报备">
																	</td>
																</tr>
															</c:if>


														</table>


													</div>   
						            </c:otherwise>
						            
						         </c:choose>
						       </c:forEach>  
                                   
		
                         </div>
						
				    </div>
						<!--  -->
					
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
		
		
		$(function(){
			$("#kdjd").click(function(){
				 var ORDER_ID=$(this).attr("ORDER_ID");
				 var index=layer.open({
					    type: 2,
			            title: '订单处理日志',
			            shadeClose: true,
			            shade: 0.3,
			            maxmin: true, //开启最大化最小化按钮
			            area: ['800px', '400px'],
			            content: "<%=basePath%>order/logistics_information.do?ORDER_ID="+ORDER_ID,
			            offset:'auto'
					   //这里content是一个DOM，这个元素要放在body根节点下
				});	 
			 });
			
			
			$(".ycxxbb").click(function(){
				var PARCEL_ID = $(this).attr("PARCEL_ID");
				var LOGISTICS = $(this).attr("LOGISTICS");
				
				var str_ ="";
				str_ += '<table id="pack_info" class="table table-striped table-bordered table-hover" style="text-align: center;margin-top:26px;" >';
				str_ += '<tr><td>快递单号：&nbsp;&nbsp;&nbsp;<input readonly id="ORDER_PK" name="ORDER_PK" value="'+LOGISTICS+'" style="width:70%;line-height:30px" > <input type="hidden"  value="'+PARCEL_ID+'" id="PARCEL_ID_bak"></td></tr>';
				str_ += '<tr><td>下单时间： &nbsp;<input readonly id="ORDER_TIME" name="ORDER_TIME" value="'+'${order.CREATETIME }'+'" style="width:70%;line-height:30px" ></td></tr>';
				str_ += '<tr><td>备注：  <textarea id="REMARKS" name="REMARKS" style="width:80%;line-height:30px"></textarea></td></tr>';
				str_ += '<tr><td><a class="btn btn-mini btn-primary" id="tjly">提交</a></td></tr>';
				str_ += '</table>';
		    	//自定页
		    	layerindex = layer.open({
		    	  type: 1,
		    	  skin: 'layui-layer-molv', //样式类名
		    	  closeBtn: 1, //不显示关闭按钮
		    	  anim: 2,
		    	  area: ['380px', '350px'],
		    	  shadeClose: false, //开启遮罩关闭
		    	  content: str_
		    	});	
				 
			});
			
		});

		
		//提交异常信息
		$(document).on("click", "#tjly", function(){
			var ORDER_PK = $("#ORDER_PK").val();
			var ORDER_TIME = $("#ORDER_TIME").val();
			var REMARKS = $("#REMARKS").val();
			var ORDER_ID= $("#PARCEL_ID_bak").val();
			//alert(ORDER_ID);
			if($("#REMARKS").val() == ""){
				layer.msg('请填写备注信息!',{time:1000});
			    return false;
			}
			$.ajax({
				type: "POST",
				url: '<%=basePath%>msg_board/save.do?tm='+new Date().getTime(),
		    	data: {"ORDER_PK":ORDER_PK,"ORDER_TIME":ORDER_TIME,"REMARKS":REMARKS,"ORDER_ID":ORDER_ID},
				dataType:'json',
				cache: false,
				success: function(data){
					if(data.flag){
						layer.close(layerindex);
						layer.msg("提交成功",{time:1000}); 
						
					}else{
						layer.msg(data.msg,{time:1000});
					}
				}
			});	
		});
		
		
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
		
		//面单收据
		function printFaceSheet_store(ORDER_ID){
			if(ORDER_ID!=null && ORDER_ID!=''){
				var index=layer.open({
				    type: 2,
		            title: '面单收据',
		            shadeClose: true,
		            shade: 0.3,
		            maxmin: true, //开启最大化最小化按钮
		            area: ['420px', '600px'],
		            content: "<%=basePath%>storeOrder/receipt_details.do?ORDER_ID="+ORDER_ID,
		            offset:'auto'
				   //这里content是一个DOM，这个元素要放在body根节点下
			   });	
			}
		}
		
		
		$(function(){
		
			$(".againGetWaybillNo").click(function(){
				var PARCEL_ID=$(this).attr("PARCEL_ID");
				if(PARCEL_ID!=null && PARCEL_ID!=''){
					var index = layer.load(1, {
						  shade: [0.1,'#fff'] //0.1透明度的白色背景
					});
					$.ajax({
						type: "POST",
						url: '<%=basePath%>storeOrder/againGetWaybillNo.do?tm='+new Date().getTime(),
				    	data: {"parcelId":PARCEL_ID},
						dataType:'json',
						cache: false,
						success: function(data){
							if(data.code== 00){
								location.reload();
							}else{
								layer.msg(data.msg,{time:1000});
							}
						}
					});	
				}
			});

			
		});
		
		</script>
</body>
</html>