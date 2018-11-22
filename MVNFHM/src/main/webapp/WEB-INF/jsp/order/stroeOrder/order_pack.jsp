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
					
					       <!-- js 打印日志按钮 -->
                           <!-- <button id="ce">测试</button>  -->
                           
                           
							<form action="parcel/${msg }.do" name="Form" id="Form" method="post">
								<div id="zhongxin" style="padding-top: 35px;">
									<table id="table_report" class="table table-striped table-bordered table-hover">
										<tr>
											<td style="width: 50%;">
												 <select style="width: 100%" class="chosen-select form-control" name="PACK_TYPE" id="PACK_TYPE" data-placeholder="请选择包裹类型">
													<option value=""></option>
													<c:forEach items="${products }" var="p">
														<option value="${p.PRODUCTMANAGER_ID }" ${pd.PACK_TYPE==p.PRODUCTMANAGER_ID?"selected":"" }>${p.PRO_TYPE }</option>
													</c:forEach>
											     </select>
											</td>
											<td style="width: 50%;">
											     <input type="text" name="WEIGHT" id="WEIGHT"  onInput="clearNoNum(this)" value="${pd.WEIGHT}" maxlength="50" placeholder="这里输入包裹重量(磅)" title="包裹重量(磅)" style="width: 98%;" />
											</td>
										</tr>
										<tr>
											<td colspan="2">
											     <input type="text" name="XM_WEIGHT" id="XM_WEIGHT"  onInput="clearNoNum(this)" value="${pd.WEIGHT}" maxlength="50" placeholder="推送厦门包裹重量(kg)" title="包裹重量(kg)" style="width: 49%;" />
											</td>
										</tr>
										
									</table>
								</div>
								
								<!--  -->
								
								<div id="zhongxin2" class="center" style="display: none">
									<br />
									<br />
									<br />
									<br />
									<br />
									<img src="static/images/jiazai.gif" /><br />
									<h4 class="lighter block green">提交中...</h4>
								</div>
							    
							    <input type="hidden" id="PARCEL_ID" name="PARCEL_ID" value="${pd.PARCEL_ID}">
							    <input type="hidden" id="orderId" name="orderId" value="${ORDER_ID }">
							    <input type="hidden" id="paPks"  name="paPks" >
							    <input type="hidden" id="packInfoArray" name="packInfoArray">
							    
							
							</form>


					<!-- 待打包的物件信息 -->
					<table id="table_report_1" class="table table-striped table-bordered table-hover">
					    <tr>
					      <th colspan="3">寄件物品</th>
					    </tr>
					    
					   
					    <c:forEach items="${parcelArticles }" var="pa">
					       <tr>
					           <td>${pa.PA_PM }</td>
					           <td>${pa.PA_COUNT }</td>
					           <td><a class="delPA" id="${pa.PARCELARTICLES_ID }" href="javaScript:void(0);">删除</a></td>
					       </tr>
					    </c:forEach>
				    </table>
					    
					    	    
					<!-- 包材信息 -->   
					<table id="table_report_2" class="table table-striped table-bordered table-hover">
					    <tr>
						   <td colspan="3"><strong>包材选择</strong></td>
						   <td><button id="choosePack">新增包材</button></td>
						</tr>	
				     </table>
				     
				     
				     <table id="table_report_3" class="table table-striped table-bordered table-hover">
					   <tr>
					      <td style="text-align: center;" colspan="10">
							 <a class="btn btn-mini btn-primary" onclick="save()">打包包裹</a>
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
    <!-- layer 弹出层 -->
    <script type="text/javascript" src="static/czzx/js/layer.js"></script>
    
    
	<!--提示框-->
	<script type="text/javascript" src="static/js/jquery.tips.js"></script>
		<script type="text/javascript">
		$(top.hangge());
		
		var paPks =new Array();       //寄件物品列表
		var packIdArray=new Array();   //包材数组
		var packInfoArray=new Array();   //包材数组

		
		function clearNoNum(obj){ 
		    obj.value = obj.value.replace(/[^\d.]/g,"");  //清除“数字”和“.”以外的字符  
		    obj.value = obj.value.replace(/\.{2,}/g,"."); //只保留第一个. 清除多余的  
		    obj.value = obj.value.replace(".","$#$").replace(/\./g,"").replace("$#$","."); 
		    obj.value = obj.value.replace(/^(\-)*(\d+)\.(\d\d).*$/,'$1$2.$3');//只能输入两个小数  
		    if(obj.value.indexOf(".")< 0 && obj.value !=""){//以上已经过滤，此处控制的是如果没有小数点，首位不能为类似于 01、02的金额 
		        obj.value= parseFloat(obj.value); 
		    } 
		} 
		
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
			
			
			// 选择包材
			$("#choosePack").click(function(){
				//获取已选择的id
				var index=layer.open({
					type: 2,
		            title: '',
		            shadeClose: true,
		            shade: 0.3,
		            maxmin: true, //开启最大化最小化按钮
		            area: ['800px', '400px'],
		            content: "<%=basePath%>packingmaterials/toChoose.do?ids="+packIdArray.toString(),
		            offset:'auto'
				   //这里content是一个DOM，这个元素要放在body根节点下
				});
			});
			
			$("#pack").click(function(){
			      var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
				     //parent.$("#SENDER").val(personName);
				     //parent.$("#SENDERSTR").val(personName);
				   //parent.location.reload(); 刷新无效
				  parent.layer.close(index); //再执行关闭
			});
		
			
			$("#ce").click(function(){
				//console.log(packIdArray);
				console.log(packInfoArray);
				//console.log(paPks);
			});
			
		});
		
		
		//*****************************************************************************************************************//
		//****************************************提交数据*****************************************************************//
		//*****************************************************************************************************************//
		function save(){
			if($("#PACK_TYPE").val()==""){
				$("#PACK_TYPE").tips({
					side:3,
		            msg:'请选择包裹类型',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#PACK_TYPE").focus();
			return false;
			}
			if($("#WEIGHT").val()==""){
				$("#WEIGHT").tips({
					side:3,
		            msg:'请输入包裹打包重量',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#WEIGHT").focus();
			return false;
			}
			if($("#XM_WEIGHT").val()==""){
				$("#XM_WEIGHT").tips({
					side:3,
		            msg:'请输入推送重量',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#XM_WEIGHT").focus();
			return false;
			}

		    $("#paPks").val(paPks.toString());//寄件物品列表
			if(packInfoArray.length>0){
				$("#packInfoArray").val(JSON.stringify(packInfoArray));  //包材数组
			}else{
			    layer.msg('请选择合适的包材', {
	        	     time: 2000, 
	        	 });
				 return false;
			}
			$("#Form").submit();
			$("#zhongxin").hide();
			$("#zhongxin2").show();
		}
		
		
		//*****************************************************************************************************************//
		//****************************************寄件物品信息信息**********************************************************//
		//*****************************************************************************************************************//
		
		//初始化数据
		$(function(){
			var  paStr='${ids}';
			if(paStr!=null && paStr!=''){
				paPks =paStr.split(',');
			}
			
			
		   //初始化包材
		   var packStr = '${pd.PACKJSONARR}' ; 
		   if(packStr!=null && packStr!=''){
	    		var arr=eval(packStr);
	    		var str="";
	    		$.each(arr,function(idx,obj){
	    		    packInfoArray.push(obj);
	    		    packIdArray.push(obj.PACKINGMATERIALS_ID);
                    str += "<tr id='"+obj.PACKINGMATERIALS_ID+"'><td>"+obj.PM_NAME+"</td><td>"+obj.PM_PRICE+"元/个</td>";
				    str += "<td>";
				    str += "<div style='overflow:hidden;width:139.2px;height:34.8px;border: 1px solid #CCC;'>";
				    str += "<div class='reduce' onselectstart='return false;' style='-moz-user-select:none;cursor:pointer;text-align:center;width:34.8px;height:34.8px;line-height:34.8px;border-right: 1px solid #CCC;float:left'>-</div>";
				    str += "<input  readonly='readonly' value='"+obj.COUNT+"' style='border: medium none; width: 67.6px; height: 34.8px; padding: 0px; margin: 0px; text-align: center; vertical-align: middle; line-height: 34.8px;'>";
				    str += "<div class='plus'  onselectstart='return false;' style='-moz-user-select:none;cursor:pointer;text-align:center;width:34.8px;height:34.8px;line-height:34.8px;border-left: 1px solid #CCC;float:right'> + </div>";
				    str += "</div></td>";
					str += "<td>"+(obj.PM_PRICE*obj.COUNT).toFixed(1)+"</td></tr>";
	    		});
	    		 console.log(packInfoArray);
	    		 console.log(packIdArray);
   		         $("#table_report_2").append(str);
	    	}
			
		   
			//删除寄件物品元素
			$(".delPA").click(function(){
				var length = $(".delPA").length;
			    if(length == 1){
			    	layer.msg('只剩一样物品了哦!',{time:1000});
			    	return false;
			    } else {
			    	if(confirm("确认移除该件物品吗？")){
					   var id=$(this).attr("id");
					   var paId;
					   $.each(paPks,function(idx,obj){
							if(obj==id){
								paId=obj;
								return false;
							}					
					    });
					   paPks.splice(jQuery.inArray(paId,paPks),1);
					   $(this).parent().parent().remove();
					}
			    }			
			});
		});
	
		//*****************************************************************************************************************//
		//****************************************加减包材信息信息**********************************************************//
		//*****************************************************************************************************************//
		
		$(document).on("click", ".reduce", function(){
			 var id=$(this).parent().parent().parent().attr("id");
			  var o_info;
			  $.each(packInfoArray,function(idx,obj){
				 if(obj.PACKINGMATERIALS_ID==id){
					 o_info=obj;
					return false;
				 }					
			  });
			  
			  var o_pk;
			  $.each(packIdArray,function(idx,obj){
				 if(obj==id){
					 o_pk=obj;
					return false;
				 }					
			  });
			  
			var input = $(this).next();
			var val=input.val();
			//总价格后台算
			
			if(val == 1){
				if(confirm("确认要删除该包材吗？")){
					//删除元素
				    if(o_info!=null){
				    	packInfoArray.splice(jQuery.inArray(o_info,packInfoArray),1); 
					    //移除表格tr
						$(this).parent().parent().parent().remove();
				    }
					if(o_pk!=null){
						packIdArray.splice(jQuery.inArray(o_pk,packIdArray),1); 
					}
				}
			}else{
				var count = parseInt(val) -1;
				o_info.COUNT=count; 
				//计算金额
				$(this).parent().parent().next().html((parseFloat(o_info.PM_PRICE)*count).toFixed(1));
				$(input).val(count);
			}
		}); 
		
		
		$(document).on("click", ".plus", function(){
			 var id=$(this).parent().parent().parent().attr("id");
			 var o_info;
			  $.each(packInfoArray,function(idx,obj){
				 if(obj.PACKINGMATERIALS_ID==id){
					 o_info=obj;
					return false;
				 }					
			});		
			var input = $(this).prev();
			var count = parseInt(input.val()) +1;
			o_info.COUNT=count;
			$(this).parent().parent().next().html((parseFloat(o_info.PM_PRICE)*count).toFixed(1));
			$(input).val(count);
		});
		
		</script>
</body>
</html>