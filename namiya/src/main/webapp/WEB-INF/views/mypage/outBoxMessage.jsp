<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="resources/mypage/css/mypage_message.css">
<script src="resources/search/js/common/jquery-1.12.4.js"></script>
<script> 
$(function(){ 
	 
	$('.rightSide_MyInfoBoxDown_goToHome').on('click',function(){ 
		location.href = 'search';
	}); 
	 
	$('.rightSide_MyInfoBoxDown_myStore').on('click',function(){ 
		location.href = 'myStore';
	});
	
	 $('.rightSide_MyInfoBoxDown_profile').on('click',function(){ 
		location.href = 'editForm'; 
	});  
	 
	$('.rightSide_MyInfoBoxDown_logOut').on('click',function(){ 
		location.href = 'logOut';
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
	$('.leftSide_tabs_tab4').on('click',function(){ 
		location.href = 'keywordList';		 
	}); 
	$('.leftSide_tabs_tab5').on('click',function(){ 
		location.href = 'mInBoxListAll';		 
	}); 
	$('.leftSide_tabs_tab6').on('click',function(){ 
		location.href = 'noticeList';		 
	}); 
	$('.leftSide_tabs_tab7').on('click',function(){ 
		location.href = 'pointRecord';		 
	});
	
	/* 0918 받은 쪽지함 보낸 쪽지함 탭 효과 */
	$('.leftSide_searchBar_inoutMsgBoxTabs_in').on('click',function(){ 
		location.href = 'mInBoxListAll';		 
	});
	$('.leftSide_searchBar_inoutMsgBoxTabs_out').on('click',function(){ 
		location.href = 'mOutBoxListAll';		 
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
				window.open("https://notify-bot.line.me/oauth/authorize?response_type=code&client_id=j1pv2YPVmD4wAI5oJhXxBp&redirect_uri=http://localhost:8081/namiya/linenotify&scope=notify&state=oi","MsgWindow", "width=1013,height=1188"); 
			} 
		} 
	});	 
	 
} 
 
// 인증키가 등록되었다는 메세지 출력 
function alertMsg() { 
	alert("등록되었습니다."); 
} 
</script> 
<title>Inbox message</title>
</head>
 <body>
<!-- 	<div class="wrapper">
		<div class="leftSide">
			<div class="leftSide_searchBar">
				<input type="text" id="inputBar" class="inputBar">
				<a href="검색 컨트롤러"><img src="images/if_misc-_Search__1276849.svg" class="searchIcon"></a>
			</div>
		</div>
	</div> 
 -->
 	<img alt="" src="resources/images/pagetop.gif" id="logo">	
 	<div class="wrapper"> 
		<div class="leftSide"> 
			<div class="tabs"> 
				<div class="leftSide_tabs_tab2"> 
					Interest 
				</div> 
				<div class="leftSide_tabs_tab3"> 
					History 
				</div> 
				<div class="leftSide_tabs_tab4"> 
					Keyword 
				</div> 
				<div class="leftSide_tabs_tab5"> 
					Message 
				</div> 
				<div class="leftSide_tabs_tab6"> 
					Notice 
				</div> 
				<div class="leftSide_tabs_tab7"> 
					Point 
				</div> 
			</div>
			<div class="leftSide_2nd">
				<div class="leftSide_2nd_searchBar"> 
					<input type="text" id="inputBar" class="inputBar"> 
					<a href="검색 컨트롤러"><img src="resources/mypage/images/searchIcon.png" class="searchIcon"></a>
				</div>
				<!--<div class="leftSide_2nd_noticeService"> 
					<img id="noticeService" src="resources/linenotify/linenotify.png" onclick="javascript:noticeService()" /> 
				</div> -->
						 
 			<!-- 여기부터 받은쪽지함/보낸쪽지함 탭 --> 
			 	<div class="leftSide_searchBar_inoutMsgBoxTabs"> 
					<div class="leftSide_searchBar_inoutMsgBoxTabs_in">Inbox message</div> 
					<div class="leftSide_searchBar_inoutMsgBoxTabs_out">Outbox message</div> 
				</div>
			</div>
			<!-- 라인 인증키 얻는 링크 --> 
<!-- 			<input id="noticeService" type="button" value="Line 알림 서비스 등록" onclick="noticeService()" /> --> 
			 
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
								<p>보낸 쪽지가 없습니다</p>
							</td>
						</tr>
					</c:if>
					<c:if test="${not empty message }">
						<c:forEach var="messageList" items="${OutboxList}"> <!-- 수정부분 -->
							<tr class="leftSide_table_rows">
								<td><a href="selectOneMessage?messagenum=${messageList.messagenum}">${messageList.title }</a>></td>
								<td>${messageList.userid }</td>
								<td>${messageList.date }</td>
							</tr>
						</c:forEach>
					</c:if>
				</table>
			</div><!-- 테이블의 div -->
		</div> 
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
						Go To Home 
					</div><!-- rightSide_MyInfoBoxDown_goToHome의 div닫힘 -->
					<div class="rightSide_MyInfoBoxDown_myStore">
						My Store
					</div><!-- rightSide_MyInfoBoxDown_myStore의 div닫힘 -->
					<div class="rightSide_MyInfoBoxDown_profile">
						Edit <!-- <span onclick="goProfile()"></span> -->
					</div><!-- rightSide_MyInfoBoxDown_profile의 div닫힘 0916추가 -->
					<div class="rightSide_MyInfoBoxDown_logOut">
						Logout
					</div><!-- rightSide_MyInfoBoxDown_logOut의 div닫힘 -->
					<div class="rightSide_MyInfoBoxDown_signOut">
						SignOut
					</div><!-- rightSide_MyInfoBoxDown_signOut의 div닫힘 -->
				</div><!-- rightSide_MyInfoBoxDown div닫힘 -->
			</div><!-- rightSide_MyInfoBox div 닫음 -->
		</div><!-- rightSide div 닫음 -->
	</div>
	<!-- <form action="reqProfile" method="post" id="goProfile"></form> -->
</body>
</html>