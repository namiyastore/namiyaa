<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
</head>
<script type="text/javascript" src="resources/jquery-3.3.1.min.js"></script>
<script type="text/javascript">
	var idFlag = false;
	var pwdFlag = false;
	var isShift = false;
	
$(document).ready(function(){
	$("#loginUp").click(function(){
		if(idFlag&&pwdFlag&&(!isShift)){
			alert("로그인");
			$("#login_form").submit();
		}else{
			alert("id Fail"+idFlag);
			alert("pwd Fail"+pwdFlag);
			alert("shift Fail"+isShift);
			return false;
		}
	});
	
	$("#password").keydown(function(key) {
        if (key.keyCode == 13) {// 엔터
        	if(idFlag&&pwdFlag&&(!isShift)){
    			alert("엔터누름");
    			$("#login_form").submit();
    		}else{
    			alert("id Fail"+idFlag);
    			alert("pwd Fail"+pwdFlag);
    			alert("shift Fail"+isShift);
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
	alert("회원가입");
	location.href="joinForm";
}

function checkId(){
	var userid = $("#userid").val();
	var oMsg = $("#idMsg");
	
	if ( userid == "") {
        showErrorMsg(oMsg,"아이디를 입력해주세요");
        idFlag = false;
    }else{
    	showErrorMsg(oMsg,"비밀번호를 입력하세요");
    	idFlag = true;
    }

    var isID = /^[a-z0-9][a-z0-9_\-]{4,19}$/;
    if (!isID.test(userid)) {
        showErrorMsg(oMsg,"아이디를 확인해주세요.");
        idFlag = false;
    }else{
    	idFlag = true;
    }
}

function checkPassword(){
	var password = $("#password").val();
	var oMsg = $("#pwdMsg");
	
	 if (password == "") {
         showErrorMsg(oMsg,"비밀번호를 입력해주세요.");
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
        showErrorMsg(oMsg,"Caps Lock이 켜져 있습니다.");
    } else if ((myKeyCode >= 97 && myKeyCode <= 122) && myShiftKey) {
        showErrorMsg(oMsg,"Caps Lock이 켜져 있습니다.");
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
</script>

<body class="is-preload">

	<div id="wrap"class="limiter">
	<div  class="container-login100">
	<div class="wrap-login10">
	<div id="header" class="login100-form-title p-b-26" role="banner">
   		<a href="${pageContext.request.contextPath}"><img style="border-radius: 10px;" width="540px" height="150px" alt="" src="resources/images/logo.gif"> </a>
	</div>
		
		<form action="login_form" id="login_form" method="post" class="login100-form">
			<div style="display: inline-block"  class="wrap-input0 validate-input">
				<input type="text" id="userid" name="userid" class="input100" maxlength="40"/>
				<span class="focus-input100" data-placeholder="아이디"></span>
			</div>
			<span style="display: inline" class="error_next_box" id="idMsg" style="display:none"></span>
			
			<br><br>
			<div style="display: inline-block"  class="wrap-input0 validate-input">
				 <input type="password" id="password" name="password" class="input100" maxlength="40">
				 <span class="focus-input100" data-placeholder="비밀번호"></span>
			</div>
			<span class="error_next_box" id="pwdMsg" style="display:none"></span>
			<div style="">
				<br><br>
				<a id="loginUp" class="clickbutton"><img width="120" height="50" alt="" src="resources/images/login.png"/></a>
				<a id="signup" class="clickbutton" onclick="signUp()"><img width="120" height="50" alt="" src="resources/images/signup.png"></a>
				<br>
				<a href="">아이디</a><a href="">비밀번호 찾기</a>
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