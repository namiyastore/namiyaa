<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>교환게시판</title>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/jquery-3.3.1.min.js"></script>
<script>
$(document).ready(function(){
	   $(window).resize(function (){
	      resizeTo(1217, 728);
	   });
});


function interest(boardnum, userid) {
	var boardnum = boardnum;
	var userid = userid;
	
	var sendData = {"userid" : userid, "boardnum" : boardnum};
	
 $.ajax({
    	url : 'selectItr',
    	method : 'post',
    	data : JSON.stringify(sendData),
    	contentType : 'application/json; charset=UTF-8',
    	success : function(resp) {
			alert(resp);
    	}
    	,
    	error : function(error) {
    		alert("interest error : "+error);
    	}
    });
}

function want(boardnum, userid) {
	window.open("checkPoint?boardnum="+boardnum+"&userid="+userid, "newwindowpoint", "width=500, height=300");
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
	
	
	#tradedetail {
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
		font-family: 'Jeju Gothic', Eco Sans Mono;
	}
	
	table, tr, td {
		margin : 0 auto;
		padding: 0px;	
	}
	
	table {
		width:900px;
		height: 160px;
		padding: 0px;
		margin:0px;
		font-family: 'Jeju Gothic', Eco Sans Mono;
	}
	
	hr {
		width:950px;
	}
	
	#image {
		width:180px;
		text-align: center;
	}
	
	#title {
		width:350px;
		font-size:20px;
	}
	
	#date {
		width:150px;
		text-align: center;
		font-family: 'Jeju Gothic';
	}
	
	#btn {
		width:150px;
		text-align: center;
	}
	
	#page {
		width: 150px;
		display:flex;
		align-items: center;
		justify-content: space-between;
	}
</style>
</head>
<body>
<div id="wrapper" align="center">
	<div id="scroll" style="float:left; width: 1073px; height:545px; overflow-y:auto; overflow-x:hidden; border-radius: 25px; background-color: white;">
		<div id="tradedetail">
			<h1><b>Exchange Things</b></h1>
			<hr/>
			
				<a href="tradeForm"><img src="${pageContext.request.contextPath}/resources/images/write.png" style="width:70px; height:40px;"></a>
				
				<hr/>
				<c:if test="${empty map}"> 
				<br/>
					<tr>
						<td colspan="3">등록된 교환 상품이 없습니다.</td>
					</tr>
				</c:if>
		
				<%-- 이하 글 목록 반복 --%>
				<c:if test="${not empty map}">
				<c:forEach var="map" items="${map}" varStatus="status">
				<table>
					<tr>
						<td style="width:50px; font-family: 'Jeju Gothic'; font-size: 15px; color:#105531;"><b>${map.SSTATUS}</b></td>
						<c:if test="${map.ORIGINALFILE != null}">
						<td id="image"><img src="${pageContext.request.contextPath}/boardfile/${map.SAVEDFILE}" style="width:150px; height:100px;"></td>
						</c:if>
						<c:if test="${map.ORIGINALFILE == null}">
						<td id="image"><img src="${pageContext.request.contextPath}/resources/images/basiclogo.png" style="width:150px; height:50px;"></td>
						</c:if>
						<td id="title"><a href="tradeView?boardnum=${map.BOARDNUM}" style="text-decoration:none; color:black;"><span id="title"><b>${map.TITLE}</b></span></a></td>
						<td id="date">${map.REGDATE}</td>
						<c:if test="${map.USERID != sessionScope.loginId}">
						<td id="btn">
							<img src="${pageContext.request.contextPath}/resources/images/interest.png" onclick="interest(${map.BOARDNUM}, '${sessionScope.loginId}')" style="width:55px; height:40px;">
							&nbsp;
							<img src="${pageContext.request.contextPath}/resources/images/want.png" onclick="want(${map.BOARDNUM}, '${sessionScope.loginId}')" style="width:55px; height:40px;">
						</td>
						</c:if>
					</tr>
				</table>
				<hr/>
				</c:forEach>
			
			<%-- 페이징 처리하기  --%>
			<br/>
			<div id="page">
				<div>
					<a href="trade?currentPage=${navi.currentPage-navi.pagePerGroup}"><img src="${pageContext.request.contextPath}/resources/images/arrow2.png" style="width:20px; height:30px;"></a>
				</div>
				
				<div>
					<a href="trade?currentPage=${navi.currentPage-1}"><img src="${pageContext.request.contextPath}/resources/images/arrow4.png" style="width:20px; height:30px;"></a>
				</div>
				
				<c:forEach var="page" begin="${navi.startPageGroup}" end="${navi.endPageGroup}">
					<c:if test="${page == navi.currentPage}">
						<div>
							<span style="color:#0081C6; font-weight:bold; text-decoration:none; color:black;"><dr>&nbsp;${page}</dr></span>&nbsp;
						</div>
					</c:if>	
					
					<c:if test="${page != navi.currentPage}">
						<div>
							<a style="text-decoration:none; color:black;" href="trade?currentPage=${page}">&nbsp;${page}</a>&nbsp;
						</div>
					</c:if>
				</c:forEach>
				
				<div>
					<a href="trade?currentPage=${navi.currentPage+1}"><img src="${pageContext.request.contextPath}/resources/images/arrow3.png" style="width:20px; height:30px;"></a>
				</div>
				
				<div>
					<a href="trade?currentPage=${navi.currentPage+navi.pagePerGroup}"><img src="${pageContext.request.contextPath}/resources/images/arrow1.png" style="width:20px; height:30px;"></a>
				</div>
			</div>
			</c:if>
				<br/>
		</div>
	</div>
	<div id="list" style="float:left; width: 90px; text-align:right; height:545px;">
		<ul>
			<li><a href="home"><img src="${pageContext.request.contextPath}/resources/images/home.png" style="width:90px; height:50px; margin-bottom: 1px;"></a></li>
			<li><a href="give"><img src="${pageContext.request.contextPath}/resources/images/give.png" style="width:90px; height:50px; margin-bottom: 1px;"></a></li>
			<li><a href="trade"><img src="${pageContext.request.contextPath}/resources/images/trade.png" style="width:90px; height:50px; margin-bottom: 1px;"></a></li>
			<li><a href="talent"><img src="${pageContext.request.contextPath}/resources/images/talent.png" style="width:90px; height:50px; margin-bottom: 1px;"></a></li>
			<li><a href="review"><img src="${pageContext.request.contextPath}/resources/images/review.png" style="width:90px; height:50px; margin-bottom: 1px;"></a></li>
			<li><a href="favorite"><img src="${pageContext.request.contextPath}/resources/images/favoritemenu.png" style="width:90px; height:50px; margin-bottom: 1px;"></a></li>
			<li><a href="setting"><img src="${pageContext.request.contextPath}/resources/images/setting.png" style="width:90px; height:50px; margin-bottom: 1px;"></a></li>
		</ul>
	</div>
	
</div>
</body>
</html>