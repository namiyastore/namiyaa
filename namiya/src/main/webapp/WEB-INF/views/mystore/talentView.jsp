<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>교환 글 자세히 보기</title>
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

	function talent() {
		location.href="talent";
	}
	
	function talentUpdate(boardnum) {
		location.href="talentUpdate?boardnum="+boardnum;
	}
	
	function deleted(boardnum) {
		var boardnum = boardnum;
		
		var answer = confirm("게시글을 삭제하시겠습니까?");
		
		if(answer) {
			$.ajax({
				method: 'get',
				url : 'deleted',
				data : {"boardnum" : boardnum},
				success : function(resp) {
					alert("삭제가 완료되었습니다!");
					location.href="talent";
				},
				error : function(resp) {
					alert("error: "+ error);
				}
			});
		}
		
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
	
	#givedetail {
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
   		width:100px;
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

	#image {
		width:200px;
		text-align: center;
	}
	
	#title {
		width:450px;
	}
	
	#date {
		width:150px;
		text-align: center;
	}
	
	#btn {
		width:150px;
		text-align: center;
	}
	
	#sstatus {
		width:450px;
	}
	
</style>
</head>
<body>
<div id="wrapper" align="center">
	<div id="scroll" style="float:left; width: 1073px; height:545px; overflow-y:auto; overflow-x:hidden; border-radius: 25px; background-color: white;">
			<div id="tradeform">
				<table>
					<tr>
						<td colspan="2" id="boardname">
							<h1 align="center"><b>Take advantage of my talent</b></h1>
							<hr/>
						</td>
					</tr>
					<tr>
					<c:if test="${userid != sessionScope.loginId && map.SSTATUS != '진행완료'}"> 
						<td colspan="2" align="right">
							<img src="${pageContext.request.contextPath}/resources/images/interest.png" onclick="interest(${map.BOARDNUM}, '${sessionScope.loginId}')" style="width:55px; height:40px;">
							<img src="${pageContext.request.contextPath}/resources/images/want.png" onclick="want(${map.BOARDNUM}, '${sessionScope.loginId}')" style="width:55px; height:40px;">
							<hr/>
						</td>
					</c:if>
					</tr>
					<tr>
						<td class="menu" colspan="2"><b>거래상태</b></td>
					</tr>
					<tr>
						<td colspan="2" class="scontent"> 
							<input class="ins" type="text" name="sstatus" id="sstatus" value="${map.SSTATUS}" readonly="readonly">
						</td>
					</tr>
					<tr>
						<td colspan="2" class="menu"><b>제목</b></td>
					</tr>
					<tr>
						<td colspan="2" class="scontent"><input type="text" class="ins" id="title" name="title" value="${board.title}" readonly="readonly"></td>
					</tr>
					<tr>
						<td colspan="2" class="menu"><b>내용</b></td>
					</tr>
					<tr>
						<td colspan="2">
							<div id="content" style="width:950px;" >
								<c:if test="${not empty board.originalfile}">
								<div align="center">
										<img alt="" src="${pageContext.request.contextPath}/home/img/boardfile/${board.savedfile}" style="width:200px; height:150px;">
										<br/>
								</div>
								<textarea rows="15" cols="150" style="resize:none; outline: none; border: none; background-color: #fcfbf9; padding-left: 10px; font-family: 'Jeju Gothic', Eco Sans Mono;" readonly="readonly">${board.content}</textarea>
								</c:if>	
								
								
								<c:if test="${empty board.originalfile}" >
										<textarea rows="15" cols="150" style="resize:none; outline: none; border: none; background-color: #fcfbf9; padding-left: 10px; font-family: 'Jeju Gothic', Eco Sans Mono;" readonly="readonly">${board.content}</textarea>
								</c:if>
							</div>
						</td>
					</tr>
					<tr>
						<td colspan="2" class="menu"><b>재능기부 정보</b></td>
					</tr>
					<tr>
						<td class="sort"><b>분류</b></td>
						<td class="scontent">
							<input class="ins" type="text" id="categoryname" name="categoryname" value="${map.CATEGORYNAME}" readonly="readonly">
						</td>
						
					</tr>
					<tr>
						<td class="sort"><b>상품이름</b></td>
						<td class="scontent"><input class="ins" type="text" id="productname" name="productname" value="${map.PRODUCTNAME}" readonly="readonly"></td>
					</tr>
				</table>
				<br/>
				<img src="${pageContext.request.contextPath}/resources/images/board.png" style="width:60px; height:40px;" onclick="talent()">
				<c:if test="${userid == sessionScope.loginId}"> 
				<img src="${pageContext.request.contextPath}/resources/images/update.png" style="width:60px; height:40px;" onclick="talentUpdate(${board.boardnum})">
				<img src="${pageContext.request.contextPath}/resources/images/delete.png" style="width:60px; height:40px;" onclick="deleted(${board.boardnum})">
				</c:if>
				<br/><br/>
			</div>
	</div>
			
	<div id="list" style="float:left; width: 90px; text-align:right; height:545px;">
		<ul>
			<li><a href="home"><img src="${pageContext.request.contextPath}/resources/images/home.png" style="width:90px; height:50px;"></a></li>
			<li><a href="give"><img src="${pageContext.request.contextPath}/resources/images/give.png" style="width:90px; height:50px;"></a></li>
			<li><a href="trade"><img src="${pageContext.request.contextPath}/resources/images/trade.png" style="width:90px; height:50px;"></a></li>
			<li><a href="talent"><img src="${pageContext.request.contextPath}/resources/images/talent.png" style="width:90px; height:50px;"></a></li>
			<li><a href="review"><img src="${pageContext.request.contextPath}/resources/images/review.png" style="width:90px; height:50px;"></a></li>
			<li><a href="favorite"><img src="${pageContext.request.contextPath}/resources/images/favoritemenu.png" style="width:90px; height:50px;"></a></li>
			<c:if test="${userid == sessionScope.loginId}">
			<li><a href="setting"><img src="${pageContext.request.contextPath}/resources/images/setting.png" style="width:90px; height:50px; "></a></li>
			</c:if>
		</ul>
	</div>
	
</div>
</body>
</html>