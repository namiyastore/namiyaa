<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>양도글 작성 폼</title>
<link href="https://fonts.googleapis.com/css?family=VT323" rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Nanum+Gothic" rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Raleway:600" rel="stylesheet">
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/jquery-3.3.1.min.js"></script>
<script>
$(document).ready(function(){
	   $(window).resize(function (){
	      resizeTo(1217, 728);
	   });
});

$(function(){
    $("#big").on("change", function(){
    	var big = document.getElementById("big");
    	
    	if (big.value == '대분류') {
    		$("#middle").html("");
    		$("#small").html("");
    	}
    
       var categorynum = $(this).val();
       var result = '';
       if (categorynum > 0) {
       $.ajax({
       	url : 'selectMlist',
       	method : 'get',
       	data : {"categorynum" : categorynum},
       	success : function(resp) {
 		for(var i in resp) {
 			result += '<option class="category" value="'+resp[i].categorynum+'">'+resp[i].categoryname+'</option>';
 		}
			$("#middle").html(result);
			middle();
			var categorynum2 = $("#middle").val();
   	        var last = '';
   	        $.ajax({
   	        	url : 'selectSlist',
   	        	method : 'get',
   	        	data : {"categorynum" : categorynum2},
   	        	success : function(resp) {
   	  				for(var i in resp) {
   	  					last += '<option class="category" value="'+resp[i].categorynum+'">'+resp[i].categoryname+'</option>';
   	  				}
   	 				$("#small").html(last);
   	        	},
   	        	error : function(error) {
   	        		alert("error : "+error);
   	        	}
   	        });
       	}
       	,
       	error : function(error) {
       		alert("error : "+error);
       	}
       });
       }
    });
    
   	function middle() {
   		$("#middle").on("change", function(){
   	   		var categorynum2 = $("#middle").val();
   	        var last = '';
   	        
   	        if(categorynum2 > 0) {
   	        $.ajax({
   	        	url : 'selectSlist',
   	        	method : 'get',
   	        	data : {"categorynum" : categorynum2},
   	        	success : function(resp) {
   	  				for(var i in resp) {
   	  					last += '<option class="category" value="'+resp[i].categorynum+'">'+resp[i].categoryname+'</option>';
   	  				}
   	 				$("#small").html(last);
   	        	},
   	        	error : function(error) {
   	        		alert("error : "+error);
   	        	}
   	        });
   	        
   	        }
   	     });
   	}
});

function  formCheck() {
	var title = document.getElementById("title");
	var content = document.getElementById("content");
	var big = document.getElementById("big");
	var middle = document.getElementById("middle");
	var small = document.getElementById("small");
	var productname = document.getElementById("productname");
	var type = document.getElementById("service").value;
	
	//alert("종류:"+type);
	
	var sendData = {"type" : type};
	
	if (title.value == '' || content.value == '') {
		alert('제목과 내용을 입력하세요.');
		return false;
	}
	
	if (big.value == '' || middle.value == '' || small.value == '' || big.value == '대분류') {
		alert('상품의 분류를 정확히 입력하세요.');
		return false;
	}
	
	if (productname.value == '') {
		alert('상품명을 정확히 입력하세요.');
		return false;
	}

	
	return true;
}


</script>
<style>
@import url(//fonts.googleapis.com/earlyaccess/notosansjapanese.css);
::-webkit-scrollbar{width: 16px;}
::-webkit-scrollbar-track {background-color:AE79F1;}
::-webkit-scrollbar-thumb {background-color:#79bfe5;}
::-webkit-scrollbar-thumb:hover {background: #79bfe5;}
::-webkit-scrollbar-button:start:decrement,::-webkit-scrollbar-button:end:increment {
	width:16px;height:16px;background:#79bfe5;} 
	li {
		list-style:none;
	}
	
	body {
		background: url('${pageContext.request.contextPath}/resources/images/mystore.png') no-repeat center center fixed; 
 		-webkit-background-size: cover;
  		-moz-background-size: cover;
  		-o-background-size: cover;
  		background-size: cover;
	}
	
	#wrapper {
		border-radius: 25px;
		border-style: dotted;
		background-color: #fff9e7;
		width:1180px;
		height:545px;
		padding-top: 5px;
		padding-left: 5px;
		padding-right: 0px;
		border-color: #fff9e7;
	}
	
	
	#giveform {
		width: 1073px;
		height: 545px;
		border-radius: 25px;
		background-color: white;
		padding-top: 5px;
		padding-bottom: 5px;
	}
	
	
	ul, list, dir {
    	display: block;
   		list-style-type: disc;
    	-webkit-margin-before: 1em;
    	-webkit-margin-after: 1em;
   	 	-webkit-margin-start: 0px;
   	 	-webkit-margin-end: 0px;
    	-webkit-padding-start: 0px;
    	-webkit-padding-end: 0px;
	}
	
	.menu {
		border: 1px solid #79bfe5;
    	padding: 10px;
   		border-radius: 10px;
   		background-color: #79bfe5;
   		margin : 0 auto;
   		text-align:left;
   		width: 800px;
		color: #414244;
	}
	
	.scontent {
		background-color: #fcfbf9;
		margin : 0 auto;
		border: 1px solid #fcfbf9;
   		border-radius: 10px;
   		background-color: #fcfbf9;
   		width: 800px;
   		outline: none;
	}
	
	#content {
		background-color: #fcfbf9;
		margin : 0 auto;
		border: 1px solid #fcfbf9;
   		border-radius: 10px;
   		background-color: #fcfbf9;
   		outline: none;
	}
	
	.ins {
		background-color: #fcfbf9;
		width: 800px;
		margin : 0 auto;
		border: 1px solid #fcfbf9;
    	padding: 10px;
   		border-radius: 10px;
   		background-color: #fcfbf9;
   		outline: none;
	}

	.sort {
		border: 1px solid #a3d9f7;
    	padding: 10px;
   		border-radius: 10px;
   		background-color: #a3d9f7;
   		margin : 0 auto;
   		text-align:left;
   		color: #646568;
   		font-size: 14px;
	}
	
	h1 {
		font-family: 'VT323';
		font-size: 50px;
	}
	
	body {
		font-family: 'Raleway', 'Nanum Gothic', 'Noto Sans Japanese';
	}
	
	.scl {
		float:left; 
		width: 1073px; 
		height:545px; 
		overflow-y:auto; 
		overflow-x:hidden; 
		border-radius: 25px; 
		background-color: white;
	}

</style>
</head>
<body>
<input id="lang" type="hidden" value="<spring:message code="common.lang" />">
<div id="wrapper" align="center">
	<form name="form1" action="write" method="post" enctype="multipart/form-data">
	<input type="hidden" name="userid" value="${sessionScope.loginId}" id="userid">
		<div class="scl" id="scroll">
			<div id="giveform">
				<table>
					<tr>
						<td colspan="2" id="boardname" align="center">
							<h1><b>Free Give</b></h1>
							<hr/>
						</td>
					</tr>
					<tr>
						<td class="menu" colspan="2"><b><spring:message code="giveForm.sevice" /></b></td>
					</tr>
					<tr>
						<td colspan="2" class="scontent"> 
							<input class="ins" type="text" name="service" id="service" value="<spring:message code="giveForm.give" />" readonly="readonly">
						</td>
					</tr>
					<tr>
						<td colspan="2" class="menu"><b><spring:message code="giveForm.title" /></b></td>
					</tr>
					<tr>
						<td colspan="2" class="scontent"><input type="text" class="ins" id="title" name="title"></td>
					</tr>
					<tr>
						<td colspan="2" class="menu"><b><spring:message code="giveForm.content" /></b></td>
					</tr>
					<tr>
						<td colspan="2"><textarea rows="15" cols="150" id="content" name="content" style="resize:none;"></textarea></td>
					</tr>
					<tr>
						<td colspan="2" class="menu"><b><spring:message code="giveForm.productinfo" /></b></td>
					</tr>
					<tr>
						<td class="sort"><b><spring:message code="giveForm.sort" /></b></td>
						<td class="scontent">
						<label style="font-size: 14px;"><spring:message code="giveForm.sort.big" /></label>
							<select id="big">
								<option class="category" value="대분류">--대분류--</option>
								<c:forEach var="list" items="${c_list}">
									<c:if test="${list.categorynum != 1984 && list.categorynum != 1985}">
										<option class="category" value="${list.categorynum}">${list.categoryname}</option>
									</c:if>
								</c:forEach>
							</select>
						<label style="font-size: 14px;"><spring:message code="giveForm.sort.middle" /></label>
							<select id="middle">
							</select>
						<label style="font-size: 14px;"><spring:message code="giveForm.sort.small" /></label>
							<select id="small" name="categorynum">
							</select>
						</td>
					</tr>
					<tr>
						<td class="sort"><b><spring:message code="giveForm.name" /></b></td>
						<td class="scontent"><input class="ins" type="text" id="productname" name="productname"></td>
					</tr>
					<tr>
						<td class="sort"><b><spring:message code="giveForm.file" /></b></td>
						<td class="scontent">
							<input type="file" name="upload" id="file" accept="image/jpeg, image/png, image/gif">
							<p style="font-family: 'Nanum Gothic', 'Noto Sans Japanese'; font-size: 12px; color:red;"><spring:message code="giveForm.notice" /></p>
						</td>
					</tr>
				</table>
				<br/>
				<input id="insert" type="image" src="${pageContext.request.contextPath}/resources/images/insert.png" style="width:60px; height:40px; outline: none;" onclick="return formCheck()">
				<a href="give"><img src="${pageContext.request.contextPath}/resources/images/board.png" style="width:60px; height:40px;"></a>
				<br/><br/>
			</div>
		</div>
	</form>
	
	<div id="list" style="float:left; width: 90px; text-align:right; height:545px;">
		<ul>
			<li><a href="home"><img src="${pageContext.request.contextPath}/resources/images/home.png" style="width:90px; height:50px;"></a></li>
			<li><a href="give"><img src="${pageContext.request.contextPath}/resources/images/give.png" style="width:90px; height:50px;"></a></li>
			<li><a href="trade"><img src="${pageContext.request.contextPath}/resources/images/trade.png" style="width:90px; height:50px;"></a></li>
			<li><a href="talent"><img src="${pageContext.request.contextPath}/resources/images/talent.png" style="width:90px; height:50px;"></a></li>
			<li><a href="review"><img src="${pageContext.request.contextPath}/resources/images/review.png" style="width:90px; height:50px;"></a></li>
			<li><a href="favorite"><img src="${pageContext.request.contextPath}/resources/images/favoritemenu.png" style="width:90px; height:50px;"></a></li>
			<li><a href="setting"><img src="${pageContext.request.contextPath}/resources/images/setting.png" style="width:90px; height:50px; "></a></li>
		</ul>
	</div>
	
</div>
</body>
</html>