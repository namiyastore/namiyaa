<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>양도게시판</title>
<script type="text/javascript" src="resources/jquery-3.3.1.min.js"></script>
<script>
	function interest() {
		alert("관심상품에 추가되었습니다!");
	}
	
	function want() {
		alert("이 상품을 원합니다");
	}
</script>
<style>
::-webkit-scrollbar{width: 16px;}
::-webkit-scrollbar-track {background-color:AE79F1;}
::-webkit-scrollbar-thumb {background-color:#79bfe5;}
::-webkit-scrollbar-thumb:hover {background: #79bfe5;}
::-webkit-scrollbar-button:start:decrement,::-webkit-scrollbar-button:end:increment {
	width:16px;height:16px;background:#79bfe5;} 

@import url(//fonts.googleapis.com/earlyaccess/jejugothic.css);
	li {
		list-style:none;
	}
	
	body {
		background: url('resources/images/mystore.png') no-repeat center center fixed; 
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
	
	#givedetail {
		width: 1081px;
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
   		width: 600px;
		color: #414244;
	}
	
	.scontent {
		background-color: #fcfbf9;
		margin : 0 auto;
		border: 1px solid #fcfbf9;
   		border-radius: 10px;
   		background-color: #fcfbf9;
   		width: 600px;
	}
	
	#content {
		background-color: #fcfbf9;
		margin : 0 auto;
		border: 1px solid #fcfbf9;
   		border-radius: 10px;
   		background-color: #fcfbf9;
	}
	
	.ins {
		background-color: #fcfbf9;
		width: 600px;
		margin : 0 auto;
		border: 1px solid #fcfbf9;
    	padding: 10px;
   		border-radius: 10px;
   		background-color: #fcfbf9;
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
		font-family: Eco Sans Mono;
	}
	
	body, p {
		font-family: 'Jeju Gothic', sans-serif;
	}
	
	table, tr, td {
		margin : 0 auto;
		padding: 0px;	
	}
	
	table {
		width:950px;
		height: 160px;
		padding: 0px;
		margin:0px;
	}
	
	hr {
		width:950px;
	}
	
	#image {
		width:200px;
		text-align: center;
	}
	
	#title {
		width:450px;
		font-size:20px;
	}
	
	#date {
		width:150px;
		text-align: center;
	}
	
	#btn {
		width:150px;
		text-align: center;
	}
	
</style>
</head>
<body>
<div id="wrapper" align="center">
	<div id="scroll" style="float:left; width: 1081px; height:545px; overflow-y:auto; overflow-x:hidden; border-radius: 25px; background-color: white;">
		<div id="givedetail">
			<h1><b>Free Give</b></h1>
			<hr/>
			
			<a href="giveForm"><img src="resources/images/write.png" style="width:70px; height:40px;"></a>
			
			<hr/>
			<c:if test="${empty list}">
					<br/>
					<tr>
						<td colspan="3">등록된 무료양도 상품이 없습니다.</td>
					</tr>
			</c:if>
	
			<%-- 이하 글 목록 반복 --%>
			<c:if test="${not empty list}">
			<c:forEach var="list" items="${list}" varStatus="status">
				<table>
					<tr>
						<td id="image"><img src="resources/images/rabit.png" style="width:150px; height:150px;"></td>
						<td id="title"><a href="giveView?boardnum=${list.boardnum}" style="text-decoration:none; color:black;"><span id="title"><b>${list.title}</b></span></a></td>
						<td id="date">${list.regdate}</td>
						<td id="btn">
							<img src="resources/images/interest.png" onclick="interest()" style="width:55px; height:40px;">
							&nbsp;
							<img src="resources/images/want.png" onclick="want()" style="width:60px; height:39px;">
						</td>
					</tr>
				</table>
				<hr/>
			</c:forEach>
			</c:if>
				
				<%-- <c:if test="${empty list}"> 
					<p>등록된 무료양도 상품 목록이 없습니다.</p>
				</c:if>
		
				<c:if test="${not empty list}">
					<c:forEach var="list" items="${list}" varStatus="status">
				<table>
					<tr>
						<td rowspan="2" id="image"><img src="resources/images/rabit.png"></td>
						<td colspan="2" id="title"><a href="boardView?boardnum=${list.boardnum}" style="text-decoration:none; color:black;"><b>${list.title}</b></a></td>
					</tr>
					
					<tr>
						<td id="writer">Write by&nbsp;<span><b>${list.userid}</b></span></td>
						<td id="date">Date &nbsp;<span><b>${list.regdate}</b></span></td>
					</tr>
				</table>
					<tr></tr>
					</c:forEach>
				</c:if> --%>
			</div>
	</div>
		
	<div id="list" style="float:left; width: 90px; text-align:right; height:545px;">
		<ul>
			<li><a href="myStore"><img src="resources/images/home.png" style="width:90px; height:50px;"></a></li>
			<li><a href="give"><img src="resources/images/give.png" style="width:90px; height:50px;"></a></li>
			<li><a href="trade"><img src="resources/images/trade.png" style="width:90px; height:50px;"></a></li>
			<li><a href="talent"><img src="resources/images/talent.png" style="width:90px; height:50px;"></a></li>
			<li><a href="review"><img src="resources/images/review.png" style="width:90px; height:50px;"></a></li>
			<li><a href="setting"><img src="resources/images/setting.png" style="width:90px; height:50px;"></a></li>
		</ul>
	</div>
	
</div>
</body>
</html>