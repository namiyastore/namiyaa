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
<title>joinform.jsp</title>
<link href="https://fonts.googleapis.com/css?family=Nanum+Gothic" rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Raleway:600" rel="stylesheet">
</head>

<script type="text/javascript" src="resources/jquery-3.3.1.min.js"></script>
<script type="text/JavaScript">
    //region define, setter
    var idFlag = false;
    var pwFlag = false;
    var authFlag = false;
    var mailFlag = false;
    var sendFlag = false;
    var phoneFlag= false;
    var userAuthNo = 0;
    
    	//language pack
		var joinFormId='';var joinFormPw='';var joinFormChkPw='';var joinFormName='';var joinFormBirth='';var joinFormYear='';var joinFormMonth='';var joinFormDay='';var joinFormGender='';var joinFormMan='';var joinFormWoman='';var joinFormEmail='';var joinFormAuthRequest='';var joinFormPhone='';var joinFormAddrKor='';var joinFormSearchAddr='';var joinFormSignUp='';var joinFormnInfo='';var joinFormchkBirth='';var joinFormchkEmail='';var joinFormClause='';var joinFormPersonalInfo='';
    	var joinFormidem='';var joinFormidsm='';var joinFormidfm='';var joinFormpwem='';var joinFormpwem1='';var joinFormpwem2='';var joinFormmsm='';var joinFormmfm='';var joinFormbem='';var joinFormyem='';var joinFormmem='';var joinFormdem='';var joinFormaem='';var joinFormaem1='';var joinFormaem2='';var joinFormeem='';var joinFormeem1='';var joinFormesm='';var joinFormeem2='';var joinFormvem='';var joinFormvsm='';var joinFormnem='';var joinFormnsm='';var joinFormnfm='';var joinFormvnm='';var joinFormvsm2='';var joinFormvsm3='';var joinFormncm='';

    $(document).ready(function() {
    	joinFormId=$("#joinFormId").val();joinFormPw=$("#joinFormPw").val();joinFormChkPw=$("#joinFormChkPw").val();joinFormName=$("#joinFormName").val();joinFormBirth=$("#joinFormBirth").val();joinFormYear=$("#joinFormYear").val();joinFormMonth=$("#joinFormMonth").val();joinFormDay=$("#joinFormDay").val();joinFormGender=$("#joinFormGender").val();joinFormMan=$("#joinFormMan").val();joinFormWoman=$("#joinFormWoman").val();joinFormEmail=$("joinFormEmail").val();joinFormAuthRequest=$("#joinFormAuthRequest").val();joinFormPhone=$("#joinFormPhone").val();joinFormAddrKor=$("#joinFormAddrKor").val();joinFormSearchAddr=$("#joinFormSearchAddr").val();joinFormSignUp=$("#joinFormSignUp").val();joinFormnInfo=$("#joinFormnInfo").val();joinFormchkBirth=$("#joinFormchkBirth").val();joinFormchkEmail=$("#joinFormchkEmail").val();joinFormClause=$("#joinFormClause").val();joinFormPersonalInfo=$("#joinFormPersonalInfo").val();
    	joinFormidem=$("#joinFormidem").val();joinFormidsm=$("#joinFormidsm").val();joinFormidfm=$("#joinFormidfm").val();joinFormpwem=$("#joinFormpwem").val();joinFormpwem1=$("#joinFormpwem1").val();joinFormpwem2=$("#joinFormpwem2").val();joinFormmsm=$("#joinFormmsm").val();joinFormmfm=$("#joinFormmfm").val();joinFormbem=$("#joinFormbem").val();joinFormyem=$("#joinFormyem").val();joinFormmem=$("#joinFormmem").val();joinFormdem=$("#joinFormdem").val();joinFormaem=$("#joinFormaem").val();joinFormaem1=$("#joinFormaem1").val();joinFormaem2=$("#joinFormaem2").val();joinFormeem=$("#joinFormeem").val();joinFormeem1=$("#joinFormeem1").val();joinFormesm=$("#joinFormesm").val();joinFormeem2=$("#joinFormeem2").val();joinFormvem=$("#joinFormvem").val();joinFormvsm=$("#joinFormvsm").val();joinFormnem=$("#joinFormnem").val();joinFormnsm=$("#joinFormnsm").val();joinFormnfm=$("#joinFormnfm").val();joinFormvnm=$("#joinFormvnm").val();joinFormvsm2=$("#joinFormvsm2").val();joinFormvsm3=$("#joinFormvsm3").val();joinFormncm=$("#joinFormncm").val();
    	
        defaultScript();
        $("#id").val("");
        $("#username").val("");
        function setAddr2(obj) {
    		alert(obj);
    	}	
        
        //region unreal id
        $("#id").blur(function() {
            idFlag = false;
            checkId();
        });
        
        $("#id").keyup(function(event){
        	checkId();
        });

        $("#pswd1").blur(function() {
            pwFlag = false;
            checkPswd1();
        });
        $("#pswd1").keyup(function(event) {
            checkShiftUp(event);
        }).keypress(function(event) {
            checkCapslock(event);
        }).keydown(function(event) {
            checkShiftDown(event);
        });

        $("#pswd2").blur(function() {
            checkPswd2();
        });
        $("#pswd2").keyup(function(event) {
            checkShiftUp(event);
        }).keypress(function(event) {
            checkCapslock2(event);
        }).keydown(function(event) {
            checkShiftDown(event);
        });

        $("#name").blur(function() {
            checkName();
        });

        $("#name1").blur(function() {
            checkName();
        });

        $("#name2").blur(function() {
            checkName();
        });

        $("#yy").blur(function() {
            checkBirthday();
        });

        $("#mm").change(function() {
            checkBirthday();
        });

        $("#dd").blur(function() {
            checkBirthday();
        });

        $("#gender").change(function() {
            checkGender();
        });
        
        $("#email").keyup(function(){
        	checkEmail();
        });

        $("#phoneNo").blur(function() {
            checkPhoneNo();
            checkPhone();
        });
        
        $("#phoneNo").keyup(function(event){
        	checkPhone();
        });

        $("#btnSend").click(function() {
            sendSmsButton();
            return false;
        });
        $("#authNo").keyup(function() {
            checkAuthNo();
        });
        $("#email").blur(function() {
            checkEmail();
        });
        $("#addr").blur(function(){
        	checkAddr();
        });
        $("#detailAddr").blur(function(){
        	checkDetailAddr();
        });
        //endregion
    });
    //endregion
	/////////////////////////////////////////////////////////////////////////////////////////////////!!Form Submit Check
    //region mainSubmit
    function mainSubmit() {
    	
        var joinMode = $("#joinMode").val();
        var userid = $("#id").val();
    	var password = $("#pswd2").val();
    	var username = $("#name").val();
    	var myurl = userid;
    	
        /* if (!checkUnrealInput()) {
            submitOpen();
            return false;
        } */
		
        if(idFlag && pwFlag && authFlag && phoneFlag && mailFlag) {
        	alert(joinFormmsm);
        	$("#userid").val(userid);
        	$("#password").val(password);
        	$("#username").val(username);
        	$("#myurl").val(myurl);
        	
            $("#form").submit();
        } else {
        	alert(joinFormmfm);
            submitOpen();
            return false;
        }
    }

    /*  function checkUnrealInput() {
        if (checkId('join')
                & checkPswd1()
                & checkPswd2()
                & checkName()
                & checkBirthday()
                & checkGender()
                & checkEmail()
                & checkPhoneNo()
                & checkAuthNo()
        ) {
        	alert("checkUnrealInput완료");
            return true;
        } else {
        	alert("checkUnrealInput실패");
            return false;
        }
    } */
    //endregion

    //region unreal 가입
    function checkId() {//아이디 확인
        if(idFlag){ 
        	return true;
        	}

        var id = $("#id").val();
        var oMsg = $("#idMsg");

        if ( id == "") {
            showErrorMsg(oMsg,joinFormnInfo);
            return false;
        }

        var isID = /^[a-z0-9][a-z0-9_\-]{4,19}$/;
        if (!isID.test(id)) {
            showErrorMsg(oMsg,joinFormpwem);
            return false;
        }

        $.ajax({//Id Duplication Check
            type:"GET",
            url: "checkId?id=" + id ,
            success : function(result) {
                if (result == 1) {
                	showSuccessMsg(oMsg, joinFormidsm);
                	idFlag = true;
                } else {
                    showErrorMsg(oMsg, joinFormidfm);
                }
            }
        });
        return true;
    }

    function checkPswd1() {
        if(pwFlag) return true;

        var id = $("#id").val();
        var pw = $("#pswd1").val();
        var oSpan = $("#pswd1Span");
        var oMsg = $("#pswd1Msg");

        if (pw == "") {
            showErrorMsg(oMsg,joinFormnInfo);
            return false;
        }
        if (isValidPasswd(pw) != true) {
            showErrorMsg(oMsg,joinFormpwem);
            return false;
        }

        pwFlag = true;

        return true;
    }

    function checkPswd2() {
        var pswd1 = $("#pswd1");
        var pswd2 = $("#pswd2");
        var oMsg = $("#pswd2Msg");

        if (pswd2.val() == "") {
     
            showErrorMsg(oMsg,joinFormnInfo);
            return false;
        }
        if (pswd1.val() != pswd2.val()) {
            
            showErrorMsg(oMsg,joinFormpwem1);
            pswd2.val("");
            return false;
        } else {
            
            hideMsg(oMsg);
            return true;
        }

        return true;
    }

    function checkName() {
        var oMsg = $("#nameMsg");
        var nonchar = /[^가-힣a-zA-Z0-9]/gi;

        var name = $("#name").val();
        if (name == "") {
            showErrorMsg(oMsg,joinFormnInfo);
            return false;
        }
        if (name != "" && nonchar.test(name)) {
            showErrorMsg(oMsg,joinFormpwem2);
            return false;
        }

        hideMsg(oMsg);
        return true;
    }

    function checkBirthday() {
        var birthday;
        var yy = $("#yy").val();
        var mm = $("#mm").val();
        var dd = $("#dd").val();
        var oMsg = $("#birthdayMsg");
        var lang = "ko_KR";

        if (yy == "" && mm == "" && dd == "") {
            showErrorMsg(oMsg,joinFormbem);
            return false;
        }

        if (mm.length == 1) {
            mm = "0" + mm;
        }
        if (dd.length == 1) {
            dd = "0" + dd;
        }

        if(yy == "") {
            showErrorMsg(oMsg,joinFormyem);
            return false;
        }
        if(yy.length != 4 || yy.indexOf('e') != -1 || yy.indexOf('E') != -1) {
            showErrorMsg(oMsg,joinFormyem);
            return false;
        }
        if(mm == "") {
           
            showErrorMsg(oMsg,joinFormmem);
            return false;
        }
        if(dd == "") {
            showErrorMsg(oMsg,joinFormdem);
            return false;
        }
        if(dd.length != 2 || dd.indexOf('e') != -1 || dd.indexOf('E') != -1) {
            showErrorMsg(oMsg,joinFormdem);
            return false;
        }

        birthday = yy + mm + dd;
        if (!isValidDate(birthday)) {
            showErrorMsg(oMsg,joinFormyem);
            return false;
        }
        $("#birthday").val(birthday);

        var age = calcAge(birthday);
        if (age < 0) {
            showErrorMsg(oMsg,joinFormaem);
            return false;
        } else if (age >= 100) {
            showErrorMsg(oMsg,joinFormaem1);
            return false;
        } else if (age < 14) {
            showErrorMsg(oMsg,joinFormaem2);
            return false;
        } else {
            hideMsg(oMsg);
            return true;
        }
        return true;
    }

    function checkGender() {
        var gender = $("#gender").val();
        var oMsg = $("#genderMsg");

        if (gender == "") {
            showErrorMsg(oMsg,joinFormnInfo);
            return false;
        }
        hideMsg(oMsg);
        return true;
    }

    function checkEmail() {
        var email = $("#email").val();
        var oMsg = $("#emailMsg");

        if (email == "") {
            showErrorMsg(oMsg,joinFormeem);
            return false;
        }

        var isEmail = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
        var isHan = /[ㄱ-ㅎ가-힣]/g;
  
        if (!isEmail.test(email) || isHan.test(email)) {
            showErrorMsg(oMsg,joinFormeem1);
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
                	showSuccessMsg(oMsg, joinFormesm);
                	mailFlag = true;
                } else {
                    showErrorMsg(oMsg, joinFormeem2);
                }
            }
        });
        hideMsg(oMsg);
        return true;
    }
    //////////////////////////////////////////////////////////////
 
    //////////////////////////////////////////////////////////////
    function checkAuthNo(){
    	var authNo = $("#authNo").val();
    	var oMsg = $("#authNoMsg");
    	
    	if(authNo==""){
    		showErrorMsg(oMsg,joinFormvem);
    		return false;
    	}
		if(sendFlag){
			if(userAuthNo==authNo){
				showSuccessMsg(oMsg,joinFormvsm);
				authFlag = true;
			}else{
				showErrorMsg(oMsg,joinFormnem);
			}
		}else{
			showErrorMsg(oMsg,joinFormnem);
		}
    }
	///////////////////////////////////////////////////////////
    function checkPhoneNo() {
        var phoneNo = $("#phoneNo").val();
        var oMsg = $("#phoneNoMsg");

        if (phoneNo == "") {
            showErrorMsg(oMsg,joinFormnInfo);
            return false;
        }

        hideMsg(oMsg);
        return true;
    }
	
	//Addr check
	function checkAddr(){
		
		var addr = $("#fullAddr").val();
		var oMsg = $("#fullAddrMsg");
		
		if(addr == ""){
			showErrorMsg(oMsg,joinForm.nInfo);
			return false;
		}
		
		hideMsg(oMsg);
		return true;
	}
    //endregion

	////////////////////////////////////////////////////////////////////input text
	//region validCheck
    function checkSpace(str) {
        if (str.search(/\s/) != -1) {
            return true;
        } else {
            return false;
        }
    }

    function isValidPasswd(str) {
        var cnt = 0;
        if (str == "") {
            return false;
        }

        /* check whether input value is included space or not */
        var retVal = checkSpace(str);
        if (retVal) {
            return false;
        }
        if (str.length < 8) {
            return false;
        }
        for (var i = 0; i < str.length; ++i) {
            if (str.charAt(0) == str.substring(i, i + 1))
                ++cnt;
        }
        if (cnt == str.length) {
            return false;
        }

        var isPW = /^[A-Za-z0-9`\-=\\\[\];',\./~!@#\$%\^&\*\(\)_\+|\{\}:"<>\?]{8,16}$/;
        if (!isPW.test(str)) {
            return false;
        }

        return true;
    }

    var isShift = false;
    function checkShiftUp(e) {
        if (e.which && e.which == 16) {
            isShift = false;
        }
    }

    function checkShiftDown(e) {//CapsLockCheck
        if (e.which && e.which == 16) {
            isShift = true;
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

        var oMsg = $("#pswd1Msg");
        if ((myKeyCode >= 65 && myKeyCode <= 90) && !myShiftKey) {
            showErrorMsg(oMsg,"Caps Lock ON");
        } else if ((myKeyCode >= 97 && myKeyCode <= 122) && myShiftKey) {
            showErrorMsg(oMsg,"Caps Lock ON");
        } else {
            hideMsg(oMsg);
        }
    }

    function checkCapslock2(e) {
        var myKeyCode = 0;
        var myShiftKey = false;
        if (window.event) { // IE
            myKeyCode = e.keyCode;
            myShiftKey = e.shiftKey;
        } else if (e.which) { // netscape ff opera
            myKeyCode = e.which;
            myShiftKey = isShift;
        }

        var oMsg = $("#pswd2Msg");
        if ((myKeyCode >= 65 && myKeyCode <= 90) && !myShiftKey) {
            showErrorMsg(oMsg,"Caps Lock ON");
        } else if ((myKeyCode >= 97 && myKeyCode <= 122) && myShiftKey) {
            showErrorMsg(oMsg,"Caps Lock ON");
        } else {
            hideMsg(oMsg);
        }
    }

    function defaultScript() {
        $('.ps_box').click(function() {
            $(this).children('input').focus();
            $(this).addClass('focus');
        }).focusout(function() {
            var welInputText = $('.ps_box');
            welInputText.removeClass('focus');
        });
    }

    function submitClose() {
        $("#btnJoin").attr("disabled",true);
    }

    function submitOpen() {
        $("#btnJoin").attr("disabled",false);
    }

    function showErrorMsg(obj, msg) {
        obj.attr("class", "error_next_box");
        obj.html(msg);
        obj.show();
    }

    function showSuccessMsg(obj, msg) {
        obj.attr("class", "error_next_box green");
        obj.html(msg);
        obj.show();
    }

    function showAuthDefaultBox(oBox, oCode) {
        oBox.attr("class", "ps_box");
        oCode.html("");
        oCode.hide();
    }

    function showAuthSuccessBox(oBox, oCode, msg) {
        oBox.attr("class", "ps_box accord");
        oCode.html(msg);
        oCode.show();
    }

    function showAuthErrorBox(oBox, oCode, msg) {
        oBox.attr("class", "ps_box discord");
        oCode.html(msg);
        oCode.show();
    }

    function hideMsg(obj) {
        obj.hide();
    }
/////////////////////////////////////////////////////////////////////////////////////////////////////
    function pwdCheck(oSpan, step) {
        if("IE8" == "") {
            return false;
        }
        if(step == 1) {
            oSpan.attr("class", "step_txt txt_red");
            oSpan.html("사용불가");
        } else if(step == 2) {
            oSpan.attr("class", "step_txt txt_orange");
            oSpan.html("위험");
        } else if(step == 3) {
            oSpan.attr("class", "step_txt txt_yellow");
            oSpan.html("보통");
        } else if(step == 4) {
            oSpan.attr("class", "step_txt txt_green");
            oSpan.html("안전");
        } else {
            oSpan.attr("class", "step_txt");
            oSpan.html("");
        }
    }

    function showPasswd2ImgByDiff(diff) {
        if("IE8" == "") {
            return false;
        }
    alert("비밀번호가 다릅니다.")
    }

    function calcAge(birth) {
        var date = new Date();
        var year = date.getFullYear();
        var month = (date.getMonth() + 1);
        var day = date.getDate();
        if (month < 10)
            month = '0' + month;
        if (day < 10)
            day = '0' + day;
        var monthDay = month + '' + day;

        birth = birth.replace('-', '').replace('-', '');
        var birthdayy = birth.substr(0, 4);
        var birthdaymd = birth.substr(4, 4);

        var age = monthDay < birthdaymd ? year - birthdayy - 1 : year - birthdayy;
        return age;
    }
	
    function isValidDate(param) {
        if(param.length==8){
        	return true;
        }else{
        	false;
        }
    }
    
    //region EmailCheck////////////////////////////////////////////////////////////////////////////////////////////////
   	function isAuthEmail(){
   		//$("authNo").attr("disabled", false); //해제
   		var oMsg = $("#emailMsg");
   		var usermail = $("#email").val();

   		if(mailFlag){
   			
   			$.ajax({//Id Duplication Check
   	            type:"GET",
   	            url: "checkAuthNum?usermail=" + usermail ,
   	            success : function(result) {
   	                if (result != 0) {
   	                	showSuccessMsg(oMsg, joinFormnsm);
   	                	sendFlag=true;
   	                	userAuthNo = result;
   	                } else {
   	                    showErrorMsg(oMsg, joinFormnfm);
   	                }
   	            }
   	        });
   		}else{
   			alert("Pls check Email!");
   		}
    }
    //Ajax 이메일인증번호 
    function isValidEmail() {
        var authNo = $("#authNo").val();
        var oMsg = $("#authNoMsg");
        var oBox = $("#authNoBox");
        var oCode = $("#authNoCode");

        if (authNo == "") {
            showErrorMsg(oMsg,joinFormvnm);
            return false;
        }

        if(authFlag) {
            showSuccessMsg(oMsg,joinFormvsm2);
            showAuthSuccessBox(oBox, oCode, joinFormvsm3);
            $("#phoneNoMsg").hide();
            return true;
        } else {
            checkAuthnoByAjax();
        }
        return true;
    }

    function checkPhone() {
    	var p = $("#phoneNo").val();
        var oMsg = $("#phoneNoMsg");
        var regPhone = /^((01[1|6|7|8|9])[1-9]+[0-9]{6,7})|(010[1-9][0-9]{7})$/;
        if(isNaN(p)){
        	showErrorMsg(oMsg, joinFormncm);
        	return false;
        }else{
        	phoneFlag = true;
        	return true;
        }
    }
    ///////////////////////////////////////////////////////////////////////////////////////////////
    //Korean Address API
	function setAddress(){
		var roadFullAddr = $('#roadFullAddr').val();
		var zipNo = $('zipNo').val();
		
		document.getElementById('fullAddr').value = roadFullAddr;
		document.getElementById('zipcode').value = zipNo;
	}
	
	function goPopup(){
		// 주소검색을 수행할 팝업 페이지를 호출합니다.
		// 호출된 페이지(jusopopup.jsp)에서 실제 주소검색URL(http://www.juso.go.kr/addrlink/addrLinkUrl.do)를 호출하게 됩니다.
		var pop = window.open("pop","pop","width=570,height=420, scrollbars=yes, resizable=yes"); 
		
		// 모바일 웹인 경우, 호출된 페이지(jusopopup.jsp)에서 실제 주소검색URL(http://www.juso.go.kr/addrlink/addrMobileLinkUrl.do)를 호출하게 됩니다.
	    //var pop = window.open("/popup/jusoPopup.jsp","pop","scrollbars=yes, resizable=yes"); 
	}
	
	
	////////////////////////////////////////////////////////////////////////////////////////////인증 팝업구현
    function winOpenAtCenter(sURL, sWindowName, w, h, sScroll) {
        // 화면 중앙으로 Popup 띄우기.. 스크롤바는 옵션..
        // ex)
        // openWin("test.asp", "winTest", 400, 300); ☞ 스크롤바 없음
        // openWin("test.asp", "winTest", 400, 300, "yes"); ☞ 스크롤바 있음
        // openWin("test.asp", "winTest", 400, 300, "auto"); ☞ 스크롤바 자동

        var x = (screen.width - w) / 2;
        var y = (screen.height - h) / 2;

        if (sScroll == null)
            sScroll = "no";

        var sOption = "";
        sOption = sOption + "toolbar=no, channelmode=no, location=no, directories=no, resizable=no, menubar=no";
        sOption = sOption + ", scrollbars=" + sScroll + ", left=" + x + ", top=" + y + ", width=" + w + ", height=" + h;

        var win = window.open(sURL, sWindowName, sOption);
        return win;
    }

    //endregion
</script>
<style>
@import url(//fonts.googleapis.com/earlyaccess/notosansjapanese.css);

body, h {
	font-family: 'Raleway', 'Nanum Gothic', 'Noto Sans Japanese';
}
</style>
<body class="is-preload">
<input id="lang" type="hidden" value="<spring:message code="common.lang" />">

<input id="joinFormId" type="hidden" value="<spring:message code="joinForm.Id" />">
<input id="joinFormPw" type="hidden" value="<spring:message code="joinForm.Pw" />">
<input id="joinFormName" type="hidden" value="<spring:message code="joinForm.Name" />">
<input id="joinFormBirth" type="hidden" value="<spring:message code="joinForm.Birth" />">
<input id="joinFormYear" type="hidden" value="<spring:message code="joinForm.Year" />">
<input id="joinFormMonth" type="hidden" value="<spring:message code="joinForm.Month" />">
<input id="joinFormDay" type="hidden" value="<spring:message code="joinForm.Day" />">
<input id="joinFormGender" type="hidden" value="<spring:message code="joinForm.Gender" />">
<input id="joinFormMan" type="hidden" value="<spring:message code="joinForm.Man" />">
<input id="joinFormWoman" type="hidden" value="<spring:message code="joinForm.Woman" />">
<input id="joinFormEmail" type="hidden" value="<spring:message code="joinForm.Email" />">
<input id="joinFormAuthRequest" type="hidden" value="<spring:message code="joinForm.AuthRequest" />">
<input id="joinFormPhone" type="hidden" value="<spring:message code="joinForm.Phone" />">
<input id="joinFormAddrKor" type="hidden" value="<spring:message code="joinForm.AddrKor" />">
<input id="joinFormSearchAddr" type="hidden" value="<spring:message code="joinForm.SearchAddr" />">
<input id="joinFormSignUp" type="hidden" value="<spring:message code="joinForm.SignUp" />">
<input id="joinFormnInfo" type="hidden" value="<spring:message code="joinForm.nInfo" />">
<input id="joinFormchkBirth" type="hidden" value="<spring:message code="joinForm.chkBirth" />">
<input id="joinFormchkEmail" type="hidden" value="<spring:message code="joinForm.chkEmail" />">
<input id="joinFormClause" type="hidden" value="<spring:message code="joinForm.Clause" />">
<input id="joinFormPersonalInfo" type="hidden" value="<spring:message code="joinForm.PersonalInfo" />">

<input id="joinFormnem" type="hidden" value="<spring:message code="joinForm.nem" />">
<input id="joinFormnsm" type="hidden" value="<spring:message code="joinForm.nsm" />">
<input id="joinFormnfm" type="hidden" value="<spring:message code="joinForm.nfm" />">
<input id="joinFormvnm" type="hidden" value="<spring:message code="joinForm.vnm" />">
<input id="joinFormvsm2" type="hidden" value="<spring:message code="joinForm.vsm2" />">
<input id="joinFormvsm3" type="hidden" value="<spring:message code="joinForm.vsm3" />">
<input id="joinFormncm" type="hidden" value="<spring:message code="joinForm.ncm" />">

<input id="joinFormidem" type="hidden" value="<spring:message code="joinForm.idem" />">
<input id="joinFormidsm" type="hidden" value="<spring:message code="joinForm.idsm" />">
<input id="joinFormidfm" type="hidden" value="<spring:message code="joinForm.idfm" />">
<input id="joinFormpwem" type="hidden" value="<spring:message code="joinForm.pwem" />">
<input id="joinFormpwem1" type="hidden" value="<spring:message code="joinForm.pwem1" />">
<input id="joinFormpwem2" type="hidden" value="<spring:message code="joinForm.pwem2" />">
<input id="joinFormmsm" type="hidden" value="<spring:message code="joinForm.msm" />">
<input id="joinFormmfm" type="hidden" value="<spring:message code="joinForm.mfm" />">
<input id="joinFormbem" type="hidden" value="<spring:message code="joinForm.bem" />">
<input id="joinFormyem" type="hidden" value="<spring:message code="joinForm.yem" />">
<input id="joinFormmem" type="hidden" value="<spring:message code="joinForm.mem" />">
<input id="joinFormdem" type="hidden" value="<spring:message code="joinForm.dem" />">
<input id="joinFormaem" type="hidden" value="<spring:message code="joinForm.aem" />">
<input id="joinFormaem1" type="hidden" value="<spring:message code="joinForm.aem1" />">
<input id="joinFormaem2" type="hidden" value="<spring:message code="joinForm.aem2" />">
<input id="joinFormeem" type="hidden" value="<spring:message code="joinForm.eem" />">
<input id="joinFormeem1" type="hidden" value="<spring:message code="joinForm.eem1" />">
<input id="joinFormesm" type="hidden" value="<spring:message code="joinForm.esm" />">
<input id="joinFormeem2" type="hidden" value="<spring:message code="joinForm.eem2" />">
<input id="joinFormvem" type="hidden" value="<spring:message code="joinForm.vem" />">
<input id="joinFormvsm" type="hidden" value="<spring:message code="joinForm.vsm" />">



<div id="wrap"class="limiter">
<div  class="container-login100">
<div class="wrap-login100">
<!-- header -->
<div id="header" class="login100-form-title" role="banner">
    <a href="${pageContext.request.contextPath}"><img style="border-radius: 10px" width="490px" height="150px" alt="" src="resources/images/logo.gif"> </a>
</div>

<!-- // header -->

<form action="join_form" id="form" name="form" method="post" class="login100-form">
    <input type="hidden" id="userid" name="userid" value="">
    <input type="hidden" id="password" name="password" value="">
    <input type="hidden" id="username" name="username" value="">
    <input type="hidden" id="birthday" name="birthday" value="">
    <input type="hidden" id="myurl" name="myurl" value="">
    <input type="hidden" id="joinMode" name="joinMode" value="unreal">
	<br><br>
	
    <!-- container -->
    <div id="container" role="main">
        <div id="content">
            
            <div class="join_content">
                <!-- 아이디, 비밀번호 입력 -->
                <div class="row_group">
                    <div style="display: inline-block" class="wrap-input100 validate-input">      
							<input type="text" id="id" name="id" class="input100" title="ID" maxlength="20">
							<span class="focus-input100" data-placeholder="<spring:message code="joinForm.Id" />"></span>
                    </div>
                    <span style="display: block;"  class="error_next_box" id="idMsg" style="display:none"></span>
                    <br>
                    <div style="display: inline-block"  class="wrap-input100 validate-input">
							<input type="password" id="pswd1" name="pswd1" class="input100" maxlength="20">
							<span class="focus-input100" data-placeholder="<spring:message code="joinForm.Pw" />"></span>
					</div>
					 <span style="display: block;"  class="error_next_box" id="pswd1Msg" style="display:none"></span>
					<br>
					<div style="display: inline-block;"  class="wrap-input100 validate-input">
							<input type="password" id="pswd2" name="pswd2" class="input100" maxlength="40">
							<span class="focus-input100" data-placeholder="<spring:message code="joinForm.ChkPw" />"></span>
                    </div>
                    <span style="display: block;"  class="error_next_box" id="pswd2Msg" style="display:none"></span>
                    <br>
                </div>
                <!-- // 아이디, 비밀번호 입력 -->

                <!-- 이름, 생년월일 입력 -->
                <div class="row_group">

                    <!-- lang = ko_KR -->
                    <div style="display: inline-block" class="wrap-input100 validate-input">
						<input type="text" id="name" name="name" title="이름" class="input100" maxlength="40">
						<span class="focus-input100" data-placeholder="<spring:message code="joinForm.Name" />"></span>
                    </div>
                    <span class="error_next_box" id="nameMsg" style="display:none"></span>
                    <!-- lang = ko_KR -->

                    <div>
                        <h6 style="color: #999999" class="join_title"><spring:message code="joinForm.Birth" /></h6>
                        
                            <div style="display: inline-block;" class="wrap-input10 validate-input">
								<input type="text" id="yy" placeholder="<spring:message code="joinForm.Year" />" class="input1" maxlength="4">
                            </div>
                            <div style="display: inline-block;" class="wrap-input10 validate-input">
									<select id="mm" title="월" class="sel">
										<option><spring:message code="joinForm.Month" /></option>
										  	 			<option value="01">
                                                            1
                                                        </option>
										  	 			<option value="02">
                                                            2
                                                        </option>
										  	 			<option value="03">
                                                            3
                                                        </option>
										  	 			<option value="04">
                                                            4
                                                        </option>
										  	 			<option value="05">
                                                            5
                                                        </option>
										  	 			<option value="06">
                                                            6
                                                        </option>
										  	 			<option value="07">
                                                            7
                                                        </option>
										  	 			<option value="08">
                                                            8
                                                        </option>
										  	 			<option value="09">
                                                            9
                                                        </option>
										  	 			<option value="10">
                                                            10
                                                        </option>
										  	 			<option value="11">
                                                            11
                                                        </option>
										  	 			<option value="12">
                                                            12
                                                        </option>
									</select>
                            </div>
                            <div style="display: inline-block;" class="wrap-input10 validate-input">
									<input type="text" id="dd" placeholder="<spring:message code="joinForm.Day" />" class="input10" maxlength="2">
                            </div>
                        
                    </div>
                    <span style="display: block;" class="error_next_box" id="birthdayMsg" style="display:none"></span>
					<br>
                    <div class="join_row join_sex">
                        <h6 style="color: #999999" class="join_title"><spring:message code="joinForm.Gender" /></h6>
                        <div class="ps_box gender_code">
                            <select id="gender" name="gender" title="성별" class="sel">
                                <option value="" selected="">"<spring:message code="joinForm.Gender" />"</option>
                                <option value="남자"><spring:message code="joinForm.Man" /></option>
                                <option value="여자"><spring:message code="joinForm.Woman" /></option>
                            </select>
                        </div>
                    </div>
                    <span class="error_next_box" id="genderMsg" style="display:none"></span>
					
					<br>
					
					<div style="display: inline-block" class="wrap-input100 validate-input">      
							<input type="text" id="email" name="email" class="input100" maxlength="100">
							<span class="focus-input100" data-placeholder="<spring:message code="joinForm.Email" />"></span>
                    </div>
							<input class="clickbutton" type="button" id="emailCheck" value="<spring:message code="joinForm.AuthRequest" />" onclick="isAuthEmail()"/>
							<span style="display: block;" class="error_next_box" id="emailMsg" style="display:none"></span>
					<br>
					<div style="display: inline-block" class="wrap-input100 validate-input">				
							<input type="text" id="authNo" name="authNo" class="input100" maxlength="100">
							<span class="focus-input100" data-placeholder="<spring:message code="joinForm.AuthRequest" />"></span>
                    </div>
                    <span class="error_next_box" id="authNoMsg" style="display:none"></span>
                </div>
				<br><br>
                <!-- 휴대전화 번호 -->
                <div style="display: inline-block" class="wrap-input100 validate-input">
							<input type="tel" id="phoneNo" name="phoneNo" class="input100" maxlength="16">
							<span class="focus-input100" data-placeholder="<spring:message code="joinForm.Phone" />"></span>
                </div>
                <span class="error_next_box" id="phoneNoMsg" style="display:none"></span>
                
                <br>
           		<!-- region KorAddressAPI -->              
       <div class="KorAddress">
			<div id="list"></div>
	        <div id="callBackDiv">
	        	<div style="display: inline-block" class="wrap-input100 validate-input">
	        		<input type="text" id="zipcode" name="zipcode" class="input100" maxlength="16" readonly="readonly">
					<input type="text" id="fullAddr" name="fullAddr" class="input100" maxlength="16" readonly="readonly" placeholder="<spring:message code="joinForm.AddrKor" />">
                </div>
				 <input class="clickbutton" type="button" onClick="goPopup();" value="<spring:message code="joinForm.SearchAddr" />"/>
			</div>
			<span class="error_next_box" id="fullAddrMsg" style="display:none"></span>
           	<br>
       </div>
          		<div>
          		<h3 class="join_title"> </h3>
          			<input type="button" onClick="mainSubmit()" value="<spring:message code="joinForm.SignUp" />" class="clickbutton"/>
         		</div>
         		<br><br>
          </div>
	</div>
</div>
    <!-- // container -->
</form>

	<!-- footer -->
	<div id="footer" role="contentinfo">
		<ul>
			<li><a href=""><spring:message code="joinForm.Clause" /></a></li>
			<li><strong><a href=""><spring:message code="joinForm.PersonalInfo" /></a></strong></li>
		</ul>
		<address>
			<em><a href="" target="_blank" class="logo"><span class="blind">C1</span></a></em>
			<em class="copy">Copyright</em>
			<em class="u_cri">©</em>
			<a href="" target="_blank" class="u_cra">ITmaster35.</a><!-- http://nhncorp.com/ -->
			<span class="all_r">All Rights Reserved.</span>
		</address>
	</div>
	<!-- //footer -->
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