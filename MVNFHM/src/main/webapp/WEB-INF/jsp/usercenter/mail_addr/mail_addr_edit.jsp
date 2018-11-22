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
										<div class="form-group"  style="width: 80%" >
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
										style="margin-top: 9%;margin-left: 17%;width: 70%;line-height: 28px;"
										type="button" value="确定">
								</div>
							</div>

							<!-- ############################################################################################### -->
 
 
					<form action="mail_addr/${msg }.do" name="Form" id="Form" method="post" enctype="multipart/form-data">
						<input type="hidden" name="MAIL_ADDR_ID" id="MAIL_ADDR_ID" value="${pd.MAIL_ADDR_ID}"/>
						<input type="hidden"  name="M_TYPE" id="M_TYPE"  value="${pd.M_TYPE}">
						<div id="zhongxin" style="padding-top: 13px;">
						<table id="table_report" class="table table-striped table-bordered table-hover">
							
							<tr>
								<td style="width:100px;text-align: right;padding-top: 13px;">
								  <c:choose>
									      <c:when test="${pd.M_TYPE=='0'}">
									          寄件人
									      </c:when>
									      <c:otherwise>
									           收件人
									      </c:otherwise>
									    </c:choose>
								</td>
								<td><input type="text" name="SENDER" id="SENDER" value="${pd.SENDER}" maxlength="32" placeholder="这里输入${pd.M_TYPE=='0'?'寄件人':'收件人'}" title="${pd.M_TYPE=='0'?'寄件人':'收件人'}" style="width:98%;"/></td>
							</tr>
							
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">联系电话:</td>
								<td><input type="text" name="PHONE" id="PHONE" value="${pd.PHONE}" maxlength="15" placeholder="这里输入联系电话" title="联系电话" style="width:98%;"/></td>
							</tr>
							
		
						    <c:if test="${pd.M_TYPE=='1'}">
						      <tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">收件地址</td>
								<td>
								    <input type="text" readonly="readonly" name="S_ADDRESS_SHOW" id="S_ADDRESS_SHOW" class="S_ADDRESS"  value="${fn:replace(pd.S_ADDRESS,',','')}" maxlength="255" placeholder="这里选择收件地址" title="收件地址" style="width:98%;"/>
									<input type="hidden" name="S_ADDRESS" id="S_ADDRESS" value="${pd.S_ADDRESS}" />    
								</td>
							 </tr>
						       
						     <tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">详细地址:</td>
								<td><input type="text" name="D_ADDRESS" id="D_ADDRESS" value="${pd.D_ADDRESS}" maxlength="255" placeholder="这里输入详细地址" title="详细地址" style="width:98%;"/></td>
							 </tr>
						       
							 
							 <tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">邮编:</td>
								<td><input type="text" name="ZIP_CODE" id="ZIP_CODE" value="${pd.ZIP_CODE}" maxlength="15" placeholder="这里输入邮编" title="邮编" style="width:98%;"/></td>
							  </tr>
						    
						     <tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">身份证号码:</td>
								<td><input type="text" name="CARD_NO" id="CARD_NO" value="${pd.CARD_NO}" maxlength="18" placeholder="这里输入身份证号码" title="身份证号码" style="width:98%;"/></td>
							 </tr> 
						    
						     <tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">身份证正反面:</td>
								<td>
								     
								     <div  class="tp_2">
								           正面
								     </div>
								     <div  class="tp">      
										   <img id="header_1" ${pd.FACE==null?"":"height='100px' width='120px'"}  onclick="addPic(1)" src="<%=basePath%>${pd.FACE==null?'static/images/files/default.png':pd.FACE }"  style="cursor: pointer;"/>
									       <input type="file" accept='image/png,image/jpeg,image/gif' class="thumbnailFile" name="thumbnailFile_1"  style="display: none" />
									 </div>
									
									 <div  class="tp_2">
								           反面
								     </div>
									 <div class="tp">
										   <img id="header_2" ${pd.OPPOSITE==null?"":"height='100px' width='120px'"}  onclick="addPic(2)" src="<%=basePath%>${pd.OPPOSITE==null?'static/images/files/default.png': pd.OPPOSITE }"  style="cursor: pointer;"/>
										   <input type="file" accept='image/png,image/jpeg,image/gif' class="thumbnailFile" name="thumbnailFile_2"  style="display: none" />
									 </div>
								</td>
							 </tr>

						    </c:if>
								
							<tr>
								<td style="text-align: center;" colspan="10">
									<a class="btn btn-mini btn-primary" onclick="save();">保存</a>
									<a class="btn btn-mini btn-danger" onclick="top.Dialog.close();">取消</a>
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
	
		<script type="text/javascript">
		$(top.hangge());
		//保存
		function save(){
			if($("#SENDER").val()==""){
				$("#SENDER").tips({
					side:3,
		            msg:'请输入姓名',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#SENDER").focus();
			return false;
			}
			if($("#PHONE").val()==""){
				$("#PHONE").tips({
					side:3,
		            msg:'请输入联系电话',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#PHONE").focus();
			return false;
			}
	
		
	
			var flag = '${pd.M_TYPE}';
				if (flag == '1') {
					
					var myreg=/^[1][3,4,5,7,8][0-9]{9}$/;
		            if (!myreg.test($("#PHONE").val())) {
		            	$("#PHONE").tips({
							side:3,
				            msg:'请输入有效的电话号码',
				            bg:'#AE81FF',
				            time:2
				        });
						$("#PHONE").focus();
					  return false;
		            }
					
					
					if ($("#S_ADDRESS").val() == "") {
						$("#S_ADDRESS").tips({
							side : 3,
							msg : '请输入地址',
							bg : '#AE81FF',
							time : 2
						});
						$("#S_ADDRESS").focus();
						return false;
					}
					if ($("#D_ADDRESS").val() == "") {
						$("#D_ADDRESS").tips({
							side : 3,
							msg : '请输入详细地址',
							bg : '#AE81FF',
							time : 2
						});
						$("#D_ADDRESS").focus();
						return false;
					}
					
					if ($("#CARD_NO").val() == "") {
						$("#CARD_NO").tips({
							side : 3,
							msg : '请输入身份证号码',
							bg : '#AE81FF',
							time : 2
						});
						$("#CARD_NO").focus();
						return false;
					}
					
					var regIdNo = /(^\d{18}$)|(^\d{17}(\d|X|x)$)/;
					if(!regIdNo.test($("#CARD_NO").val())){ 
						$("#CARD_NO").tips({
							side : 3,
							msg : '身份证号码错误',
							bg : '#AE81FF',
							time : 2
						});
						$("#CARD_NO").focus();
						return false;
				    }
					
				}
				$("#Form").submit();
				$("#zhongxin").hide();
				$("#zhongxin2").show();
			}

			$(function() {
				//日期框
				$('.date-picker').datepicker({
					autoclose : true,
					todayHighlight : true
				});

				$(".S_ADDRESS").on("click", function() {
					var index = layer.open({
						type : 1,
						title : "请选择省市",
						area : [ '300px', '270px' ],
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
                if (district2 == "" && ADDR_ZDY == "") {
                    layer.msg("请选择区或自定义")
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