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
						<form action="mail_addr/toChoose.do" method="post" name="Form" id="Form">
						<table style="margin-top:5px;">
							<tr>
							   <td>
									<div class="nav-search">
										 <input type="hidden" name="M_TYPE" id="M_TYPE" value="${pd.M_TYPE }">
										<span class="input-icon">
											<input type="text" class="nav-search-input" id="nav-search-input" autocomplete="off" name="keywords" value="${pd.keywords }" placeholder="这里输入关键词(姓名/电话)"/>
											<i class="ace-icon fa fa-search nav-search-icon"></i>
										</span>
									</div>
								</td>

							   <td>							
							     <td style="vertical-align:top;padding-left:2px"><a class="btn btn-light btn-xs" onclick="tosearch();"  title="检索"><i id="nav-search-icon" class="ace-icon fa fa-search bigger-110 nav-search-icon blue"></i></a></td>
							   </td>
							   
							   
							   
							
								<%-- <c:if test="${QX.cha == 1 }">
								   <td style="vertical-align:top;padding-left:2px"><a class="btn btn-light btn-xs" onclick="tosearch();"  title="检索"><i id="nav-search-icon" class="ace-icon fa fa-search bigger-110 nav-search-icon blue"></i></a></td>
								</c:if> --%>
							</tr>
						</table>
						<!-- 检索  -->
					       
					    <div><strong style="position: absolute;right: 20px;top: 10px;"><a href="javaScript:void(0);" onclick="goToJys();">【&darr;】</a></strong></div>   
					       
					       
						<table id="simple-table" class="table table-striped table-bordered table-hover" style="margin-top:5px;">	
							<thead>
								<tr>
								    <th class="center" style="width:35px;">
									   <label class="pos-rel"><span class="lbl"></span></label>
									</th> 
									<th class="center" style="width:50px;">序号</th>
									 <c:choose>
									      <c:when test="${pd.M_TYPE=='0'}">
									         <th class="center">寄件人</th>
									         <th class="center">联系电话</th>
									      </c:when>
									      <c:otherwise>
									        <th class="center">收件人</th>
									         <th class="center">联系电话</th>
									        <th class="center">收件地址</th>
									        <th class="center">详细地址</th>
									        <th class="center">身份证</th>
									      </c:otherwise>
									</c:choose>
								
								
								</tr>
							</thead>
													
							<tbody>
							<!-- 开始循环 -->	
							<c:choose>
								<c:when test="${not empty varList}">
									<c:if test="${QX.cha == 1 }">
									<c:forEach items="${varList}" var="var" varStatus="vs">
										<tr>
											<td class='center'>
												<label class="pos-rel"><input type="radio" name='ids' jsonStr='${var.jsonStr}' personName='${var.SENDER}' value="${var.MAIL_ADDR_ID}" class="ace" /><span class="lbl"></span></label>
											</td>
											<td class='center' style="width: 30px;">${vs.index+1}</td>
											<td class='center'>${var.SENDER} &nbsp; ${var.IS_DEFAULT=='1'?"[默认地址]":""}</td>
											<td class='center'>${var.PHONE}</td>
											<c:if test="${pd.M_TYPE=='1'}">
											   <td class='center'>${var.S_ADDRESS}</td>
											   <td class='center'>${var.D_ADDRESS}</td>
											   <td class='center'>${var.CARD_NO}</td>
											</c:if>						
										</tr>
									</c:forEach>
									</c:if>
									<c:if test="${QX.cha == 0 }">
										<tr>
											<td colspan="100" class="center">您无权查看</td>
										</tr>
									</c:if>
								</c:when>
								<c:otherwise>
									<tr class="main_info">
										<td colspan="100" class="center" >没有相关数据，请先添加</td>
									</tr>
								</c:otherwise>
							</c:choose>
							</tbody>
						</table>
						 
						<div id="bottom_1"></div>
						<div class="page-header position-relative">
						<table style="width:100%;">
							<tr>
								<td style="vertical-align:top;">
                                   <a class="btn btn-mini btn-success" href="<%=basePath %>mail_addr/to_choose_add.do?M_TYPE=${pd.M_TYPE}">新增</a>
                                </td>
							</tr>
						</table>
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
		
		function goToJys() {
	        $("html,body").animate({scrollTop: $("#bottom_1").offset().top}, 500);//定位到《静夜思》
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
			
			
			//选择并关闭
			$("input[name='ids']").click(function(){
				var mtype = '${pd.M_TYPE}';
			    var personName = $(this).attr("personName");
				var jsonStr = $(this).attr("jsonStr");
				if(mtype==0)
				 {
					 var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
				     parent.$("#SENDER").val(personName);
				     parent.$("#SENDERSTR").val(jsonStr);
				     parent.layer.close(index); //再执行关闭
				 }
				else if(mtype==1)
				 {
					 var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
				     parent.$("#ADDRESSEE").val(personName);
				     parent.$("#ADDRESSEESTR").val(jsonStr);
				    parent.layer.close(index); //再执行关闭	
				 }	
			});
			
		});
		
		
		
		
		
		
		

	</script>


</body>
</html>