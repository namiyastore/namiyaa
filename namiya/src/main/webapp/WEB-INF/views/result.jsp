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
<link href="resources/search/css/result/result.css" rel="stylesheet">

<!-- 결과 -->
<script src="resources/search/js/result/result.js" type="text/javascript"></script>

</head>
<style>

a{
  text-decoration: none;
}

p, li, a{
  font-size: 14px;
  text-decoration: none;
}

/* GRID */

.twelve { width: 100%; }
.eleven { width: 91.53%; }
.ten { width: 83.06%; }
.nine { width: 74.6%; }
.eight { width: 66.13%; }
.seven { width: 57.66%; }
.six { width: 49.2%; }
.five { width: 40.73%; }
.four { width: 32.26%; }
.three { width: 23.8%; }
.two { width: 15.33%; }
.one { width: 6.866%; }

/* COLUMNS */

.col {
	display: block;
	float:left;
	margin: 1% 0 1% 1.6%;
}

.col:first-of-type {
  margin-left: 0;
}

.container{
	width: 100%;
	max-width: 940px;
	margin: 0 auto;
	position: relative;
	text-align: center;
	
}

/* CLEARFIX */

.cf:before,
.cf:after {
    content: " ";
    display: table;
}

.cf:after {
    clear: both;
}

.cf {
    *zoom: 1;
}

/* GENERAL STYLES */

.pagination ul{
  margin: 0;
  padding: 0;
  list-style-type: none;
}

.pagination a{
  display: inline-block;
  padding: 4px 18px;
  color: #222;
}

/* ONE */

.p1 a{
  width: 40px;
  height: 40px;
  line-height: 40px;
  padding: 0;
  text-align: center;
}

.p1 a.is-active{
  background-color: #2ecc71;
  border-radius: 100%;
  color: #fff;
}

/* TWO */

.p2 .is-active li{
  font-weight: bold;
  border-bottom: 3px solid #2ecc71;
}

/* THREE */

.p3 .is-active{
  background-color: #2ecc71;
  color: #fff;
}

/* FOUR */

.p4 a{
  width: 40px;
  height: 40px;
  line-height: 40px;
  border-radius: 100%;
  padding: 0;
  text-align: center;
  position: relative;
  border: 3px solid #2ecc71;
}

.p4 .is-active:before{
  content: "";
  width: 30px;
  height: 30px;
  border-radius: 100%;
  background-color: #2ecc71;
  position: absolute;
  top: 5px;
  left: 5px;
}

/* FIVE */

.p5 a{
  width: 30px;
  height: 5px;
  padding: 0;
  margin: auto 5px;
  background-color: rgba(46, 204, 113, 0.4);
}

.p5 .is-active{
  background-color: #2ecc71;
}

/* SIX */

.p6 a{
  width: 30px;
  height: 30px;
  border-radius: 100%;
  padding: 0;
  margin: auto 5px;
  text-align: center;
  position: relative;
  background-color: rgba(46, 204, 113, 0.4);
}

.p6 .is-active{
  background-color: #2ecc71;
}

/* SEVEN */

.p7 a{
  border: 3px solid #2ecc71;
  margin: auto 5px;
  color: #2ecc71;
  font-weight: bold;
}

.p7 .is-active{
  background-color: #2ecc71;
  color: #fff;
}

/* EIGHT */

.p8 a{
  background-color: #2ecc71;
  margin: auto 5px;
  color: #fff;
  font-weight: bold;
  border: 3px solid #2ecc71;
  text-decoration: none;
}

.p8 .is-active{
  background-color: #fff;
  color: #2ecc71;
  text-decoration: none;
}

/* NINE */

.p9 a{
  width: 30px;
  height: 30px;
  line-height: 30px;
  padding: 0;
  text-align: center;
  margin: auto 5px;
}

.p9 a.is-active{
  border: 3px solid #2ecc71;
  border-radius: 100%;
}

/* TEN */

.p10 a{
  width: 30px;
  height: 30px;
  line-height: 30px;
  padding: 0;
  text-align: center;
  margin: auto 5px;
}

.p10 a.is-active{
  border: 3px solid #2ecc71;
}

/* ELEVEN */

.p11 a{
  background-color: #2ecc71;
  margin: auto 5px;
  color: #fff;
  border: 3px solid #2ecc71;
  position: relative;
}

.p11 a:first-of-type:before{
  content: "";
  position: absolute;
  top: -3px;
  left: -25px;
  border-top: 22px solid transparent;
  border-bottom: 22px solid transparent;
  border-right: 22px solid #2ecc71;
}

.p11 a:last-of-type:after{
  content: "";
  position: absolute;
  top: -3px;
  right: -25px;
  border-top: 22px solid transparent;
  border-bottom: 22px solid transparent;
  border-left: 22px solid #2ecc71;
}

.p11 .is-active{
  font-weight: bold;
}

/* TWELVE */

.p12 a:first-of-type, .p12 a:last-of-type, .p12 .is-active{
  background-color: #2ecc71;
  color: #fff;
  font-weight: bold;
}

</style>
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
				<input type="text" class="  search-query form-control" placeholder="Search" /> <span class="input-group-btn">
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
		
		<!-- 상품 리스트 -->
		<div id="productContainer">
			<!-- 페이징 -->
<!-- 			<div id="paging"> -->
<!-- 				<div class="pagingBtn" id="pagingFirst"> -->
<!-- 					<div>&lt;&lt;</div> -->
<!-- 				</div> -->
						
<!-- 				<div class="pagingBtn" id="pagingLeft"> -->
<!-- 					<div>&lt;</div> -->
<!-- 				</div> -->
				
<!-- 				<span id="pagingNum"> -->
<!-- 				</span> -->



				
<!-- 				<div class="pagingBtn" id="pagingRight"> -->
<!-- 					<div>&gt;</div> -->
<!-- 				</div> -->
				
<!-- 				<div class="pagingBtn" id="pagingLast"> -->
<!-- 					<div>&gt;&gt;</div> -->
<!-- 				</div> -->
<!-- 			</div> -->
			
			<!-- 페이징 버튼 CSS테스트 -->
			<div class="pagination p8">
		      <ul>
		      	<a href="#" id="pagingFirst"><li>first</li></a>
		        <a href="#" id="pagingLeft"><li>prev</li></a>
		        <span id="pagingNum">
				</span>
		        <a href="#" id="pagingRight"><li>next</li></a>
		        <a href="#" id="pagingLast"><li>last</li></a>
		      </ul>
		    </div>		
			
			<c:if test="${not empty list}">
				<c:forEach var="ptList" items="${list}" varStatus="status">
					<c:if test="${status.first}">
						<input id="pnumFirst" type="hidden" value="${status.count + navi.startRecord}">
					</c:if>
					<c:if test="${status.last}">
						<input id="pnumLast" type="hidden" value="${status.count + navi.startRecord}">
					</c:if>
					<div>
						<div class="productList" data-boardnum="${ptList.boardnum}">
							<div class="leftFrame">
								<div class="productImg">
									<img onError="this.src='resources/search/image/noimage.png'" src="a" width="100px" height="100px">
								</div>
							</div>
							
							<div class="rightFrame">
								<div class="productTitle">${ptList.title}</div>
								<div class="rightFrameSub">
									<div class="regdate">${ptList.regdate}</div>
									<div class="userid">${ptList.userid}</div>
								</div>
							</div>			
						
						</div>
					</div>
				</c:forEach>			
			</c:if>
			
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
	</div>
	
</div>

</body>
</html>