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
					    
					    <form action="mail_addr/accountInfo.do" method="post" name="Form" id="Form"></form>
					    
					    
					    
					    <table id="table_report" class="table table-striped table-bordered table-hover" style="margin-top: 35px; width: 60%">
							<tr>
								<td style="width:100px;text-align: right;padding-top: 13px;">
								     账户名:
								</td>
								<td colspan="2">
								   ${user.USERNAME }
								</td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;" >
								   账户等级
								</td>    
								<td colspan="2">
								  ${userLev.LEV_NAME }
								</td>
								<%-- <td style="text-align: right;color: red">
								    您已下订单${_count_sum._count}单,${_count_sum._sum}元 &nbsp;&nbsp;&nbsp;
								</td> --%>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">
								     登陆密码
								</td>
								<td colspan="2" style="text-align: right;">
								    <a href="javaScript:;" id="changePwd">【修改】</a>&nbsp;&nbsp;&nbsp;
								</td>
							</tr>
							<tr>
							    <td style="width:75px;text-align: right;padding-top: 13px;">
								     默认门店
								</td>    
								<td>
								   ${stores.S_NAME }
								</td>
								<td style="text-align: right;">
								   <a href="javaScript:;" id="changeCity">【修改】</a>&nbsp;&nbsp;&nbsp;
								</td>
							</tr>
						
					</table>
					
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
	
    <script src="static/ace/js/chosen.jquery.js"></script>
	
	<script type="text/javascript" src="static/czzx/js/layer.js"></script>
	<!--提示框-->
	<script type="text/javascript" src="static/js/jquery.tips.js"></script>
		<script type="text/javascript">
		$(top.hangge());
		
		function tosearch(){
			top.jzts();
			$("#Form").submit();
		}
		
		
		//保存		
		$(function() {
			//日期框
			$('.date-picker').datepicker({autoclose: true,todayHighlight: true});
			
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
		
		var layerindex;
		
		$(function(){
			
			//changePwd
			$("#changePwd").click(function(){
				var str_ ="";
				str_ += '<table id="pack_info" class="table table-striped table-bordered table-hover" style="text-align: center;margin-top:26px;" >';
				str_ += '<tr><td>旧密码：     &nbsp;&nbsp;<input type="password"  id="old_pwd" name="old_pwd" style="width:80%;line-height:30px" ></td></tr>';
				str_ += '<tr><td>新密码：      &nbsp;&nbsp;<input type="password"  id="new_pwd" name="new_pwd" style="width:80%;line-height:30px" ></td></tr>';
				str_ += '<tr><td>重复密码：<input type="password" id="again_pwd" name="again_pwd" style="width:80%;line-height:30px" ></td></tr>';
				str_ += '<tr><td><a class="btn btn-mini btn-primary" id="update_pwd">确认修改</a></td></tr>';
				str_ += '</table>';
		
		    	//自定页
		    	layerindex = layer.open({
		    	  title: '修改密码',
		    	  type: 1,
		    	  skin: 'layui-layer-molv', //样式类名
		    	  closeBtn: 1, //不显示关闭按钮
		    	  anim: 2,
		    	  area: ['380px', '350px'],
		    	  shadeClose: false, //开启遮罩关闭
		    	  content: str_
		    	});	
			});
			
			$("#changeCity").click(function(){
				//异步加载数据
				$.ajax({
			         type: "POST",
			         url: '<%=basePath%>client/storeList.do?tm='+new Date().getTime(),
			         dataType:'json',
			         cache: false,
			         success: function(data){
			        
						var str_ ="";
						str_ += '<table id="pack_info" class="table table-striped table-bordered table-hover" style="text-align: center;margin-top:26px;" >';
						str_ += '<tr><td><select id="city"  name="city" style="width:80%;line-height:30px" data-placeholder="请选择默认门店" ><option value=""></option>';
						
						$.each(data, function(i, dvar){
							str_ +="<option value="+dvar.STORE_ID+">"+dvar.S_NAME+"</option>";
					    });
						str_ += '</select></td></tr>';
						str_ += '<tr><td><a class="btn btn-mini btn-primary" id="Support_comit">确认修改</a></td></tr>';
						str_ += '</table>';
						
				    	//自定页
				    	layerindex = layer.open({
				    	  title: '修改默认门店', 
				    	  type: 1,
				    	  skin: 'layui-layer-molv', //样式类名
				    	  closeBtn: 1, //不显示关闭按钮
				    	  anim: 2,
				    	  area: ['380px', '200px'],
				    	  shadeClose: false, //开启遮罩关闭
				    	  content: str_
				    	});	
			            }
				     });
 		           
		        });
			
			

			});

		
		
		//修改发货城市
		$(document).on("click", "#Support_comit", function(){
			if($("#city").val()==""){
				layer.msg('请选择默认门店!',{time:1000});
			    return false;
			}
			$.ajax({
				type: "POST",
				url: '<%=basePath%>mail_addr/changeCity.do?tm='+new Date().getTime(),
		    	data: {"city":$("#city").val()},
				dataType:'json',
				cache: false,
				success: function(data){
					if(data.flag){
						// layer.close(layerindex);
						layer.msg("修改成功",{time:1000}); 
						tosearch();
					}else{
						layer.msg(data.msg,{time:1000});
					}
				}
			});	
			
		});
		
     
		//修改密码
		$(document).on("click", "#update_pwd", function(){
			var old_pwd = $("#old_pwd").val();
			var new_pwd = $("#new_pwd").val();
			var again_pwd = $("#again_pwd").val();
			if($("#old_pwd").val()==""){
				layer.msg('原密码不能为空!',{time:1000});
			    return false;
			}
			if($("#new_pwd").val()==""){
				layer.msg('新密码不能为空!',{time:1000});
			    return false;
			}
			
			if($("#again_pwd").val()==""){
				layer.msg('请重复新密码!',{time:1000});
			    return false;
			}
			if(new_pwd != again_pwd ){
				layer.msg('两次密码不一致!',{time:1000});
			    return false;
			}
			$.ajax({
				type: "POST",
				url: '<%=basePath%>mail_addr/changePwd.do?tm='+new Date().getTime(),
		    	data: {"old_pwd":old_pwd,"new_pwd": new_pwd,"again_pwd":again_pwd},
				dataType:'json',
				cache: false,
				success: function(data){
					if(data.flag){
						layer.close(layerindex);
						layer.msg("修改成功",{time:1000});
					}else{
						layer.msg(data.msg,{time:1000});
					}
				}
			});	
	    }); 
		
		
		</script>
</body>
</html>