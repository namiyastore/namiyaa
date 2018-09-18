<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="resources/mypage/css/mypageCommon.css">
<title>keword</title>
<script src="resources/search/js/common/jquery-1.12.4.js"></script>
<script type="text/javascript">
function kdelete(num) {
	location.href="kDelete?keywordnum="+num;
}

function kupdate(num){
	location.href="kSelectOne?keywordnum="+num;
}
</script>
<script> 
$(function(){ 
	 
	$('.rightSide_MyInfoBoxDown_goToHome').on('click',function(){ 
		location.href = './';		 
	}); 
	 
	$('.rightSide_MyInfoBoxDown_myStore').on('click',function(){ 
		location.href = 'myStore';		 
	});
	
	 $('.rightSide_MyInfoBoxDown_profile').on('click',function(){ 
		location.href = 'profileEdit';		 
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
		location.href = 'pointList';		 
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
</head>
<body>
	<h2>키워드</h2>
	<%-- <a href="myPage">뒤로가기</a>
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
 --%>
 <div class="wrapper"> 
	 
		<div class="leftSide"> 
			<div class="tabs"> 
 
				<!-- <div class="leftSide_tabs_tab1"> 
					Favorite 
				</div> --> 
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
				<div class="leftSide_2nd_noticeService"> 
					<img id="noticeService" src="resources/linenotify/linenotify.png" onclick="javascript:noticeService()" /> 
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
					<c:if test="${empty pointRecord }"> 
						<tr> 
							<td colspan="4"> 
								<p>포인트가 없습니다</p> 
							</td> 
						</tr> 
					</c:if> 
					<c:if test="${not empty pointRecord }"> 
						<div class="customers_thead"> 
							<thead> 
								<tr> 
									<th>Point</th> 
									<th>Service</th> 
									<th>Date</th> 
								</tr> 
							</thead> 
						</div> 
						 
						<div class="customers_tbody"> 
							<tbody> 
								<c:forEach var="PointList" items="${pointRecord}"> 
								<tr class="leftSide_table_rows"> 
								<!--포인트 추가시 수정부분 --> 
								<c:if test="${PointList.point gt 0}"> 
									<td class="table_1st_td">+ ${PointList.point}</td> 
								</c:if> 
								 <c:if test="${PointList.point lt 0}"> 
									<td class="table_1st_td">${PointList.point}</td> 
								</c:if>
									<td class="table_2nd_td">${PointList.type}</td> 
									<td class="table_3rd_td">${PointList.regdate}</td> 
								</tr> 
								</c:forEach> 
							</tbody> 
							 
						</div><!-- customers_tbody 닫음 --> 
						 
						<div class="customer_tfoot"> 
							<tfoot> 
								<tr style="color: white; background-color: #0B3B0B;"> 
									<td colspan="3"> 
										현재포인트 : <span id="pointTotal" ></span> 
									</td> 
								</tr> 
							</tfoot> 
						</div><!-- customer_tfoot div닫음 --> 
				</table> 
				</c:if> 
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
						Profile <!-- <span onclick="goProfile()"></span> -->
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