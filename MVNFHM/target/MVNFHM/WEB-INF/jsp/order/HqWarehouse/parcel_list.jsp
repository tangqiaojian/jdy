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
							
						<!-- 检索  -->
						<form action="HqWarehouse/list.do" method="post" name="Form" id="Form">
						<table style="margin-top:5px;">
							<tr>
								<td>
									<div class="nav-search">
										<span class="input-icon">
											<input type="text" placeholder="这里输入快递编号" class="nav-search-input" id="nav-search-input" autocomplete="off" name="keywords" value="${pd.keywords }" placeholder="这里输入关键词"/>
											<i class="ace-icon fa fa-search nav-search-icon"></i>
										</span>
									</div>
								</td>
								 
								 <input type="hidden" name="APPLY_STATUS" value="${pd.APPLY_STATUS }" >

								 <td style="vertical-align:top;padding-left:2px"><a class="btn btn-light btn-xs" onclick="tosearch();"  title="检索"><i id="nav-search-icon" class="ace-icon fa fa-search bigger-110 nav-search-icon blue"></i></a></td>
							
							</tr>
						</table>
						<!-- 检索  -->
					
						<table id="simple-table" class="table table-striped table-bordered table-hover" style="margin-top:5px;">	
							<thead>
								<tr>
									<th class="center" style="width:35px;">
									<label class="pos-rel"><input type="checkbox" class="ace" id="zcheckbox" /><span class="lbl"></span></label>
									</th>
									<th class="center" style="width:50px;">序号</th>
                                    <th class="center">快递单号</th>
                                    <c:if test="${pd.APPLY_STATUS=='0' }">
                                      <th class="center">订单单号</th>
                                      <th class="center">收件人</th>
									  <th class="center">下单时间</th>
                                    </c:if>
                                    <c:if test="${pd.APPLY_STATUS=='1' }">
                                      <th class="center">二次称重重量(磅)</th>
									  <th class="center">入库时间</th>
                                    </c:if>
									<th class="center">操作</th>
								</tr>
							</thead>
													
							<tbody>
							<!-- 开始循环 -->	
							<c:choose>
								<c:when test="${not empty varList}">
																	<c:forEach items="${varList}" var="var" varStatus="vs">
										<tr>
											<td class='center'>
												<label class="pos-rel"><input type='checkbox' name='ids' value="${var.PARCEL_ID}" class="ace" /><span class="lbl"></span></label>
											</td>
											<td class='center' style="width: 30px;">${vs.index+1}</td>
									
                                            <td class="center">${var.LOGISTICS}</td>
                                            
                                            <c:if test="${pd.APPLY_STATUS=='0' }">
                                               <td class="center">${var.ORDERNO}</td>
                                               <td class='center'>${var.ADDRESSEE}</td>
											   <td class='center'>${var.CREATETIME}</td>
                                            </c:if>
                                           
                                            <c:if test="${pd.APPLY_STATUS=='1' }">
                                               <td class="center">${var.Reweighting} <%-- <fmt:formatNumber type="number" value="${var.Reweighting * 0.4535924}" pattern="0.00" maxFractionDigits="2"/> --%></td>
                                               <td class='center'>${var.UPDATETIME}</td>
                                            </c:if>
											
											<td class="center">
												<div class="hidden-sm hidden-xs btn-group">
													
													     <a class="btn btn-xs btn-success" title="查看" onclick="details('${var.LOGISTICS}')" >
														       查看
													     </a>
													<c:if test="${pd.APPLY_STATUS=='0' }">
														<a class="btn btn-xs btn-error" title="删除" onclick="del('${var.ORDER_ID}');" >
															删除
														</a>
													</c:if>
												</div>
												
												<div class="hidden-md hidden-lg">
													<div class="inline pos-rel">
														<button class="btn btn-minier btn-primary dropdown-toggle" data-toggle="dropdown" data-position="auto">
															<i class="ace-icon fa fa-cog icon-only bigger-110"></i>
														</button>
			
														<ul class="dropdown-menu dropdown-only-icon dropdown-yellow dropdown-menu-right dropdown-caret dropdown-close">
															 <li>
															   <a style="cursor:pointer;" onclick="details('${var.LOGISTICS}')"  class="tooltip-success" data-rel="tooltip" title="修改">
																  <span class="green">
																		 查看
																   </span>
															   </a>
															 </li>
															<li>
																<a style="cursor:pointer;" onclick="del('${var.ORDER_ID}');" class="tooltip-success" data-rel="tooltip" title="删除">
																	 <span class="green">
																		删除
																	   </span>
																</a>

															</li>
														</ul>
													</div>
												</div>
											</td>
										</tr>
									</c:forEach>
								
									<c:if test="${QX.cha == 0 }">
										<tr>
											<td colspan="100" class="center">您无权查看</td>
										</tr>
									</c:if>
								</c:when>
								<c:otherwise>
									<tr class="main_info">
										<td colspan="100" class="center" >没有相关数据</td>
									</tr>
								</c:otherwise>
							</c:choose>
							</tbody>
						</table>
						<div class="page-header position-relative">
						<table style="width:100%;">
							<tr>
								<td style="vertical-align:top;">
																
								</td>
								<td style="vertical-align:top;"><div class="pagination" style="float: right;padding-top: 0px;margin-top: 0px;">${page.pageStr}</div></td>
							</tr>
						</table>
						</div>
						</form>
					   
					   
					    <c:if test="${pd.APPLY_STATUS =='1'}">
					       <table id="table_report_3" class="table table-striped table-bordered table-hover">
					          <tr>
					           <td style="text-align: center;" colspan="10">
							     <a class="btn btn-mini btn-primary PalletOper" id="Pallet" onclick="makeAll('确定打托?')" >打托</a>
						       </td>
					          </tr>					   
				           </table>
					    </c:if>
					    
                           
                        <c:if test="${pd.APPLY_STATUS =='0'}">
					       <table id="table_report_3" class="table table-striped table-bordered table-hover">
					          <tr>
					           <td style="text-align: center;" colspan="10">
							     <a class="btn btn-mini btn-primary PalletOper" id="Pallet" onclick="makeAll_2('当前未检测到称重设备，点击取消返回上一步，点击确认将使用包裹预填写重量到下一步')" >称重测试</a>
						       </td>
					          </tr>
				           </table>
					    </c:if>

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
			<i class="ace-icon fa fa-angle-double-up icon-only bigger-110" ></i>
		</a>

	</div>
	<!-- /.main-container -->

	<!-- basic scripts -->
	<!-- 页面底部js¨ -->
	<%@ include file="../../system/index/foot.jsp"%>
	<!-- 删除时确认窗口 -->
	<script src="static/ace/js/bootbox.js"></script>
	<!-- ace scripts -->
	<script src="static/ace/js/ace/ace.js"></script>
	<!-- 下拉框 -->
	<script src="static/ace/js/chosen.jquery.js"></script>
	<script type="text/javascript" src="static/js/myjs/head.js"></script>
	
	<script type="text/javascript" src="static/czzx/js/layer.js"></script>
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
		
		
		//详情
		function details(Id){
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="";
			 diag.URL = '<%=basePath%>HqWarehouse/details_1.do?LOGISTICS='+Id;
			 diag.Width = 1000;
			 diag.Height = 800;
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
			
		//导出excel
		function toExcel(){
			window.location.href='<%=basePath%>order/excel.do';
		}
		
		
		//批量操作
		function makeAll(msg){
			bootbox.confirm(msg, function(result) {
				if(result) {
					var str = '';
					for(var i=0;i < document.getElementsByName('ids').length;i++){
					  if(document.getElementsByName('ids')[i].checked){
					  	if(str=='') str += document.getElementsByName('ids')[i].value;
					  	else str += ',' + document.getElementsByName('ids')[i].value;
					  }
					}
					if(str==''){
						bootbox.dialog({
							message: "<span class='bigger-110'>您没有选择任何内容!</span>",
							buttons: 			
							{ "button":{ "label":"确定", "className":"btn-sm btn-success"}}
						});
						$("#zcheckbox").tips({
							side:1,
				            msg:'点这里全选',
				            bg:'#AE81FF',
				            time:8
				        });
						return;
					}else{
						
						if(msg == '确定打托?'){
							top.jzts();
							$.ajax({
								type: "POST",
								url: '<%=basePath%>HqWarehouse/pallet.do?tm='+new Date().getTime(),
						    	data: {DATA_IDS:str},
								dataType:'json',
								//beforeSend: validateData,
								cache: false,
								success: function(data){
									 $.each(data.list, function(i, list){
											tosearch();
									});
								}
							});
						}
						
					}
				}
			});
		};
		
		
		var  selectAllStr;
		//批量操作
		function makeAll_2(msg){
			bootbox.confirm(msg, function(result) {
				if(result) {
					var str = '';
					for(var i=0;i < document.getElementsByName('ids').length;i++){
					  if(document.getElementsByName('ids')[i].checked){
					  	if(str=='') str += document.getElementsByName('ids')[i].value;
					  	else str += ',' + document.getElementsByName('ids')[i].value;
					  }
					}
					if(str==''){
						bootbox.dialog({
							message: "<span class='bigger-110'>您没有选择任何内容!</span>",
							buttons: 			
							{ "button":{ "label":"确定", "className":"btn-sm btn-success"}}
						});
						$("#zcheckbox").tips({
							side:1,
				            msg:'点这里全选',
				            bg:'#AE81FF',
				            time:8
				        });
						return;
					}else{
					    
						selectAllStr = str;
						var str_ ="";
					    str_ += '<table id="pack_info" class="table table-striped table-bordered table-hover" style="text-align: center;margin-top:26px;" >';
					    str_ += '<tr><td><input id="weight" name="weight" placeholder="请填写重量(KG)" style="width:80%;line-height:30px" ></td></tr>';
					    str_ += '<tr><td><a class="btn btn-mini btn-primary" id="Support_FA">下一步</a></td></tr>';
					    str_ += '</table>';	
				    	//自定页
				    	layerindex = layer.open({
				    	  type: 1,
				    	  skin: 'layui-layer-molv', //样式类名
				    	  closeBtn: 1, //不显示关闭按钮
				    	  anim: 2,
				    	  area: ['380px', '200px'],
				    	  shadeClose: false, //开启遮罩关闭
				    	  content: str_
				    	});


						
						
						<%-- if(msg == '当前未检测到称重设备，点击取消返回上一步，点击确认将使用包裹预填写重量到下一步'){
							top.jzts();
							$.ajax({
								type: "POST",
								url: '<%=basePath%>HqWarehouse/pushData.do?tm='+new Date().getTime(),
						    	data: {DATA_IDS:str},
								dataType:'json',
								//beforeSend: validateData,
								cache: false,
								success: function(data){
									 $.each(data.list, function(i, list){
											tosearch();
									});
								}
							});
						} --%>
						
					}
				}
			});
		};
		
		
		
		$(document).on("click", "#Support_FA", function(){
		 	if($("#weight").val()==""){
				layer.msg('请填写重量(磅)!',{time:1000});
			    return false;
			}
			var weight=$("#weight").val();  //托盘号 
			$.ajax({
				type: "POST",
				url: '<%=basePath%>HqWarehouse/pushData.do?tm='+new Date().getTime(),
		    	data: {DATA_IDS:selectAllStr,"weight": weight},
				dataType:'json',
				cache: false,
				success: function(data){
					if(data){
						tosearch();
                        siMenu('z139', 'lm137', '待打托包裹', 'HqWarehouse/list?APPLY_STATUS=1');
					}else{
						layer.msg('二次称重失败!',{time:1000});
					}
				}
			});	
	    });
        //删除
        function del(Id){
            bootbox.confirm("确定要删除吗?", function(result) {
                if(result) {
                    top.jzts();
                    var url = "<%=basePath%>storeOrder/del_order.do?ORDER_ID="+Id+"&tm="+new Date().getTime();
                    $.get(url,function(data){
                        tosearch();
                    });
                }
            });
        }

	</script>


</body>
</html>