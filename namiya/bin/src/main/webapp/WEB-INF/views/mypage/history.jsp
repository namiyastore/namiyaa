<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>history</title>
<script>
	function detailView(historynum) {
		alert("상세보기");
		location.href="deal?historynum="+historynum;
	}
</script>
</head>
<body>
	<h2>구매이력</h2>
	<a href="myPage">뒤로가기</a>
	<table border="1">
		<tr>
			<th>거래번호</th>
			<th>거래종류</th>
			<th>물건이름</th>
			<th>거래시작날짜</th>
			<th>거래완료날짜</th>
			<th>판매자</th>
			<th>구매자</th>
			<th>거래상태</th>
			<th>상세보기</th>
		</tr>
		<c:if test="${not empty hlist }">
			<c:forEach var="hList" items="${hlist}" >
				<tr>
					<td>${hList.historynum}</td>
					<td>거래종류</td>
					<td>물건이름</td>
					<td>${hList.deal_start}</td>
					<td>${hList.deal_end}</td>
					<td>${hList.sellerid}</td>
					<td>${hList.buyerid}</td>
					<td>거래상태</td>
					<td><input type="button" value="상세" onclick="detailView(${hList.historynum})"></td>
				</tr>
			</c:forEach>
		</c:if>
		<c:if test="${empty hlist }">
			<tr>
				<th colspan="6">구매 내역이 없습니다.</th>
			</tr>
		</c:if>
	</table>
</body>
</html>