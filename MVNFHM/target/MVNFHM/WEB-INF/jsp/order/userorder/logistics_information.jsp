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
							   <!-----------------物流信息------------------ -->
						        <h5><strong>订单处理状态:</strong></h5>
						        <div style="text-align: left;">
						           <c:forEach items="${logisticsInfos }"  var="info">
						             <p>${info.STATUS }</p>
						           </c:forEach>
						        </div>
						        
						      <!--   <h5><strong>物流信息:</strong></h5>
						        <div style="text-align: left;" id="wlxx">
						        </div>     -->
						        
						         
						         
						     
					           <!-- ----------  物流信息------------------------ -->
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
	
   <script type="text/javascript">
    /*   $(function(){
    	 //初始化 解析数据  
    	 var logisticsStr='${logisticsStr}';
    	 console.log(logisticsStr);
    	 if(logisticsStr!=null && logisticsStr!=''){
    		 var obj = eval('(' + logisticsStr + ')');
    		 console.log(obj);
    		 var  str="";
    		 $.each(obj.result.list,function(index,o){
    			 str += "<p>"+o.time+" "+o.status+"</p>";
    		 });
    		 $("#wlxx").append(str);
    	 }else{
    		 $("#wlxx").append("<p>暂无数据</p>");
    	 }    	 
      }); */
   </script>
   	

</body>
</html>