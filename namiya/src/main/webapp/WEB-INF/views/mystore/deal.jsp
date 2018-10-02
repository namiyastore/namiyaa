<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>거래진행과정</title>
<script type="text/javascript" src="resources/jquery-3.3.1.min.js"></script>
<script src="resources/search/js/common/jquery-1.12.4.js"></script>
<link rel="stylesheet" href="resources/mypage/css/mypage_historyDetail.css">
<link href="https://fonts.googleapis.com/css?family=Nanum+Gothic" rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Raleway:600" rel="stylesheet">
<script>
	function gotohistory() {
		location.href="historyList";
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
		/* $('.leftSide_tabs_tab1').on('click', function() {
			location.href = 'favoriteList';
		}); */
		$('.leftSide_tabs_tab2').on('click', function() {
			location.href = 'interestList';
		});
		$('.leftSide_tabs_tab3').on('click', function() {
			location.href = 'historyList';
		});
		/* $('.leftSide_tabs_tab4').on('click', function() {
			location.href = 'keywordList';
		}); */
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

	
	// 라인 메세지 전송
	function msgSend(id, content) {
		var message = content;
		var receive = id;
		
		var jsonData = { 
			'message' : message,
			'receive' : receive
		};
		
		$.ajax({
			method : 'get',
			url : 'LinenotifySendMsg',
			data : jsonData,
			dataType : 'json',
			success : function(resp) {
				alert("라인메세지가 전송되었습니다!");
			}
		});
	}
	
	function selected(historynum) {
		//alert("추첨하기");
		//alert(historynum);
		
		$.ajax({
			method : 'post',
			url : 'selectWinner',
			data : {"historynum" : historynum},
			
			dataType: 'text',
			success : function(resp) {
				alert(resp);
				var a = '';
					a += '<td id="winnerid" class="result_info" style="text-align: center; width:120px; font-size: 14px; color:red;">';
					a += resp;
					a += '</td>';
					a += '<td class="result_info">';
					a += '<input type="button" id="message" class="btn" name="message" value="쪽지" onclick= "message(';
					a += "'"+resp+"'"; 
					a += ')" >';				
					a += '</td>';
				$("#winner").html(a);
				
				var senderid = $("#userid").val();
				
				var urlAddr = "http://13.125.208.152:8081";
				var msg = "추첨%20대상자로%20선정되셨습니다%0Aline:" + urlAddr + "/namiya/sendMsg?userid=" + resp + "&senderid=" + senderid;
				
				// 당첨자에게 메세지 전송
				msgSend(resp, msg);
				
				// <input type="button" class="btn" id="selected" name="selected" value="추첨" onclick="selected(${history.historynum})">
				$("#buyer").html(resp);
			},
			error : function(error) {
				alert("추첨 error : "+error);
			}
			
		});
		
	}
	
	function message(userid) {
		window.open("sendMsg?userid="+userid, "newmsgwindow", "width=450,height=400");
	}
</script>
<style>
	/* #info {
		width:810px;
	} */
	
	/* #apply {
		width:280px;
	} */
	
	.apply_list {
		border: 1px solid #79bfe5;
   		border-radius:7px;
   		background-color: #79bfe5;
   		margin : 0 auto;
   		width: 800px;
		color: #414244;
		font-size: 14px;
		padding: 3px;
	}
	
	.result {
		border: 1px solid #79bfe5;
   		border-radius:7px;
   		background-color: #79bfe5;
   		margin : 0 auto;
		color: #414244;
		width:200px;
		font-size: 14px;
		padding: 3px;
	}
	
	.result_info {
		background-color: #fcfbf9;
		margin : 0 auto;
		border: 1px solid #fcfbf9;
   		border-radius: 7px;
   		background-color: #fcfbf9;
   		font-size: 13px;
		padding: 3px;
	}
	
	.apply_info {
		background-color: #fcfbf9;
		margin : 0 auto;
		border: 1px solid #fcfbf9;
   		border-radius: 7px;
   		background-color: #fcfbf9;
   		font-size: 13px;
		padding: 3px;
	}
	
	.deal_list {
		border: 1px solid #79bfe5;
   		border-radius:7px;
   		background-color: #79bfe5;
   		margin : 0 auto;
   		width: 810px;
		color: #414244;
		font-size: 14px;
		padding: 3px;
	}
	
	.deal_info {
		background-color: #fcfbf9;
		margin : 0 auto;
		border: 1px solid #fcfbf9;
   		border-radius: 7px;
   		background-color: #fcfbf9;
   		font-size: 13px;
		padding: 3px;
	}
	
		
	.btn {
		display: inline-block;
		width: 60px;
		border: none;
		color: #fff;
		border-radius: 5px;
		background-color: var(--color-primary);
		-webkit-box-shadow: 0 2px 7px var(--color-semidark);
	        	box-shadow: 0 2px 7px var(--color-semidark);
		outline: 0;
		cursor: pointer;
		-webkit-transition: all .5s;
		-o-transition: all .5s;
		transition: all .5s;
		background-color:#105531;
		font-size: 15px;
	}
	
	.btn:hover {
		opacity: .9;
	}
	
	body {
		font-family: 'Raleway', 'Nanum Gothic';
	}
</style>
</head>
<body>
<img alt="" src="resources/images/pagetop.gif" id="logo">	
<input id="lang" type="hidden" value="<spring:message code="common.lang" />" />
<input id="userid" type="hidden" value="${sessionScope.loginId }" />

<div class="wrapper">
	<div class="leftSide">
		<div class="tabs">
			<div class="leftSide_tabs_tab2">
				<spring:message code="mypage.leftSide_tabs_tab2" />
			</div>
			<div class="leftSide_tabs_tab3">
				<spring:message code="mypage.leftSide_tabs_tab3" />
			</div>
			<div class="leftSide_tabs_tab5">
				<spring:message code="mypage.leftSide_tabs_tab5" />
			</div>
			<div class="leftSide_tabs_tab7">
				<spring:message code="mypage.leftSide_tabs_tab7" />
			</div>
		</div>
		
	<div class="leftSide_table" style="background-color: white; height: 500px; overflow-x:hidden; overflow-y: auto;">
		<%-- 거래정보 --%>
		<div>
		<h2>거래상품정보</h2>
			<table id="info">
				<tr style="width:800px; text-align: center">
					<th class="deal_list" >거래번호</th>
					<th class="deal_list" >거래종류</th>
					<th class="deal_list" >물건이름</th>
					<th class="deal_list" >거래시작날짜</th>
					<th class="deal_list" >거래완료날짜</th>
					<th class="deal_list" >판매자</th>
					<th class="deal_list" >구매자</th>
					<th class="deal_list" >거래상태</th>
					<th class="deal_list" style="width:400px;">거래목록</th>
				</tr>
				<tr class="deal_info" style="text-align: center;">
					<td class="deal_info" >${history.historynum}</td>
					<td class="deal_info" >${board.service}</td>
					<td class="deal_info" >${product.productname}</td>
					<td class="deal_info" >${history.deal_start}</td>
					<td class="deal_info" >
						<c:if test="${product.sstatus eq '진행완료'}">
							${history.deal_end}
						</c:if>				
					</td>
					<td class="deal_info" >${sessionScope.loginId}</td>
					<td id="buyer" class="deal_info" >${history.buyerid}</td>
					<td class="deal_info" >${product.sstatus}</td>
					<td class="deal_info"><input type="button" class="btn" value="list" id="gotolist" onclick="gotohistory()"></td>
				</tr>
			</table>
		</div>
		<%-- 양도신청현황 --%>
		<div id="application" style="float: left; padding-top: 20px; padding-bottom: 20px; margin-right: 20px; width:280px; height:400px;">
		<h2>양도신청 현황</h2>
			<table id="apply" style="text-align: center;">
				<tr>
					<th class="apply_list">신청번호</th>
					<th class="apply_list">신청자</th>
				</tr>
				<c:forEach var="wlist" items="${wlist}" varStatus="status">
				<tr>
					<td class="apply_info">${wlist.wishnum}</td>
					<td class="apply_info">${wlist.userid}</td>
				</tr>
				</c:forEach>
			</table>
		</div>
	
		<%-- 추첨결과 --%>
		<div id="result" style="float: left; padding-top: 20px; padding-bottom: 20px; width:500px; height:400px;" align="center">
		<h2 style="margin-bottom: 10px;">추첨결과</h2>
			<div style="float: left; width:300px;">
				<img src="resources/images/takarakuzi.gif" style="width:200px;">
				<br/>
				<div id="select">
				<c:if test="${product.sstatus eq '진행완료' && history.buyerid == null}">
					<input type="button" class="btn" id="selected" name="selected" value="추첨" onclick="selected(${history.historynum})">
				</c:if>
				</div>
			</div>
			
			<div style="float: left; width:200px;">
				<table style="text-align: center; padding-top: 10px;">
					<tr>
						<th class="result" colspan="2">당첨자</th>
					</tr>
					<tr id="winner"></tr>
				</table>
			</div>
		</div>
	
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
</body>
</html>