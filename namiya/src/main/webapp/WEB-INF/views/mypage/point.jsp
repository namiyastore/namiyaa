<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<style type="text/css">
body {
	background-image: url("resources/images/NaviBackGround.png");
	background-size: 80%;
	font-family: 'EcoSansMono', 'JejuGothic';
}

.wrapper {
	width: 100%;
	height: 650px;
	/* margin: 0 auto; */
	border: 1px solid black;
	display: flex;
	justify-content: space-between;
	align-items: center;
}

.leftSide{

	display: flex;
	flex-direction: column;
	align-items: center;
}

.wrapper .tabs {
	width: 95%;
	height: 10%;
	display: flex;
	justify-content: flex-start;
	align-items: center;
	border: 1px green solid;
}

.wrapper .leftSide {
	width: 80%;
	height: 90%;
	border: 1px blue solid;
	
}

.wrapper .rightSide {
	width: 20%;
	height: 90%;
	border: 1px blue solid;
	
}

.leftSide .tabs {
	width: 90%;
	height: 10%;
	border: 1px solid yellow;
}

.tabs>div {
	width: 15%;
	height: 80%;
	border: 1px solid rgb(50, 50, 50);
	background-color: white;
	border-top-left-radius: 10px;
	border-top-right-radius: 10px;
	border: 1px solid rgb(50, 50, 50);
}

.leftSide_tabs_tab1 {
	display: flex;
	justify-content: center;
	align-items: center;
}

.leftSide_tabs_tab2 {
	display: flex;
	justify-content: center;
	align-items: center;
}

.leftSide_tabs_tab3 {
	display: flex;
	justify-content: center;
	align-items: center;
}

.leftSide_tabs_tab4 {
	display: flex;
	justify-content: center;
	align-items: center;
}

.leftSide_tabs_tab5 {
	display: flex;
	justify-content: center;
	align-items: center;
}

.leftSide_tabs_tab6 {
	display: flex;
	justify-content: center;
	align-items: center;
}

.leftSide_tabs_tab7 {
	display: flex;
	justify-content: center;
	align-items: center;
}

.leftSide .searchIcon {
	width: auto;
	height: auto;
}

.leftSide .leftSide_searchBar {
	display: flex;
	width:90%;
	height:5%;
	border: solid 1px white;
}

.leftSide_searchBar #inputBar {
	display: flex;
	width: 25%;
	height: 90%;
	
}

/* 받은쪽지함 보낸쪽지함 탭 */

.leftSide .leftSide_searchBar_inoutMsgBoxTabs{
	display: flex;
	width:90%;
	height:5%;
	border: solid 1px white;
}

.leftSide_searchBar_inoutMsgBoxTabs{
	display:flex;
	border: 1px white solid;
	justify-content: flex-start;
}

.leftSide_searchBar_inoutMsgBoxTabs > div{
	display:flex;
	width: 15%;
	background-color: white;
	border-top-left-radius: 10px;
	border-top-right-radius: 10px;
	border: 1px black solid;
	align-items: center;
	justify-content: center;
}

.leftSide .leftSide_table {
	display: flex;
	width: 90%;
	height: 80%;
}

@font-face {
	font-family: 'EcoSansMono';
	src: url("resources/fonts/EcoSansMono.ttf") format('truetype');
}

@font-face {
	font-family: 'JejuGothic';
	src: url("resources/fonts/JejuGothic.ttf") format('truetype');
}

#customers {
	font-family: "Trebuchet MS", Arial, Helvetica, sans-serif;
	border-collapse: collapse;
	width: 100%;
}

#customers td, #customers th {
	border: 1px solid #ddd;
	padding: 8px;
}

#customers tr:nth-child(even) {
	background-color: #f2f2f2;
}

#customers tr:hover {
	background-color: #ddd;
}

#customers th {
	padding-top: 12px;
	padding-bottom: 12px;
	text-align: left;
	background-color: #4CAF50;
	color: white;
}

.rightSide .rightSide_MyInfoBox {
	display: flex;
	flex-direction:column;
	width: 100%;
	height: 90%;
	background-color: #BDBDBD;
}

.rightSide_MyInfoBox .rightSide_MyInfoBoxUp {
	display: flex;
	width: 100%;
	height: 30%;
	background-color: yellow;
	flex-direction: column;
/* 	justify-content: space-between;
 */
 }

#rightSide_MyInfoBoxUp_profileImg_profile_pic {
	width: 40%;
	height: 100%;
}

.rightSide_MyInfoBoxUp .rightSide_MyInfoBoxUp_profileImg {
	height: 45%;
	border: 1px black solid;
	text-align: center;
}

.rightSide_MyInfoBoxUp .rightSide_MyInfoBoxUp_userId {
	height: 25%;
	border: 1px black solid;
	text-align: center;
}

.rightSide_MyInfoBoxUp .rightSide_MyInfoBoxUp_userName {
	height: 25%;
	border: 1px black solid;
	text-align: center;	
}

.rightSide_MyInfoBoxUp .rightSide_MyInfoBoxUp_profileImg{
	display: flex;
	justify-content: center;
	align-items: center;
}

.rightSide_MyInfoBox .rightSide_MyInfoBoxMidle{
	display: flex;
	flex-direction:column;
	height: 30%;
	width: 100%;
}

.rightSide_MyInfoBoxMidle .rightSide_MyInfoBoxMidle_mobile{
	display: flex;
	height: 50%;
	border: 1px blue solid;
}

.rightSide_MyInfoBoxMidle_mobile .rightSide_MyInfoBoxMidle_mobile_leftSide{
	display: flex;
	border: 1px black solid;
	width: 19%;
	height: 99%;
}

.rightSide_MyInfoBoxMidle_mobile .rightSide_MyInfoBoxMidle_mobile_rightSide{
	display:flex;
	border: 1px black solid;
	width: 80%;
}

.rightSide_MyInfoBoxMidle_mobile_leftSide{
	display: flex;
	justify-content: center;
	align-items: center;
}

/* 이메일 */
.rightSide_MyInfoBoxMidle .rightSide_MyInfoBoxMidle_email{
	display: flex;
	height: 50%;
	border: 1px blue solid;
}

.rightSide_MyInfoBoxMidle_email .rightSide_MyInfoBoxMidle_email_leftSide{
	display: flex;
	border: 1px black solid;
	width: 20%;
	height: 100%;
}

.rightSide_MyInfoBoxMidle_email_leftSide{
	display: flex;
	justify-content: center;
	align-items: center;
}

.rightSide_MyInfoBoxMidle_email .rightSide_MyInfoBoxMidle_email_rightSide{
	display:flex;
	border: 1px black solid;
	width: 80%;
}


.rightSide_MyInfoBoxDown{
	display: flex;
	border: 1px solid pink;
	flex-direction: column;
	height: 40%;
	width: 100%;
	justify-content: space-between;
	align-items: center;
	
}

.rightSide_MyInfoBoxDown > div{
	display:flex;
	justify-content:center;
	align-items:center;
	height: 20%;
	width: 80%;
	border: 1px solid black;
	background-color: white;
}
</style>
<title>Point</title>
</head>
<body>
	<h2 style="color: white; text-align: center; ">Point</h2>
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
					<a href="mInBoxListAll" class="liftSide_tabs_tab5_a5">Message</a>
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
				<a href="검색 컨트롤러"><img src="resources/images/searchTool.png" class="searchIcon"></a>
			</div>
			
 			<!-- 여기부터 받은쪽지함/보낸쪽지함 탭 -->
			<!-- <div class="leftSide_searchBar_inoutMsgBoxTabs">
				<div class="leftSide_searchBar_inoutMsgBoxTabs_in"><a href="mInBoxListAll">Inbox message</a></div>
				<div class="leftSide_searchBar_inoutMsgBoxTabs_out"><a href="mOutBoxListAll">Outbox message</a></div>
			</div> -->
			
 			<!-- 여기부터 테이블 -->
			<div class="leftSide_table">
				<table id="customers">
					<tr>
						<th>No.</th>
						<th>Title</th>
						<th>Sender</th>
						<th>Date</th>
					</tr>
					<c:if test="${empty InboxList }">
						<tr>
							<td colspan="4">
								<p>받은 쪽지가 없습니다</p>
							</td>
						</tr>
					</c:if>
					<c:if test="${not empty InboxList }">
						<c:forEach var="PointList" items="${PointList}">
							<tr class="leftSide_table_rows">
								<!--포인트 추가시 수정부분 -->
								<td><a href="selectOnePoint?pointnum=${PointList.messagenum}">${InboxList.title }</a>></td>
								<td>${pointList.userid }</td>
								<td>${pointList.date }</td>
							</tr>
						</c:forEach>
					</c:if>
				</table>
			</div><!-- 테이블의 div 닫음 -->
		</div>
		<!-- 개인정보 표시 부분 -->
		<div class="rightSide">
			<div class="rightSide_MyInfoBox">
				<div class="rightSide_MyInfoBoxUp">
					<div class="rightSide_MyInfoBoxUp_profileImg">
						<img src="resources/images/parkby.jpg" id="rightSide_MyInfoBoxUp_profileImg_profile_pic">
					</div>
					<div class="rightSide_MyInfoBoxUp_userId">
						<p>유저 아이디</p><!-- 세션id가 있으면 거기서 가지고 옮 9/5 <%-- ${"user.userid"} --%>  -->
					</div>
					<div class="rightSide_MyInfoBoxUp_userName">
						<p>유저 이름</p><!-- 세션id로 해당 user를 찾아내서 입력할 예정 9/5 <%-- ${"user.username"} --%> -->
					</div>
				</div>
				<div class="rightSide_MyInfoBoxMidle">
					<div class="rightSide_MyInfoBoxMidle_mobile">
						<div class="rightSide_MyInfoBoxMidle_mobile_leftSide">
							<img src="resources/images/telephone.png">
						</div>
						<div class="rightSide_MyInfoBoxMidle_mobile_rightSide">
							<p>MOBILE<br/>
							010-0000-0000</p><!-- 세션id로 해당 user의 전화번호 받아오기 현재는 임의로 넣어준것임 9/5 <%-- ${"user.userphonenum" } --%> -->
						</div>
					</div>
					<div class="rightSide_MyInfoBoxMidle_email">		
						<div class="rightSide_MyInfoBoxMidle_email_leftSide">
							<img src="resources/images/email.png">
						</div>
						<div class="rightSide_MyInfoBoxMidle_email_rightSide">
							<p>EMAIL<br/>
							유저 이메일주소</p><!-- 세션id로 해당 user의 이메일주소 받아오기 현재는 임의로 넣어준것임 9/5 <%-- ${"user.userEmailaddress" } --%> -->
						</div>
					</div>
				</div>
				<div class="rightSide_MyInfoBoxDown">
					<div class="rightSide_MyInfoBoxDown_goToHome">
						<a href="./">Go To Home</a>
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
				</div><!-- rightSide_MyInfoBoxDown div닫힘 -->
			</div><!-- rightSide_MyInfoBox div 닫음 -->
		</div><!-- rightSide div 닫음 -->
	</div>
</body>
</html>