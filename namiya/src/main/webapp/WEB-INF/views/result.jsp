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

<script>

var idx1 = "";	// 대분류 index
var idx2 = "";	// 중분류 index

// 카테고리 div 높이( 단위 : px )
// CSS : '#sideMenu > div > div' 부분에 height 값과 일치시켜야됨
var divHeight = 30;

var colorMajor = 'rgb(70,102,128)';	// 대분류 카테고리 색상
var colorMedium = 'rgb(70,102,128)';	// 중분류 카테고리 색상
var colorMiner = 'rgb(255,90,90)';		// 소분류 카테고리 색상

var category = "product";	// 검색 옵션 선택
							// product : 양도
							// talent : 재능
							// trade : 교환

$(function(){
	
	// 카테고리 대분류 가져오기
	majorCategory();

	$("#sideMenu").mouseleave(function(){		
		$("#depth2").css("visibility","hidden");
		$("#depth3").css("visibility","hidden");
		
		$("#depth1 div").css("backgroundColor","#FFFFFF");
		$("#depth1 div").css("color","#000000");
	});
	
	// 검색
	$(".btn-danger").on("click",function(){
		var searchWord = $(".form-control").val();
		var currentPage1 = $("#currentPage1").val();
		
		if(!currentPage1) {
			currentPage1 = 1;
		}
		
		location.href="result?currentPage1=" + currentPage1 + "&searchWord=" + searchWord + "&searchFlag=on";
	});
	
	// 위치 초기화( 검색결과창창, 프로필 )
	setPositionInit();
	
	// 미니홈피 창 열기
	$("#myStoreClick").on("click",function(){
		window.open("myStore","mystoreWindow","width:1200","height:650");
	});
	
	// 창 크기에 따라 좌표 지정 ( 창크기 변경 감지 )
	$( window ).resize( function() {
		
		// < 검색결과창창 위치 >
		
		// 카테고리 위치값
		var left_category = $("#sideMenu").offset().left;
		var top_category = $("#sideMenu").offset().top;
		
		$("#productContainer").css("position", "absolute")
// 		.css("top", (parseInt(top_category)+40) + "px")
		.css("top", 60 + "px")
		.css("left", (parseInt(left_category)+250) + "px")
		.css("margin-top","40px");
		
		document.getElementById("sideMenu").style.zIndex = 1;
		
		// < 프로필 위치 >
		
		// 검색결과창 위치값
		var left_product = $("#productContainer").offset().left;
		var top_product = $("#productContainer").offset().top;
		
		// 프로필 위치 지정
		$('#profile').css("position", "absolute")
			.css("top", 101 + "px")
			.css("left", (parseInt(left_product)+600) + "px")
			.css("margin-left","50px");
	} );
	
	$("#pagingFirst").on("click",function(){
		
		var searchWord = $("#searchWord").val();
		var currentPage = "";
		var pagePerGroup = $("#pagePerGroup").val();
		var startPageGroup = $("#startPageGroup").val();
		var endPageGroup = $("#endPageGroup").val();
		var searchFlag = $("#searchFlag").val();
		var parentnum = $("#parentnum").val();
		var categoryGroup = $("#categoryGroup").val();
		
		if(searchFlag == "on") {
			currentPage = $("#currentPage1").val();
			
			if((parseInt(currentPage) - parseInt(pagePerGroup)) > 1) {
				location.href="result?currentPage1=" + (parseInt(currentPage) - parseInt(pagePerGroup)) + "&searchWord=" + searchWord + "&searchFlag=on";
			}
			else {
				location.href="result?currentPage1=1" + "&searchWord=" + searchWord + "&searchFlag=on";
			}
		}
		else {
			if(categoryGroup == 'major') {
				currentPage = $("#currentPage2").val();
			}
			else if(categoryGroup == 'medium') {
				currentPage = $("#currentPage3").val();
			}
			else if(categoryGroup == 'minor') {
				currentPage = $("#currentPage4").val();
			}			
			
			if((parseInt(currentPage) - parseInt(pagePerGroup)) > 1) {
				if(categoryGroup == 'major') {
					location.href="result?currentPage2=" + (parseInt(currentPage) - parseInt(pagePerGroup)) + "&searchWord=" + searchWord + "&parentnum=" + parentnum + "&categoryGroup=major";
				}
				else if(categoryGroup == 'medium') {
					location.href="result?currentPage3=" + (parseInt(currentPage) - parseInt(pagePerGroup)) + "&searchWord=" + searchWord + "&parentnum=" + parentnum + "&categoryGroup=medium";
				}
				else if(categoryGroup == 'minor') {
					location.href="result?currentPage4=" + (parseInt(currentPage) - parseInt(pagePerGroup)) + "&searchWord=" + searchWord + "&parentnum=" + parentnum + "&categoryGroup=minor";
				}
			}
			else {
				if(categoryGroup == 'major') {					
					location.href="result?currentPage2=1" + "&searchWord=" + searchWord + "&parentnum=" + parentnum + "&categoryGroup=major";
				}
				else if(categoryGroup == 'medium') {
					location.href="result?currentPage3=1" + "&searchWord=" + searchWord + "&parentnum=" + parentnum + "&categoryGroup=medium";
				}
				else if(categoryGroup == 'minor') {
					location.href="result?currentPage4=1" + "&searchWord=" + searchWord + "&parentnum=" + parentnum + "&categoryGroup=minor";
				}
				
			}
		}		
		
	});
	
	$("#pagingLeft").on("click",function(){
		
		var searchWord = $("#searchWord").val();
		var currentPage = "";
		var pagePerGroup = $("#pagePerGroup").val();
		var startPageGroup = $("#startPageGroup").val();
		var endPageGroup = $("#endPageGroup").val();
		var searchFlag = $("#searchFlag").val();
		var parentnum = $("#parentnum").val();
		var categoryGroup = $("#categoryGroup").val();
		
		if(searchFlag == "on") {
			currentPage = $("#currentPage1").val();
			
			if((parseInt(currentPage) - 1) > 1) {
				location.href="result?currentPage1=" + (parseInt(currentPage) - 1)  + "&searchWord=" + searchWord + "&searchFlag=on";
			}
			else {
				location.href="result?currentPage1=1" + "&searchWord=" + searchWord + "&searchFlag=on";
			}
		}
		else {
			if(categoryGroup == 'major') {
				currentPage = $("#currentPage2").val();
			}
			else if(categoryGroup == 'medium') {
				currentPage = $("#currentPage3").val();
			}
			else if(categoryGroup == 'minor') {
				currentPage = $("#currentPage4").val();
			}
			
			if((parseInt(currentPage) - 1) > 1) {
				if(categoryGroup == 'major') {
					location.href="result?currentPage2=" + (parseInt(currentPage) - 1)  + "&searchWord=" + searchWord + "&parentnum=" + parentnum + "&categoryGroup=major";
				}
				else if(categoryGroup == 'medium') {
					location.href="result?currentPage3=" + (parseInt(currentPage) - 1)  + "&searchWord=" + searchWord + "&parentnum=" + parentnum + "&categoryGroup=medium";
				}
				else if(categoryGroup == 'minor') {
					location.href="result?currentPage4=" + (parseInt(currentPage) - 1)  + "&searchWord=" + searchWord + "&parentnum=" + parentnum + "&categoryGroup=minor";
				}					
			}
			else {
				if(categoryGroup == 'major') {
					location.href="result?currentPage2=1" + "&searchWord=" + searchWord + "&parentnum=" + parentnum + "&categoryGroup=major";
				}
				else if(categoryGroup == 'medium') {
					location.href="result?currentPage3=1" + "&searchWord=" + searchWord + "&parentnum=" + parentnum + "&categoryGroup=medium";
				}
				else if(categoryGroup == 'minor') {
					location.href="result?currentPage4=1" + "&searchWord=" + searchWord + "&parentnum=" + parentnum + "&categoryGroup=minor";
				}				
			}
			
		}
	});
	
	$("#pagingRight").on("click",function(){
		
		var searchWord = $("#searchWord").val();
		var currentPage = "";
		var pagePerGroup = $("#pagePerGroup").val();
		var startPageGroup = $("#startPageGroup").val();
		var endPageGroup = $("#endPageGroup").val();
		var searchFlag = $("#searchFlag").val();
		var parentnum = $("#parentnum").val();
		var categoryGroup = $("#categoryGroup").val();
		
		if(searchFlag == "on") {
			currentPage = $("#currentPage1").val();
			
			if(endPageGroup >= (parseInt(currentPage) + 1)) {
				location.href="result?currentPage1=" + (parseInt(currentPage) + 1)  + "&searchWord=" + searchWord + "&searchFlag=on";
			}
			else {
				location.href="result?currentPage1=" + endPageGroup + "&searchWord=" + searchWord + "&searchFlag=on";
			}
		}
		else {
			if(categoryGroup == 'major') {
				currentPage = $("#currentPage2").val();
			}
			else if(categoryGroup == 'medium') {
				currentPage = $("#currentPage3").val();
			}
			else if(categoryGroup == 'minor') {
				currentPage = $("#currentPage4").val();
			}
			
			if(endPageGroup >= (parseInt(currentPage) + 1)) {
				if(categoryGroup == 'major') {
					location.href="result?currentPage2=" + (parseInt(currentPage) + 1)  + "&searchWord=" + searchWord + "&parentnum=" + parentnum + "&categoryGroup=major";
				}
				if(categoryGroup == 'medium') {
					location.href="result?currentPage3=" + (parseInt(currentPage) + 1)  + "&searchWord=" + searchWord + "&parentnum=" + parentnum + "&categoryGroup=medium";
				}
				if(categoryGroup == 'minor') {
					location.href="result?currentPage4=" + (parseInt(currentPage) + 1)  + "&searchWord=" + searchWord + "&parentnum=" + parentnum + "&categoryGroup=minor";
				}
			}
			else {
				if(categoryGroup == 'major') {
					location.href="result?currentPage2=" + endPageGroup + "&searchWord=" + searchWord + "&parentnum=" + parentnum + "&categoryGroup=major";	
				}
				if(categoryGroup == 'medium') {
					location.href="result?currentPage3=" + endPageGroup + "&searchWord=" + searchWord + "&parentnum=" + parentnum + "&categoryGroup=medium";
				}
				if(categoryGroup == 'minor') {
					location.href="result?currentPage4=" + endPageGroup + "&searchWord=" + searchWord + "&parentnum=" + parentnum + "&categoryGroup=minor";
				}
			}
		}
	});
	
	$("#pagingLast").on("click",function(){
		
		var searchWord = $("#searchWord").val();
		var currentPage = "";
		var pagePerGroup = $("#pagePerGroup").val();
		var startPageGroup = $("#startPageGroup").val();
		var endPageGroup = $("#endPageGroup").val();
		var searchFlag = $("#searchFlag").val();
		var parentnum = $("#parentnum").val();
		var categoryGroup = $("#categoryGroup").val();
		
		if(searchFlag == "on") {
			currentPage = $("#currentPage1").val();
			
			if(endPageGroup  >= (parseInt(currentPage) + parseInt(pagePerGroup))) {
				location.href="result?currentPage1=" + (parseInt(currentPage) + parseInt(pagePerGroup)) + "&searchWord=" + searchWord + "&searchFlag=on";	
			}
			else {
				location.href="result?currentPage1=" + endPageGroup + "&searchWord=" + searchWord + "&searchFlag=on";
			}
		}
		else {
			if(categoryGroup == 'major') {
				currentPage = $("#currentPage2").val();
			}
			else if(categoryGroup == 'medium') {
				currentPage = $("#currentPage3").val();
			}
			else if(categoryGroup == 'minor') {
				currentPage = $("#currentPage4").val();
			}
			
			if(endPageGroup >= (parseInt(currentPage) + parseInt(pagePerGroup))) {
				if(categoryGroup == 'major') {
					location.href="result?currentPage2=" + (parseInt(currentPage) + parseInt(pagePerGroup)) + "&searchWord=" + searchWord + "&parentnum=" + parentnum + "&categoryGroup=major";
				}
				if(categoryGroup == 'medium') {
					location.href="result?currentPage3=" + (parseInt(currentPage) + parseInt(pagePerGroup)) + "&searchWord=" + searchWord + "&parentnum=" + parentnum + "&categoryGroup=medium";
				}
				if(categoryGroup == 'minor') {
					location.href="result?currentPage4=" + (parseInt(currentPage) + parseInt(pagePerGroup)) + "&searchWord=" + searchWord + "&parentnum=" + parentnum + "&categoryGroup=minor";
				}
			}
			else {
				if(categoryGroup == 'major') {
					location.href="result?currentPage2=" + endPageGroup + "&searchWord=" + searchWord + "&parentnum=" + parentnum + "&categoryGroup=major";
				}
				if(categoryGroup == 'medium') {
					location.href="result?currentPage3=" + endPageGroup + "&searchWord=" + searchWord + "&parentnum=" + parentnum + "&categoryGroup=medium";
				}
				if(categoryGroup == 'minor') {
					location.href="result?currentPage4=" + endPageGroup + "&searchWord=" + searchWord + "&parentnum=" + parentnum + "&categoryGroup=minor";
				}
			}
		}
	});
	
	var pagingFirstNum = $("#pnumFirst").val();
	var pagingLastNum = $("#pnumLast").val();
	
	if(pagingFirstNum != pagingLastNum) {
		$("#pagingNum").html(pagingFirstNum + " - " + pagingLastNum);
	}
	else {
		$("#pagingNum").html(pagingFirstNum);
	}
	
});

function setPositionInit() {
	
	// 카테고리 위치값
	var left_category = $("#sideMenu").offset().left;
	var top_category = $("#sideMenu").offset().top;
	
	// 검색결과창 위치 지정
	$("#productContainer").css("position", "absolute")
// 		.css("top", (parseInt(top_category)+40) + "px")
		.css("top", 60 + "px")
		.css("left", (parseInt(left_category)+250) + "px")
		.css("margin-top","40px");
	
	document.getElementById("sideMenu").style.zIndex = 1;
	
	// 검색결과창 위치값
	var left_productContainer = $("#productContainer").offset().left;
	var top_productContainer = $("#productContainer").offset().top;
	
	// 프로필 위치 지정
	$("#profile").css("position", "absolute")
// 		.css("top", parseInt(top_category)+40 + "px")
		.css("top", 101 + "px")
		.css("left", (parseInt(left_productContainer)+600) + "px")
		.css("margin-left","50px");
	
}

// 대분류 클릭 이벤트 함수
function majorCategoryClick(categorynum) {
	var currentPage2 = $("#currentPage2").val();
	location.href = "result?currentPage2=" + currentPage2 + "&parentnum=" + categorynum + "&categoryGroup=major";
}

// 중분류 클릭 이벤트 함수
function mediumCategoryClick(categorynum) {
	var currentPage3 = $("#currentPage3").val();
	location.href = "result?currentPage3=" + currentPage3 + "&parentnum=" + categorynum + "&categoryGroup=medium";
}

// 소분류 클릭 이벤트 함수
function minorCategoryClick(categorynum) {
	var currentPage4 = $("#currentPage4").val();
	location.href = "result?currentPage4=" + currentPage4 + "&parentnum=" + categorynum + "&categoryGroup=minor";
}

function majorCategory() {
	
	$.ajax({
		method : "get",
		url : "majorCategory",
		success : function(resp) {			
			for(var i in resp) {
				if(i == 0) {
					$("#depth1").append(
						"<div style='border-top: 1px solid gray;' data-num='" + resp[i].categorynum + "' data-dept='" + resp[i].depth + "' data-idx='" + (parseInt(i)+1) + "' onclick='javascript:majorCategoryClick(" + resp[i].categorynum + ")'>" + resp[i].categoryname + "</div>"
					);
				}
				else if(i == (resp.length-1)) {
					$("#depth1").append(
						"<div style='border-bottom: 1px solid gray;' data-num='" + resp[i].categorynum + "' data-dept='" + resp[i].depth + "' data-idx='" + (parseInt(i)+1) + "' onclick='javascript:majorCategoryClick(" + resp[i].categorynum + ")'>" + resp[i].categoryname + "</div>"
					);
				}
				else {
					$("#depth1").append(
						"<div data-num='" + resp[i].categorynum + "' data-dept='" + resp[i].depth + "' data-idx='" + (parseInt(i)+1) + "' onclick='javascript:majorCategoryClick(" + resp[i].categorynum + ")'>" + resp[i].categoryname + "</div>"
					);
				}
			}
			
			$("#depth1 div").mouseenter(function(){
				// 선택된 카테고리 색상 셋팅
				$("#depth1 div").css("backgroundColor","#FFFFFF");
				$("#depth1 div").css("color","#000000");
				
				$(this).css("backgroundColor",colorMajor);
				$(this).css("color","#FFFFFF");
				
				// 카테고리 중분류 가져오기
				idx1 = $(this).attr("data-idx");
				
				mediumCategory($(this));
				
				$("#depth3").html('');
			});
		}
	});
}

function mediumCategory(categoryM) {
	
	var dataNum = categoryM.attr("data-num");	// 카테고리번호
	var dataDept = categoryM.attr("data-dept");	// 카테고리 대/중/소
	var dataIdx = categoryM.attr("data-idx");	// 카테고리 위치
	var dataName = categoryM.html();			// 카테고리 이름
	
	$.ajax({
		method : "get",
		url : "mediumCategory",
		async: false,
		data : "categorynum=" + dataNum,
		success : function(resp) {
			
 			$("#depth2").html('');
			
			var ht = parseInt(dataIdx) * divHeight + "px";
			
			$("#depth2").css("top",ht);
			
			// 중분류 카테고리 출력
			for(var i in resp) {
				if(i == 0) {
					$("#depth2").append(
						"<div style='border-top: 1px solid gray;' data-num='" + resp[i].categorynum + "' data-dept='" + resp[i].depth + "' data-idx='" + (parseInt(i)+1) + "' onclick='javascript:mediumCategoryClick(" + resp[i].categorynum + ")'>" + resp[i].categoryname + "</div>"
					);
				}
				else if(i == (resp.length-1)) {
					$("#depth2").append(
						"<div style='border-bottom: 1px solid gray;' data-num='" + resp[i].categorynum + "' data-dept='" + resp[i].depth + "' data-idx='" + (parseInt(i)+1) + "' onclick='javascript:mediumCategoryClick(" + resp[i].categorynum + ")'>" + resp[i].categoryname + "</div>"
					);
				}
				else {
					$("#depth2").append(
						"<div data-num='" + resp[i].categorynum + "' data-dept='" + resp[i].depth + "' data-idx='" + (parseInt(i)+1) + "' onclick='javascript:mediumCategoryClick(" + resp[i].categorynum + ")'>" + resp[i].categoryname + "</div>"
					);	
				}
				
				$("#depth2").css("border-left","1px solid gray");
				$("#depth2").css("border-right","1px solid gray");
			}
			
			$("#depth2 div").mouseenter(function(){
				// 선택된 카테고리 색상 셋팅
				$("#depth2 div").css("backgroundColor","#FFFFFF");
				$("#depth2 div").css("color","#000000");
				
				$(this).css("backgroundColor",colorMedium);
				$(this).css("color","#FFFFFF");
				
				// 카테고리 중분류 가져오기
				idx2 = $(this).attr("data-idx");
				minerCategory($(this));
			});
			
			document.getElementById("depth2").style.zIndex = 1;
			document.getElementById("productContainer").style.zIndex = 0;
			
			$("#depth2").css("visibility","visible");
		}
	});
}

function minerCategory(category_m) {
	
	// 카테고리 선택시 선택 색상 지정
	$("#depth1 div").css("backgroundColor","#FFFFFF");
	$("#depth1 div").css("color","#000000");
	
	$("#depth1 div").eq(parseInt(idx1)-1).css("backgroundColor",colorMajor);
	$("#depth1 div").eq(parseInt(idx1)-1).css("color","#FFFFFF");
	
	var dataNum = category_m.attr("data-num");	// 카테고리번호
	var dataDept = category_m.attr("data-dept");	// 카테고리 대/중/소
	var dataIdx = category_m.attr("data-idx");	// 카테고리 위치
	var dataName = category_m.html();			// 카테고리 이름
	
	$.ajax({
		method : "get",
		url : "minerCategory",
		async: false,
		data : "categorynum=" + dataNum,
		success : function(resp) {
			
			$("#depth3").html('');
			
			var ht = ( (parseInt(idx1) * divHeight) + ((parseInt(idx2)-1) * divHeight) ) + "px";
			
			$("#depth3").css("top",ht);
			
			// 소분류 카테고리 출력
			for(var i in resp) {
				if(i == 0) {
					$("#depth3").append(
						"<div style='border-top: 1px solid gray; border-right: 1px solid gray;' data-num='" + resp[i].categorynum + "' data-dept='" + resp[i].depth + "' data-idx='" + (parseInt(i)+1) + "' onclick='javascript:minorCategoryClick(" + resp[i].categorynum + ")'>" + resp[i].categoryname + "</div>"
					);
				}
				else if(i == (resp.length-1)) {
					$("#depth3").append(
						"<div style='border-bottom: 1px solid gray; border-right: 1px solid gray;' data-num='" + resp[i].categorynum + "' data-dept='" + resp[i].depth + "' data-idx='" + (parseInt(i)+1) + "' onclick='javascript:minorCategoryClick(" + resp[i].categorynum + ")'>" + resp[i].categoryname + "</div>"
					);
				}
				else {
					$("#depth3").append(
						"<div style='border-right: 1px solid gray;' data-num='" + resp[i].categorynum + "' data-dept='" + resp[i].depth + "' data-idx='" + (parseInt(i)+1) + "' onclick='javascript:minorCategoryClick(" + resp[i].categorynum + ")'>" + resp[i].categoryname + "</div>"
					);
				}
			}
			
			document.getElementById("depth3").style.zIndex = 1;
			document.getElementById("productContainer").style.zIndex = 0;
			
			$("#depth3").css("visibility","visible");
		}
	});
	
	
}

</script>

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
			<div id="paging">
				<div class="pagingBtn" id="pagingFirst">
					<div>&lt;&lt;</div>
				</div>
						
				<div class="pagingBtn" id="pagingLeft">
					<div>&lt;</div>
				</div>
				
				<span id="pagingNum">
				</span>
				
				<div class="pagingBtn" id="pagingRight">
					<div>&gt;</div>
				</div>
				
				<div class="pagingBtn" id="pagingLast">
					<div>&gt;&gt;</div>
				</div>
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
				<img src="resources/search/image/jennifer.jpg" width="200px">
			</div>
			<div class="profileBtn">My Page</div>
			<div id="myStoreClick" class="profileBtn">My Store</div>
			<div class="profileBtn">Logout</div>
		</div>
	</div>
	
</div>

</body>
</html>