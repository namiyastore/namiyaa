<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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
<title>jindPop.jsp</title>
</head>
<script type="text/javascript" src="resources/jquery-3.3.1.min.js"></script>
<script type="text/javascript">

$("#email").keyup(function(){
	checkEmail();
});
$("#authNo").keyup(function() {
    checkAuthNo();
});
$("#email").blur(function() {
    checkEmail();
});


function checkEmail() {
    var email = $("#email").val();
    var oMsg = $("#emailMsg");

    if (email == "") {
        showErrorMsg(oMsg,"이메일 주소를 입력해주세요.");
        return false;
    }

    var isEmail = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
    var isHan = /[ㄱ-ㅎ가-힣]/g;

    if (!isEmail.test(email) || isHan.test(email)) {
        showErrorMsg(oMsg,"이메일 주소를 다시 확인해주세요.");
        return false;
    }
  ////////////////////////////////////
  //Ajax로 동일 이메일 입력이벤트확인하는 function
  //showErrorMsg(oMsg,"이미  가입된 이메일 주소입니다.");
  ////////////////////////////////////
    $.ajax({//Id Duplication Check
        type:"GET",
        url: "checkEmail?email=" + email ,
        success : function(result) {
            if (result == 1) {
            	showSuccessMsg(oMsg, "인증가능합니다.");
            	mailFlag = true;
            } else {
                showErrorMsg(oMsg, "이미 가입된 이메일입니다.");
            }
        }
    });
    hideMsg(oMsg);
    return true;
}

function checkAuthNo(){
	var authNo = $("#authNo").val();
	var oMsg = $("#authNoMsg");
	
	if(authNo==""){
		showErrorMsg(oMsg,"반드시 해주세요.");
		return false;
	}
	if(sendFlag){
		if(userAuthNo==authNo){
			showSuccessMsg(oMsg," 인증완료.");
			authFlag = true;
		}else{
			showErrorMsg(oMsg,"번호가 다릅니다.");
		}
	}else{
		showErrorMsg(oMsg,"반드시 해주세요.");
	}
}

function isAuthEmail(){
		//$("authNo").attr("disabled", false); //해제
		var oMsg = $("#emailMsg");
		var usermail = $("#email").val();

		if(mailFlag){
			alert("인증버튼 클릭");
			$.ajax({//Id Duplication Check
	            type:"GET",
	            url: "checkAuthNum?usermail=" + usermail ,
	            success : function(result) {
	                if (result != 0) {
	                	showSuccessMsg(oMsg, "인증번호 발송완료");
	                	sendFlag=true;
	                	userAuthNo = result;
	                } else {
	                    showErrorMsg(oMsg, "발송실패");
	                }
	            }
	        });
		}else{
			alert("이메일을 확인해주세요.");
		}
}
//Ajax 이메일인증번호 
function isValidEmail() {
    var authNo = $("#authNo").val();
    var oMsg = $("#authNoMsg");
    var oBox = $("#authNoBox");
    var oCode = $("#authNoCode");

    if (authNo == "") {
        showErrorMsg(oMsg,"인증이 필요합니다.");
        return false;
    }

    if(authFlag) {
        showSuccessMsg(oMsg,"인증이 성공했습니다.");
        showAuthSuccessBox(oBox, oCode, "일치");
        $("#phoneNoMsg").hide();
        return true;
    } else {
        checkAuthnoByAjax();
    }
    return true;
}
</script>
<body>
	<div  class="container-login100">
	<div class="wrap-login10">
	<div id="header" class="login100-form-title p-b-26" role="banner">
   		<a href="${pageContext.request.contextPath}"><img style="border-radius: 10px;" width="540px" height="150px" alt="" src="resources/images/idpw.gif"> </a>
	</div>
					<div style="display: inline-block" class="wrap-input100 validate-input">      
							<input type="text" id="email" name="email" class="input100" maxlength="100">
							<span class="focus-input100" data-placeholder="본인인증 이메일"></span>
                    </div>
							<input class="clickbutton" type="button" id="emailCheck" value=" 인증 요청 " onclick="isAuthEmail()"/>
							<span style="display: block;" class="error_next_box" id="emailMsg" style="display:none"></span>
					<br>
					<div style="display: inline-block" class="wrap-input100 validate-input">				
							<input type="text" id="authNo" name="authNo" class="input100" maxlength="100">
							<span class="focus-input100" data-placeholder="인증번호입력"></span>
                    </div>
                    <span class="error_next_box" id="authNoMsg" style="display:none"></span>
	
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