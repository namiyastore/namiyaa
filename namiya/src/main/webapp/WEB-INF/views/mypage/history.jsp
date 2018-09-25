<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>history</title>
<script src="resources/search/js/common/jquery-1.12.4.js"></script>
<link rel="stylesheet" href="resources/mypage/css/mypage_history.css">
<script>
	function detailView(historynum) {
		alert("상세보기");
		location.href = "deal?historynum=" + historynum;
	}
	$(function() {

		$('.rightSide_MyInfoBoxDown_goToHome').on('click', function() {
			location.href = './';
		});

		$('.rightSide_MyInfoBoxDown_myStore').on('click', function() {
			location.href = 'myStore';
		});

		$('.rightSide_MyInfoBoxDown_profile').on('click', function() {
			location.href = 'editForm';
		});

		$('.rightSide_MyInfoBoxDown_logOut').on('click', function() {
			location.href = 'logOut';
		});

		$('.rightSide_MyInfoBoxDown_signOut').on('click', function() {
			location.href = 'signOut';
		});

		/* 0915 탭들 hover효과 추가 */
		$('.leftSide_tabs_tab1').on('click', function() {
			location.href = 'favoriteList';
		});
		$('.leftSide_tabs_tab2').on('click', function() {
			location.href = 'interestList';
		});
		$('.leftSide_tabs_tab3').on('click', function() {
			location.href = 'historyList';
		});
		$('.leftSide_tabs_tab4').on('click', function() {
			location.href = 'keywordList';
		});
		$('.leftSide_tabs_tab5').on('click', function() {
			location.href = 'mInBoxListAll';
		});
		$('.leftSide_tabs_tab6').on('click', function() {
			location.href = 'noticeList';
		});
		$('.leftSide_tabs_tab7').on('click', function() {
			location.href = 'pointRecord';
		});

	});

	// 라인 인증키 등록 
	function noticeService() {
		$.ajax({
				method : "post",
				url : "LinenotifyIdCheck",
				success : function(resp) {
									if (resp == 1) {
										alert('이미 등록되어 있습니다');
									} else {
										window.open("https://notify-bot.line.me/oauth/authorize?response_type=code&client_id=j1pv2YPVmD4wAI5oJhXxBp&redirect_uri=http://localhost:8081/namiya/linenotify&scope=notify&state=oi",
										"MsgWindow","width=1013,height=1188");
										}
					}
				});
	}
	// 인증키가 등록되었다는 메세지 출력 
	function alertMsg() {
		alert("등록되었습니다.");
	}
</script>
</head>
<body>
<img alt="" src="resources/images/pagetop.gif" id="logo">	
	
	<div class="wrapper">
		<div class="leftSide">
			<div class="tabs">
				<div class="leftSide_tabs_tab2">Interest</div>
				<div class="leftSide_tabs_tab3">History</div>
				<div class="leftSide_tabs_tab4">Keyword</div>
				<div class="leftSide_tabs_tab5">Message</div>
				<div class="leftSide_tabs_tab6">Notice</div>
				<div class="leftSide_tabs_tab7">Point</div>
			</div>
			<div class="leftSide_2nd">
				<div class="leftSide_2nd_searchBar">
					<input type="text" id="inputBar" class="inputBar">
					<a href="검색 컨트롤러"><img src="resources/mypage/images/searchIcon.png" class="searchIcon"></a>
				</div>
				<div class="leftSide_2nd_noticeService">
					<img id="noticeService" src="resources/linenotify/linenotify.png" onclick="javascript:noticeService()" />
				</div>
			</div>
			<div class="leftSide_table">
				<table id="customers">
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
						<c:forEach var="hList" items="${hlist}" varStatus="status">
							<tr>
								<td>${hList.historynum}</td>
								<td>${blist[status.index].service}</td>
								<td>${plist[status.index].productname}</td>
								<td>${hList.deal_start}</td>
								<td>${hList.deal_end}</td>
								<td>${hList.sellerid}</td>
								<td>${hList.buyerid}</td>
								<td>${plist[status.index].sstatus}</td>
								<c:if test="${sessionScope.loginId eq hList.sellerid}">
								<td>
									<input type="button" value="상세" onclick="detailView(${hList.historynum})">
								</td>
								</c:if>
							</tr>
						</c:forEach>
					</c:if>
					<c:if test="${empty hlist }">
						<tr>
							<th colspan="6">구매 내역이 없습니다.</th>
						</tr>
					</c:if>
				</table>
			</div><!-- 테이블의 div 닫음 -->
		</div>
		<!-- 개인정보 표시 부분 -->
		<div class="rightSide">
			<div class="rightSide_MyInfoBox">
				<div class="rightSide_MyInfoBoxUp">
					<div class="rightSide_MyInfoBoxUp_profileImg">
						<img src="resources/images/parkby.jpg"	id="rightSide_MyInfoBoxUp_profileImg_profile_pic">
					</div>
					<div class="rightSide_MyInfoBoxUp_userId">
						${sessionScope.loginId}
						<!-- 세션id가 있으면 거기서 가지고 옮 9/5 <%-- ${"user.userid"} --%>  -->
					</div>
					<div class="rightSide_MyInfoBoxUp_userName">
						${sessionScope.loginName}
						<!-- 세션id로 해당 user를 찾아내서 입력할 예정 9/5 <%-- ${"user.username"} --%> -->
					</div>
				</div>

				<div class="rightSide_MyInfoBoxDown">
					<div class="rightSide_MyInfoBoxDown_goToHome">Go To Home</div>
					<!-- rightSide_MyInfoBoxDown_goToHome의 div닫힘 -->
					<div class="rightSide_MyInfoBoxDown_myStore">My Store</div>
					<!-- rightSide_MyInfoBoxDown_myStore의 div닫힘 -->
					<div class="rightSide_MyInfoBoxDown_profile">Edit</div>
					<!-- rightSide_MyInfoBoxDown_profile의 div닫힘 0916추가 -->
					<div class="rightSide_MyInfoBoxDown_logOut">Logout</div>
					<!-- rightSide_MyInfoBoxDown_logOut의 div닫힘 -->
					<div class="rightSide_MyInfoBoxDown_signOut">SignOut</div>
					<!-- rightSide_MyInfoBoxDown_signOut의 div닫힘 -->
				</div>
				<!-- rightSide_MyInfoBoxDown div닫힘 -->
			</div>
			<!-- rightSide_MyInfoBox div 닫음 -->
		</div>
		<!-- rightSide div 닫음 -->
	</div>
	<!-- <form action="reqProfile" method="post" id="goProfile"></form> -->
</body>
</html>