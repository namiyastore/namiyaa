<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>history</title>
<link href="https://fonts.googleapis.com/css?family=Nanum+Gothic" rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Raleway:600" rel="stylesheet">
<script src="resources/search/js/common/jquery-1.12.4.js"></script>
<link rel="stylesheet" href="resources/mypage/css/mypage_history.css">
<script>
	function detailView(historynum) {
		location.href = "deal?historynum=" + historynum;
	}
	$(function() {

		$('.rightSide_MyInfoBoxDown_goToHome').on('click', function() {
			location.href = 'search';
		});

		// 미니홈피 창 열기 0929추가
		$(".rightSide_MyInfoBoxDown_myStore").on("click",function(){
			// 메세지 전송
			// message -> 전할 내용
			// receive -> 받을상대 id
			
			var myurl = $('#myurl').val();
			window.open("myStore/" + myurl + "/home","mystoreWindow","width=1200, height=650");
		});
		
		/* 0926 페이징 이미지버튼 클릭 */
		$('#btn1').on('click',function(){ 
			location.href = 'mInBoxListAll?currentPage=${navi.currentPage - navi.pagePerGroup}&searchWord=${searchWord}';		 
		});
		$('#btn2').on('click',function(){ 
			location.href = 'mInBoxListAll?currentPage=${navi.currentPage - 1}&searchWord=${searchWord}';		 
		});
		$('#btn3').on('click',function(){ 
			location.href = 'mInBoxListAll?currentPage=${navi.currentPage + 1}&searchWord=${searchWord}';		 
		});
		$('#btn4').on('click',function(){ 
			location.href = 'mInBoxListAll?currentPage=${navi.currentPage + navi.pagePerGroup}&searchWord=${searchWord}';		 
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
		
		/* $('.leftSide_tabs_tab4').on('click', function() {
			location.href = 'keywordList';
		}); 1002 수정 */
		
		$('.leftSide_tabs_tab5').on('click', function() {
			location.href = 'mInBoxListAll';
		});
		/* $('.leftSide_tabs_tab6').on('click', function() {
			location.href = 'noticeList';
		}); */
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
										window.open("https://notify-bot.line.me/oauth/authorize?response_type=code&client_id=j1pv2YPVmD4wAI5oJhXxBp&redirect_uri=http://13.125.208.152:8081/namiya/linenotify&scope=notify&state=oi",
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
<style>
	body {
		font-family: 'Raleway', 'Nanum Gothic';
	}
</style>
</head>
<body>
<img alt="" src="resources/images/pagetop.gif" id="logo">	
<input id="lang" type="hidden" value="<spring:message code="common.lang" />" />
	<div class="wrapper">
		<div class="leftSide">
			<div class="tabs"> 
				<div class="leftSide_tabs_tab2"> 
					 <spring:message code="mypage.leftSide_tabs_tab2" />
				</div> 
				<div class="leftSide_tabs_tab3"> 
					<spring:message code="mypage.leftSide_tabs_tab3" /> 
				</div> 
				
				<%-- <div class="leftSide_tabs_tab4"> 
					<spring:message code="mypage.leftSide_tabs_tab4" /> 
				</div>  1002수정 --%>
				
				<div class="leftSide_tabs_tab5"> 
					<spring:message code="mypage.leftSide_tabs_tab5" /> 
				</div> 
				<%-- <div class="leftSide_tabs_tab6"> 
					<spring:message code="mypage.leftSide_tabs_tab6" /> 
				</div>  --%>
				<div class="leftSide_tabs_tab7"> 
					<spring:message code="mypage.leftSide_tabs_tab7" /> 
				</div> 
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
			<div class="leftSide_table" style="overflow-x:hidden; overflow-y:auto;">
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
								<td>
									<c:if test="${plist[status.index].sstatus eq '진행완료'}">
										${hList.deal_end}
									</c:if>
								</td>
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
							<td colspan="9">구매 내역이 없습니다.</td>
						</tr>
					</c:if>
				</table>
			</div><!-- 테이블의 div 닫음 -->
			<!-- 페이징 처리 부분 -->
			<div class="leftSide_page">
				<img id="btn1" src="resources/images/arrow7.png" width="24px" height="24px">
				<img id="btn2" src="resources/images/arrow8.png" width="24px" height="24px">
				<c:forEach var="page" begin="${navi.startPageGroup }" end="${navi.endPageGroup }">
					<c:if test="${page == currentPage }">
						<span id="selectedPage">${page} &nbsp</span>
					</c:if>
					<c:if test="${page != currentPage }">
						<a style="text-decoration:none; color: white; font-size: 15pt;" href="mInBoxListAll?currentPage=${page}&searchWord=${searchWord}">${page} &nbsp</a>
					</c:if>
				</c:forEach>
				<img id="btn3" src="resources/images/arrow9.png" width="24px" height="24px">
				<img id="btn4" src="resources/images/arrow10.png" width="24px" height="24px">
			</div>
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
					<div class="rightSide_MyInfoBoxDown_goToHome"> 
						<spring:message code="mypage.rightSide_MyInfoBoxDown_goToHome" /> 
					</div><!-- rightSide_MyInfoBoxDown_goToHome의 div닫힘 -->
					<div class="rightSide_MyInfoBoxDown_myStore">
						<spring:message code="mypage.rightSide_MyInfoBoxDown_myStore" /> 
					</div><!-- rightSide_MyInfoBoxDown_myStore의 div닫힘 -->
					<div class="rightSide_MyInfoBoxDown_profile">
						<spring:message code="mypage.rightSide_MyInfoBoxDown_profile" />
					</div><!-- rightSide_MyInfoBoxDown_profile의 div닫힘 0916추가 -->
					<div class="rightSide_MyInfoBoxDown_logOut">
						<spring:message code="mypage.rightSide_MyInfoBoxDown_logOut" />
					</div><!-- rightSide_MyInfoBoxDown_logOut의 div닫힘 -->
					<div class="rightSide_MyInfoBoxDown_signOut">
						<spring:message code="mypage.rightSide_MyInfoBoxDown_signOut" />
					</div><!-- rightSide_MyInfoBoxDown_signOut의 div닫힘 -->
				</div><!-- rightSide_MyInfoBoxDown div닫힘 -->
			</div>
			<!-- rightSide_MyInfoBox div 닫음 -->
		</div>
		<!-- rightSide div 닫음 -->
	</div>
	<!-- <form action="reqProfile" method="post" id="goProfile"></form> -->
</body>
</html>