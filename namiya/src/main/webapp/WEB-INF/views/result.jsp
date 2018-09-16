<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
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

<!-- websocket -->
<!-- jQuery CDN-->
<script src="https://code.jquery.com/jquery-1.9.0.js"
  integrity="sha256-TXsBwvYEO87oOjPQ9ifcb7wn3IrrW91dhj6EMEtRLvM="
  crossorigin="anonymous"></script>
  
<!-- Web socket CDN -->
<script src="http://cdn.sockjs.org/sockjs-0.3.4.js"></script>

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
	
	// 마이 페이지 이동
	$("#myPageClick").on("click",function(){
		location.href = "myPage";
	});
	
	// 로그아웃
	$("#logoutClick").on("click",function(){
		location.href = "logout";
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
		
		// < 채팅창 위치 >
		
		// 채팅창 위치조정
		$("#chat").css("position", "absolute")
			.css("top", 350 + "px")
			.css("left", (parseInt(left_product)+650) + "px");
		
		// 채팅창 검색버튼 위치조정	
		$("#custom-search-input2").css("position","absolute")
			.css("top", 560 + "px")
			.css("left", (parseInt(left_product)+650) + "px");
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
	
	// 검색결과 중 원한는 항목 클릭
	$(".productList").on("click",function(){
		alert($(this).attr('data-boardnum'));
		
		var myurl = $('#myurl').val();
		window.open("myStore/" + myurl + "/giveView?boardnum=" + boardnum,"mystoreWindow","width=1200, height=650");
	});
	
	var bgSize = (window.innerWidth || document.body.clientWidth) + "px " + (window.innerHeight || document.body.clientHeight) + "px";
	
	$('body').css('backgroundSize', bgSize);
	
	$('.pagination p8').css('margin-bottom','20px');
	
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
	
	// 채팅창 위치조정
	$("#chat").css("position", "absolute")
		.css("top", 350 + "px")
		.css("left", (parseInt(left_productContainer)+650) + "px");
	
	// 채팅창 검색버튼 위치조정	
	$("#custom-search-input2").css("position","absolute")
		.css("top", 560 + "px")
		.css("left", (parseInt(left_productContainer)+650) + "px");
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
	
	var lang = $('#lang').val();
	
	$.ajax({
		method : "get",
		url : "majorCategory?" + "lang=" + lang,
		success : function(resp) {			
			for(var i in resp) {
				if(i == 0) {
					$("#depth1").append(
						"<div style='border-top: 1px solid gray;' data-num='" + resp[i].categorynum + "' data-dept='" + resp[i].depth + "' data-idx='" + (parseInt(i)+1) + "' onclick='javascript:majorCategoryClick(" + resp[i].categorynum + ")'>" + resp[i].categoryname + "</div>"
						+ "<span id='tooltipnum" + resp[i].categorynum + "' class='tooltiptext'>" + resp[i].categoryname + "</span>"
					);
				}
				else if(i == (resp.length-1)) {
					$("#depth1").append(
						"<div style='border-bottom: 1px solid gray;' data-num='" + resp[i].categorynum + "' data-dept='" + resp[i].depth + "' data-idx='" + (parseInt(i)+1) + "' onclick='javascript:majorCategoryClick(" + resp[i].categorynum + ")'>" + resp[i].categoryname + "</div>"
						+ "<span id='tooltipnum" + resp[i].categorynum + "' class='tooltiptext'>" + resp[i].categoryname + "</span>"
					);
				}
				else {
					$("#depth1").append(
						"<div data-num='" + resp[i].categorynum + "' data-dept='" + resp[i].depth + "' data-idx='" + (parseInt(i)+1) + "' onclick='javascript:majorCategoryClick(" + resp[i].categorynum + ")'>" + resp[i].categoryname + "</div>"
						+ "<span id='tooltipnum" + resp[i].categorynum + "' class='tooltiptext'>" + resp[i].categoryname + "</span>"
					);
				}
			}
			
			$("#depth1 div").mouseenter(function(){
				// 선택된 카테고리 색상 셋팅
				$("#depth1 div").css("backgroundColor","#FFFFFF");
				$("#depth1 div").css("color","#000000");
				
				$(this).css("backgroundColor",colorMajor);
				$(this).css("color","#FFFFFF");
				
				// 카테고리명의 길이가 너무 긴지 확인(28자 까지만 가능)
				if($(this).text().length >= 28) {
					var num = $(this).attr('data-num');					
					$("#tooltipnum" + num).attr('style','visibility:visible');
				}
				
				// 카테고리 중분류 가져오기
				idx1 = $(this).attr("data-idx");
				
				mediumCategory($(this));
				
				$("#depth3").html('');
				
				// 툴팁 z-index 최상위로 변경
				var num = 1;
				
				$("div").each(function(){
					var z = $(this).css("z-index");
					
					if( z != "auto" && parseInt(z) >= num ) {
						num = z + 1;
					}
				});
				$(".tooltiptext").css({"z-index":num});
			});
			
			// 대분류에서 마우스가 떠나면 툴팁창 숨기기
			$("#depth1 div").mouseleave(function(){
				$(".tooltiptext").attr('style','visibility:hidden');			
				
			});
		}
	});
}

function mediumCategory(categoryM) {
	
	var dataNum = categoryM.attr("data-num");	// 카테고리번호
	var dataDept = categoryM.attr("data-dept");	// 카테고리 대/중/소
	var dataIdx = categoryM.attr("data-idx");	// 카테고리 위치
	var dataName = categoryM.html();			// 카테고리 이름
	
	var lang = $('#lang').val();
	
	$.ajax({
		method : "get",
		url : "mediumCategory",
		async: false,
		data : "categorynum=" + dataNum + "&lang=" + lang,
		success : function(resp) {
			
 			$("#depth2").html('');
			
			var ht = parseInt(dataIdx) * divHeight + "px";
			
			$("#depth2").css("top",ht);
			
			// 중분류 카테고리 출력
			for(var i in resp) {
				if(i == 0) {
					$("#depth2").append(
						"<div style='color: white; background-color: rgb(70, 102, 128); border-top: 1px solid gray;' data-num='" + resp[i].categorynum + "' data-dept='" + resp[i].depth + "' data-idx='" + (parseInt(i)+1) + "' onclick='javascript:mediumCategoryClick(" + resp[i].categorynum + ")'>" + resp[i].categoryname + "</div>"
						+ "<span id='tooltipnum" + resp[i].categorynum + "' class='tooltiptext'>" + resp[i].categoryname + "</span>"
					);
				}
				else if(i == (resp.length-1)) {
					$("#depth2").append(
						"<div style='color: white; background-color: rgb(70, 102, 128); border-bottom: 1px solid gray;' data-num='" + resp[i].categorynum + "' data-dept='" + resp[i].depth + "' data-idx='" + (parseInt(i)+1) + "' onclick='javascript:mediumCategoryClick(" + resp[i].categorynum + ")'>" + resp[i].categoryname + "</div>"
						+ "<span id='tooltipnum" + resp[i].categorynum + "' class='tooltiptext'>" + resp[i].categoryname + "</span>"
					);
				}
				else {
					$("#depth2").append(
						"<div style='color: white; background-color: rgb(70, 102, 128);' data-num='" + resp[i].categorynum + "' data-dept='" + resp[i].depth + "' data-idx='" + (parseInt(i)+1) + "' onclick='javascript:mediumCategoryClick(" + resp[i].categorynum + ")'>" + resp[i].categoryname + "</div>"
						+ "<span id='tooltipnum" + resp[i].categorynum + "' class='tooltiptext'>" + resp[i].categoryname + "</span>"
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
				
				// 카테고리명의 길이가 너무 긴지 확인(28자 까지만 가능)
				if($(this).text().length >= 28) {
					var num = $(this).attr('data-num');					
					$("#tooltipnum" + num).attr('style','visibility:visible');
				}
				
				// 카테고리 소분류 가져오기
				idx2 = $(this).attr("data-idx");
				minerCategory($(this));
			});
			
			document.getElementById("depth2").style.zIndex = 1;
			document.getElementById("productContainer").style.zIndex = 0;
			
			// z-index 맨위로 올리기
			var noticeZindex = parseInt($(".tooltiptext").css("z-index"));
			var tooltiptextZindex = parseInt($("#notice").css("z-index"));
			
			noticeZindex++;
			$("#depth3").css({"z-index":noticeZindex});
			
			noticeZindex++;
			$("#depth2").css({"z-index":noticeZindex});
						
			$("#depth2").css("visibility","visible");
			
			// 중분류에서 마우스가 떠나면 툴팁창 숨기기
			$("#depth2 div").mouseleave(function(){
				$(".tooltiptext").attr('style','visibility:hidden');			
				
			});
			
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
	
	var lang = $('#lang').val();
	
	$.ajax({
		method : "get",
		url : "minerCategory",
		async: false,
		data : "categorynum=" + dataNum + "&lang=" + lang,
		success : function(resp) {
			
			$("#depth3").html('');
			
			var ht = ( (parseInt(idx1) * divHeight) + ((parseInt(idx2)-1) * divHeight) ) + "px";
			
			$("#depth3").css("top",ht);
			
			// 소분류 카테고리 출력
			for(var i in resp) {
				if(i == 0) {
					$("#depth3").append(
						"<div style='border-left: 3px solid black; border-top: 3px solid black; border-right: 3px solid black;' data-num='" + resp[i].categorynum + "' data-dept='" + resp[i].depth + "' data-idx='" + (parseInt(i)+1) + "' onclick='javascript:minorCategoryClick(" + resp[i].categorynum + ")'>" + resp[i].categoryname + "</div>"
						+ "<span id='tooltipnum" + resp[i].categorynum + "' class='tooltiptext'>" + resp[i].categoryname + "</span>"
					);
				}
				else if(i == (resp.length-1)) {
					$("#depth3").append(
						"<div style='border-left: 3px solid black; border-bottom: 3px solid black; border-right: 3px solid black;' data-num='" + resp[i].categorynum + "' data-dept='" + resp[i].depth + "' data-idx='" + (parseInt(i)+1) + "' onclick='javascript:minorCategoryClick(" + resp[i].categorynum + ")'>" + resp[i].categoryname + "</div>"
						+ "<span id='tooltipnum" + resp[i].categorynum + "' class='tooltiptext'>" + resp[i].categoryname + "</span>"
					);
				}
				else {
					$("#depth3").append(
						"<div style='border-left: 3px solid black; border-right: 3px solid black;' data-num='" + resp[i].categorynum + "' data-dept='" + resp[i].depth + "' data-idx='" + (parseInt(i)+1) + "' onclick='javascript:minorCategoryClick(" + resp[i].categorynum + ")'>" + resp[i].categoryname + "</div>"
						+ "<span id='tooltipnum" + resp[i].categorynum + "' class='tooltiptext'>" + resp[i].categoryname + "</span>"
					);
				}
			}
			
			// 중분류에서 마우스가 떠나면 툴팁창 숨기기
			$("#depth3 div").mouseenter(function(){
				// 카테고리명의 길이가 너무 긴지 확인(28자 까지만 가능)
				if($(this).text().length >= 28) {
					var num = $(this).attr('data-num');					
					$("#tooltipnum" + num).attr('style','visibility:visible');
				}	
			});
			
			// 중분류에서 마우스가 떠나면 툴팁창 숨기기
			$("#depth3 div").mouseleave(function(){
				$(".tooltiptext").attr('style','visibility:hidden');			
				
			});
			
			$("#depth3").css("visibility","visible");
		}
	});
	
	
}
</script>

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
/*   background-color: #fff; */
/*   color: #2ecc71; */
	cursor: pointer;
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

/* 검색 결과가 없을때 보여주는 태그 */
#searchEmpty {
    width: 600px;
    height: 427px;
    background-color: #FFFFFF;
    border-radius: 10px;
    line-height: 427px;
}

.pagingBtnCss {
	width: 20px;
	height: 20px;
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
<input id="userid" type="hidden" value="${sessionScope.loginId }">
<input id="myurl" type="hidden" value="${myurl}" />
<input id="lang" type="hidden" value="<spring:message code="common.lang" />">

<div id="container">

	<!-- 레이아웃(로고, 검색) -->
	<div id="layoutTop">
		<!-- 로고 -->
		<a href="${pageContext.request.contextPath}/search"><img id="logo" src="resources/search/image/logo.gif"/></a>
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
			<div class="pagination p8">
		      <ul>
<!-- 		      	<a href="#" id="pagingFirst"><li>first</li></a> -->
<!-- 		        <a href="#" id="pagingLeft"><li>prev</li></a> -->
<!-- 		        <span id="pagingNum"> -->
<!-- 				</span> -->
<!-- 		        <a href="#" id="pagingRight"><li>next</li></a> -->
<!-- 		        <a href="#" id="pagingLast"><li>last</li></a> -->
		        
		        <img class="pagingBtnCss" id="pagingFirst" src="resources/images/arrow7.png" />
		        <img class="pagingBtnCss" id="pagingLeft" src="resources/images/arrow8.png" />
		        <span id="pagingNum">
				</span>
		        <img class="pagingBtnCss" id="pagingRight" src="resources/images/arrow9.png" />
		        <img class="pagingBtnCss" id="pagingLast" src="resources/images/arrow10.png" />
		      </ul>
		    </div>
		    
		    <div id="listScroll">	
		    
		    	
			<c:if test="${empty list}">
				<div id="searchEmpty"><spring:message code="result.searchEmpty" /></div>
			</c:if>
			<c:if test="${not empty list}">
				<c:forEach var="ptList" items="${list}" varStatus="status">
					<c:if test="${status.first}">
						<input id="pnumFirst" type="hidden" value="${status.count + navi.startRecord}">
					</c:if>
					<c:if test="${status.last}">
						<input id="pnumLast" type="hidden" value="${status.count + navi.startRecord}">
						<div>
					</c:if>
					<c:if test="${!status.last}">
						<div>
					</c:if>
						<div class="productList" data-boardnum="${ptList.boardnum}">
							<div class="leftFrame">
								<div class="productImg">
									<c:if test="${!status.first}">
										<hr/>
									</c:if>									
									<img onError="this.src='resources/search/image/noimage.png'" src="${pageContext.request.contextPath}/boardfile/${ptList.savedfile}" width="100px" height="100px">
									
								</div>
							</div>
							
							<div class="rightFrame">
								<c:if test="${!status.first}">
									<hr/>
								</c:if>
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
		</div>
		<!-- 프로필 -->
		<div id="profile">
		
			<div id="profilePicture">
				<img src="resources/search/image/jennifer.jpg" width="100px">
			</div>
			<div id="myPageClick" class="profileBtn"><spring:message code="search.profileBtn.myPageClick" /></div>
			<div id="myStoreClick" class="profileBtn"><spring:message code="search.profileBtn.myStoreClick" /></div>
			<div id="myInfoClick" class="profileBtn"><spring:message code="search.profileBtn.myInfoClick" /></div>
			<div id="logoutClick" class="profileBtn"><spring:message code="search.profileBtn.logoutClick" /></div>
		</div>
		
		<!-- 채팅창 -->
		<div id="chat">
		</div>
		<div id="custom-search-input2">
			<div class="input-group col-md-12">				
				<input id="message" type="text" class="  search-query form-control" value="" /> <span class="input-group-btn">
					<button id="chatBtnClick" class="btn btn-danger" type="button">					
						<span class="glyphicon glyphicon-pencil"></span>
					</button>
				</span>
			</div>
		</div>
	</div>
	
</div>

</body>
<script type="text/javascript">
		var msgHeightAdd = 0;
		var userid = "";
		
		$(document).ready(function() {
			userid = $("#userid").val();
			
			$("#chatBtnClick").click(function() {
				sendMessage();
				$('#message').val('');
			});

			$("#message").keydown(function(key) {
				if (key.keyCode == 13) {// 엔터
					sendMessage();
					$('#message').val('');
				}
			});
        });
		
		// 해당 ID에 맞는 홈피 열기
		function openMiniHome(obj) {
			var uri = "myStore/" + $(obj).attr('data-id');
			
			window.open(uri,"mystoreWindow","width=1200, height=650");
		}

        // 웹소켓을 지정한 url로 연결한다.
        let sock = new SockJS("<c:url value="/echo"/>");

        sock.onmessage = onMessage;
        sock.onclose = onClose;

        // 메시지 전송
        function sendMessage() {
        	var tag = "&nbsp;<a href='javascript:void(0);' onclick='openMiniHome(this);' data-id='" + userid + "' style='text-decoration:none;'>" + userid + "</a>" + " : " + $("#message").val() + "<br/>";
        	
        	
        	
        	
        	sock.send(tag);
        	//sock.send( + $("#message").val());
        }

        // 서버로부터 메시지를 받았을 때
        function onMessage(msg) {
        	var data = msg.data;
        	
        	$("#chat").append(data);
        	msgHeightAdd = msgHeightAdd + 20;
        	$("#chat").scrollTop(($("#chat").height() + msgHeightAdd));
        }

        // 서버와 연결을 끊었을 때
        function onClose(evt) {
        	$("#chat").append("연결 끊김");
        }

</script>

</html>