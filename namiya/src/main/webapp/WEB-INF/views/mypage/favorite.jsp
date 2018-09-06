<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>favorite</title>
<script type="text/javascript">
function fdelete(num) {
	location.href="fDelete?favoritenum="+num;
}

function fupdate(num){
	location.href="fSelectOne?favoritenum="+num;
}
</script>
</head>
<body>
	<h2>즐겨찾기</h2>
	<div id="wrapper">
		<a href="myPage">뒤로가기</a>
		<table border="1">
			<tr>
				<th>No.</th>
				<th>즐겨찾기URL</th>
				<th colspan="2">삭제</th>
			</tr>
			<c:if test="${not empty flist }">
				<c:forEach var="fList" items="${flist }">
					<tr>
						<th>${fList.favoritenum}</th>
						<td><a href="${fList.myurl}">${fList.myurl }</a></td>
						<td><input type="button" value="삭제"	onclick="fdelete(${fList.favoritenum})" /></td>
						<td><input type="button" value="수정"	onclick="fupdate(${fList.favoritenum})" /></td>
					</tr>
				</c:forEach>
			</c:if>
		</table>
		<form action="fInsert" method="post">
			myurl입력
			<input type="text" name="myurl" />
			<br /> userid입력
			<input type="text" name="userid" />
			<input type="submit" value="즐겨찾기입력">
		</form>
		<br />
		<hr />
		<h3>즐겨찾기 수정</h3>
		<form action="fUpdate" method="post">
			<input type="hidden" name="favoritenum"	value="${selectedfavorite.favoritenum}" />
			myurl입력
			<input type="text" name="myurl" value="${selectedfavorite.myurl}" />
			<br /> userid입력
			<input type="text" name="userid" value="${selectedfavorite.userid}" />
			<input type="submit" value="수정완료">
		</form>
		<div class="boardfooter">
			<a href="listboard?currentPage=${navi.currentPage - navi.pagePerGroup}&searchItem=${searchItem}&searchWord=${searchWord}">◁◁</a>
			<a href="listboard?currentPage=${navi.currentPage - 1}&searchItem=${searchItem}&searchWord=${searchWord}">◀</a>

			<c:forEach var="page" begin="${navi.startPageGroup }"
				end="${navi.endPageGroup }">
				<c:if test="${page == currentPage }">
					<span style="color: red; font-weight: bolder;">${page} &nbsp</span>
				</c:if>

				<c:if test="${page != currentPage }">
					<a href="listboard?currentPage=${page}&searchItem=${searchItem}&searchWord=${searchWord}">${page}&nbsp</a>
				</c:if>
			</c:forEach>
			<a href="listboard?currentPage=${navi.currentPage + 1}&searchItem=${searchItem}&searchWord=${searchWord}">▶</a>
			<a href="listboard?currentPage=${navi.currentPage + navi.pagePerGroup}&searchItem=${searchItem}&searchWord=${searchWord}">▷▷</a>
		</div>
	</div>
</body>
</html>