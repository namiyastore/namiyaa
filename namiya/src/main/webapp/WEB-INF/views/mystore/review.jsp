<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>후기게시판</title>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/jquery-3.3.1.min.js"></script>
<script>
$(document).ready(function(){
	   $(window).resize(function (){
	      resizeTo(1217, 728);
	   });
});

	function writeReview() {
		var answer = confirm("후기를 등록하시겠습니까?");
		if (answer) {
			document.form.submit();
		}
	}
	
	function deleteReview(reviewnum) {
		var answer = confirm("후기를 삭제하시겠습니까?");
		var reviewnum = reviewnum;
		
		if (answer) {
			$.ajax({
				method: 'get',
				url : 'deleteReview',
				data : {"reviewnum" : reviewnum},
				success : function(resp) {
					alert("삭제 되었습니다!");
					location.href="review";
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
	
	#reviewdetail {
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
	
	.btn {
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
	
	.btn:hover {
		opacity: .9;
	}
	
	hr {
		width:950px;
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
		<div id="givedetail">
		<form name="form" action="insertReview" method="post">
		<input type="hidden" name="userid" value="${sessionScope.loginId}">
		<input type="hidden" name="store_owner" value="${store_owner}">
			<h1><b>Review</b></h1>
			<hr/>
			<br/>
				<%-- 후기작성 칸 --%>
				<div style="width:550px; height:185px; background-color: #edf0f2; border-radius: 15px;">
					<table align="center">
						<tr>
							<td>
								<img src="${pageContext.request.contextPath}/resources/images/basiclogo.png" style="width:130px; height: 45px; margin-top: 5px; margin-right: 20px;">
							</td>
							<td>
								<textarea rows="9" cols="50" style="resize: none; margin-top: 5px; outline: none;" id="review_content" name="review_content"></textarea>
							</td>
						</tr>
						
						<c:if test="${store_owner != sessionScope.loginId}">
						<tr>
							<td colspan="2" align="right" style="padding-top: 8px;">
								<input class="btn" id="write" type="button" value="Write" onclick="writeReview()">
							</td>
						</tr>
						</c:if>
					</table>
				</div>
		</form>
		<br/>
		<hr/>
		<br/>
				<c:if test="${empty list}"> 
					<p>등록된 후기가 없습니다.</p>
				</c:if>
				<c:if test="${not empty list}">
					<c:forEach var="list" items="${list}" varStatus="status">
						<div style="width:550px; height:220px; background-color: #f2f6f9; border-radius: 15px;">
						<table align="center">
							<tr>
								<td align="center" style="padding-top: 8px; padding-bottom: 5px;">Write by <b>${list.userid}</b></td>
								<td align="right" style="padding-top: 8px; padding-bottom: 5px;font-family: 'Jeju Gothic';">${list.regdate}</td>
							</tr>
							<tr>
								<td>
									<img align="center" src="${pageContext.request.contextPath}/resources/images/basiclogo.png" style="width:130px; height: 45px; margin-top: 5px; margin-right: 20px;">
								</td>
								<td>
									<textarea rows="9" cols="50" style="resize: none; margin-top: 5px; outline: none; " id="review_content" name="review_content">${list.review_content}</textarea>
								</td>
							</tr>
							<tr>
								<td colspan="2" align="right" style="padding-top: 5px;">
									<input class="btn" style="background-color:#2a3d4c;" id="deleted" type="button" value="Delete" onclick="deleteReview(${list.reviewnum})">
								</td>
							</tr>
						</table>
						</div>
						<br/>
					</c:forEach>
					
					<div id="page">
						<div>
							<a href="review?currentPage=${navi.currentPage-navi.pagePerGroup}"><img src="${pageContext.request.contextPath}/resources/images/arrow2.png" style="width:20px; height:30px;"></a>
						</div>
						
						<div>
							<a href="review?currentPage=${navi.currentPage-1}"><img src="${pageContext.request.contextPath}/resources/images/arrow4.png" style="width:20px; height:30px;"></a>
						</div>
						
						<c:forEach var="page" begin="${navi.startPageGroup}" end="${navi.endPageGroup}">
							<c:if test="${page == navi.currentPage}">
								<div>
									<span style="color:#0081C6; font-weight:bold; text-decoration:none; color:black;"><dr>${page}</dr></span>
								</div>
							</c:if>	
							
							<c:if test="${page != navi.currentPage}">
								<div>
									<a style="text-decoration:none; color:black;" href="review?currentPage=${page}">${page}</a>
								</div>
							</c:if>
						</c:forEach>
						
						<div>
							<a href="review?currentPage=${navi.currentPage+1}"><img src="${pageContext.request.contextPath}/resources/images/arrow3.png" style="width:20px; height:30px;"></a>
						</div>
						
						<div>
							<a href="review?currentPage=${navi.currentPage+navi.pagePerGroup}"><img src="${pageContext.request.contextPath}/resources/images/arrow1.png" style="width:20px; height:30px;"></a>
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
			<c:if test="${store_owner == sessionScope.loginId}">
			<li><a href="setting"><img src="${pageContext.request.contextPath}/resources/images/setting.png" style="width:90px; height:50px; margin-bottom: 1px;"></a></li>
			</c:if>
		</ul>
	</div>

</div>
</body>
</html>