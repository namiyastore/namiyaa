﻿<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html>
<html> 
<head> 
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"> 
<link rel="stylesheet" href="resources/mypage/css/mypageCommon.css"> 
 
<title>Point</title>
<link href="https://fonts.googleapis.com/css?family=Nanum+Gothic" rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Raleway:600" rel="stylesheet"> 
<script src="resources/search/js/common/jquery-1.12.4.js"></script> 
<style>
	body {
		font-family: 'Raleway', 'Nanum Gothic';
	}
</style>
<script> 
$(function(){ 
	 
	// ajax로 총 포인트 가져오는 부분 
	$.ajax({ 
		method : 'post', 
		url : 'pointTotal', 
		success : function(resp){ 
			$('#pointTotal').html(resp); 
		} 
	}); 
	 
	$('.rightSide_MyInfoBoxDown_goToHome').on('click',function(){ 
		location.href = './';		 
	}); 
	 
	// 미니홈피 창 열기 0929추가
	$(".rightSide_MyInfoBoxDown_myStore").on("click",function(){
		// 메세지 전송
		// message -> 전할 내용
		// receive -> 받을상대 id
		
		var myurl = $('#myurl').val();
		window.open("myStore/" + myurl + "/home","mystoreWindow","width=1200, height=650");
	});
	
	 $('.rightSide_MyInfoBoxDown_profile').on('click',function(){ 
		location.href = 'editForm';		 
	});  
	 
	$('.rightSide_MyInfoBoxDown_logOut').on('click',function(){ 
		location.href = 'logout';		 
	}); 
	 
	$('.rightSide_MyInfoBoxDown_signOut').on('click',function(){ 
		location.href = 'signOut';		 
	}); 
	 
	/* 0915 탭들 hover효과 추가 */ 
	$('.leftSide_tabs_tab1').on('click',function(){ 
		location.href = 'favoriteList';		 
	}); 
	$('.leftSide_tabs_tab2').on('click',function(){ 
		location.href = 'interestList';		 
	}); 
	$('.leftSide_tabs_tab3').on('click',function(){ 
		location.href = 'historyList';		 
	}); 
	/* $('.leftSide_tabs_tab4').on('click',function(){ 
		location.href = 'keywordList';		 
	}); 1002 수정 */ 
	$('.leftSide_tabs_tab5').on('click',function(){ 
		location.href = 'mInBoxListAll';		 
	}); 
	/* $('.leftSide_tabs_tab6').on('click',function(){ 
		location.href = 'noticeList';		 
	});  */
	$('.leftSide_tabs_tab7').on('click',function(){ 
		location.href = 'pointRecord';		 
	}); 
	
});
// 라인 인증키 등록 
function noticeService() { 
	$.ajax({ 
		method : "post", 
		url : "LinenotifyIdCheck", 
		success : function(resp) { 
			if(resp == 1) { 
				alert('이미 등록되어 있습니다'); 
			} 
			else { 
				window.open("https://notify-bot.line.me/oauth/authorize?response_type=code&client_id=j1pv2YPVmD4wAI5oJhXxBp&redirect_uri=http://13.125.208.152:8081/namiya/linenotify&scope=notify&state=oi","MsgWindow", "width=1013,height=1188"); 
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
<input id="myurl" type="hidden" value="${myurl}" /> 
<input id="lang" type="hidden" value="<spring:message code="common.lang" />" />
	<img alt="" src="resources/images/pagetop.gif" id="logo">
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
				</div>  1002 수정 --%>
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
			<!-- 검색창과 라인인증 버튼 -->
			<div class="leftSide_2nd">
				<div class="leftSide_2nd_searchBar"> 
					<!-- <input type="text" id="inputBar" class="inputBar">  -->
					<a href="검색 컨트롤러"><!-- <img src="resources/mypage/images/searchIcon.png" class="searchIcon"> --></a>
				</div>
				<div class="leftSide_2nd_noticeService"> 
					<!-- <img id="noticeService" src="resources/linenotify/linenotify.png" onclick="javascript:noticeService()" /> --> 
				</div>
			</div>	 
			 
 			<!-- 여기부터 받은쪽지함/보낸쪽지함 탭 --> 
			<!-- <div class="leftSide_searchBar_inoutMsgBoxTabs"> 
				<div class="leftSide_searchBar_inoutMsgBoxTabs_in"><a href="mInBoxListAll">Inbox message</a></div> 
				<div class="leftSide_searchBar_inoutMsgBoxTabs_out"><a href="mOutBoxListAll">Outbox message</a></div> 
			</div> --> 
			 
			<!-- 라인 인증키 얻는 링크 --> 
<!-- 			<input id="noticeService" type="button" value="Line 알림 서비스 등록" onclick="noticeService()" /> --> 
 			<!-- 여기부터 테이블 --> 
			<div class="leftSide_table"> 
				<table id="customers"> 
					<thead> 
						<tr> 
							<th><spring:message code="point.point" /></th> 
							<th><spring:message code="point.service" /></th> 
							<th><spring:message code="point.date" /></th> 
						</tr> 
					</thead> 
					<c:if test="${empty pointRecord }"> 
						<tr> 
							<td colspan="3"><spring:message code="point.empty" /></td> 
						</tr> 
					</c:if> 
					<c:if test="${not empty pointRecord }"> 
						<tbody> 
							<c:forEach var="PointList" items="${pointRecord}"> 
								<tr class="leftSide_table_rows"> 
								<!--포인트 추가시 수정부분 --> 
								<c:if test="${PointList.point gt 0}"> 
									<td class="table_1st_td">+${PointList.point}</td> 
								</c:if> 
								 <c:if test="${PointList.point lt 0}"> 
									<td class="table_1st_td">${PointList.point}</td> 
								</c:if>
									<td class="table_2nd_td">${PointList.type}</td> 
									<td class="table_3rd_td">${PointList.regdate}</td> 
								</tr> 
							</c:forEach> 
						</tbody>
					</c:if> 
						<tfoot> 
							<tr style="color: white; background-color: #0B3B0B;"> 
								<td colspan="3"> 
										<spring:message code="point.currrentPoint" /> : <span id="pointTotal" ></span> 
								</td> 
							</tr> 
						</tfoot> 
						<!-- </div> --><!-- customer_tfoot div닫음 --> 
					</table> 
				 
			</div><!-- 테이블의 div 닫음 --> 
		</div> <!-- left의 div 닫음 -->
		<!-- 개인정보 표시 부분 --> 
		<div class="rightSide"> 
			<div class="rightSide_MyInfoBox"> 
				<div class="rightSide_MyInfoBoxUp"> 
					<div class="rightSide_MyInfoBoxUp_profileImg"> 
						<img src="resources/images/parkby.jpg" id="rightSide_MyInfoBoxUp_profileImg_profile_pic"> 
					</div> 
					<div class="rightSide_MyInfoBoxUp_userId"> 
						${sessionScope.loginId} <!-- 세션id가 있으면 거기서 가지고 옮 9/5 <%-- ${"user.userid"} --%>  --> 
					</div> 
					<div class="rightSide_MyInfoBoxUp_userName"> 
						${sessionScope.loginName} <!-- 세션id로 해당 user를 찾아내서 입력할 예정 9/5 <%-- ${"user.username"} --%> --> 
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
			</div><!-- rightSide_MyInfoBox div 닫음 -->
		</div><!-- rightSide div 닫음 -->
	</div>
</body>
</html>