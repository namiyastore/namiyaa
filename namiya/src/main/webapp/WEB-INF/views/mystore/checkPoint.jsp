<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Point 사용</title>
<link href="https://fonts.googleapis.com/css?family=VT323" rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Nanum+Gothic" rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Raleway:600" rel="stylesheet">
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/jquery-3.3.1.min.js"></script>
<script>
	function UsePoint(boardnum, userid) {
		var usepoint = document.getElementById("pointcontent").value;
		var userid = userid;
		var boardnum = boardnum;
		var total = document.getElementById("total").innerHTML;
		var sendData = {"usepoint" : usepoint, "userid" : userid, "boardnum" : boardnum};
		
		if(isNaN(usepoint)) {
			alert("숫자만 입력해주세요!");	
			return false;
		}
		
		if(usepoint == 0) {
			alert("사용할 포인트를 입력해주세요!");
			return false;
		}
		
		if((usepoint%200) != 0) {
			alert("포인트는 200점 단위로 사용이 가능합니다.");
			return false;
		}
		
		if (total < 200) {
			alert("포인트는 200점 이상부터 사용이 가능합니다!");
			return false;
		}
		
		//alert(boardnum+", "+userid+"," + usepoint);
		// 포인트 사용하는 로직
		$.ajax({
			method : 'get',
			url : 'usePoint',
			data : {"usepoint" : usepoint, "userid" : userid, "boardnum" : boardnum},
			contentType : 'application/json; charset=UTF-8',
			success : function(resp) {
				alert(resp);
				this.close();
			},
			error : function(error) {
				alert("point error :"  + error);
			}
		});
		
	}
	
	function DontusePoint(boardnum, userid) {
		//alert(boardnum+", "+userid);
		var sendData = {"boardnum" : boardnum, "userid" : userid};
		$.ajax({
			url : 'DontusePoint',
			method : 'post',
			data : JSON.stringify(sendData),
			contentType : 'application/json; charset=UTF-8',
			success : function(resp) {
				alert(resp);
				this.close();
			},
			error : function(error) {
				alert("point error :"  + error);
			}
		});
		
	}
	
	function Closed() {
		this.close();
	}
</script>
<style>
	input[type="number"]::-webkit-outer-spin-button,
	input[type="number"]::-webkit-inner-spin-button {
	}

	body {
		background: url('${pageContext.request.contextPath}/resources/images/msgmain.png') no-repeat center center fixed; 
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
		width:110px;
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
	
	#pointcontent {
		background-color: #fcfbf9;
		margin : 0 auto;
		border: 1px solid #fcfbf9;
   		border-radius: 7px;
   		background-color: #fcfbf9;
   		font-size: 13px;
	}
	
	.btn {
		display: inline-block;
		width: 70px;
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
		font-family: 'Raleway';
		font-size: 15px;
	}
	
	.btn:hover {
		opacity: .9;
	}
	
	h1 {
		font-family: 'VT323';
		font-size: 50px;
	}
	
	body, p {
		font-family: 'Raleway', 'Nanum Gothic';
	}
</style>
</head>
<body>
<div id="wrapper" align="center">
<h1 style="color: white;">Point Use</h1>
<table style="padding-bottom: 10px;">
	<tr>
		<th colspan="2" style="color:white; font-size: 13px; padding-bottom: 10px;">포인트는 200점 단위로 사용이 가능합니다.</th>
	</tr>
	<tr>
		<th class="menu">사용가능 포인트</th>
		<td class="content" id="total">${point_total}</td>
	</tr>
	<tr>
		<th class="menu">사용할 포인트</th>
		<td class="content"><input id="pointcontent" type="number" name="quantity" min="0" step="200" value="0"></td>
	</tr>
</table>
<input class="btn" type="button" value="사용하기" onclick="UsePoint(${boardnum}, '${sessionScope.loginId}')">
<input class="btn" type="button" value="사용안함" onclick="DontusePoint(${boardnum}, '${sessionScope.loginId}')">
<input class="btn" type="button" value="닫기" onclick="Closed()">
</div>
</body>
</html>