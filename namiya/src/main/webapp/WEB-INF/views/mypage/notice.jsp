<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Notice</title>
<link rel="stylesheet" href="resources/mypage/css/mypageCommon.css">
<script type="text/javascript">
function ndelete(num) {
	location.href="nDelete?noticenum="+num;
}

function nupdate(num){
	location.href="nSelectOne?noticenum="+num;
}
</script>
</head>
<body>
	<h2>알림</h2>
	<a href="myPage">뒤로가기</a>
	<table border="1">
		<tr>
			<th>No.</th>
			<th>알림게시글</th>
			<th colspan="2">삭제</th>
		</tr>
		<c:if test="${not empty nlist }">
			<c:forEach var="nList" items="${nlist }">
				<tr>
					<th>${nList.noticenum}</th>
					<td><a href="${nList.boardnum}">${nList.boardnum }</a></td>
					<td><input type="button" value="삭제"
							onclick="ndelete(${nList.noticenum})" /></td>
					<td><input type="button" value="수정"
							onclick="nupdate(${nList.noticenum})" /></td>
				</tr>
			</c:forEach>
		</c:if>
	</table>
	<form action="nInsert" method="post">
		userid입력
		<input type="text" name="userid" />
		<br /> boardnum입력
		<input type="text" name="boardnum" />
		<input type="submit" value="입력완료">
	</form>
	<br />
	<hr />
	<h3>즐겨찾기 수정</h3>
	<form action="nUpdate" method="post">
		<input type="hidden" name="noticenum" value="${selectednotice.noticenum}"/>
		boardnum입력
		<input type="text" name="boardnum" value="${selectednotice.boardnum}" />
		<br /> userid입력
		<input type="text" name="userid" value="${selectednotice.userid}" />
		<input type="submit" value="수정완료">
	</form>
</body>
</html>