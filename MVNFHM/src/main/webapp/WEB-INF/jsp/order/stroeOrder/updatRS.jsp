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
<style type="text/css">
.spkx {
	margin-left: 1%;
}

.tp {
	width: 120px;
	height: 100px;
	border-style: dashed;
	border-width: 1px;
	border-color: #cccccc;
	text-align: center;
	line-height: 100px;
	float: left;
	margin-left: 3%;
	position: relative;
}

.tp_2 {
	width: 120px;
	height: 100px;
	text-align: center;
	line-height: 100px;
	float: left;
	margin-left: 3%;
	position: relative;
}

.tps {
	width: 120px;
	height: 100px;
	text-align: center;
	line-height: 100px;
	float: left;
	margin-left: 3%;
}

.tps .zoomify_img,.op_content{position: relative;}

.cl {
	position: absolute;
	right: 0px;
	top: 3px;
	z-index: 12;
	opacity: 0.5;
	}
.cl:hover{
		opacity: 1;
	}
	
.form-group{
   margin-top: 15px;
}	
	
</style>


<body class="no-skin">
<!-- /section:basics/navbar.layout -->
<div class="main-container" id="main-container">
	<!-- /section:basics/sidebar -->
	<div class="main-content">
		<div class="main-content-inner">
			<div class="page-content">
				<div class="row">
					<div class="col-xs-12">
					
					 <!-- ############################################################################################### -->

							<div style="display: none; " id="pro-city">
								<form class="form-inline">
									<div data-toggle="distpicker" align="center">
										<div class="form-group"  style="width: 80%;margin-top: 5px;" >
											<label class="sr-only" for="province2">Province</label>
											<select class="form-control" id="province2"  style="width: 70%" data-province="---- 选择省 ----"></select>
										</div>
										<div class="form-group" style="width: 80%">
											<label class="sr-only" for="city2">City</label> 
											<select class="form-control" id="city2"  style="width: 70%" data-city="---- 选择市 ----"></select>
										</div>
										<div class="form-group" style="width: 80%">
											<label class="sr-only" for="district2">District</label>
											<select class="form-control" id="district2"  style="width: 70%" data-district="---- 选择区 ----"></select>
										</div>
										<div class="form-group" style="width: 80%">
											<input type="text" name="ADDR_ZDY" id="ADDR_ZDY" maxlength="32" placeholder="有填写则选择自定义" title="自定义区" style="width:70%;"/>
										</div>
										
									</div>
								</form>
								<div>
									<input onclick="save_city()"
										style="margin-top: 5%;margin-left: 21%;width: 58%;line-height: 28px;"
										type="button" value="确定">
								</div>
							</div>

					 <!-- ############################################################################################### -->
					
					
					
					<form action="storeOrder/updateRS.do" name="Form" id="Form" method="post" enctype="multipart/form-data">
						<input type="hidden" name="ORDER_ID" id="ORDER_ID" value="${order.ORDER_ID}"/>
						<div id="zhongxin" style="padding-top: 13px;">
						<table id="table_report" class="table table-striped table-bordered table-hover">
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">收件人:</td>
								<td><input type="text" name="SENDER" id="SENDER" value="${adderssee.SENDER}" maxlength="50" placeholder="这里输入收件人" title="收件人" style="width:98%;"/></td>
							</tr>
							
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">电话:</td>
								<td><input type="text" name="PHONE" id="PHONE" value="${adderssee.PHONE}" maxlength="50" placeholder="这里输入收件人电话" title="收件人电话" style="width:98%;"/></td>
							</tr>
							
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">地区:</td>
								<td><input type="text" name="S_ADDRESS_SHOW" id="S_ADDRESS_SHOW" readonly="readonly" value="${fn:replace(adderssee.S_ADDRESS,',','')}" maxlength="50" placeholder="这里地区" title="地区" style="width:98%;"/>
								    <input type="hidden" name="S_ADDRESS" id="S_ADDRESS" readonly="readonly" value="${adderssee.S_ADDRESS}" />
								</td>
							</tr>
							
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">地址:</td>
								<td><input type="text" name="D_ADDRESS" id="D_ADDRESS"  value="${adderssee.D_ADDRESS}" maxlength="50" placeholder="这里输入详细地址" title="详细地址" style="width:98%;"/></td>
							</tr>
							
							
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">邮编:</td>
								<td><input type="text" name="ZIP_CODE" id="ZIP_CODE" value="${adderssee.ZIP_CODE}" maxlength="50" placeholder="这里输入详细地址" title="详细地址" style="width:98%;"/></td>
							</tr>
							
							
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">证件号码:</td>
								<td><input type="text" name="CARD_NO" id="CARD_NO" value="${adderssee.CARD_NO}" maxlength="50" placeholder="这里输入详细地址" title="详细地址" style="width:98%;"/></td>
							</tr>
							
							 <tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">身份证正反面:</td>
								<td>
								     
								     <div  class="tp_2">
								           正面
								     </div>
								     <div  class="tp">      
										   <img id="header_1" ${adderssee.FACE==null?"":"height='100px' width='120px'"}  onclick="addPic(1)" src="<%=basePath%>${adderssee.FACE==null?'static/images/files/default.png':adderssee.FACE }"  style="cursor: pointer;"/>
									       <input type="file" accept='image/png,image/jpeg,image/gif' class="thumbnailFile" name="thumbnailFile_1"  style="display: none" />
									       <input type="hidden" name="FACE_URL" value="${adderssee.FACE }" id="FACE_URL"/>
									 </div>
									
									 <div  class="tp_2">
								           反面
								     </div>
									 <div class="tp">
										   <img id="header_2" ${adderssee.OPPOSITE==null?"":"height='100px' width='120px'"}  onclick="addPic(2)" src="<%=basePath%>${adderssee.OPPOSITE==null?'static/images/files/default.png': adderssee.OPPOSITE }"  style="cursor: pointer;"/>
										   <input type="file" accept='image/png,image/jpeg,image/gif' class="thumbnailFile" name="thumbnailFile_2"  style="display: none" />
									        <input type="hidden" name="OPPOSITE_URL" value="${adderssee.OPPOSITE }" id="OPPOSITE_URL"/>
									 </div>
								</td>
							 </tr>
							
							
							
							<tr>
								<td style="text-align: center;" colspan="10">
									<a class="btn btn-mini btn-primary" onclick="save();">保存</a>
								</td>
							</tr>
						</table>
						</div>
						<div id="zhongxin2" class="center" style="display:none"><br/><br/><br/><br/><br/><img src="static/images/jiazai.gif" /><br/><h4 class="lighter block green">提交中...</h4></div>
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
	<!--jquery需要引入的文件-->
    <script src="static/js/jquery-3.2.1.js"></script>
	<!-- 下拉框 -->
	<script src="static/ace/js/chosen.jquery.js"></script>
	<!-- 日期框 -->
	<script src="static/ace/js/date-time/bootstrap-datepicker.js"></script>
	
	<script type="text/javascript" src="static/czzx/js/layer.js"></script>
	<!--提示框-->
	<script type="text/javascript" src="static/js/jquery.tips.js"></script>
	<script src="static/distpicker/js/distpicker.data.js"></script>
	<script src="static/distpicker/js/distpicker.js"></script>
	<script src="static/distpicker/js/main.js"></script>
	<!--ajax提交表单需要引入jquery.form.js-->
    <script type="text/javascript" src="static/js/jquery.form.js"></script>
		<script type="text/javascript">
		$(top.hangge());
		//保存
		function save(){
			
			if($("#SENDER").val()==""){
				$("#SENDER").tips({
					side:3,
		            msg:'请输入收件人',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#SENDER").focus();
			return false;
			}
			
			if($("#PHONE").val()==""){
				$("#PHONE").tips({
					side:3,
		            msg:'请输入电话',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#PHONE").focus();
			return false;
			}
			
			if($("#S_ADDRESSS").val()==""){
				$("#S_ADDRESSS").tips({
					side:3,
		            msg:'请输入地区,分割',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#S_ADDRESSS").focus();
			return false;
			}
			
			if($("#SENDER").val()==""){
				$("#SENDER").tips({
					side:3,
		            msg:'请输入详细地址',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#SENDER").focus();
			return false;
			}
			
			if($("#ZIP_CODE").val()==""){
				$("#ZIP_CODE").tips({
					side:3,
		            msg:'请输入邮编',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#ZIP_CODE").focus();
			return false;
			}
			
			if($("#CARD_NO").val()==""){
				$("#CARD_NO").tips({
					side:3,
		            msg:'请输入证件号码',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#CARD_NO").focus();
			return false;
			}
			
			$("#Form").ajaxSubmit({
		          beforeSubmit:function () {
		            // alert("我在提交表单之前被调用！");
		        	   var index = layer.load(1, {
		        		  shade: [0.1,'#fff'] //0.1透明度的白色背景
		        	  });
		          },
		          success:function (data) {
		        	  if(data){
		        		  parent.tosearch(); 
		                }else{
		                	layer.msg('提交失败', {
	                	        time: 2000, 
	                	 });
		                }
		          }
		   });
			
		}
		
		function save_city() {
			var province = $("#province2").val();
			var city = $("#city2").val();
			var district2 = $("#district2").val();
			var ADDR_ZDY= $("#ADDR_ZDY").val();
			
			if (province == null || province == '') {
				layer.msg("请选择省份")
				return;
			}
			if (city == null || city == '') {
				layer.msg("请选择城市")
				return;
			}
			
			if (ADDR_ZDY == null || ADDR_ZDY == '') {
				$("#S_ADDRESS_SHOW").val(province + city + district2);
			} else {
				district2 = ADDR_ZDY;
				$("#S_ADDRESS_SHOW").val(province + city + district2);
			}

			$("#S_ADDRESS").val(province + "," + city + "," + district2);
			layer.closeAll();
		}
		
		
		$(function() {
			//日期框
			$('.date-picker').datepicker({autoclose: true,todayHighlight: true});
			
			$("#S_ADDRESS_SHOW").on("click", function() {
				var index = layer.open({
					type : 1,
					title : "请选择省市",
					area : [ '300px', '280px' ],
					content : $('#pro-city')
				//这里content是一个DOM，这个元素要放在body根节点下
				});
			});
			
			$("[name=thumbnailFile_1]").bind("change", function() {
				var objUrl = getObjectURL(this.files[0]);
		        var imgSize = this.files[0].size;
				console.log(imgSize);
				if (imgSize > 1 * 1024 * 1024) {
					alert('上传的图片的大于1M,请重新选择');
					$(this).val('')
					return false;
				}
				$("#header_1").css({"width":"120px","height":"100px"});
				$("#header_1").attr("src", objUrl);
				
				
			})

			$("[name=thumbnailFile_2]").bind("change", function() {
				var objUrl = getObjectURL(this.files[0]);
				var imgSize = this.files[0].size;
				console.log(imgSize);
				if (imgSize > 1 * 1024 * 1024) {
					alert('上传的图片的大于1M,请重新选择');
					$(this).val('')
				    return false;
				}
				$("#header_2").css({"width":"120px","height":"100px"})
				$("#header_2").attr("src", objUrl);
			})
			
			
		});
		
		function addPic(type) {
			if (type == 1) {
				$("[name=thumbnailFile_1]").click();
			} else {
				$("[name=thumbnailFile_2]").click();
			}

		}

		function getObjectURL(file) {
			var url = null;
			if (window.createObjectURL != undefined) { // basic
				url = window.createObjectURL(file);
			} else if (window.URL != undefined) { // mozilla(firefox)
				url = window.URL.createObjectURL(file);
			} else if (window.webkitURL != undefined) { // webkit or chrome
				url = window.webkitURL.createObjectURL(file);
			}
			return url;
		}
		
		</script>
</body>
</html>