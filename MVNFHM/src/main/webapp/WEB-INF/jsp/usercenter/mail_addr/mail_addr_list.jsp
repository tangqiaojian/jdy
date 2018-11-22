<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
						<form action="mail_addr/list.do" method="post" name="Form" id="Form">
						   <table style="margin-top:5px;"></table>
						</form>
						
						<!-- 检索  -->
						<div class="tab-content" style="margin-top:25px;">

									<ul class="nav nav-tabs" id="myTab">
										<li class="active"><a data-toggle="tab" href="#_M_TYPE_0"><i
												class="green icon-home bigger-110"></i>寄件人</a></li>
										<li><a data-toggle="tab" href="#_M_TYPE_1"><i
												class="green icon-cog bigger-110"></i>收件人</a></li>
									</ul>

									<div id="_M_TYPE_0" class="tab-pane in active">
										<table id="simple-table" class="table table-striped table-bordered table-hover" style="margin-top: 5px;">
											<thead>
					                            <tr>
													<th class="center">寄件人</th>
													<th class="center">联系电话</th>
													<!-- <th class="center">身份证号</th> -->
													<th class="center">默认寄件人</th>
													<th class="center">操作</th>
												</tr>
											</thead>

											<tbody>
												<!-- 开始循环 -->
												<c:choose>
													<c:when test="${not empty varList}">
														<c:if test="${QX.cha == 1 }">
															<c:forEach items="${varList}" var="var" varStatus="vs">
																<tr>
																	<td class='center'>${var.SENDER}</td>
																	<td class='center'>${var.PHONE}</td>
																	<%-- <td class='center'>${var.CARD_NO}</td> --%>
																	<td class='center'>
																	      <label class="pos-rel"><input
																			type="checkbox" class="0" name='IS_DEFAULT'
																			${var.IS_DEFAULT=='1'?"checked disabled='disabled' ":"" }
																			value="${var.MAIL_ADDR_ID}" class="ace" /><span
																			class="lbl"></span></label>
																	</td>
																	<td class="center">
																		<div class="hidden-sm hidden-xs btn-group">
																				<a class="btn btn-xs btn-success" title="编辑" onclick="edit('${var.MAIL_ADDR_ID}');"> 
																				   <i class="ace-icon fa fa-pencil-square-o bigger-120" title="编辑"></i>
																				</a>
																				<a class="btn btn-xs btn-danger" onclick="del('${var.MAIL_ADDR_ID}');"> 
																				    <i class="ace-icon fa fa-trash-o bigger-120" title="删除"></i>
																				</a>
																		</div>
																		
																		<div class="hidden-md hidden-lg">
																			
																			<div class="inline pos-rel">
																				<button
																					class="btn btn-minier btn-primary dropdown-toggle"
																					data-toggle="dropdown" data-position="auto">
																					<i class="ace-icon fa fa-cog icon-only bigger-110"></i>
																				</button>

																				<ul class="dropdown-menu dropdown-only-icon dropdown-yellow dropdown-menu-right dropdown-caret dropdown-close">
																						<li><a style="cursor: pointer;"
																							onclick="edit('${var.MAIL_ADDR_ID}');"
																							class="tooltip-success" data-rel="tooltip"
																							title="修改"> <span class="green"> <i
																									class="ace-icon fa fa-pencil-square-o bigger-120"></i>
																							</span>
																						</a></li>
																	
																						<li><a style="cursor: pointer;"
																							onclick="del('${var.MAIL_ADDR_ID}');"
																							class="tooltip-error" data-rel="tooltip"
																							title="删除"> 
																							 <span class="red"> <i class="ace-icon fa fa-trash-o bigger-120"></i> </span>
																						    </a>
																						</li>
																				</ul>
																			</div>
																		</div></td>
																</tr>

															</c:forEach>
														</c:if>
													</c:when>
													<c:otherwise>
														<tr class="main_info">
															<td colspan="100" class="center">没有相关数据</td>
														</tr>
													</c:otherwise>
												</c:choose>
											</tbody>
										</table>

										<div class="page-header position-relative">
											<table style="width: 100%;">
												<tr>
													<td style="vertical-align: top;"><c:if
															test="${QX.add == 1 }">
															<a class="btn btn-mini btn-success" onclick="add(0);">新增</a>
														</c:if></td>
												</tr>
											</table>
										</div>

									</div>
                                    
                                    <!----------------------------------------------------------------------------------------- -->

									<div id="_M_TYPE_1" class="tab-pane">
										<table id="simple-table"
											class="table table-striped table-bordered table-hover"
											style="margin-top: 5px;">
											<thead>
												<tr>
													<th class="center">收件人</th>
													<th class="center">收件地址</th>
													<th class="center">详细地址</th>
													<th class="center">联系电话</th>
													<th class="center">身份证号</th>
													<th class="center">默认收件人</th>
													<th class="center">操作</th>
												</tr>
											</thead>

											<tbody>
												<!-- 开始循环 -->
												<c:choose>
													<c:when test="${not empty varList_2}">
														<c:if test="${QX.cha == 1 }">
															<c:forEach items="${varList_2}" var="var" varStatus="vs">
																<tr>
																	<td class='center'>${var.SENDER}</td>
																	<td class='center'>${fn:replace(var.S_ADDRESS,',','')}</td>
																	<td class='center'>${var.D_ADDRESS}</td>
																	<td class='center'>${var.PHONE}</td>
																	<td class='center'>${var.CARD_NO}</td>

																	<td class='center'>
																	      <label class="pos-rel"><input
																			type="checkbox" class="1" name='IS_DEFAULT'
																			${var.IS_DEFAULT=='1'?"checked disabled='disabled' ":"" }
																			value="${var.MAIL_ADDR_ID}" class="ace" /><span
																			class="lbl"></span></label>
																	 </td>

																	<td class="center">
																		<div class="hidden-sm hidden-xs btn-group">
																				<a class="btn btn-xs btn-success" title="编辑"
																					onclick="edit('${var.MAIL_ADDR_ID}');"> <i
																					class="ace-icon fa fa-pencil-square-o bigger-120"
																					title="编辑"></i>
																				</a>
																				<a class="btn btn-xs btn-danger"
																					onclick="del('${var.MAIL_ADDR_ID}');"> <i
																					class="ace-icon fa fa-trash-o bigger-120"
																					title="删除"></i>
																				</a>										
																		</div>
																		<div class="hidden-md hidden-lg">
																			<div class="inline pos-rel">
																				<button
																					class="btn btn-minier btn-primary dropdown-toggle"
																					data-toggle="dropdown" data-position="auto">
																					<i class="ace-icon fa fa-cog icon-only bigger-110"></i>
																				</button>

																				<ul
																					class="dropdown-menu dropdown-only-icon dropdown-yellow dropdown-menu-right dropdown-caret dropdown-close">
																					
																						<li><a style="cursor: pointer;"
																							onclick="edit('${var.MAIL_ADDR_ID}');"
																							class="tooltip-success" data-rel="tooltip"
																							title="修改"> <span class="green"> <i
																									class="ace-icon fa fa-pencil-square-o bigger-120"></i>
																							</span>
																						</a></li>
																				
																				
																						<li><a style="cursor: pointer;"
																							onclick="del('${var.MAIL_ADDR_ID}');"
																							class="tooltip-error" data-rel="tooltip"
																							title="删除"> <span class="red"> <i
																									class="ace-icon fa fa-trash-o bigger-120"></i>
																							</span>
																						</a></li>
																				
																				</ul>
																			</div>
																		</div>
																	</td>
																</tr>
															</c:forEach>
														</c:if>
													</c:when>
													<c:otherwise>
														<tr class="main_info">
															<td colspan="100" class="center">没有相关数据</td>
														</tr>
													</c:otherwise>
												</c:choose>
											</tbody>
										</table>

										<div class="page-header position-relative">
											<table style="width: 100%;">
												<tr>
													<td style="vertical-align: top;"><c:if
															test="${QX.add == 1 }">
															<a class="btn btn-mini btn-success" onclick="add(1);">新增</a>
														</c:if></td>
												</tr>
											</table>
										</div>


									</div>

								</div>
                           <!-- --------------------------------------------------------------------------------------- -->
					
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
			<i class="ace-icon fa fa-angle-double-up icon-only bigger-110"></i>
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
		
		//新增
		function add(M_TYPE){
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="新增";
			 diag.URL = '<%=basePath%>mail_addr/goAdd.do?M_TYPE='+M_TYPE;
			 diag.Width = 800;
			 diag.Height = 480;
			 diag.Modal = true;				//有无遮罩窗口
			 diag. ShowMaxButton = true;	//最大化按钮
		     diag.ShowMinButton = true;		//最小化按钮
			 diag.CancelEvent = function(){ //关闭事件
				 if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
					 if('${page.currentPage}' == '0'){
						 tosearch();
					 }else{
						 tosearch();
					 }
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
					var url = "<%=basePath%>mail_addr/delete.do?MAIL_ADDR_ID="+Id+"&tm="+new Date().getTime();
					$.get(url,function(data){
						tosearch();
					});
				}
			});
		}
		
		//修改
		function edit(Id){
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="编辑";
			 diag.URL = '<%=basePath%>mail_addr/goEdit.do?MAIL_ADDR_ID='+Id;
			 diag.Width = 800;
			 diag.Height = 480;
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
		
		
	
		$(function(){
			$("#M_TYPE").change(function(){
				tosearch();
			});
			
			//修改默认状态
		    $("input[name='IS_DEFAULT']").click(function(){
		    	var ids=$(this).val();
		    	if(ids != null && ids !=''){
		    		 $.ajax({
		    			 type: "POST",
						 url: '<%=basePath%>mail_addr/editDefault.do?tm='+new Date().getTime(),
					     data: {'MAIL_ADDR_ID':ids,'M_TYPE':'${pd.M_TYPE}'},
						 cache: false,
						 success: function(data){
							 tosearch();
						 }
		    		 });
		    	}
		    });
			
			
		    $("input[name='IS_DEFAULT']").click(function(){
		    	var ids=$(this).val();
		    	var M_TYPE=$(this).attr("class");
		    	
		    	if(ids != null && ids !=''){
		    		 $.ajax({
		    			 type: "POST",
						 url: '<%=basePath%>mail_addr/editDefault.do?tm='+new Date().getTime(),
					     data: {'MAIL_ADDR_ID':ids,'M_TYPE': M_TYPE},
						 cache: false,
						 success: function(data){
							 tosearch();
						 }
		    		 });
		    	}
		    });
			
		});
		
	</script>


</body>
</html>