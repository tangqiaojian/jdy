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
  <%--   <script language="javascript" src="<%=basePath %>static/electSurface/LodopFuncs.js"></script> --%>
  </head>
 
<style media="print">
    @page {
      size: auto;  /* auto is the initial value */
      margin: 3.5mm; /* this affects the margin in the printer settings */
    }
</style>
 
 
  <style id="style1">
  *{
    margin: 0;
    padding: 0;
  }
  html,body{
    font-size: 10px;
    font-family: 'Avenir', Helvetica, Arial, sans-serif;
  }
  ul,li{
    list-style: none;
  }
  .layoutBox{
    width: 283px;
    height: 425px;
    border:1px solid #000;

  }
  .tc{
    text-align: center;
  }
  .bd{
    border-bottom: 1px solid #000;
  }
  .flex{
    display: flex;
    display: -moz-flex;
    display: -webkit-flex;
    align-items: center;
  }
  .flexCell{
    flex:1;
    -moz-flex:1;
    -webkit-flex:1;
  }
  .flexcell2{
    flex:2;
    -moz-flex:2;
    -webkit-flex:2;
  }
  .flexcell3{
    flex:3;
    -moz-flex:3;
    -webkit-flex:3;
  }
  .mainbox{
    /* border:1px solid #000;
    width: 273px;
    height: 415px;
    margin:4px; */
  }
  .logoDiv{
    padding: 4px;
    border-bottom: 1px solid #000;
    justify-content: space-between;
    text-align: center;
  }
  .logoimg{
    width: 88px;
  }
  .tiaoxingimg{
    width: 170px;
    font-size: 0.8rem;
  }

  .receiptInformation{
    padding: 4px;
    border-bottom: 1px solid #000;
  }
  .receiptMsg{
    border-right: 1px solid #000;
    flex:4;
    -moz-flex:4;
    -webkit-flex:4;
    width: 156px;
  }

  .receiptWeight{
    flex:3;
    -moz-flex:3;
    -webkit-flex:3;
    padding-left: 10px;
    font-size: 1.4rem;
  }
  .takeDelivery{
    padding: 4px;
    border-bottom: 1px solid #000;
    line-height: 1.6rem;
  }
  .weightMsg{
    font-weight: bold;
    padding: 4px;
    border-bottom: 1px solid #000;
  }
  .weightMsg div{
    flex:1;
    -moz-flex:1;
    -webkit-flex:1;
  }
  .weightMsg div:last-child{
    flex:1.5;
    -moz-flex:1.5;
    -webkit-flex:1.5;
  }
  .weightMsg div:nth-child(2){
    width: 24%;
  }
  .weightMsg div:last-child{
    width: 38%;
  }

  .signSection{
    font-weight: bold;
    font-size: 0.8rem;
    padding: 4px;
    align-items: flex-start;
    border-bottom: 1px solid #000;
  }
  .signSection textarea{
    width: 120px;
    border:none;
    list-style: none;
    height:25px;
    resize:none;
  }
  
   .m{
    width: 120px;
    border:none;
    list-style: none;
    height:25px;
    resize:none;
   }
  
  
  .signSection div{
    height: 50px;
  }
  .signSection div:first-child{
    border-right: 1px solid #000;
    padding: 0 2px;
    width:20%;
  }
  .scanImg{
    padding-top: 4px;
    border-bottom: 1px solid #000;
    text-align: center;
  }
  .tuihuoAddr{
    align-items: flex-start;
    justify-content: space-between;
    padding: 4px;
  }
  </style>
  
  <body>
    
    <div style="margin-top: 30px;margin-left: 60px;">
    <div id="printLayout" >
    <div  class="layoutBox" >
      <div class="mainbox">
        
        <div class="logoDiv flex" style="height: 52px">
          <img src="data:image/png;base64,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" alt="" class="logoimg"><!-- logo图片 -->
          <div class="tiaoxingimg">
            <img src="data:image/jpeg;base64,${barCode.barCode}" alt="" class="" width="100%" style="position: relative;top: 4px;"><!-- 条形码图片位置 -->
            <p style="position: relative;top: 5px;letter-spacing: 0.3em;">${barCode.parcelId}</p>
          </div>
        </div>

        <div class="flex receiptInformation">   <!-- 收货信息 -->
            <div class="receiptMsg">
              <p>收件：${ReqData.orderbody.consignee }</p>
              <p>电话：${ReqData.orderbody.consigneetelephone }</p>
              <p><b>${ReqData.orderbody.consigneeaddress }</b></p>
            </div>
            <div class="receiptWeight">
              <!-- 大头签 -->
               <b>${Printspec[0] }</b><br/>
               <b>${Printspec[1] }</b>
            </div>
        </div>

        <div class="takeDelivery"><!-- 寄件 -->
          寄件：<span>${ReqData.orderbody.consignor }</span><span>${ReqData.orderbody.consignortelephone }</span>
          <p>${ReqData.orderbody.consignoraddress }</p>
        </div>

        <div class="weightMsg flex" style="height: 18px"><!-- 重量、产地 -->
          <div>
            重量：${ReqData.orderbody.grossweight}
          </div>
          <div>
            数量：${ReqData.orderbody.goodsqty}
          </div>
          <div style="border-left:1px solid #000; padding-left:4px;">
            原产地：加拿大
          </div>
        </div>

        <div class="signSection flex"><!-- 签名 -->
          <div class="flexcell2">
            <p class="flex" align="center">
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
          <div class="flexcell2" style="margin-left: 4px;">
            <p>收件人签名</p>
            <p style="height: 25px;"></p>
            <p align="right">年&nbsp;&nbsp;&nbsp;月&nbsp;&nbsp;&nbsp;日</p>
          </div>
        </div>
      
        <!-- 条形码 -->
        <div class="scanImg"  style="height: 66px">
          <img src="data:image/jpeg;base64,${barCode.barCode}" alt="" class="" width="90%"><!-- 条形码图片位置 -->
          <p style="font-weight: bold;letter-spacing: 0.5em;">${barCode.parcelId}</p>
        </div>

        <div class="bd" style="padding:4px;height: 35px;">
          <p>收件：${ReqData.orderbody.consignee }
            <span>${ReqData.orderbody.consigneetelephone }</span>
          </p>
          <p><b>${ReqData.orderbody.consigneeaddress }</b></p>
        </div>

        <div class="takeDelivery" style="height: 32px;"><!-- 寄件 -->
          寄件：<span>${ReqData.orderbody.consignor }</span>
          <span>${ReqData.orderbody.consignortelephone }</span>
          <span>配货单号 ${barCode.parcelId}</span>
          <p>${ReqData.orderbody.consignoraddress }</p>
        </div>

        <div class="flex tuihuoAddr">
          <b>HKD</b>
          <p class="flexcell">国内退件地址：厦门市海沧区海景路266号</p>
        </div>
      </div>
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
