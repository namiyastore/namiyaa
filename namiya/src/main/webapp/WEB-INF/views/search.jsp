<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>jQuery UI Menu - Default functionality</title>

<!-- 카테고리 -->
<link rel="stylesheet" href="resources/search/css/common/jquery-ui.css">
<script src="resources/search/js/common/jquery-1.12.4.js"></script>
<script src="resources/search/js/common/jquery-ui.js"></script>

<!-- 검색 -->
<link href="resources/search/css/search/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<!-- <script src="resources/main/js/search/jquery-1.11.1.min.js"></script> -->
<!-- <script src="resources/main/js/search/bootstrap.min.js"></script> -->

<script>
	$(function() {
		// 카테고리 디자인 적용
		$("#menu").menu();
		
		$("li > div").mouseover(function(){
			var dept = $(this).attr("data-dp");
			
			if(dept == 1) {
				$(this).css("color","white");
				$(this).css("backgroundColor","#466680");
			}
			else if(dept == 2) {
				$(this).css("color","white");
				$(this).css("backgroundColor","red");
			}
		});
		
		$("li > div").mouseout(function(){
			var dept = $(this).attr("data-dp");
			
			if(dept == 1 || dept == 2) {
				$(this).css("color","black");
				$(this).css("backgroundColor","white");
			}
		});
		
		// 검색 버튼 클릭
		$(".btn-danger").on("click", function(){
			location.href = "result";
		});
		
	});
	
	
</script>
<style>

body {
	background-color: #2A3D4C;
}

/* 메인프레임 */
#container{
	margin: 0 auto;
	width: 1000px;
}

/* 카테고리 */
.ui-menu {
	position: absolute;
	top: 0px;
	left: 0px;
	width: 200px;
}

/* 로고 */
#logo {
	margin-top: 50px;
	position: relative;	
	width: 150px;
	left: 425px;
}

/* 검색 */
#custom-search-input {
	position: relative;
	top: 25px;
	left: 350px;
	width: 300px;
}

/* 거래 외침 내용 */
#notice {
	margin-top: 50px;
	margin-left: 350px;
	height: 250px;
	width: 300px;
	background-color: #FFFFFF;
	
	overflow: auto;
	overflow: scroll;
}

/* 프로필 */
#profile {
	position: absolute;
	width: 300px;
	top: 0px;
	left: 77%;
	right: 0%;
	background-color: #FFFFFF;
}

/* 거래 외침 폰트 */
#notice a {
	color: #000000;
	text-decoration: none;
}

/* 프로필 */
#profile {
	margin: 0 auto;
	border-radius: 5px;
}

/* 프로필 사진 프레임 */
#profilePicture {
	margin: 0 auto;
	margin-top: 20px;
	width: 300px;
}

/* 이미지 테두리 */
#profilePicture > img {
	border-radius: 5px;
}

/* 프로필 버튼 */
.profileBtn {
	margin: 20px;
	margin-left: 50px;
	
	text-align: center;
	font-size: 1.5em;
	
	border: 1px solid;
	border-radius: 5px;
	
	width: 200px;
	height: 40px;
	
	line-height: 1.6em;
	
	cursor: pointer;
	
	background-color: #2A3D4C;
	color: #FFFFFF;
	
}

/* 프로필 버튼 ( on mouse ) */
.profileBtn:hover {
	background-color: #FFFFFF;
	color: #2A3D4C;
}

</style>
</head>
<body>

<div id="container">
	<!-- 카테고리 -->
	<ul id="menu">
		<li class="ui-state-disabled"><div>전체 카테고리</div></li>
		<li><div>브랜드패션</div></li>
		<li><div>의류/잡화</div></li>
		<li><div>뷰티</div></li>
		<li><div>레저/자동차</div></li>
		<li><div>식품</div></li>
		<li><div>출산/육아</div></li>
		<li><div>생활/건강</div></li>
		<li><div>가구/인테리어</div></li>
		<li><div>디지털/가전/컴퓨터</div></li>
		<li><div>도서/취미/반려동물</div></li>
		<li><div>여행/공연/e쿠폰</div></li>
		<li><div>test</div>
			<ul>
				<li><div data-dp="1">Car Hifi</div></li>
				<li><div data-dp="1">Utilities</div></li>
			</ul></li>
		<li><div>Movies</div></li>
		<li><div>Music</div>
			<ul>
				<li><div data-dp="1">Rock</div>
					<ul>
						<li><div data-dp="2">Alternative</div></li>
						<li><div data-dp="2">Classic</div></li>
					</ul></li>
				<li><div data-dp="1">Jazz</div>
					<ul>
						<li><div data-dp="2">Freejazz</div></li>
						<li><div data-dp="2">Big Band</div></li>
						<li><div data-dp="2">전동레저/인라인/킥보드</div></li>
					</ul></li>
				<li><div data-dp="1">Pop</div></li>
			</ul></li>
	</ul>

	<!-- 검색 -->
	<div>
		<img id="logo" src="resources/search/image/logo.jpg" />
	</div>
	<div id="custom-search-input">
		<div class="input-group col-md-12">
			<input type="text" class="  search-query form-control"
				placeholder="Search" /> <span class="input-group-btn">
				<button class="btn btn-danger" type="button">
					<span class=" glyphicon glyphicon-search"></span>
				</button>
			</span>
		</div>
	</div>


	<div id="notice">
		<a href="#">&nbsp;1111111111111111111</a><br/>
		<a href="#">&nbsp;2222222222222222222</a><br/>
		<a href="#">&nbsp;3333333333333333333</a><br/>
		<a href="#">&nbsp;4444444444444444444</a><br/>
		<a href="#">&nbsp;5555555555555555555</a><br/>
		<a href="#">&nbsp;6666666666666666666</a><br/>
		<a href="#">&nbsp;7777777777777777777</a><br/>
		<a href="#">&nbsp;8888888888888888888</a><br/>
		<a href="#">&nbsp;9999999999999999999</a><br/>
		<a href="#">&nbsp;1010101010101010101</a><br/>
		<a href="#">&nbsp;1010101010101010101</a><br/>
		<a href="#">&nbsp;1010101010101010101</a><br/>
		<a href="#">&nbsp;1010101010101010101</a><br/>
		<a href="#">&nbsp;1010101010101010101</a><br/>
		<a href="#">&nbsp;1010101010101010101</a><br/>
	</div>

	<div id="profile">
		<div id="profilePicture" align="center">
			<img src="resources/search/image/jennifer.jpg" width="200px">
		</div>
		<div class="profileBtn">My Page</div>
		<div class="profileBtn">My Store</div>
		<div class="profileBtn">Logout</div>
	</div>

</div>

</body>
</html>