<%--
  Created by IntelliJ IDEA.
  User: newcdl
  Date: 2018/11/19
  Time: 9:05
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html lang="en">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<head>
    <title>身份证上传</title>
</head>
<base href="<%=basePath%>">
<meta name="description" content="overview & stats" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />

<script type="text/javascript" src="static/js/jquery-1.7.2.js"></script>
<style type="text/css" media="screen">
    body{
        background:#fff;
    }
    .container{
        width:840px;
        margin:0 auto;
        background:#fff;
        /* border-radius:10px; */
    }
    .title{
        color:#333;
        height: 45px;
        line-height:45px;
        width:100%;
        text-align:left;
        font-size:16px;
        font-weight:bold;
        position:relative;
        border-bottom:1px solid #eee;
    }
    .close{
        position:absolute;
        font-weight:normal;
        right:10px;
        top: 5px;
        font-size:12px;
        height: 25px;
        line-height:25px;
        cursor:pointer;
        padding:2px 7px;
        border:1px solid #999;
    }
    .close:hover{
        background: #3399fe;
        color:#fff;
    }
    .main{
        width:740px;
        padding:20px 0 20px 100px ;
    }
    .info_box{
        height: 25px;
        padding:15px 0 5px 20px;
        line-height:25px;
        width:720px;
    }
    .details_title{
        width:130px;
        float:left;
        text-align:right;
    }
    .details{
        width:130px;
        float:left;
        padding:0 5px;
        margin-left:20px;
        height: 20px;
        outline:none;
        padding-right:2%;
    }
    .details_tips{
        margin-left:20px;
        line-height:25px;
        width:310px;
        float:left;
        color:#aaa;
        font-size:12px;
    }
    .card_box{

        height: 320px;
        background:#f5f7f7;
        margin:10px 0;
        padding:20px;
    }
    .card_title{
        font-size:16px;
        color:#000;
        width:560px;
        float:left ;
    }
    .card_main{
        height: 120px;
        width:560px;
    }
    .details_upload{
        float:left ;
        margin-top:15px;
    }
    .img_class{
        width:120px;
        height: 80px;
    }
    .img_title{
        height:30px;
        line-height:30px;
        color: #333;
        width:120px;
        text-align: center;
    }
    .img_tip{
        width:245px;
        margin:15px 0 0 30px;
        line-height:20px;
    }
    .ps{
        color:#3399fe;
        font-size:12px;
        border-bottom:none ;
        padding:30px 0 0 10px!important;
        height: auto;
        padding-bottom:20px;
        line-height:25px;
    }
    .button{
        width: 200px;
        height: 40px;
        margin:30px 200px 0;
        background: #3399fe;
        color:#fff;
        font-size:16px;
        border-radius:5px;
    }
    .f30{
        color:#f30;
    }
    .inputfile {
        position:absolute;clip:rect(0 0 0 0);
    }
    .marb10{
        padding-bottom:15px;
    }
</style>
<body>
<div class="container">
    <div class="title">
        身份实名验证
        <div class="close">返回上级</div>
    </div>
    <div class="main">
        <div class="info_box">
            <div class="details_title">
                <span class="f30">*</span>真实姓名：
            </div>
            <input class="details" id="name" autocomplete="off" type="text" name="name" value="" >
            <div class="details_tips">
                请输入您的姓名，确保与身份证姓名一致！
            </div>
        </div>
        <div class="info_box">
            <div class="details_title">
                <span class="f30">*</span>电话号码：
            </div>
            <input class="details" id="mobile" autocomplete="off" type="text" name="name" value="" >
            <div class="details_tips">
                请输入您的电话号码，用于找回密码！
            </div>
        </div>
        <div class="info_box">
            <div class="details_title">
                <span class="f30">*</span>身份证号码：
            </div>
            <input class="details" id="id_card" autocomplete="off" type="text" name="name" value="">
            <div class="details_tips">
                请输入您的身份证号，确保与您的<span class="f30">身份证</span>号码一致
            </div>
        </div>
        <div class="info_box" style="height:405px">
            <div class="details_title">
                <span class="f30">*</span>上传身份证：
            </div>
            <div class="details_tips" style=" width:570px">
                <div>
                    此照片用于身份认证，请上传清晰的证件照
                </div>
                <div class="card_box">
                    <div class="card_title">
                        身份证正面
                    </div>
                    <div class="card_main">
                        <div class="details_upload">
                            <div class="img_class">
                                <input type="file" name="file" id="file_1" class="inputfile"  onchange="upLoad_1()"/>
                                <label for="file_1"><img class="img_class" id="img_1" src="static/images/userimage/button_upload.png" alt=""></label>
                            </div>
                            <div class="img_title" style="">
                                点击上传
                            </div>
                        </div>

                        <div class="details_upload" style="margin-left:15px; line-height:0 !important; ">
                            <img class="img_class" src="static/images/userimage/img_a.png" alt="">
                            <div class="img_title" >
                                正确示例
                            </div>
                        </div>
                        <div class="details_tips img_tip">
                            请认真检查身份证号码，保证身份证号码与证件照片上面的一致!以避免后期出现的审核不通过！
                        </div>
                    </div>
                    <div class="card_title">
                        身份证反面
                    </div>
                    <div class="card_main">
                        <div class="details_upload">
                            <div class="img_class">
                                <input type="file" name="file" id="file_2" class="inputfile"  onchange="upLoad_2()"/>
                                <label for="file_2"><img class="img_class" id="img_2" src="static/images/userimage/button_upload.png" alt=""></label>
                            </div>
                            <div class="img_title" style="">
                                点击上传
                            </div>
                        </div>

                        <div class="details_upload" style="margin-left:15px; line-height:0 !important; ">
                            <img class="img_class" src="static/images/userimage/img_b.png" alt="">
                            <div class="img_title" >
                                正确示例
                            </div>
                        </div>
                        <div class="details_tips img_tip">
                            请认真检查身份证号码，保证身份证号码与证件照片上面的一致!以避免后期出现的审核不通过！
                        </div>
                    </div>
                </div>

            </div>
        </div>
        <div class="info_box" style=" height: 40px; line-height: 40px; ">
            <div class="details_title">
                验证码:
            </div>
            <input style="width:127px; margin: 8px 0 8px 20px;" id="verification" class="details" autocomplete="off" type="text" name="name" value="" placeholder="请输入验证码">
            <img src="static/images/userimage/222.jpg" alt="" style="height:40px; width:100px;margin-left:20px">
        </div>
        <div class="info_box ps">
            PS:您填写的以上信息，均不会被商务使用，请放心填写!<br />照片用于身份认证，请上传清晰的证件照，要求国旗清晰，证件照无残缺!<br>身份证与号码不一致或翻拍其他照片都将对后期的审核产生不必要麻烦，请您认真审核！
        </div>
        <button class="button" id="button" type="button">提交</button>
    </div>

</div>
</body>
</html>
<script>
    var file_one = '';
    function upLoad_1(){
        var fileInput = document.getElementById("file_1");
        var file_1 = fileInput.files[0];
        file_one = file_1.name;
        //创建读取文件的对象
        var reader = new FileReader();
        //创建文件读取相关的变量
        var imgFile;
        //为文件读取成功设置事件
        reader.onload=function(e) {
            // alert('文件读取完成');
            imgFile = e.target.result;
            $("#img_1").attr('src',imgFile);
        };
        //正式读取文件
        reader.readAsDataURL(file_1);
    }
    var file_two = '';
    function upLoad_2(){
        var fileInput = document.getElementById("file_2");
        var file_2 = fileInput.files[0];
        file_two = file_2.name;
        //创建读取文件的对象
        var reader = new FileReader();
        //创建文件读取相关的变量
        var imgFile;
        //为文件读取成功设置事件
        reader.onload=function(e) {
            // alert('文件读取完成');
            imgFile = e.target.result;
            $("#img_2").attr('src',imgFile);
        };
        //正式读取文件
        reader.readAsDataURL(file_2);
    }
    var name = ''; //姓名
    $('#name').bind('input propertychange', function(){
        name = $("#name").val()
    });
    var mobile = ''; //电话
    $('#mobile').bind('input propertychange', function(){
        mobile = $("#mobile").val()
    });
    var id_card = ''; //身份证
    $('#id_card').bind('input propertychange', function(){
        id_card = $("#id_card").val()
    });
    var verification = ''; //验证码
    $('#verification').bind('input propertychange', function(){
        verification = $("#verification").val()
    });

    $('#button').click(function(event) {
        console.log(file_one,file_two,verification)
        var regName =/^[\u4e00-\u9fa5]{2,4}$/;
        var regmobile = /^1[34578]\d{9}$/;
        var regIdNo = /(^\d{15}$)|(^\d{18}$)|(^\d{17}(\d|X|x)$)/;
        if(name == ''){
            console.log('姓名不能为空');
            return false;
        }else if(!regName.test(name)){
            console.log('姓名不符合规范');
            return false;
        }else if(mobile == ''){
            console.log('电话号码不能为空');
            return false;
        }else if(!regmobile.test(mobile)){
            console.log('电话号码格式不正确');
            return false;
        }else if(id_card == ''){
            console.log('身份证号不能为空');
            return false;
        }else if(!regIdNo.test(id_card)){
            console.log('身份证号不为15或18位');
            return false;
        }else if(file_one ==''){
            console.log('请上传身份证正面照');
            return false;
        }else if(file_two ==''){
            console.log('请上传身份证反面照');
            return false;
        }else if(verification == ''){
            console.log('验证码不能为空');
            return false;
        }else if(verification != '1'){
            console.log('验证码不正确');
            return false;
        }

    });


</script>

