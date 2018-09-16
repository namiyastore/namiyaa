<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="resources/mypage/css/mypageCommon.css">
<title>Interest</title>
<script type="text/javascript">
function idelete(num) {
	location.href="iDelete?interestnum="+num;
}

function iupdate(num){
	location.href="iSelectOne?interestnum="+num;
}
</script>
</head>
<body>
	<h2>관심상품</h2>
	<a href="myPage">뒤로가기</a>
	<table border="1">
		<tr>
			<th>No.</th>
			<th>관심상품의 게시글</th>
			<th colspan="2">삭제</th>
		</tr>
		<c:if test="${not empty ilist }">
			<c:forEach var="iList" items="${ilist }">
				<tr>
					<th>${iList.interestnum}</th>
					<td><a href="${iList.boardnum}">${iList.boardnum}</a></td>
					<td><input type="button" value="삭제"
							onclick="idelete(${iList.interestnum})" /></td>
					<td><input type="button" value="수정"
							onclick="iupdate(${iList.interestnum})" /></td>
				</tr>
			</c:forEach>
		</c:if>
	</table>
	<form action="iInsert" method="post">
		관심게시글 번호입력
		<input type="text" name="boardnum" />
		<br /> userid입력
		<input type="text" name="userid" />
		<input type="submit" value="관심상품 입력완료">
	</form>
	<br />
	<hr />
	<h3>즐겨찾기 수정</h3>
	<form action="iUpdate" method="post">
		<input type="hidden" name="interestnum" value="${selectedInterest.interestnum}"/>
		userid입력
		<input type="text" name="userid" value="${selectedInterest.userid}" /><br /> 
		관심상품의 게시글번호 입력
		<input type="text" name="boardnum" value="${selectedInterest.boardnum}" />
		<input type="submit" value="수정완료">
	</form>
</body>
</html>