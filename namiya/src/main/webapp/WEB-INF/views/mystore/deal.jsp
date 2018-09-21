<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>거래진행과정</title>
<script type="text/javascript" src="resources/jquery-3.3.1.min.js"></script>
<script>
	function gotohistory() {
		location.href="historyList";
	}
	
	// 라인 메세지 전송
	function msgSend(id, content) {
		var message = content;
		var receive = id;
		
		var jsonData = { 
			'message' : message,
			'receive' : receive
		};
		
		$.ajax({
			method : 'get',
			url : 'LinenotifySendMsg',
			data : jsonData,
			dataType : 'json',
			success : function(resp) {
				alert(JSON.stringify(resp));
			}
		});
	}
	
	function selected(historynum) {
		alert("추첨하기");
		alert(historynum);
		
		$.ajax({
			method : 'post',
			url : 'selectWinner',
			data : {"historynum" : historynum},
			
			dataType: 'text',
			success : function(resp) {
				alert(resp);
				var a = '';
					a += '<td id="winnerid" class="result_info" style="text-align: center; width:120px; font-size: 14px; color:red;">';
					a += resp;
					a += '</td>';
					a += '<td class="result_info">';
					a += '<input type="button" id="message" class="btn" name="message" value="쪽지" onclick= "message(';
					a += "'"+resp+"'"; 
					a += ')" >';				
					a += '</td>';
				$("#winner").html(a);
				
				var urlAddr = "http://203.233.199.138:8081";
				var msg = "추첨%20대상자로%20선정되셨습니다%0Aline:" + urlAddr + "/namiya/sendMsg?userid=" + resp;
				
				// 당첨자에게 메세지 전송
				msgSend(resp, msg);
			},
			error : function(error) {
				alert("추첨 error : "+error);
			}
			
		});
		
	}
	
	function message(userid) {
		window.open("sendMsg?userid="+userid, "newmsgwindow", "width=450,height=400");
	}
</script>
<style>
	#info {
		width:810px;
	}
	
	#apply {
		width:280px;
	}
	
	.apply_list {
		border: 1px solid #79bfe5;
   		border-radius:7px;
   		background-color: #79bfe5;
   		margin : 0 auto;
   		width: 800px;
		color: #414244;
		font-size: 14px;
		padding: 3px;
	}
	
	.result {
		border: 1px solid #79bfe5;
   		border-radius:7px;
   		background-color: #79bfe5;
   		margin : 0 auto;
		color: #414244;
		width:200px;
		font-size: 14px;
		padding: 3px;
	}
	
	.result_info {
		background-color: #fcfbf9;
		margin : 0 auto;
		border: 1px solid #fcfbf9;
   		border-radius: 7px;
   		background-color: #fcfbf9;
   		font-size: 13px;
		padding: 3px;
	}
	
	.apply_info {
		background-color: #fcfbf9;
		margin : 0 auto;
		border: 1px solid #fcfbf9;
   		border-radius: 7px;
   		background-color: #fcfbf9;
   		font-size: 13px;
		padding: 3px;
	}
	
	.deal_list {
		border: 1px solid #79bfe5;
   		border-radius:7px;
   		background-color: #79bfe5;
   		margin : 0 auto;
   		width: 810px;
		color: #414244;
		font-size: 14px;
		padding: 3px;
	}
	
	.deal_info {
		background-color: #fcfbf9;
		margin : 0 auto;
		border: 1px solid #fcfbf9;
   		border-radius: 7px;
   		background-color: #fcfbf9;
   		font-size: 13px;
		padding: 3px;
	}
	
	body {
		font-family: 'Jeju Gothic', Eco Sans Mono;
	}
	
	h2 {
		font-family: 'Jeju Gothic', Eco Sans Mono;
	}
	
	.btn {
		display: inline-block;
		width: 60px;
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
</style>
</head>
<body>

<input id="userid" type="hidden" value="${sessionScope.loginId }" />

<div id="wrapper" align="center">
<div style="width:800px; height:600px;">
	<%-- 거래정보 --%>
	<div id="deal" style="padding-bottom: 30px; padding-top: 20px;">
	<h2>거래상품정보</h2>
		<table id="info">
			<tr style="width:800px; text-align: center">
				<th class="deal_list" >거래번호</th>
				<th class="deal_list" >거래종류</th>
				<th class="deal_list" >물건이름</th>
				<th class="deal_list" >거래시작날짜</th>
				<th class="deal_list" >거래완료날짜</th>
				<th class="deal_list" >판매자</th>
				<!-- <th class="deal_list" >구매자</th> -->
				<th class="deal_list" >거래상태</th>
				<th class="deal_list" style="width:400px;">거래목록</th>
			</tr>
			<tr class="deal_info" style="text-align: center;">
				<td class="deal_info" >${history.historynum}</td>
				<td class="deal_info" >${board.service}</td>
				<td class="deal_info" >${product.productname}</td>
				<td class="deal_info" style="font-family: 'Jeju Gothic';">${history.deal_start}</td>
				<td class="deal_info" style="font-family: 'Jeju Gothic';">
					<c:if test="${product.sstatus eq '거래완료'}">
						${history.deal_end}
					</c:if>				
				</td>
				<td class="deal_info" >${sessionScope.loginId}</td>
				<!-- <td id="buyer" class="deal_info" ></td> -->
				<td class="deal_info" >${product.sstatus}</td>
				<td><input type="button" class="btn" value="list" id="gotolist" onclick="gotohistory()"></td>
			</tr>
		</table>
	</div>
	
	<%-- 양도신청현황 --%>
	<div id="application" style="float: left; padding-top: 20px; padding-bottom: 20px; margin-right: 20px; width:280px; height:400px;">
	<h2>양도신청 현황</h2>
		<table id="apply" style="text-align: center;">
			<tr>
				<th class="apply_list">신청번호</th>
				<th class="apply_list">신청자</th>
			</tr>
			<c:forEach var="wlist" items="${wlist}" varStatus="status">
			<tr>
				<td class="apply_info">${wlist.wishnum}</td>
				<td class="apply_info">${wlist.userid}</td>
			</tr>
			</c:forEach>
		</table>
	</div>
	
	<%-- 추첨결과 --%>
	<div id="result" style="float: left; padding-top: 20px; padding-bottom: 20px; width:500px; height:400px;" align="center">
	<h2 style="margin-bottom: 10px;">추첨결과</h2>
		<div style="float: left; width:300px;">
			<img src="resources/images/takarakuzi.gif" style="width:250px;">
			<br/>
			<input type="button" class="btn" id="selected" name="selected" value="추첨" onclick="selected(${history.historynum})">
		</div>
		
		<div style="float: left; width:200px;">
			<table style="text-align: center; padding-top: 10px;">
				<tr>
					<th class="result" colspan="2">당첨자</th>
				</tr>
				<tr id="winner">
				
				</tr>
			</table>
		</div>
	</div>
</div>
</div>
</body>
</html>