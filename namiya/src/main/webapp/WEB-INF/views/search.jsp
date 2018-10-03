<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>MAKANAI</title>
<link href="https://fonts.googleapis.com/css?family=Nanum+Gothic" rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Raleway:600" rel="stylesheet">
<style>
::-webkit-scrollbar{width: 16px;}
::-webkit-scrollbar-track {background-color:AE79F1;}
::-webkit-scrollbar-thumb {background-color:#79bfe5;}
::-webkit-scrollbar-thumb:hover {background: #79bfe5;}
::-webkit-scrollbar-button:start:decrement,::-webkit-scrollbar-button:end:increment {
   width:16px;height:16px;background:#79bfe5;} 
   
	body {
		font-family: 'Raleway', 'Nanum Gothic';
	}
</style>
<!-- 카테고리 -->
<script src="resources/search/js/common/jquery-1.12.4.js"></script>

<!-- 검색 -->
<link href="resources/search/css/search/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<link href="resources/search/css/search/search.css" rel="stylesheet">

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
							
var myurl = "";		// 고유 url
var lang = "";

var alarmMax = 0;	// 실시간 알림글 가장 최근 번호

$(function(){
	
	// 카테고리 대분류 가져오기
	majorCategory();
	
	myurl = $("#myurl").val();
	lang = $("#lang").val();
	
	$("#sideMenu").mouseleave(function(){		
		$("#depth2").css("visibility","hidden");
		$("#depth3").css("visibility","hidden");
		
		$("#depth1 div").css("backgroundColor","#FFFFFF");
		$("#depth1 div").css("color","#000000");
	});
	
	// 위치 초기화( 거래 알림창, 프로필 )
	setPositionInit();
	
	var userid = $('#userid').val();
	
	// 미니홈피 창 열기
	$("#myStoreClick").on("click",function(){
		// 메세지 전송
		// message -> 전할 내용
		// receive -> 받을상대 id
		
		var myurl = $('#myurl').val();
		window.open("myStore/" + myurl + "/home","mystoreWindow","width=1200, height=650");
	});
	
	// 마이 페이지 이동
	$("#myPageClick").on("click",function(){
		location.href = "interestList";
	});
	
	// 로그아웃
	$("#logoutClick").on("click",function(){
		location.href = "logout";
	});
	
	// 창 크기에 따라 좌표 지정 ( 창크기 변경 감지 )
	$( window ).resize( function() {
		// < 알림창 위치 >
		
		// 카테고리 위치값
		var left_category = $("#sideMenu").offset().left;
		var top_category = $("#sideMenu").offset().top;
		
		// 거래 알림창 위치 지정
		$("#notice").css("position", "absolute")
			.css("top", "61px")
			.css("left", (parseInt(left_category)+250) + "px")
			.css("margin-top","40px")
		
		document.getElementById("sideMenu").style.zIndex = 1;
		
		// < 프로필 위치 >
		
		// 거래 알림창 위치값
		var left_notice = $("#notice").offset().left;
		var top_notice = $("#notice").offset().top;
		
		// 프로필 위치 지정
		$('#profile').css("position", "absolute")
			.css("top", "101px")
			.css("left", (parseInt(left_notice)+600) + "px")
			.css("margin-left","50px");
		
		// < 채팅창 위치 >
		
		// 채팅창 위치조정
		$("#chat").css("position", "absolute")
			.css("top", 350 + "px")
			.css("left", (parseInt(left_notice)+650) + "px");
		
		// 채팅창 검색버튼 위치조정	
		$("#custom-search-input2").css("position","absolute")
			.css("top", 560 + "px")
			.css("left", (parseInt(left_notice)+650) + "px");
		
		// 파이차트 위치조정
		$("#flot-pie-chart-wrapper").css("position","absolute")
			.css("top", 630 + "px")
			.css("left", (parseInt(left_notice)+650) + "px");
		
		// 배경화면 다시 고정
		$("body").css("background-image","resources/images/background.png")
		.css("background-attachment","fixed");
		
		$('body').css('height', (window.innerHeight)+'px');
		$('body').css('width', (window.innerWidth)+'px');
	});
	
	function setPositionInit() {
		
		// 카테고리 위치값
		var left_category = $("#sideMenu").offset().left;
		var top_category = $("#sideMenu").offset().top;
		
		// 거래 알림창 위치 지정
		$("#notice").css("position", "absolute")
			.css("top", "101px")
			.css("left", (parseInt(left_category)+250) + "px");
		
		document.getElementById("sideMenu").style.zIndex = 1;
		
		
		// 거래 알림창 위치값
		var left_notice = $("#notice").offset().left;
		var top_notice = $("#notice").offset().top;
		
		// 프로필 위치 지정
		$("#profile").css("position", "absolute")
			.css("top", top_notice)
			.css("left", (parseInt(left_notice)+600) + "px")
			.css("margin-left","50px");
		
		// 채팅창 위치조정
		$("#chat").css("position", "absolute")
			.css("top", 350 + "px")
			.css("left", (parseInt(left_notice)+650) + "px");
		
		// 채팅창 검색버튼 위치조정	
		$("#custom-search-input2").css("position","absolute")
			.css("top", 560 + "px")
			.css("left", (parseInt(left_notice)+650) + "px");
		
		// 파이차트 위치조정
		$("#flot-pie-chart-wrapper").css("position","absolute")
			.css("top", 630 + "px")
			.css("left", (parseInt(left_notice)+650) + "px");
		
		$('body').css('height', (window.innerHeight)+'px');
		$('body').css('width', (window.innerWidth)+'px');
	}
	
	// 검색(버튼)
	$("#searchBtnClick").on("click",function(){
		var searchWord = $(".form-control").val();
		var currentPage1 = $("#currentPage").val();
		
		if(!currentPage1) {
			currentPage1 = 1;
		}
		
		location.href="result?currentPage1=" + currentPage1 + "&searchWord=" + searchWord + "&myurl=" + myurl + "&searchFlag=on";
	});
	
	// 검색(엔터)
	$('#searchText').keydown(function(key){
		if(key.keyCode == 13) {
			var searchWord = $(".form-control").val();
			var currentPage1 = $("#currentPage").val();
			
			if(!currentPage1) {
				currentPage1 = 1;
			}
			
			location.href="result?currentPage1=" + currentPage1 + "&searchWord=" + searchWord + "&myurl=" + myurl + "&searchFlag=on";
		}
	});
	
	// 실시간 목록 초기화(처음 한번만 10개 가져오기)
	$.ajax({
		method : "get",
		url : "searchPageInit",
		success : function(resp) {
			alarmMax = resp[0].boardnum;
			
			var val = "";
			for(var i in resp) {
				val += '<hr/>';
				val += '<div class="noticeItem" data-service="' + resp[i].service + '" data-boardnum="' + resp[i].boardnum + '">'; 
				val += '<div class="noticeItemDisplay" id="noticeItemContent">';
					
				val += '<div id="noticeText">';
				if(lang == 'ko') {
					val += '<h3>&nbsp;&nbsp;&nbsp;&nbsp;[ ' + resp[i].service + ' ]</h3>';	
				}
				else if(lang == 'ja') {
					if(resp[i].service == '양도') {
						val += '<h3>&nbsp;&nbsp;&nbsp;&nbsp;[ お譲り ]</h3>';	
					}
					else if(resp[i].service == '재능기부') {
						val += '<h3>&nbsp;&nbsp;&nbsp;&nbsp;[ 才能寄付 ]</h3>';
					}
					else if(resp[i].service == '교환') {
						val += '<h3>&nbsp;&nbsp;&nbsp;&nbsp;[ 交換 ]</h3>';
					}
				}
				else if(lang == 'en') {
					if(resp[i].service == '양도') {
						val += '<h3>&nbsp;&nbsp;&nbsp;&nbsp;[ Transfer ]</h3>';	
					}
					else if(resp[i].service == '재능기부') {
						val += '<h3>&nbsp;&nbsp;&nbsp;&nbsp;[ Talent donation ]</h3>';
					}
					else if(resp[i].service == '교환') {
						val += '<h3>&nbsp;&nbsp;&nbsp;&nbsp;[ barter ]</h3>';
					}
				}
				
				val += '&nbsp;&nbsp;&nbsp;&nbsp;' + resp[i].content;
				val += '</div>';
				val += '<div id="noticeDate">';
				val += resp[i].regdate;
				val += '</div>';
				val += '</div>';
				val += '<img onError="this.src=' + "'" + 'resources/search/image/noimage.png' + "'" + '" id="noticePic" class="noticeItemDisplay" width="100px" height="100px" src="home/img/boardfile/' + resp[i].savedfile + '">';
				
				val += '</div>';
			}
			
			$("#notice").prepend(val);
			
			$('.noticeItem').off().on('click', function(){
				var boardnum = $(this).attr('data-boardnum');
				var service = $(this).attr('data-service');
				
				$.ajax({
					method : 'get',
					url : 'getMyurl?boardnum=' + boardnum,
					success : function(myurl){
						if(service == '양도') {
							window.open("myStore/" + myurl + "/giveView?boardnum=" + boardnum,"mystoreWindow","width=1200, height=650");
						}
						else if(service == '교환') {
							window.open("myStore/" + myurl + "/tradeView?boardnum=" + boardnum,"mystoreWindow","width=1200, height=650");
						}
						else if(service == '재능기부') {
							window.open("myStore/" + myurl + "/talentView?boardnum=" + boardnum,"mystoreWindow","width=1200, height=650");
						}
					}
				});
				
			});
		}
	
	});
	
	// 실시간 목록 가져오기
	var lang = $('#lang').val();
	
	function noticeRealtime() {
		$.ajax({
			method : "get",
			url : "noticeForAll?lang=" + lang,
			dataType : "json",
			success : function(resp) {
				
				var val = "";				
				if(resp != null) {
					if(alarmMax < resp.boardnum) {
						val += '<hr/>';
						val += '<div class="noticeItem" data-service="' + resp.service + '" data-boardnum="' + resp.boardnum + '">'; 
						val += '<div class="noticeItemDisplay" id="noticeItemContent">';
							
						val += '<div id="noticeText">';
						val += '<h3>&nbsp;&nbsp;&nbsp;&nbsp;[ ' + resp.service + ' ]</h3>';
						
						val += '&nbsp;&nbsp;&nbsp;&nbsp;' + resp.content;
						val += '</div>';
						val += '<div id="noticeDate">';
						val += resp.regdate;
						val += '</div>';
						val += '</div>';
						val += '<img onError="this.src=' + "'" + 'resources/search/image/noimage.png' + "'" + '" id="noticePic" class="noticeItemDisplay" width="100px" height="100px" src="home/img/boardfile/' + resp.savedfile + '">';
						
						val += '</div>';					
					
						$("#notice").prepend(val);
						
						alarmMax = resp.boardnum;
					}
					
					$('.noticeItem').off().on('click', function(){
						var boardnum = $(this).attr('data-boardnum');
						var service = $(this).attr('data-service');
						
						$.ajax({
							method : 'get',
							url : 'getMyurl?boardnum=' + boardnum,
							success : function(myurl){
								if(service == '양도') {
									window.open("myStore/" + myurl + "/giveView?boardnum=" + boardnum,"mystoreWindow","width=1200, height=650");
								}
								else if(service == '교환') {
									window.open("myStore/" + myurl + "/tradeView?boardnum=" + boardnum,"mystoreWindow","width=1200, height=650");
								}
								else if(service == '재능기부') {
									window.open("myStore/" + myurl + "/talentView?boardnum=" + boardnum,"mystoreWindow","width=1200, height=650");
								}
							}
						});
						
					});
				}
			}
		});
	}
	
	var bgSize = (window.innerWidth || document.body.clientWidth) + "px " + (window.innerHeight || document.body.clientHeight) + "px";
	
	$('body').css('backgroundSize', bgSize);
	$('body').css('height', '1100px');
	
	setInterval(noticeRealtime, 5000);
	
});



// 대분류 클릭 이벤트 함수
function majorCategoryClick(categorynum) {
	location.href = "result?currentPage2=1" + "&parentnum=" + categorynum + "&categoryGroup=major" + "&myurl=" + myurl;
}

// 중분류 클릭 이벤트 함수
function mediumCategoryClick(categorynum) {
	location.href = "result?currentPage3=1" + "&parentnum=" + categorynum + "&categoryGroup=medium" + "&myurl=" + myurl;
}

// 소분류 클릭 이벤트 함수
function minorCategoryClick(categorynum) {
	location.href = "result?currentPage4=1" + "&parentnum=" + categorynum + "&categoryGroup=minor" + "&myurl=" + myurl;
}

function majorCategory() {
	
	var lang = $('#lang').val();
	
	$.ajax({
		method : "get",
		url : "majorCategory?lang=" + lang,
		success : function(resp) {			
			for(var i in resp) {
				if(i == 0) {
					if(resp.length > 1) {
						$("#depth1").append(
							"<div style='border-top: 1px solid gray;' data-num='" + resp[i].categorynum + "' data-dept='" + resp[i].depth + "' data-idx='" + (parseInt(i)+1) + "' onclick='javascript:majorCategoryClick(" + resp[i].categorynum + ")' >" + resp[i].categoryname + "</div>"
							+ "<span id='tooltipnum" + resp[i].categorynum + "' class='tooltiptext'>" + resp[i].categoryname + "</span>"
						);
					}
					else {
						$("#depth1").append(
							"<div style='border-top: 1px solid gray; border-bottom: 1px solid gray;' data-num='" + resp[i].categorynum + "' data-dept='" + resp[i].depth + "' data-idx='" + (parseInt(i)+1) + "' onclick='javascript:majorCategoryClick(" + resp[i].categorynum + ")' >" + resp[i].categoryname + "</div>"
							+ "<span id='tooltipnum" + resp[i].categorynum + "' class='tooltiptext'>" + resp[i].categoryname + "</span>"
						);
					}
				}
				else if(i == (resp.length-1)) {
					$("#depth1").append(
						"<div style='border-bottom: 1px solid gray;' data-num='" + resp[i].categorynum + "' data-dept='" + resp[i].depth + "' data-idx='" + (parseInt(i)+1) + "' onclick='javascript:majorCategoryClick(" + resp[i].categorynum + ")' >" + resp[i].categoryname + "</div>"
						+ "<span id='tooltipnum" + resp[i].categorynum + "' class='tooltiptext'>" + resp[i].categoryname + "</span>"
					);
				}
				else {
					$("#depth1").append(
						"<div data-num='" + resp[i].categorynum + "' data-dept='" + resp[i].depth + "' data-idx='" + (parseInt(i)+1) + "' onclick='javascript:majorCategoryClick(" + resp[i].categorynum + ")' >" + resp[i].categoryname + "</div>"
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
					if(resp.length > 1) {
						$("#depth2").append(
							"<div style='color: white; background-color: rgb(70, 102, 128); border-top: 1px solid gray;' data-num='" + resp[i].categorynum + "' data-dept='" + resp[i].depth + "' data-idx='" + (parseInt(i)+1) + "' onclick='javascript:mediumCategoryClick(" + resp[i].categorynum + ")'>" + resp[i].categoryname + "</div>"
							+ "<span id='tooltipnum" + resp[i].categorynum + "' class='tooltiptext'>" + resp[i].categoryname + "</span>"
						);
					}
					else {
						$("#depth2").append(
								"<div style='color: white; background-color: rgb(70, 102, 128); border-top: 1px solid gray; border-bottom: 1px solid gray;' data-num='" + resp[i].categorynum + "' data-dept='" + resp[i].depth + "' data-idx='" + (parseInt(i)+1) + "' onclick='javascript:mediumCategoryClick(" + resp[i].categorynum + ")'>" + resp[i].categoryname + "</div>"
								+ "<span id='tooltipnum" + resp[i].categorynum + "' class='tooltiptext'>" + resp[i].categoryname + "</span>"
							);
					}
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
			document.getElementById("notice").style.zIndex = 0;
			
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
					if(resp.length > 1) {
						$("#depth3").append(
							"<div style='border-left: 3px solid black; border-top: 3px solid black; border-right: 3px solid black;' data-num='" + resp[i].categorynum + "' data-dept='" + resp[i].depth + "' data-idx='" + (parseInt(i)+1) + "' onclick='javascript:minorCategoryClick(" + resp[i].categorynum + ")'>" + resp[i].categoryname + "</div>"
							+ "<span id='tooltipnum" + resp[i].categorynum + "' class='tooltiptext'>" + resp[i].categoryname + "</span>"
						);
					}
					else {
						$("#depth3").append(
							"<div style='border-left: 3px solid black; border-top: 3px solid black; border-bottom: 3px solid black; border-right: 3px solid black;' data-num='" + resp[i].categorynum + "' data-dept='" + resp[i].depth + "' data-idx='" + (parseInt(i)+1) + "' onclick='javascript:minorCategoryClick(" + resp[i].categorynum + ")'>" + resp[i].categoryname + "</div>"
							+ "<span id='tooltipnum" + resp[i].categorynum + "' class='tooltiptext'>" + resp[i].categoryname + "</span>"
						);
					}
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
<input id="lang" type="hidden" value="<spring:message code="common.lang" />">
<input id="myurl" type="hidden" value="${myurl}" />
<input id="nickname" type="hidden" value="${profile.nickname}" />

<div id="container">

	<!-- 레이아웃(로고, 검색) -->
	<div id="layoutTop">
		<!-- 로고 -->
		<a href="${pageContext.request.contextPath}/search"><img id="logo" src="resources/search/image/logo.gif"/></a>
		
		<!-- 검색 -->
		<div id="custom-search-input">
			<div class="input-group col-md-12">				
				<input id="searchText" type="text" class="  search-query form-control" placeholder="Search" value="${searchWord}" /> <span class="input-group-btn">
					<button id="searchBtnClick" class="btn btn-danger" type="button">
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
		<div id="notice"></div>
	
		<!-- 프로필 -->
		<div id="profile">
		
			<div id="profilePicture">			
				<img onError="this.src='resources/images/human.png'" src="${pageContext.request.contextPath}/home/img/profile/${profile.savedfile}" width="80px" height="80px">
			</div>
			<div id="myPageClick" class="profileBtn"><spring:message code="search.profileBtn.myPageClick" /></div>
			<div id="myStoreClick" class="profileBtn"><spring:message code="search.profileBtn.myStoreClick" /></div>
			<div id="logoutClick" class="profileBtn"><spring:message code="search.profileBtn.logoutClick" /></div>
		</div>
		
		<!-- 채팅창 -->
		<div id="chat">
		</div>
		<div id="custom-search-input2">
			<div class="input-group col-md-12">				
				<input id="message" type="text" class="  search-query form-control" value="" /> <span class="input-group-btn">
					<button id="chatBtnClick" class="btn btn-danger" type="button">
						<span class=" glyphicon glyphicon-pencil"></span>
					</button>
				</span>
			</div>
		</div>
	</div>
	
	<div id="flot-pie-chart-wrapper">
		<div>
			<h3 id="pieChartTitle">
				<spring:message code="search.pieChartTitle" />
			</h3>
		</div>
		<div id="flot-pie-chart"></div>
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
			var uri = "myStore/" + $(obj).attr('data-id') + "/home";
			
			window.open(uri,"mystoreWindow","width=1200, height=650");
		}

        // 웹소켓을 지정한 url로 연결한다.
        let sock = new SockJS("<c:url value="/echo"/>");

        sock.onmessage = onMessage;
        sock.onclose = onClose;

        // 메시지 전송
        function sendMessage() {
        	var tag = "&nbsp;<a href='javascript:void(0);' onclick='openMiniHome(this);' data-id='" + userid + "' style='text-decoration:none;'>" + $('#nickname').val() + "</a>" + " : " + $("#message").val() + "<br/>";
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

<!-- Flot Charts JavaScript -->
<script src="resources/search/js/search/flotchart/jquery.min.js"></script>
<script src="resources/search/js/search/flotchart/excanvas.min.js"></script>
<script src="resources/search/js/search/flotchart/jquery.flot.js"></script>
<script src="resources/search/js/search/flotchart/jquery.flot.pie.js"></script>
<script src="resources/search/js/search/flotchart/jquery.flot.resize.js"></script>
<script src="resources/search/js/search/flotchart/jquery.flot.time.js"></script>
<script src="resources/search/js/search/flotchart/jquery.flot.tooltip.min.js"></script>
<script src="resources/search/js/search/flotchart/flot-data.js"></script>

</html>