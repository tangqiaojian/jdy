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
					     
					      <form action="storeOrder/order_store_details_0.do" method="post" name="Form" id="Form">
					        <input type="hidden" id="ORDER_ID" name="ORDER_ID" value="${order.ORDER_ID }">
					      </form>
					      
					 
					      <div id="zhongxin" style="padding-top: 13px;">
					      
					      <table id="table_report" class="table table-striped table-bordered table-hover">
					            <tr> 
					              <td>订单号：${order.ORDERNO }</td>
					              <td>寄件人:${order.SENDER }</td>
					              <td>寄件人电话:${sender.pHONE }</td>
					              <td></td>
					            </tr>
					            <tr>
					              <td>收件人：${order.ADDRESSEE }</td>
					              <td>电话:${adderssee.PHONE }</td>
					              <td>地址:${fn:replace(adderssee.S_ADDRESS, ",", "")}${adderssee.D_ADDRESS }</td>
					              <td>邮编:${adderssee.ZIP_CODE }</td>
					            </tr>
					             
					             <tr>
					              <td>身份证：${adderssee.CARD_NO }</td>
					              <td><a href="javaScript:;" id="CARD_NO" OPPOSITE ='${adderssee.OPPOSITE }' FACE='${adderssee.FACE }'  } >[身份证图片]</a>
					              </td>
					              <td></td>
					              <td><button id="xgsjr" ORDER_ID=${order.ORDER_ID }>修改</button></td>
					            </tr>
					       </table>
					      
					       <table id="table_report_5" class="table table-striped table-bordered table-hover">
	                        <thead>
					         <tr>
							    <td>类型</td>
							    <td>品牌</td>
							    <td>品名</td>
							    <td>规格</td>
							    <td>数量</td>
							    <td>单价</td>
							    <td>条形码</td>
							    <td><button id="Pack">打包勾选产品</button></td>
							 </tr>   
							</thead>
							
							 <c:forEach items="${order.parcelArticles }"  var="p">
							    <tr id="${p.PARCELARTICLES_ID }">
							       <td>${p.PA_TYPE }</td>
							       <td>${p.PA_BRAND }</td>
							       <td>${p.PA_PM }</td>
							       <td>${p.PA_SPEC }</td>
							       <td>${p.PA_COUNT }</td>
							       <td>${p.PA_PRICE }</td>
							        <td>${p.BAR_CODE }</td>
							       <td>
							            <c:if test="${p.IS_PACK== '0' }">
							                <input type="checkbox" name="gxwp" value="${p.PARCELARTICLES_ID }">
                                            
                                            &nbsp;
							                <!-- 修改删除 -->
							                 <a class="btn btn-xs btn-success" title="编辑" onclick="edit_parcelarticles('${p.PARCELARTICLES_ID}');">
												<i class="ace-icon fa fa-pencil-square-o bigger-120" title="编辑"></i>
										     </a>
			
										     <a class="btn btn-xs btn-danger" onclick="del_parcelarticles('${p.PARCELARTICLES_ID}');">
												<i class="ace-icon fa fa-trash-o bigger-120" title="删除"></i>
										      </a>
							               
							            </c:if>
							       </td>
							    </tr>
							 </c:forEach>
					      </table>
					    
					    <div class="page-header position-relative">
						  <table style="width:100%;">
							<tr>
								<td style="vertical-align:top;">
									<a class="btn btn-mini btn-success" onclick="add_parcelarticles('${order.ORDER_ID }');">新增</a>
								</td>
							</tr>
						 </table>
						</div>
					      
					      
					       <input type="hidden" id="isEmptyParcels" value="${empty order.parcels }" >
					       <!-- 包裹信息 -->
					       <table id="pack_info" class="table table-striped table-bordered table-hover">
					          <c:forEach items="${order.parcels }" var="parcel" >
					              
					           <%--    <tr style="text-align: right;">
					                  <td colspan="7"><div style="margin-right:10px">快递（${parcel.COURIER}）单号 : ${parcel.LOGISTICS }</div></td>  
					              </tr> --%>
					              <tr style="text-align: center;">
					                 <td>${parcel.PACK_NAME }</td>
					                 <td>类型: ${parcel.PACK_TYPE_NAME }</td>
					                 <td>收费标准${parcel.FEE_SCALE }元/磅</td>
					                 <td>打包重量: ${parcel.WEIGHT }元/磅</td>
					                 <td>包材费用: ${parcel.PACK_COST }元</td>
					                 <td>总费用: ${parcel.TOTAL_COST }元</td>
					                 <td>
					                      <%-- <a class="btn btn-xs btn-success" title="打印面单" onclick="printFaceSheet('${parcel.PARCEL_ID}');">
											     [打印面单]
										  </a> --%>
					                      
					                      <a class="btn btn-xs btn-success" title="编辑" onclick="edit('${parcel.PARCEL_ID}');">
												<i class="ace-icon fa fa-pencil-square-o bigger-120" title="编辑"></i>
										  </a>
										  
					                      <a class="btn btn-xs btn-danger" onclick="del('${parcel.PARCEL_ID}');">
											 <i class="ace-icon fa fa-trash-o bigger-120" title="删除"></i>
								          </a>
					                 </td>
					              </tr>
					               
					          </c:forEach>
					       </table>
					       
					     
		
					        <!-- 确定揽收 -->
					        <table id="pack_info" class="table table-striped table-bordered table-hover">
									<tr>
										<td style="text-align: center;" colspan="10">
										    <a class="btn btn-mini btn-primary"  id="confirmCollect">确认揽收</a>
										</td>
									</tr>
							</table>
					         

					      
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
</div>
<!-- /.main-container -->


	<!-- 页面底部js¨ -->
	<%@ include file="../../system/index/foot.jsp"%>
	<!-- 下拉框 -->
	<script src="static/ace/js/chosen.jquery.js"></script>
	<!-- 日期框 -->
	<script src="static/ace/js/date-time/bootstrap-datepicker.js"></script>
	
	<script type="text/javascript" src="static/czzx/js/layer.js"></script>
	
	<!-- 删除时确认窗口 -->
	<script src="static/ace/js/bootbox.js"></script>
	
	<!--提示框-->
	<script type="text/javascript" src="static/js/jquery.tips.js"></script>
		<script type="text/javascript">
		$(top.hangge());
	
		function tosearch(){
			top.jzts();
			$("#Form").submit();
		}
		
		var layerindex;
		 
		$(function() {
			//日期框
			$('.date-picker').datepicker({autoclose: true,todayHighlight: true});
			
		    //勾选物品打包	
		    $("#Pack").click(function(){
		    	var checkBox=$("input[name='gxwp']:checked");
		    	if(checkBox.size()==0){
		    		layer.msg('请勾选寄件物品',{time:1000});
		    		return false;
		    	}
		    	var ids=new Array();
		    	$.each(checkBox,function(index,obj){
		              ids.push($(this).val());
		        });
				 top.jzts();
				 var diag = new top.Dialog();
				 diag.Drag=true;
				 diag.Title ="";
				 diag.URL = "<%=basePath%>storeOrder/toPack.do?ORDER_ID="+'${order.ORDER_ID }'+"&ids="+ids.toString();
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
		    });
		   
		    
		    
		    $("#confirmCollect").click(function(){ 	    	
		    	var ORDER_ID = $("#ORDER_ID").val();
		    	bootbox.confirm("确定要揽收该订单吗?", function(result) {
					//请打包包裹
		    		if(result) {
		    			var isEmptyParcels=$("#isEmptyParcels").val();
		    			if(isEmptyParcels=="true"){
		    				layer.msg('请先打包包裹',{time:1000});
		    			}else{
		    				top.jzts();
							var url = "<%=basePath%>storeOrder/confirmCollect?ORDER_ID="+ORDER_ID+"&tm="+new Date().getTime();
							$.get(url,function(data){
								 location.href="<%=basePath%>order/order_1_details?dy=1&ORDER_ID="+ORDER_ID;
							});	
		    			}
					}
				});
		    	
		    });
		    //-----------//
			// 修改用户信息 根据订单主键
			$("#xgsjr").click(function(){
				var ORDER_ID =$(this).attr("ORDER_ID");
				if(ORDER_ID!=null && ORDER_ID!=''){
					var index=layer.open({
					    type: 2,
			            title: '修改收件人信息',
			            shadeClose: true,
			            shade: 0.3,
			            maxmin: true, //开启最大化最小化按钮
			            area: ['800px', '600px'],
			            content: "<%=basePath%>storeOrder/to_updateRS.do?ORDER_ID="+ORDER_ID,
			            offset:'auto'
					   //这里content是一个DOM，这个元素要放在body根节点下
				   });		
				}
			}); 
		
		});
		
		
		

		
		//修改
		function edit(Id){
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="";
			 diag.URL = '<%=basePath%>parcel/goEdit.do?PARCEL_ID='+Id;
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
		
		
		//删除
		function del(Id){
			bootbox.confirm("确定要删除吗?", function(result) {
				if(result) {
					top.jzts();
					var url = "<%=basePath%>parcel/delete.do?PARCEL_ID="+Id+"&tm="+new Date().getTime();
					$.get(url,function(data){
						tosearch();
					});
				}
			});
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
		            area: ['400px', '600px'],
		            content: "<%=basePath%>parcel/printFaceSheet.do?PARCEL_ID="+PARCEL_ID,
		            offset:'auto'
				   //这里content是一个DOM，这个元素要放在body根节点下
			   });	
			}
		}
		
	   //修改寄件物品
	   function edit_parcelarticles(PARCELARTICLES_ID){
		   if(PARCELARTICLES_ID !=null && PARCELARTICLES_ID!=''){
				var index=layer.open({
				    type: 2,
		            title: '物品信息',
		            shadeClose: true,
		            shade: 0.3,
		            maxmin: true, //开启最大化最小化按钮
		            area: ['400px', '600px'],
		            content: "<%=basePath%>storeOrder/goEdit.do?PARCELARTICLES_ID="+PARCELARTICLES_ID,
		            offset:'auto'
				   //这里content是一个DOM，这个元素要放在body根节点下
			   });	
			}
	   }
	   
		
	   // 删除物品
	   function del_parcelarticles(Id){
			bootbox.confirm("确定要删除吗?", function(result) {
				if(result) {
					top.jzts();
					var url = "<%=basePath%>storeOrder/delete.do?PARCELARTICLES_ID="+Id+"&tm="+new Date().getTime();
					$.get(url,function(data){
						tosearch();
					});
				}
		   });
	  }
	 
	  // 新增
	 function add_parcelarticles(ORDER_ID){
		 if(ORDER_ID !=null && ORDER_ID!=''){
				/*var index=layer.open({
				    type: 2,
		            title: '新增物品',
		            shadeClose: true,
		            shade: 0.3,
		            maxmin: true, //开启最大化最小化按钮
		            area: ['400px', '600px'],
		            content: "<%=basePath%>storeOrder/goAdd.do?ORDER_ID="+ORDER_ID,
		            offset:'auto'
				   //这里content是一个DOM，这个元素要放在body根节点下
			   });*/
             top.jzts();
             var diag = new top.Dialog();
             diag.Drag = true;
             diag.Title = "新增物品";
             diag.URL = "<%=basePath%>storeOrder/goAdd.do?ORDER_ID="+ORDER_ID;
             diag.Width = 400;
             diag.Height = 500;
             diag.Modal = true;				//有无遮罩窗口
             diag.ShowMaxButton = true;	//最大化按钮
             diag.ShowMinButton = true;		//最小化按钮
             diag.CancelEvent = function () { //关闭事件
                 diag.close();
                 tosearch();
             };
             diag.show();
			}
	 }
	  
	  
	 // 查看身份证图片 
	 $(function(){
		$("#CARD_NO").click(function(){
			  var FACE = $(this).attr("FACE");
			  var OPPOSITE = $(this).attr("OPPOSITE");
			  if((FACE ==null || FACE=='') && (OPPOSITE==null || OPPOSITE=='')){
				  layer.msg("暂无证件照");
				  return false;
			  } 
			  var str='<div style="margin-top: 5%">';
			  if(FACE !=null && FACE!=''){
				   str+='<span>正面:&nbsp;&nbsp;</span>';
				   str+='<img alt="" width="160px" height="100px" src="<%=basePath %>'+ FACE +' ">'
				   str+='<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>';
			   }
			  if(OPPOSITE!=null && OPPOSITE!=''){
				  str +='<span>反面:&nbsp;&nbsp;</span>'; 
				  str += '<img alt="" width="160px" height="100px" src="<%=basePath %>'+OPPOSITE+' ">';
			  }
			  str+='</div>';
			  layer.open({
				  type: 1,
				  title: '身份证展示', //不显示标题
				  skin: 'layui-layer-rim', //加上边框
				  area: ['480px', '240px'], //宽高
				  content:  str
			  });
		}) ;
	 });
	 
	 

	</script>
</body>
</html>