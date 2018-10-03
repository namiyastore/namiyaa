<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!--===============================================================================================-->	
	<!-- <link rel="icon" type="image/png" href="resources/images/icons/favicon.ico"/> -->
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="resources/vendor/bootstrap/css/bootstrap.min.css">
<!--===============================================================================================-->
	<!-- <link rel="stylesheet" type="text/css" href="resources/fonts/font-awesome-4.7.0/css/font-awesome.min.css"> -->
<!--===============================================================================================-->
	<!-- <link rel="stylesheet" type="text/css" href="resources/fonts/iconic/css/material-design-iconic-font.min.css"> -->
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="resources/vendor/animate/animate.css">
<!--===============================================================================================-->	
	<link rel="stylesheet" type="text/css" href="resources/vendor/css-hamburgers/hamburgers.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="resources/vendor/animsition/css/animsition.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="resources/vendor/select2/select2.min.css">
<!--===============================================================================================-->	
	<link rel="stylesheet" type="text/css" href="resources/vendor/daterangepicker/daterangepicker.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="resources/css/util.css">
	<link rel="stylesheet" type="text/css" href="resources/css/main.css">
<!--===============================================================================================-->
<title>login.jsp</title>
<link href="https://fonts.googleapis.com/css?family=Nanum+Gothic" rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Raleway:600" rel="stylesheet">
</head>
<script type="text/javascript" src="resources/jquery-3.3.1.min.js"></script>
<script type="text/javascript">
	var idFlag = false;
	var pwdFlag = false;
	var isShift = false;
	var askingPw = '';
	var askingId = '';
	
$(document).ready(function(){
	askingId = $("#askingId").val();
	askingPw = $("#askingPw").val();
	
	$("#userid").val("");
    
	$("#loginUp").click(function(){
		if(idFlag&&pwdFlag&&(!isShift)){
			$("#login_form").submit();
		}else{
			return false;
		}
	});
	
	$("#password").keydown(function(key) {
        if (key.keyCode == 13) {// 엔터
        	checkPassword();
        	if(idFlag&&pwdFlag&&(!isShift)){
    			$("#login_form").submit();
    		}else{
    			return false;
    		}
        }
     });
	
	 $("#userid").blur(function() {
		 checkId();
     });
	 
	 $("#userid").keyup(function() {
		 checkId();
     });
	 
	 $("#password").blur(function() {
         checkPassword();
     });
	 
	 $("#password").keyup(function(event) {
         checkShiftUp(event);
     }).keypress(function(event) {
         checkCapslock(event);
     }).keydown(function(event) {
         checkShiftDown(event);
     });
});


function signUp(){
	location.href="joinForm";
}

function checkId(){
	var userid = $("#userid").val();
	var oMsg = $("#idMsg");
	
	
	if ( userid == "") {
        showErrorMsg(oMsg,askingId);
        idFlag = false;
    }else{
    	showErrorMsg(oMsg,askingPw);
    	idFlag = true;
    }

    var isID = /^[a-z0-9][a-z0-9_\-]{4,19}$/;
    if (!isID.test(userid)) {
        showErrorMsg(oMsg,askingId);
        idFlag = false;
    }else{
    	idFlag = true;
    }
}

function checkPassword(){
	var password = $("#password").val();
	var oMsg = $("#pwdMsg");
	
	 if (password == "") {
         showErrorMsg(oMsg,askingPw);
         pwdFlag = false;
     }else{
    	 pwdFlag = true;
     }
	 
}

function checkShiftUp(e) {
    if (e.which && e.which == 16) {
        isShift = false;
    }
}

function checkCapslock(e) {
    var myKeyCode = 0;
    var myShiftKey = false;
    if (window.event) { // IE
        myKeyCode = e.keyCode;
        myShiftKey = e.shiftKey;
    } else if (e.which) { // netscape ff opera
        myKeyCode = e.which;
        myShiftKey = isShift;
    }

     var oMsg = $("#pwdMsg");
    if ((myKeyCode >= 65 && myKeyCode <= 90) && !myShiftKey) {
        showErrorMsg(oMsg,"Caps Lock ON");
    } else if ((myKeyCode >= 97 && myKeyCode <= 122) && myShiftKey) {
        showErrorMsg(oMsg,"Caps Lock Off");
    } else {
        hideMsg(oMsg);
    }
}

function checkShiftDown(e) {//CapsLockCheck
    if (e.which && e.which == 16) {
        isShift = true;
    }
}

function hideMsg(obj) {
    obj.hide();
}
function showErrorMsg(obj, msg) {
    obj.attr("class", "error_next_box");
    obj.html(msg);
    obj.show();
}

function memberfind(){
	var pop = window.open("findPop","findPop","width=800,height=600, scrollbars=yes"); 
}
</script>
<style>
@import url(//fonts.googleapis.com/earlyaccess/notosansjapanese.css);

body, h { 
	font-family: 'Raleway', 'Nanum Gothic', 'Noto Sans Japanese';
}
</style>
<body class="is-preload">
<input id="lang" type="hidden" value="<spring:message code="common.lang" />">
<input id="askingPw" type="hidden" value="<spring:message code="loginForm.askingForPwd" />">
<input id="askingId" type="hidden" value="<spring:message code="loginForm.askingForId" />">

	<div id="wrap"class="limiter">
	<div  class="container-login100">
	<div class="wrap-login10">
	<div id="header" class="login100-form-title p-b-26" role="banner">
   		<a href="${pageContext.request.contextPath}"><img style="border-radius: 10px;" width="540px" height="150px" alt="" src="resources/images/logo.gif"> </a>
	</div>
		
		<form action="login_form" id="login_form" method="post" class="login100-form">
			<div style="display: inline-block"  class="wrap-input0 validate-input">
				<input type="text" id="userid" name="userid" class="input100" maxlength="40"/>
				<span class="focus-input100" data-placeholder="ID"></span>
			</div>
			<span style="display: inline" class="error_next_box" id="idMsg" style="display:none"></span>
			
			<br><br>
			<div style="display: inline-block"  class="wrap-input0 validate-input">
				 <input type="password" id="password" name="password" class="input100" maxlength="40">
				 <span class="focus-input100" data-placeholder="Password"></span>
			</div>
			<span class="error_next_box" id="pwdMsg" style="display:none"></span>
			<div style="">
				<br><br>
				<a id="loginUp" class="clickbutton"><img width="120" height="50" alt="" src="resources/images/login.png"/></a>
				<a id="signup" class="clickbutton" onclick="signUp()"><img width="120" height="50" alt="" src="resources/images/signup.png"></a>
				<br>
				<a class="clickbutton" onclick="memberfind()"><spring:message code="loginForm.idNpwdFind" /></a>
				<div style="position: relative; display: inline; left: 270px;"><a class="clickbutton" onclick="location.href='${pageContext.request.contextPath}/ko'"><img width="50" height="50" alt="" src="resources/images/korea.png"/></a>
				 <a class="clickbutton" onclick="location.href='${pageContext.request.contextPath}/ja'"><img width="50" height="50" alt="" src="resources/images/japan.png"/></a></div>
				
				
			</div>
		</form>
		
	</div>
	</div>
	</div>


<!--===============================================================================================-->
	<script src="resources/vendor/animsition/js/animsition.min.js"></script>
<!--===============================================================================================-->
	<script src="resources/vendor/bootstrap/js/popper.js"></script>
	<script src="resources/vendor/bootstrap/js/bootstrap.min.js"></script>
<!--===============================================================================================-->
	<script src="resources/vendor/select2/select2.min.js"></script>
<!--===============================================================================================-->
	<script src="resources/vendor/daterangepicker/moment.min.js"></script>
	<script src="resources/vendor/daterangepicker/daterangepicker.js"></script>
<!--===============================================================================================-->
	<script src="resources/vendor/countdowntime/countdowntime.js"></script>
<!--===============================================================================================-->
	<script src="resources/js/main.js"></script>	
</body>

</html>