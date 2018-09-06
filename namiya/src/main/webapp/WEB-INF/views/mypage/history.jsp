<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>hitory</title>
<script type="text/javascript">
function hdelete(num) {
	location.href="hDelete?historynum="+num;
}

function hupdate(num){
	location.href="hSelectOne?historynum="+num;
}
</script>
</head>
<body>
	<h2>구매이력</h2>
	<a href="myPage">뒤로가기</a>
	<table border="1">
		<tr>
			<th>No.</th>
			<th>해당 거래 게시글</th>
			<th>판매자</th>
			<th>거래일자</th>
			<th colspan="2">삭제 및 수정</th>
		</tr>
		<c:if test="${not empty hlist }">
			<c:forEach var="hList" items="${hlist }">
				<tr>
					<th>${hList.historynum}</th>
					<td><a href="${hList.boardnum}">${hList.boardnum}</a></td>
					<td><a href="${hList.sellerid}">${hList.sellerid}</a></td>
					<td><a href="${hList.regdate}">${hList.regdate}</a></td>
					<td><input type="button" value="삭제" onclick = "hdelete(${hList.historynum})"/></td>
					<td><input type="button" value="수정" onclick = "hupdate(${hList.historynum})"/></td>
				</tr>
			</c:forEach>
		</c:if>
	</table>
	<form action="hInsert" method="post">
		게시글 입력
		<input type="text" name="boardnum" /><br/>
		sellerId입력
		<input type="text" name="sellerid" />
		<br /> 
		userid입력
		<input type="text" name="buyerid" />
		<input type="submit" value="구매이력입력완료">
	</form>
	<br />
	<hr />
	<h3>구매이력 수정</h3>
	<form action="hUpdate" method="post">
		<input type="hidden" name="historynum" value="${selectedhistory.historynum}"/>
		게시글입력
		<input type="text" name="boardnum" value="${selectedhistory.boardnum}"/>
		<br />
		판매자 입력
		<input type="text" name="sellerid" value="${selectedhistory.sellerid}"/>
		<br /> userid입력
		<input type="text" name="buyerid" value="${selectedhistory.buyerid}"/>
		<input type="submit" value="수정완료">
	</form>
</body>
</html>