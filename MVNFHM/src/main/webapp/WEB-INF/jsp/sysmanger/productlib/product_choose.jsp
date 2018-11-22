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
						    <table id="table_report" class="table table-striped table-bordered table-hover">
							      <c:choose>
							         <c:when test="${not empty ParcelArticles }">
							    
		                                <tr>
									        <td>类别</td>
									        <td>${ParcelArticles.PA_TYPE }</td>
									        <td>品牌</td>
									         <td>${ParcelArticles.PA_BRAND }</td>
									    </tr>
									    
									    <tr>
									        <td>品名</td>
									        <td>${ParcelArticles.PA_PM }</td>
									        <td>规格</td>
									         <td>${ParcelArticles.PA_SPEC }</td>
									    </tr>
									    
									     <tr>
									        <td>单价</td>
									        <td>${ParcelArticles.PA_PRICE }</td>
									        <td>重量</td>
									         <td>${ParcelArticles.PA_WEIGHT }</td>
									    </tr>
		                                 
		                                <tr>
		                                   <td>数量:</td> 
		                                   <td><input id="PA_COUNT" name="PA_COUNT" type="number"><input type="hidden" id="jsonStr" name="jsonStr" value='{jsonStr}'></td>
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
					var timestamp=new Date().getTime();
					var  obj=JSON.parse(jsonStr);
					console.log(obj);
					var o = new Object();
		    	    o.PA_TYPE = obj.pA_TYPE;
		    		o.PA_BRAND = obj.pA_BRAND;
		    		o.PA_PM = obj.pA_PM;
		    		o.PA_COUNT = count;
		    		o.PA_SPEC = obj.pA_SPEC;
		    		o.PA_PRICE = obj.pA_PRICE;
		    		o.PA_WEIGHT = obj.pA_WEIGHT;
		    		o.BAR_CODE = obj.bAR_CODE;          // 条形码
		    		o.PL_CODE = obj.pL_CODE;            //商品内部代码
		    		o.ID=timestamp;
		    		var str="";
		    		str+="<tr class='wp'><td>"+obj.pA_TYPE+"</td><td>"+obj.pA_BRAND+"</td><td>"+obj.pA_PM+"</td><td>"+obj.pA_SPEC+"</td><td>"+count+"</td>";
	    			str+="<td><a href='javaScript:void(0)' class='delPA' id="+timestamp+" >删除</a></td></tr>";
	    			
	    			var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
	    			parent.$("#table_report_2").append(str);
	    			parent.myArray.push(o);
	    			parent.layer.close(index); //再执行关 */
				}
			
			});
			
		});
	
	    
		
		
		
	</script>
	
</body>
</html>