<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>SETTING</title>
<script type="text/javascript" src="resources/jquery-3.3.1.min.js"></script>
<script>
	
</script>
<style>
::-webkit-scrollbar{width: 16px;}
::-webkit-scrollbar-track {background-color:AE79F1;}
::-webkit-scrollbar-thumb {background-color:#79bfe5;}
::-webkit-scrollbar-thumb:hover {background: #79bfe5;}
::-webkit-scrollbar-button:start:decrement,::-webkit-scrollbar-button:end:increment {
	width:16px;height:16px;background:#79bfe5;} 

@import url(//fonts.googleapis.com/earlyaccess/jejugothic.css);
	li {
		list-style:none;
	}
	
	body {
		background: url('resources/images/mystore.png') no-repeat center center fixed; 
 		-webkit-background-size: cover;
  		-moz-background-size: cover;
  		-o-background-size: cover;
  		background-size: cover;
	}
	
	#wrapper {
		border-radius: 25px;
		border-style: dotted;
		background-color: #fff9e7;
		width:1180px;
		height:545px;
		padding-top: 5px;
		padding-left: 5px;
		padding-right: 0px;
		border-color: #fff9e7;
	}
	
	#edit {
		width: 1081px;
		height: 545px;
		border-radius: 25px;
		background-color: white;
		padding-top: 5px;
		padding-bottom: 5px;
	}
	
	
	ul, list, dir {
    	display: block;
   		list-style-type: disc;
    	-webkit-margin-before: 1em;
    	-webkit-margin-after: 1em;
   	 	-webkit-margin-start: 0px;
   	 	-webkit-margin-end: 0px;
    	-webkit-padding-start: 0px;
    	-webkit-padding-end: 0px;
	}
	
	.menu {
		border: 1px solid #79bfe5;
    	padding: 10px;
   		border-radius: 10px;
   		background-color: #79bfe5;
   		margin : 0 auto;
   		text-align:left;
   		width: 600px;
		color: #414244;
	}
	
	h1 {
		font-family: Eco Sans Mono;
	}
	
	body {
		font-family: 'Jeju Gothic', sans-serif;
	}
	
	
</style>
</head>
<body>
<div id="wrapper" align="center">
	<div id="scroll" style="float:left; width: 1081px; height:545px; overflow-y:auto; overflow-x:hidden; border-radius: 25px; background-color: white;">
		<div id="edit">
			<h1><b>Edit My Store</b></h1>
			<hr/>
		</div>
	</div>
	<div id="list" style="float:left; width: 90px; text-align:right; height:545px;">
		<ul>
			<li><a href="myStore"><img src="resources/images/home.png" style="width:90px; height:50px;"></a></li>
			<li><a href="give"><img src="resources/images/give.png" style="width:90px; height:50px;"></a></li>
			<li><a href="trade"><img src="resources/images/trade.png" style="width:90px; height:50px;"></a></li>
			<li><a href="talent"><img src="resources/images/talent.png" style="width:90px; height:50px;"></a></li>
			<li><a href="review"><img src="resources/images/review.png" style="width:90px; height:50px;"></a></li>
			<li><a href="setting"><img src="resources/images/setting.png" style="width:90px; height:50px;"></a></li>
		</ul>
	</div>
	
</div>
</body>
</html>