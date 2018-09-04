<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>양도글 수정 폼</title>
<script type="text/javascript" src="resources/jquery-3.3.1.min.js"></script>
<script>
$(function(){
    $("#big").on("change", function(){
       var categorynum = $(this).val();
       var result = '';
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
    });
    
   	function middle() {
   		$("#middle").on("change", function(){
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

	if (title.value == '' || content.value == '') {
		alert('제목과 내용을 입력하세요.');
		return false;
	}
	
	if (big.value == '' || middle.value == '' || small.value == '') {
		alert('상품의 분류를 정확히 입력하세요.');
		return false;
	}
	
	if (productname.value == '') {
		alert('상품명을 정확히 입력하세요.');
		return false;
	}
	
	var answer = confirm("게시글을 수정하시겠습니까?");
	if (answer) {
		return true;		
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
		width: 800px;
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
	
	body {
		font-family: 'Jeju Gothic', sans-serif;
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
<div id="wrapper" align="center">
	<form name="form1" action="update" method="post" enctype="multipart/form-data">
	<input type="hidden" name="userid" value="aaa" id="userid">
	<input type="hidden" name="boardnum" value="${board.boardnum }">
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
						<td class="menu" colspan="2"><b>거래종류</b></td>
					</tr>
					<tr>
						<td colspan="2" class="scontent"> 
							<input class="ins" type="text" name="service" id="service" value="양도" readonly="readonly">
						</td>
					</tr>
					<tr>
						<td colspan="2" class="menu"><b>제목</b></td>
					</tr>
					<tr>
						<td colspan="2" class="scontent"><input type="text" class="ins" id="title" name="title" value="${board.title}"></td>
					</tr>
					<tr>
						<td colspan="2" class="menu"><b>내용</b></td>
					</tr>
					<tr>
						<td colspan="2"><textarea rows="15" cols="150" id="content" name="content" style="resize:none;">${board.content}</textarea></td>
					</tr>
					<tr>
						<td colspan="2" class="menu"><b>양도상품 정보</b></td>
					</tr>
					<tr>
						<td class="sort"><b>분류</b></td>
						<td class="scontent">
						<label style="font-size: 14px;">대분류</label>
							<select id="big">
								<c:forEach var="list" items="${c_list}">
									<option class="category" value="${list.categorynum}">${list.categoryname}</option>
								</c:forEach>
							</select>
						<label style="font-size: 14px;">중분류</label>
							<select id="middle">
							</select>
						<label style="font-size: 14px;">소분류</label>
							<select id="small" name="categorynum">
							</select>
						</td>
					</tr>
					<tr>
						<td class="sort"><b>상품이름</b></td>
						<td class="scontent"><input class="ins" type="text" id="productname" name="productname" value="${map.PRODUCTNAME}"></td>
					</tr>
					<tr>
						<td class="sort"><b>첨부파일</b></td>
						<td class="scontent">
						<c:if test="${not empty board.originalfile}">
							<img src="boardfile/${board.savedfile}" style="width:100px; height:50px;">
						</c:if>
						<!-- 기 첨부된 파일이 존재할 경우 출력 -->
						<c:if test="${board.originalfile != null}">
						&nbsp;<a style="color:red" href="deletefile?boardnum=${board.boardnum}"><span>x</span></a>
						</c:if>
						<br/>
							<input type="file" name="upload" id="file" accept="image/jpeg, image/png, image/gif">
							<p style="font-family: 'Jeju Gothic'; font-size: 12px; color:red;">이미지 파일만 등록가능합니다.</p>
						</td>
					</tr>
				</table>
				<br/>
				<input id="update" type="image" src="resources/images/update.png" style="width:60px; height:40px; outline: none;" onclick="return formCheck()">
				<a href="give"><img src="resources/images/board.png" style="width:60px; height:40px;"></a>
				<br/><br/>
			</div>
		</div>
	</form>
	<div id="list" style="float:left; width: 90px; text-align:right; height:545px;">
		<ul>
			<li><a href="myStore"><img src="resources/images/home.png" style="width:90px; height:50px;"></a></li>
			<li><a href="give"><img src="resources/images/give.png" style="width:90px; height:50px;"></a></li>
			<li><a href="trade"><img src="resources/images/trade.png" style="width:90px; height:50px;"></a></li>
			<li><a href="talent"><img src="resources/images/talent.png" style="width:90px; height:50px;"></a></li>
			<li><a href="review"><img src="resources/images/review.png" style="width:90px; height:50px;"></a></li>
			<li><a href="setting"><img src="resources/images/setting.png" style="width:90px; height:50px; "></a></li>
		</ul>
	</div>
	
</div>
</body>
</html>