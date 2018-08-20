<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>양도글 작성 폼</title>
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

function formCheck() {
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
	
	return true;
}
</script>
</head>
<body>
<div id="wrapper" align="center">
<form action="write" method="post" onsubmit="return formCheck()" enctype="multipart/form-data">
<input type="hidden" name="userid" value="${sessionScope.loginId}">
	<table border="1">
		<tr>
			<td>거래종류</td>
			<td>
				<input type="text" name="service" id="service" value="양도" readonly="readonly">
			</td>
		</tr>
		<tr>
			<td colspan="2">제목</td>
		</tr>
		<tr>
			<td colspan="2"><input type="text" id="title" name="title"></td>
		</tr>
		<tr>
			<td colspan="2">내용</td>
		</tr>
		<tr>
			<td colspan="2"><textarea rows="20" cols="110" id="content" name="content" style="resize:none;"></textarea></td>
		</tr>
		<tr>
			<td colspan="2">양도상품 정보</td>
		</tr>
		<tr>
			<td>분류</td>
			<td>
			<label>대분류</label>
				<select id="big">
					<c:forEach var="list" items="${c_list}">
						<option class="category" value="${list.categorynum}">${list.categoryname}</option>
					</c:forEach>
				</select>
			<label>중분류</label>
				<select id="middle">
				</select>
			<label>소분류</label>
				<select id="small">
				</select>
			</td>
		</tr>
		<tr>
			<td>상품명</td>
			<td><input type="text" id="productname" name="productname"></td>
		</tr>
		<tr>
			<td>첨부파일</td>
			<td><input type="file" name="upload"></td>
		</tr>
	</table>
	<input type="submit" value="등록">
	<input type="reset" value="삭제">
</form>
</div>
</body>
</html>