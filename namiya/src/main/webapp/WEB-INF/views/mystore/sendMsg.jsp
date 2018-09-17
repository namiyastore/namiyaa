<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>쪽지보내기</title>
<script>
	function sendaMsg() {
		var msg_title = document.getElementById("msg_title");
		var msg_content = document.getElementById("msg_content");
		var writerid = document.getElementById("writerid");
		var userid = document.getElementById("userid");
		
		if(msg_title.length == 0) {
			alert("제목을 입력하세요");
			return false;
		}
		
		if(msg_content.length == 0) {
			alert("내용을 입력하세요");
			return false;
		}
		
		document.form.submit();
	}
</script>
<style>
	body {
		background: url('resources/images/msgmain.png') no-repeat center center fixed; 
 		-webkit-background-size: cover;
  		-moz-background-size: cover;
  		-o-background-size: cover;
  		background-size: cover;
	}
	
	.menu {
		border: 1px solid #79bfe5;
   		border-radius:7px;
   		background-color: #79bfe5;
   		margin : 0 auto;
		font-size: 14px;
		padding: 3px;
		width:100px;
	}
	
	.content {
		background-color: #fcfbf9;
		margin : 0 auto;
		border: 1px solid #fcfbf9;
   		border-radius: 7px;
   		background-color: #fcfbf9;
   		font-size: 13px;
		padding: 3px;
	}
	
	#msg_title {
		background-color: #fcfbf9;
		margin : 0 auto;
		border: 1px solid #fcfbf9;
   		border-radius: 7px;
   		background-color: #fcfbf9;
   		font-size: 13px;
	}
	
	#msg_content {
		background-color: #fcfbf9;
		margin : 0 auto;
		border: 1px solid #fcfbf9;
   		border-radius: 7px;
   		background-color: #fcfbf9;
   		font-size: 13px;
	}
	
	#btn {
		display: inline-block;
		width: 60px;
		height: 25px;
		border: none;
		color: #fff;
		border-radius: 5px;
		background-color: var(--color-primary);
		-webkit-box-shadow: 0 2px 7px var(--color-semidark);
	        	box-shadow: 0 2px 7px var(--color-semidark);
		outline: 0;
		cursor: pointer;
		-webkit-transition: all .5s;
		-o-transition: all .5s;
		transition: all .5s;
		background-color:#105531;
		font-family: Eco Sans Mono;
		font-size: 15px;
	}
	
	#btn:hover {
		opacity: .9;
	}
</style>
</head>
<body>
<div id="wrapper" align="center">
<h1 style="color: white;">Send a message</h1>
<form action="insertMsg" name="form" method="post">
<input type="hidden" name="copy" value="1">
<table style="margin-bottom: 10px;">
	<tr>
		<td class="menu"><b>보내는사람</b></td>
		<td class="content"><input type="text" id="writerid" name="writerid" value="${sessionScope.loginId}" readonly="readonly" style="outline: none; border: none;"></td>
	</tr>
	<tr>
		<td class="menu"><b>받는사람</b></td>
		<td class="content"><input type="text" id="userid" name="userid" value="${userid}" readonly="readonly" style="outline: none; border: none;"></td>
	</tr>
	<tr>
		<td class="menu"><b>제목</b></td>
		<td class="content"><input name="msg_title" id="msg_title" style="width: 230px; outline: none;"></td>
	</tr>
	<tr>
		<td colspan="2" class="content"><textarea cols="50" rows="10" name="msg_content" id="msg_content" style="resize: none; outline: none;"></textarea></td>
	</tr>
</table>
</form>
	<input id="btn" type="button" value="Send" onclick="sendaMsg()">
</div>
</body>
</html>