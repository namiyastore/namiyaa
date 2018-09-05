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
	
	// 페이징 마우스 over/out
	$("#pagingFirst").mouseenter(function(){
		$("#pagingFirst").addClass('is-active');
	});
	
	$("#pagingFirst").mouseleave(function(){
		$("#pagingFirst").removeClass('is-active');
	});
	
	$("#pagingLeft").mouseenter(function(){
		$("#pagingLeft").addClass('is-active');
	});
	
	$("#pagingLeft").mouseleave(function(){
		$("#pagingLeft").removeClass('is-active');
	});
	
	$("#pagingRight").mouseenter(function(){
		$("#pagingRight").addClass('is-active');
	});
	
	$("#pagingRight").mouseleave(function(){
		$("#pagingRight").removeClass('is-active');
	});
	
	$("#pagingLast").mouseenter(function(){
		$("#pagingLast").addClass('is-active');
	});
	
	$("#pagingLast").mouseleave(function(){
		$("#pagingLast").removeClass('is-active');
	});
	
	
	
//	$("#pagingLeft")
//	$("#pagingRight")
//	$("#pagingLast")
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
						"<div style='color: white; background-color: rgb(70, 102, 128); border-top: 1px solid gray;' data-num='" + resp[i].categorynum + "' data-dept='" + resp[i].depth + "' data-idx='" + (parseInt(i)+1) + "' onclick='javascript:mediumCategoryClick(" + resp[i].categorynum + ")'>" + resp[i].categoryname + "</div>"
					);
				}
				else if(i == (resp.length-1)) {
					$("#depth2").append(
						"<div style='color: white; background-color: rgb(70, 102, 128); border-bottom: 1px solid gray;' data-num='" + resp[i].categorynum + "' data-dept='" + resp[i].depth + "' data-idx='" + (parseInt(i)+1) + "' onclick='javascript:mediumCategoryClick(" + resp[i].categorynum + ")'>" + resp[i].categoryname + "</div>"
					);
				}
				else {
					$("#depth2").append(
						"<div style='color: white; background-color: rgb(70, 102, 128);' data-num='" + resp[i].categorynum + "' data-dept='" + resp[i].depth + "' data-idx='" + (parseInt(i)+1) + "' onclick='javascript:mediumCategoryClick(" + resp[i].categorynum + ")'>" + resp[i].categoryname + "</div>"
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