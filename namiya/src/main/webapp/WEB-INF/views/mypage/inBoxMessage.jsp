<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="resources/mypage/css/mypageCommon.css">
<title>Inbox message</title>
</head>
<body>
	<div class="wrapper">
		<div class="leftSide">
			<div class="tabs">

				<div class="leftSide_tabs_tab1">
					<a href="favoriteList" class="liftSide_tabs_tab1_a1">Favorite</a>
				</div>
				<div class="leftSide_tabs_tab2">
					<a href="interestList" class="liftSide_tabs_tab2_a2">Interest</a>
				</div>
				<div class="leftSide_tabs_tab3">
					<a href="historyList" class="liftSide_tabs_tab3_a3">History</a>
				</div>
				<div class="leftSide_tabs_tab4">
					<a href="keywordList" class="liftSide_tabs_tab4_a4">Keyword</a>
				</div>
				<div class="leftSide_tabs_tab5">
					<a href="inboxMessageList" class="liftSide_tabs_tab5_a5">Message</a>
				</div>
				<div class="leftSide_tabs_tab6">
					<a href="noticeList" class="liftSide_tabs_tab6_a6" style="font: bold;">Notice</a>
				</div>
				<div class="leftSide_tabs_tab7">
					<a href="pointList" class="liftSide_tabs_tab7_a7">Point</a>
				</div>
			</div>
			<div class="leftSide_searchBar">
				<input type="text" id="inputBar" class="inputBar">
				<a href="검색 컨트롤러"><img src="images/if_misc-_Search__1276849.svg"
						class="searchIcon"></a>
			</div>
			<!-- 여기부터 테이블 -->
			<div class="leftSide_table">
				<table id="customers">
					<tr>
						<th>No.</th>
						<th>Title</th>
						<th>Sender</th>
						<th>Date</th>
					</tr>
					<c:if test="${empty message }">
						<tr>
							<td colspan="4">
								<p>받은 쪽지가 없습니다</p>
							</td>
						</tr>
					</c:if>
					<c:if test="${not empty message }">
						<c:forEach var="messageList" items="${InboxMList}">
							<tr class="leftSide_table_rows">
								<td><a href="selectOneMessage?messagenum=${messageList.messagenum}">${messageList.title }</a>></td>
								<td>${messageList.userid }</td>
								<td>${messageList.date }</td>
							</tr>
						</c:forEach>
					</c:if>
				</table>
			</div>
			<!-- 테이블의 div -->

		</div>
		<div class="rightSide">
			<div class="rightSide_MyInfoBox">
				<div class="rightSide_MyInfoBoxUp">
					<div class="rightSide_MyInfoBoxUp_profileImg">
						<img src="images/parkby.jpg"
							id="rightSide_MyInfoBoxUp_profileImg_profile_pic">
					</div><br/>
					<div class="rightSide_MyInfoBoxUp_userId">
						<p><%-- ${"user.userid"} --%> 유저 아이디</p><!-- 세션id가 있으면 거기서 가지고 옮 9/5 -->
					</div><br/>
					<div class="rightSide_MyInfoBoxUp_userName">
						<p><%-- ${"user.username"} --%>유저 이름</p><!-- 세션id로 해당 user를 찾아내서 입력할 예정 9/5 -->
					</div>
				</div>
				<div class="rightSide_MyInfoBoxMidle">
					<div class="rightSide_MyInfoBoxMidle_mobile">
						<img>
						<p><%-- ${"user.userphonenum" } --%>유저 전화번호</p><br/><!-- 세션id로 해당 user의 전화번호 받아오기 현재는 임의로 넣어준것임 9/5 -->
						<p><%-- ${"user.userEmailaddress" } --%> 유저 이메일주소</p><!-- 세션id로 해당 user의 이메일주소 받아오기 현재는 임의로 넣어준것임 9/5 -->
					</div>
					<div class="rightSide_MyInfoBoxMidle_email">
					</div>
				</div>
				<div class="rightSide_MyInfoBoxDown">
					<div class="rightSide_MyInfoBoxDown_goToHome">
						<a href="home">Go To Home</a>
					</div><!-- rightSide_MyInfoBoxDown_goToHome의 div닫힘 -->
					<div class="rightSide_MyInfoBoxDown_myStore">
						<a href="myStore">My Store</a>
					</div><!-- rightSide_MyInfoBoxDown_myStore의 div닫힘 -->
					<div class="rightSide_MyInfoBoxDown_logOut">
						<a href="logOut">Logout</a>
					</div><!-- rightSide_MyInfoBoxDown_logOut의 div닫힘 -->
					<div class="rightSide_MyInfoBoxDown_signOut">
						<a href="signOut">SignOut</a>
					</div><!-- rightSide_MyInfoBoxDown_signOut의 div닫힘 -->
				</div>
			</div>
		</div>

	</div>
</body>
</html>