<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE html>

<html lang="en" dir="ltr">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1,maximum-scale=1,user-scalable=no">
    <title>电子面单样式及区块功能图</title>
    <link rel="stylesheet" href="<%=basePath %>static/electSurface/css/electSurface.css">
  </head>
  
  <body>
    
    <div id="printLayout" class="layoutBox" style="margin-top: 30px;margin-left: 60px;">
      <div class="mainbox">
        <div class="logoDiv flex">
          <img src="<%=basePath %>static/electSurface/images/logo.png" alt="" class="logoimg"><!-- logo图片 -->
          
          <div class="tiaoxingimg">
            <img src="<%=basePath %>${barCode.barCode}" alt="" class="" width="100%"><!-- 条形码图片位置 -->
            <p>${barCode.parcelId}</p>
          </div>
          
        </div>

        <div class="flex receiptInformation">   <!-- 收货信息 -->
            <div class="receiptMsg">
              <p>收件：${ReqData.orderbody.consignee }</p>
              <p>电话：${ReqData.orderbody.consigneetelephone }</p>
              <p><b>${ReqData.orderbody.consigneeaddress }</b></p>
            </div>
            
            <div class="receiptWeight">
              <b>${Printspec[0] }</b><br/>
              <b>${Printspec[1] }</b>
            </div>
        </div>

        <div class="takeDelivery"><!-- 寄件 -->
          寄件：<span>${ReqData.orderbody.consignor }</span>&nbsp;&nbsp;<span>${ReqData.orderbody.consignortelephone }</span>
          <p>${ReqData.orderbody.consignoraddress }</p>
        </div>

        <div class="weightMsg flex"><!-- 重量、产地 -->
          <div class="flexcell">
                   重量：${ReqData.orderbody.grossweight} &nbsp;&nbsp;
          </div>
          <div class="flexcell">
                   数量：${ReqData.orderbody.goodsqty}
          </div>
          <div class="flexcell">
                   原产地：澳大利亚
          </div>
        </div>

        <div class="signSection flex"><!-- 签名 -->
          <div class="flexcell2">
            <p class="flex">
              <span class="flexcell2">品名</span>
              <span class="flexcell2">规格</span>
              <span class="flexcell2">数量</span>
            </p>
            <ul>
              <c:forEach items="${ReqData.orderlist }" var="o">
              <li>${o.itemname }* ${o.packno}</li>
              </c:forEach>
            </ul>
          </div>
          <div class="flexcell">
            <p class="tc">价值</p>
            <ul>
              <li>${ReqData.orderbody.goodsvalue }</li>
            </ul>
          </div>
          <div class="flexcell2" style="margin-left: 4px;">
            <p>收件人签名</p>
            <textarea name="name"></textarea>
            <p align="right">年&nbsp;&nbsp;&nbsp;月&nbsp;&nbsp;&nbsp;日</p>
          </div>
        </div>
        <!-- 条形码 -->
        <div class="scanImg">
          <img src="<%=basePath %>${barCode.barCode}" alt="" class="" width="90%"><!-- 条形码图片位置 -->
          <p>${barCode.parcelId}</p>
        </div>

        <div class="bd" style="padding:4px;">
          <p>收件：${ReqData.orderbody.consignee }
            <span>${ReqData.orderbody.consigneetelephone }</span>
          </p>
          <p><b>${ReqData.orderbody.consigneeaddress }</b></p>
        </div>

        <div class="takeDelivery"><!-- 寄件 -->
          寄件：<span>${ReqData.orderbody.consignor }</span>
          <span>${ReqData.orderbody.consignortelephone }</span>
          <span>配货单号 ${barCode.parcelId}</span>
          <p>${ReqData.orderbody.consignoraddress }</p>
        </div>

        <div class="flex tuihuoAddr">
          <b>HKD</b>
          <p class="flexcell">国内退件地址：晋江市内坑镇陆地港快件中心212室</p>
        </div>
      </div>
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
		  document.body.innerHTML = oldstr;
	}
</script>
  
</html>





