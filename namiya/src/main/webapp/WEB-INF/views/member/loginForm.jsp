<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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
<body>
	<h1>[ to Do list ]</h1>
	<p>
	1. 로그인 동작(컨트롤러연결)
	2. 회원가입 이동
	</p> 
	<form action="login_form" id="login_form" method="post">
		<div>
			<input type="text" id="userid" name="userid"/><span class="error_next_box" id="idMsg" style="display:none"></span><br>
			<input type="password" id="password" name="password" ><span class="error_next_box" id="pwdMsg" style="display:none"></span><br>
			<input type="button" id="loginUp" value="login"/>
			<input type="button" id="signup" onclick="signUp()" value="sign up"/>
			<p id="msg" style="color: #FF0000;">${message}</p>
		</div>
	</form>
		
</body>
</html>