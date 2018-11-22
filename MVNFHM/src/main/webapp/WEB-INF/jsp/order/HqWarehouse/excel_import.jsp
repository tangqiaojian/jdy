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
<style type="text/css">
.file-input{
  line-height:30px;
  position:relative;
  margin-top:10px;
}
.file-input .input-container{
  width:200px;
  height:30px;
  text-align:center;
  background:#3879d9;
  color:#fff;
  border-radius:3px;
}
.file-input input{
  width:200px;
  height:30px;
  position:absolute;
  left:0;
  top:0;
  opacity:0;
  cursor:pointer;
}
.file-input #name{
  position:absolute;
  margin-left:5px;
  left:200px;
  top:0;
  font-size:12px;
  color:#666;
}
</style>
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

							<%-- <form action="empinfo/${msg }.do" name="Form" id="Form" method="post" enctype="multipart/form-data"> --%>
							<form action="HqWarehouse/importExcel.do" name="Form" id="Form" method="post" enctype="multipart/form-data">
								<div id="zhongxin" style="padding-top: 13px;">

									<table id="table_report" class="table table-striped table-bordered table-hover">

										<caption style="text-align: center;">
											<h3>外部订单导入 </h3>
										</caption>
										
										<tr>
											<td style="width: 200px;text-align: center; padding-top: 13px;">选择导入文件:</td>
											<td style="width: 500px; text-align: center; padding-top: 13px;">
											 <div class="file-input">
  												<p class="input-container"> Excel文件 
  													<input type="file" id="upload"  name="file" accept="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet,application/vnd.ms-excel"  multiple="multiple">
  												</p>
  												<!-- <span id="name"></span> -->
											</div>
											</td>
										</tr>
										
										<tr>
											<td style="width: 200px;text-align: center; padding-top: 13px;">大客户名称:</td>
											<td style="width: 500px; text-align: center; padding-top: 13px;">
											<div style="width: 200px" >
  											 <select id="customer" name="customer" class="chosen-select form-control" data-placeholder="请选择客户">
  											      <option value=""></option>
  											      <c:forEach items="${customer}" var="c" >
  											         <option value="${c.CUSTOMER_ID }">${c.NICK_NAME }</option>
  											      </c:forEach>  											 
  											  </select>
											</div>
											</td>
										</tr>
										
										<tr>
											<td style="width: 200px; text-align: center; padding-top: 13px;">所选文件:</td>
											<td style="width: 200px; text-align: center; padding-top: 13px;">
											   <div  id="name"  style="position:relative; height:90px; overflow:auto;text-align: left;"></div>
											</td>
										</tr>


										<tr>
											<td style="text-align: center;" colspan="2">
											   <a class="btn btn-mini btn-primary" onclick="save();">导入</a>
											   
											   <a class="btn btn-mini btn-success" onclick="window.location.href='<%=basePath%>/HqWarehouse/downExcel.do'">下载模版</a>
											   
											</td>
										</tr>

									</table>

								</div>
								<div id="zhongxin2" class="center" style="display: none">
									<br /> <br /> <br /> <br /> <br /> <img
										src="static/images/jiazai.gif" /><br />
									<h4 class="lighter block green">提交中...</h4>
								</div>

							</form>

							<div id="zhongxin2" class="center" style="display: none">
								<img src="static/images/jzx.gif" style="width: 50px;" /><br />
								<h4 class="lighter block green"></h4>
							</div>
							<input id="import_flag" type="hidden" value="${codeMsg}"/>
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

	<!--jquery需要引入的文件-->
    <script src="static/js/jquery-3.2.1.js"></script>
    <!--ajax提交表单需要引入jquery.form.js-->
    <script type="text/javascript" src="static/js/jquery.form.js"></script>
	<script type="text/javascript" src="static/czzx/js/layer.js"></script>

	<!-- 日期框 -->
	<script src="static/ace/js/date-time/bootstrap-datepicker.js"></script>
	<!--提示框-->
	<script type="text/javascript" src="static/js/jquery.tips.js"></script>
	<script src="static/ace/js/chosen.jquery.js"></script>
	
	<script type="text/javascript">
		$(top.hangge());
		var index;
		//保存
		function save() {
			if ($("#upload").val() == "") {
				layer.msg('请选择文件', { time: 2000,});
				$("#upload").focus();
				return false;
			}
			if ($("#customer").val() == "") {
				layer.msg('请选择客户名称', { time: 2000,});
				$("#customer").focus();
				return false;
			}
		
			$("#Form").ajaxSubmit({
		          beforeSubmit:function () {
		            // alert("我在提交表单之前被调用！");
		        	   index = layer.load(1, {
		        		  shade: [0.1,'#fff'] //0.1透明度的白色背景
		        	  });
		          },
		          success:function (data) {
		        	  layer.close(index); 
		        	  if(data.flag){
		                	//重置表单
		                	$('#Form')[0].reset();
		                	$('#name').html('');
		                	$("#customer").trigger("chosen:updated");
		                	layer.msg('导入成功', { time: 2000,});
		                }else{
		                	layer.msg('提交失败', {
	                	        time: 2000, 
	                	   });
		               }
		          }
		   });
		}

		$(function() {
			//日期框
			/* $('.date-picker').datepicker({
				autoclose : true,
				todayHighlight : true
			}); */
			
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
		});
		
		//将所选文件显示在文件显示框内
		var upload=document.getElementById('upload');
		upload.onchange=function(){
			
		  var name="";
		 // var name=[];
		  for(var i=0;i<this.files.length;i++){
			name+=this.files[i].name+"<br/>";
		    //name[i]= this.files[i].name;
		    /* if(this.files[i].size>=307200){
		      alert("文件"+this.files[i].name+"过大，不能超过300kb")
		      } */
		  }
		  $("#importMsg").empty();
		 $("#name").html(name);
		};
	</script>
</body>
</html>