<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>keword</title>
<script type="text/javascript">
function kdelete(num) {
	location.href="kDelete?keywordnum="+num;
}

function kupdate(num){
	location.href="kSelectOne?keywordnum="+num;
}
</script>
</head>
<body>
	<h2>키워드</h2>
	<a href="myPage">뒤로가기</a>
	<table border="1">
		<tr>
			<th>No.</th>
			<th>키워드</th>
			<th colspan="2">삭제</th>
		</tr>
		<c:if test="${not empty klist }">
			<c:forEach var="kList" items="${klist }">
				<tr>
					<th>${kList.keywordnum}</th>
					<td><a href="${kList.keywordname}">${kList.keywordname}</a></td>
					<td><input type="button" value="삭제"	onclick="kdelete(${kList.keywordnum})" /></td>
					<td><input type="button" value="수정"	onclick="kupdate(${kList.keywordnum})" /></td>
				</tr>
			</c:forEach>
		</c:if>
	</table>
	<form action="kInsert" method="post">
		keyword입력
		<input type="text" name="keywordname" />
		<br /> 카테고리 입력
		<input type="text" name="category" />
		<br /> userid입력
		<input type="text" name="userid" />
		<input type="submit" value="키워드 입력완료">
	</form>
	<br />
	<hr />
	<h3>즐겨찾기 수정</h3>
	<form action="kUpdate" method="post">
		<input type="hidden" name="keywordnum" value="${selectedkeyword.keywordnum}" />
		keyword입력
		<input type="text" name="keywordname"
			value="${selectedkeyword.keywordname}" />
		<br /> 카테고리 입력
		<input type="text" name="category" value="${selectedkeyword.category}" />
		<br /> 아이디 입력
		<input type="text" name="userid" value="${selectedkeyword.userid}" />
		<input type="submit" value="수정완료">
	</form>

</body>
</html>