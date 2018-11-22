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
							<form action="storeOrder/save.do" name="Form" id="Form" method="post">
						    <table id="table_report" class="table table-striped table-bordered table-hover">
							      <c:choose>
							         <c:when test="${not empty ParcelArticles }">
							    
		                                <tr>
									        <td>类别</td>
									        <td>${ParcelArticles.PA_TYPE }</td>
									        <td>品牌</td>
									         <td>${ParcelArticles.PA_BRAND }</td>
											<input type="hidden" id="PA_TYPE" name="PA_TYPE" value="${ParcelArticles.PA_TYPE }" >
											<input type="hidden" id="PA_BRAND" name="PA_BRAND" value="${ParcelArticles.PA_BRAND }" >
									    </tr>
									    
									    <tr>
									        <td>品名</td>
									        <td>${ParcelArticles.PA_PM }</td>
									        <td>规格</td>
									         <td>${ParcelArticles.PA_SPEC }</td>
											<input type="hidden" id="PA_PM" name="PA_PM" value="${ParcelArticles.PA_PM }" >
											<input type="hidden" id="PA_SPEC" name="PA_SPEC" value="${ParcelArticles.PA_SPEC }" >
									    </tr>
									    
									     <tr>
									        <td>单价</td>
									        <td>${ParcelArticles.PA_PRICE }</td>
									        <td>重量</td>
									         <td>${ParcelArticles.PA_WEIGHT }</td>
											 <input type="hidden" id="PA_PRICE" name="PA_PRICE" value="${ParcelArticles.PA_PRICE }" >
											 <input type="hidden" id="PA_WEIGHT" name="PA_WEIGHT" value="${ParcelArticles.PA_WEIGHT }" >
											 <input type="hidden" id="ORDERID" name="ORDERID" value="${ORDERID }" >
											 <input type="hidden" id="BAR_CODE" name="BAR_CODE" value="${ParcelArticles.BAR_CODE }" >
									    </tr>
		                                 
		                                <tr>
		                                   <td>数量:</td> 
		                                   <td><input id="PA_COUNT" name="PA_COUNT" type="number"><input type="hidden" id="jsonStr" name="jsonStr" ></td>
		                                   <td></td>
		                                    <td></td>
		                                </tr>
					                   
									
									   <tr>
										 <td style="text-align: center;" colspan="10">
											<a class="btn btn-mini btn-primary" id="qdxz">确定新增</a>
											<a class="btn btn-mini btn-danger" id="close">取消</a>
										 </td>
									   </tr>
							        
							        </c:when>
							        <c:otherwise>
							            <tr>
		                                    <td  style="text-align: center;">*查无商品信息</td>
		                                </tr>
					                   
									
									   <tr>
										 <td style="text-align: center;" colspan="10">
											 <a class="btn btn-mini btn-danger" id="close">取消</a>
										 </td>
									   </tr>
							        
							       </c:otherwise>
							  </c:choose>
						</table>
							</form>
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
	<!--提示框-->
	<script type="text/javascript" src="static/js/jquery.tips.js"></script>
<script type="text/javascript" src="static/czzx/js/layer.js"></script>
<!--ajax提交表单需要引入jquery.form.js-->
<script type="text/javascript" src="static/js/jquery.form.js"></script>
	<script type="text/javascript">
		$(top.hangge());
		//保存
		$(function() {
			//日期框
			$('.date-picker').datepicker({autoclose: true,todayHighlight: true});
		     
			$("#close").click(function(){
				 var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
				 parent.layer.close(index); //再执行关闭
			});
			
			//选择并关闭
			$("#qdxz").click(function(){
				var jsonStr ='${jsonStr}';
				if(jsonStr !=null && jsonStr!=''){
					
				    var count=$("#PA_COUNT").val();
					if(count ==null || count ==''){
						$("#PA_COUNT").tips({
							side:3,
				            msg:'请输入数量',
				            bg:'#AE81FF',
				            time:2
				        });
						$("#PA_COUNT").focus();
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
                                top.Dialog.close();
                            }else{
                                layer.msg('提交失败', {
                                    time: 2000,
                                });
                            }
                        }
                    });
				}
			
			});
			
		});
	
	    
		
		
		
	</script>
	
</body>
</html>