<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title></title>
</head>


<style media="print">
    @page {
      size: auto;  /* auto is the initial value */
      margin: 3.5mm; /* this affects the margin in the printer settings */
    }
</style>



<body style="font-size: 12px;">
<div id="printLayout">
<table id="tbl" style="margin-top: 3%">
   <tr>
      <td width="40%">${fn:substring(order.CREATETIME, 0, 10)}</td>
      <td colspan="2">订单号: ${order.ORDERNO }</td>
   </tr>
   <tr>
      <td width="40%">默认揽收门店:${empty order.STORENAME?"外部excel导入":order.STORENAME }</td>
      <td width="30%"></td>
      <td width="30%"><%-- 总运费: ${order.FREIGHT }元 &nbsp;<c:if test="${not empty order.DISCOUNT }">(${order.DISCOUNT }折)</c:if> --%></td>
   </tr>
</table>

<table id="tb2" style="margin-top: 3%">
   <tr>
      <td>寄件人信息: 姓名:${sender.sENDER }</td>
      <td>电话: ${sender.pHONE }</td>
   </tr>
   <tr>
      <td colspan="2">联系地址：${sender.s_ADDRESS } ${sender.d_ADDRESS }</td>
   </tr>
</table>

<table id="tb3" style="margin-top: 3%">
   <tr>
      <td>收件人信息: 姓名:${adderssee.SENDER }</td>
      <td>电话: ${adderssee.PHONE }</td>
   </tr>
   <tr>
      <td colspan="2">联系地址：${fn:replace(adderssee.S_ADDRESS,',',' ') } ${adderssee.D_ADDRESS }</td>
   </tr>
</table>

<c:forEach items="${order.parcels }" var="var" varStatus="idx">
<table id="tb3" style="margin-top: 3%">
   <tr>
     <td colspan="6">${var.PACK_NAME }</td>
   </tr>
   <tr>
      <td>寄件物品信息</td>
      <td>运单单号: ${var.LOGISTICS }</td>
      <td>${var.WEIGHT }(磅)</td>
      <td>${var.TOTAL_COST }元</td>      
   </tr>
   <c:forEach items="${order.parcelArticles }" var="pa">
				<c:if test="${fn:indexOf(var.GOODS_PK, pa.PARCELARTICLES_ID)!=-1}">
					<tr>
						<td width="100px">${pa.PA_TYPE }&nbsp;</td>
						<td width="150px">${pa.PA_BRAND }&nbsp;</td>
						<td width="100px">${pa.PA_PM }&nbsp;</td>
						<td width="100px">${pa.PA_COUNT }件&nbsp;</td>
					<%-- 	<td width="50px">${var.WEIGHT }(磅)&nbsp;</td> --%>
						<%-- <td width="50px"> ${var.TOTAL_COST }</td> --%>
					</tr>
				</c:if>
	</c:forEach>
</table>
</c:forEach>

</div>

<div class="noprint" align="right" style="margin-right: 30px;margin-top: 30px;">
        <button onclick="preview(1)">确定打印</button>
</div>


</body>

<script>  

	function preview(oper) {
		  var newstr = document.getElementById("printLayout").innerHTML;//得到需要打印的元素HTML
		  var oldstr = document.body.innerHTML;//保存当前页面的HTML
		  document.body.innerHTML = newstr;
		  window.print();
		  pagesetup_null();
		  document.body.innerHTML = oldstr;
	}
	
	function pagesetup_null(){                
	    var hkey_root,hkey_path,hkey_key;
	    hkey_root="HKEY_CURRENT_USER";
	    hkey_path="\\Software\\Microsoft\\Internet Explorer\\PageSetup\\";
	    try{
	        var RegWsh = new ActiveXObject("WScript.Shell");
	        hkey_key="header";
	        RegWsh.RegWrite(hkey_root+hkey_path+hkey_key,"");
	        hkey_key="footer";
	        RegWsh.RegWrite(hkey_root+hkey_path+hkey_key,"");
	    }catch(e){}
	}

	
	function getExplorer() {
	    var explorer = window.navigator.userAgent ;
	    //ie 
	    if (explorer.indexOf("MSIE") >= 0) {
	        return "IE";
	    }
	    //firefox 
	    else if (explorer.indexOf("Firefox") >= 0) {
	        return "Firefox";
	    }
	    //Chrome
	    else if(explorer.indexOf("Chrome") >= 0){
	        return "Chrome";
	    }
	    //Opera
	    else if(explorer.indexOf("Opera") >= 0){
	        return "Opera";
	    }
	    //Safari
	    else if(explorer.indexOf("Safari") >= 0){
	        return "Safari";
	    }
	}
</script>
	

</html>