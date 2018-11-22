<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
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
				
	
						<table id="simple-table" class="table table-striped table-bordered table-hover" style="margin-top:5px;">	
							<thead>
								<tr>
								    <th class="center" style="width:35px;">
									   <label class="pos-rel"><span class="lbl"></span></label>
									</th> 
									<th class="center">包材名称</th>
									<th class="center">价格</th>
								</tr>
							</thead>
													
							<tbody>
							<!-- 开始循环 -->	
							<c:choose>
								<c:when test="${not empty varList}">
									<c:forEach items="${varList}" var="var" varStatus="vs">
										<tr>
											<td class='center'>
												
												<c:if test="${fn:indexOf(pd.idStr,var.PACKINGMATERIALS_ID)==-1}">
												 <label class="pos-rel">
												    <input type="checkbox" name='ids' jsonStr='${var.jsonStr}'  value="${var.PACKINGMATERIALS_ID}" class="ace" /><span class="lbl"></span>
												</label>
												</c:if>
											
											</td>
											<td class='center'>${var.PM_NAME}</td>
											<td class='center'>${var.PM_PRICE}</td>										
										</tr>
									</c:forEach>
								</c:when>
								<c:otherwise>
									<tr class="main_info">
										<td colspan="100" class="center" >没有相关数据</td>
									</tr>
								</c:otherwise>
							</c:choose>
							   
							    <tr>
							      <td colspan="3" style="text-align: center;"><a class="btn btn-mini btn-primary" id="choosePack">确定</a></td>
							    </tr>
							
							</tbody>
						</table>
						<div class="page-header position-relative">
						<table style="width:100%;">
							<tr>
								<td style="vertical-align:top;">
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
			$("#choosePack").click(function(){
		        //获取选中的值迭代
				var str="";
				
		        $("input[name='ids']:checked").each(function(i, n){ 
		        	var ids = $(this).val();
				    var jsonStr = $(this).attr("jsonStr");
				    var obj=JSON.parse(jsonStr);
				    
				    parent.packIdArray.push(ids);
				    parent.packInfoArray.push(obj);
				    console.log(obj);
				    obj.COUNT=1;    // 初始化数量为1
				    //拼接包材数据
				    str += "<tr id='"+obj.PACKINGMATERIALS_ID+"'><td>"+obj.PM_NAME+"</td><td>"+obj.PM_PRICE+"元/个</td>";
				    
				    str += "<td>";
				    str += "<div style='overflow:hidden;width:139.2px;height:34.8px;border: 1px solid #CCC;'>";
				    str += "<div class='reduce' onselectstart='return false;' style='-moz-user-select:none;cursor:pointer;text-align:center;width:34.8px;height:34.8px;line-height:34.8px;border-right: 1px solid #CCC;float:left'>-</div>";
				    str += "<input  readonly='readonly' value='1' style='border: medium none; width: 67.6px; height: 34.8px; padding: 0px; margin: 0px; text-align: center; vertical-align: middle; line-height: 34.8px;'>";
				    str += "<div class='plus'  onselectstart='return false;' style='-moz-user-select:none;cursor:pointer;text-align:center;width:34.8px;height:34.8px;line-height:34.8px;border-left: 1px solid #CCC;float:right'> + </div>";
				    str += "</div></td>";
				    
					str += "<td>"+obj.PM_PRICE+"</td></tr>";
				});
				
				var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
				parent.$("#table_report_2").append(str);
				parent.layer.close(index); //再执行关闭
			});
			
		});

	</script>

</body>
</html>