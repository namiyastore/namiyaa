<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="resources/mypage/css/mypage_interest.css">
<title>Interest</title>
<link href="https://fonts.googleapis.com/css?family=Nanum+Gothic" rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Raleway:600" rel="stylesheet">
<script src="resources/search/js/common/jquery-1.12.4.js"></script>
<style>
 @import url(//fonts.googleapis.com/earlyaccess/notosansjapanese.css);
	body {
		font-family: 'Raleway', 'Nanum Gothic', 'Noto Sans Japanese';
	}
</style>
<script type="text/javascript">
function idelete(num) {
	location.href="iDelete?interestnum="+num;
}

function iupdate(num){
	location.href="iSelectOne?interestnum="+num;
}
</script>
<script> 
$(function(){ 
	
	$(".leftSide_table_open").on('click',function(){
		var boardnum = $(this).attr('data-boardnum');
		
		//alert("boardnum: " + boardnum);
		$.ajax({
			method : 'get',
			url : 'getMyurl?boardnum=' + boardnum,
			success : function(myurl){				
				//alert("myurl: " + myurl);
				window.open("myStore/" + myurl + "/giveView?boardnum=" + boardnum, "mystoreWindow", "width=1200, height=650");
			}
		});
	});
	 
	$('.rightSide_MyInfoBoxDown_goToHome').on('click',function(){ 
		location.href = 'search';		 
	}); 
	 
	// 미니홈피 창 열기
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
		location.href = 'keywordList'; 1002 없앰 수정	 	 
	}); */
	$('.leftSide_tabs_tab5').on('click',function(){ 
		location.href = 'mInBoxListAll';		 
	}); 
	/* $('.leftSide_tabs_tab6').on('click',function(){ 
		location.href = 'noticeList';		 
	});  */
	$('.leftSide_tabs_tab7').on('click',function(){ 
		location.href = 'pointRecord';		 
	});
	
	/* 0926 페이징 이미지버튼 클릭 */
	$('#btn1').on('click',function(){ 
		location.href = 'interestList?currentPage=${navi.currentPage - navi.pagePerGroup}';		 
	});
	$('#btn2').on('click',function(){ 
		location.href = 'interestList?currentPage=${navi.currentPage - 1}';		 
	});
	$('#btn3').on('click',function(){ 
		location.href = 'interestList?currentPage=${navi.currentPage + 1}';		 
	});
	$('#btn4').on('click',function(){ 
		location.href = 'interestList?currentPage=${navi.currentPage + navi.pagePerGroup}';		 
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
				</div>  1002 수정--%>
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
			 
 			<!-- 여기부터 테이블 --> 
			<div class="leftSide_table">
				<table id="customers">
					<tr>
						<th>No.</th>
						<th><spring:message code="interest.column1" /></th>
						<th colspan="2"><spring:message code="interest.column2" /></th>
					</tr>
					<c:if test="${not empty ilist }">
						<c:forEach var="iList" items="${ilist }">
							<tr>
								<td style="text-align: center;">${iList.interestnum}</td>
									<td>
										<div class="leftSide_table_open" data-boardnum="${iList.boardnum}">
											${iList.title}
										</div>
									</td>
								<%-- <td><input type="button" value="삭제" onclick="idelete(${iList.interestnum})" /></td> --%>
								<td id="deleteBtn" ><img src="resources/mypage/images/delete_icon.png" onclick="idelete(${iList.interestnum})"
								style="width: 24px;height: 24px; display: block;margin-left: auto;margin-right: auto;"/></td>
							</tr>
						</c:forEach>
					</c:if>
					<c:if test="${empty ilist }">
						<tr>
							<td colspan="4"><spring:message code="interest.empty" /></td>
						</tr>
					</c:if>
				</table>
			</div> <!-- 테이블의 div 닫음 -->
			
			<!-- 페이징 처리 부분 -->
			<div class="leftSide_page">
				<img id="btn1" src="resources/images/arrow7.png" width="24px" height="24px">
				<img id="btn2" src="resources/images/arrow8.png" width="24px" height="24px">
				<c:forEach var="page"  begin="${navi.startPageGroup }" end="${navi.endPageGroup }">
					<c:if test="${page == currentPage }">
						<span id="selectedPage">&nbsp; ${page} &nbsp;</span>
					</c:if>
					<c:if test="${page != currentPage }">
						&nbsp; <a style="text-decoration:none; color: white; font-size: 15pt;" href="interestList?currentPage=${page}">${page} &nbsp;</a>
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
						<!-- 프로필사진 --> 
						<img onError="this.src='resources/images/human.png'" src="${pageContext.request.contextPath}/home/img/profile/${profile.savedfile}" width="80px" height="80px"> 
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
					
					<%-- <div class="rightSide_MyInfoBoxDown_signOut">
						<spring:message code="mypage.rightSide_MyInfoBoxDown_signOut" />
					</div><!-- rightSide_MyInfoBoxDown_signOut의 div닫힘 --> --%>
					
				</div><!-- rightSide_MyInfoBoxDown div닫힘 -->
			</div><!-- rightSide_MyInfoBox div 닫음 -->
		</div><!-- rightSide div 닫음 -->
	</div>
	<!-- <form action="reqProfile" method="post" id="goProfile"></form> -->
</body>
</html>