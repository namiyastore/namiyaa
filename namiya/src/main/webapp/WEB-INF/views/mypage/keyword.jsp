<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="resources/mypage/css/mypage_keyword.css">
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
	/* $('.searchIcon').on('click',function(){ 
		location.href = 'mInBoxListAll?searchWord=${searchWord}';		 
	}); */
	
	
	 
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
<input id="myurl" type="hidden" value="${myurl}" />
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
				<a href="검색 컨트롤러"><!-- <img src="resources/mypage/images/searchIcon.png" class="searchIcon"> --></a>
			</div>
				<div class="leftSide_2nd_noticeService"> 
					<!-- <img id="noticeService" src="resources/linenotify/linenotify.png" onclick="javascript:noticeService()" /> --> 
				</div>
			</div>			 
			 
			<!-- 라인 인증키 얻는 링크 --> 
<!-- 			<input id="noticeService" type="button" value="Line 알림 서비스 등록" onclick="noticeService()" /> --> 
			 
 			<!-- 여기부터 테이블 --> 
			<div class="leftSide_table">
				<table id="customers">
					<tr>
						<th>No.</th>
						<th>키워드</th>
						<th colspan="2">삭제</th>
					</tr>
					<c:if test="${not empty klist }">
						<c:forEach var="kList" items="${klist }">
							<tr>
								<td>${kList.keywordnum}</td>
								<td><a href="${kList.keywordname}">${kList.keywordname}</a></td>
								<td><input type="button" value="삭제"	 onclick="kupdate(${kList.keywordnum })"></td>
								<td><input type="button" value="수정"	 onclick="kupdate(${kList.keywordnum })"/></td>
							</tr>
						</c:forEach>
					</c:if>
					<c:if test="${empty klist }">
						<tr>
							<td colspan="3" style="text-align: center;">등록하신 키워드가 없습니다.</td>
						</tr>
					</c:if>
				</table>
			</div><!-- 테이블의 div 닫음 -->
			<div class="leftSide_Buttons">
				<div>  </div>
			</div>
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