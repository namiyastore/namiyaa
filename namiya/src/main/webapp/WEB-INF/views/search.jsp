<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title></title>

<!-- 카테고리 -->
<script src="resources/search/js/common/jquery-1.12.4.js"></script>

<!-- 검색 -->
<link href="resources/search/css/search/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<link href="resources/search/css/search/search.css" rel="stylesheet">

<!-- 검색 -->
<script src="resources/search/js/search/search.js"></script>

</head>
<body>

<input id="searchWord" type="hidden" value="${searchWord}">
<input id="currentPage1" type="hidden" value="${currentPage1}">
<input id="currentPage2" type="hidden" value="${currentPage2}">
<input id="currentPage3" type="hidden" value="${currentPage3}">
<input id="currentPage4" type="hidden" value="${currentPage4}">
<input id="categoryGroup" type="hidden" value="${categoryGroup}">
<input id="pagePerGroup" type="hidden" value="${navi.pagePerGroup}">
<input id="startPageGroup" type="hidden" value="${navi.startPageGroup}">
<input id="endPageGroup" type="hidden" value="${navi.endPageGroup}">
<input id="totalRecordCount" type="hidden" value="${totalRecordCount}">
<input id="searchFlag" type="hidden" value="${searchFlag}">
<input id="parentnum" type="hidden" value="${parentnum}">

<div id="container">

	<!-- 레이아웃(로고, 검색) -->
	<div id="layoutTop">
		<!-- 로고 -->
		<a href="${pageContext.request.contextPath}/search"><img id="logo" src="resources/search/image/logo.jpg"/></a>
		
		<!-- 검색 -->
		<div id="custom-search-input">
			<div class="input-group col-md-12">				
				<input type="text" class="  search-query form-control" placeholder="Search" value="${searchWord}" /> <span class="input-group-btn">
					<button class="btn btn-danger" type="button">
						<span class=" glyphicon glyphicon-search"></span>
					</button>
				</span>
			</div>
		</div>
	</div>
	
	<!-- 레이아웃(카테고리, 실시간알림, 프로필) -->
	<div id="layoutBottom" align="center">
		<!-- 카테고리 -->
		<div id="sideMenu">
			<div id="depth1"></div>
			<div id="depth2"></div>
			<div id="depth3"></div>
		</div>
	
		<!-- 실시간 알림 -->
		<div id="notice">
			<hr/>
			<div class="noticeItem">
				<div class="noticeItemDisplay" id="noticeItemContent">
					
					<div id="noticeText">
						<h3>&nbsp;&nbsp;&nbsp;&nbsp;[ 양도 ]</h3>
						&nbsp;&nbsp;&nbsp;&nbsp;책상 드립니다. 깨끗한 책상입니다. 이한 사정으로 처분하게 되었습니다.
					</div>
					<div id="noticeDate">
						2018-08-01 14:15
					</div>
				</div>
				<img onError="this.src='resources/search/image/noimage.png'" id="noticePic" class="noticeItemDisplay" width="100px" height="100px" src="abc">
			</div>
			<hr/>
			<div class="noticeItem">
				<div class="noticeItemDisplay" id="noticeItemContent">
					
					<div id="noticeText">
						<h3>&nbsp;&nbsp;&nbsp;&nbsp;[ 양도 ]</h3>
						&nbsp;&nbsp;&nbsp;&nbsp;책상 드립니다. 깨끗한 책상입니다. 이한 사정으로 처분하게 되었습니다.
					</div>
					<div id="noticeDate">
						2018-08-01 14:15
					</div>
				</div>
				<img onError="this.src='resources/search/image/noimage.png'" id="noticePic" class="noticeItemDisplay" width="100px" height="100px" src="abc">
			</div>
			<hr/>
			<div class="noticeItem">
				<div class="noticeItemDisplay" id="noticeItemContent">
					
					<div id="noticeText">
						<h3>&nbsp;&nbsp;&nbsp;&nbsp;[ 양도 ]</h3>
						&nbsp;&nbsp;&nbsp;&nbsp;책상 드립니다. 깨끗한 책상입니다. 이한 사정으로 처분하게 되었습니다.
					</div>
					<div id="noticeDate">
						2018-08-01 14:15
					</div>
				</div>
				<img onError="this.src='resources/search/image/noimage.png'" id="noticePic" class="noticeItemDisplay" width="100px" height="100px" src="abc">
			</div>
			<hr/>
<!-- 			<div class="noticeItem"> -->
<!-- 				<div class="noticeItemDisplay" id="noticeItemContent"> -->
					
<!-- 					<div id="noticeText"> -->
<!-- 						<h3>&nbsp;&nbsp;&nbsp;&nbsp;[ 양도 ]</h3> -->
<!-- 						&nbsp;&nbsp;&nbsp;&nbsp;책상 드립니다. 깨끗한 책상입니다. 이한 사정으로 처분하게 되었습니다. -->
<!-- 					</div> -->
<!-- 					<div id="noticeDate"> -->
<!-- 						2018-08-01 14:15 -->
<!-- 					</div> -->
<!-- 				</div> -->
<!-- 				<img onError="this.src='resources/search/image/noimage.png'" id="noticePic" class="noticeItemDisplay" width="100px" height="100px" src="abc"> -->
<!-- 			</div> -->
<!-- 			<hr/>			 -->
			
		</div>
	
		<!-- 프로필 -->
		<div id="profile">
		
			<div id="profilePicture">
				<img src="resources/search/image/jennifer.jpg" width="100px">
			</div>
			<div class="profileBtn">My Page</div>
			<div id="myStoreClick" class="profileBtn">My Store</div>
			<div class="profileBtn">Logout</div>
		</div>
		
		<!-- 채팅창 -->
		<div id="chat">
			asdf
		</div>
		
	</div>
	
</div>

</body>
</html>