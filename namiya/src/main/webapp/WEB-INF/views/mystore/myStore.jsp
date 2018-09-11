<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 
<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<title>My store main</title>
<!-- <script type="text/javascript" src="resources/jquery-3.3.1.min.js"></script> -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script>
	
var background = {
    	'width' : 700,
    	'height': 350
    };
    var i = 0;
    var canvas;
	var context ;
    var imgList = [];
    var gifTimer = null;
    var drawTimer = null;
    var tempList = []; // 가비지 콜렉터가 현재 gif배경에서는 안일어나게 하기위해....
    var clothesList = [];

    function drawPicture(context, x, y, list) { // context is the canvas 2d context.
	    for(var a = 0; a<list.length; a++) {
	    	context.drawImage(list[a].source,list[a].px,list[a].py,list[a].width,list[a].height);
	    	if(list[a].type == "minimi") { // 옷그리기
	    		drawCloth(context,list[a]);
	    	}
	    }
	 }

	function drawCloth(context, minimiImage) {
		/* context.drawImage(clothesList[0].source,minimiImage.px,minimiImage.py,clothesList[0].width,clothesList[0].height);	
		context.drawImage(clothesList[1].source,minimiImage.px,Number(minimiImage.py) + 65,clothesList[1].width,clothesList[1].height);
		context.drawImage(clothesList[2].source,minimiImage.px,Number(minimiImage.py) + 90 ,clothesList[2].width,clothesList[2].height); */
context.drawImage(clothesList[0].source,minimiImage.px,minimiImage.py,minimiImage.width,minimiImage.height);	
context.drawImage(clothesList[1].source,minimiImage.px,minimiImage.py,minimiImage.width,minimiImage.height);	
context.drawImage(clothesList[2].source,minimiImage.px,minimiImage.py,minimiImage.width,minimiImage.height);	
	}
	
	function setGifPicture(context, x, y, list) { // context is the canvas 2d context.
	    for(var a = 0; a<list.length; a++) {
	    	if(list[a].type == "background") {
	    		list[a].currentframe = (list[a].currentframe + 1) % list[a].totalframes;
	    		var img = new Image();
	    		var name = 'resources/img/'+list[a].type+'/'+list[a].filename+'/'+list[a].filename+list[a].currentframe+'.png';
	    		img.src = name;
	    		img.onload = imageChanged(list[a],img); 
	    	}
	    }    	    
 	}
	
	function loadGifPicture() { 
	    for(var a = 1; a<imgList[0].totalframes; a++) {
	    	
	    	var img = new Image();
	    	var name = 'resources/img/'+imgList[0].type+'/'+imgList[0].filename+'/'+imgList[0].filename+a+'.png';
	    	img.src = name;
	    	img.onload = imageLoaded;
	    	tempList.push(img);
	    }    	    
 	}
	
	function onBodyLoad() { // <body onload='onBodyLoad()'>...
    	canvas = document.getElementById('myCanvas');
    	context = canvas.getContext("2d");
    	count = ${fn:length(list)} + ${list[0].TOTALFRAMES} -1; // 메뉴 4개 추가 + 배경이 gif일때
    	 <c:forEach items="${list}" var="item" varStatus ="status">
		setImage("${item.TOTALFRAMES}","${item.CURRENTFRAME}","${item.WIDTH}","${item.HEIGHT}",
			"${item.FILENAME}","${item.PX}","${item.PY}","${item.IMAGEORDER}","${item.TYPE}","${item.ITEMNUM}");
		</c:forEach>
    
		loadGifPicture();
    	
    }
	
	 $(document).ready(function() {
		 onBodyLoad();
	 });
	 
	 function setImage(totalframes,currentframe,width,height,filename,px,py,imageorder,type,itemnum) {
	    	var imgObject = {
	                'source': null,
	                'totalframes': 1,
	                'currentframe': 0,
	                'width': 0,
	                'height': 0,
	           	    'filename' : null,
	           	    'px' : 0,
	                'py' : 0,
	                'imageorder' : -1,
	                'type' : null,
	                'itemnum' : -1
	                
	           	};
	    	imgObject.totalframes = totalframes;
	    	imgObject.currentframe = currentframe;
	    	imgObject.width = width;
	    	imgObject.height = height;
	    	imgObject.px = px;
	    	imgObject.py = py;
	    	imgObject.filename = filename;
	    	imgObject.imageorder = imageorder;
	    	imgObject.type = type;
	    	imgObject.itemnum = itemnum;
	    	var name;
			if(type == "background")
				name = 'resources/img/'+imgObject.type+'/'+imgObject.filename+'/'+imgObject.filename+imgObject.currentframe+'.png';
			else	
				name = 'resources/img/'+imgObject.type+'/'+imgObject.filename+imgObject.currentframe+'.png';
	    	var img = new Image();
	    	img.src = name;
	    	img.onload = imageLoaded;
	    	imgObject.source = img;
	    	if(type == "background")
	    		tempList.push(img);
	    	if(type == "furniture" || type == "background" || type == "minimi") {
				imgList.push(imgObject);
	    	}else if(type == "bottom" || type ==  "top" || type ==  "head") {
	    		clothesList.push(imgObject);
	    	}
	    }
	    
	function imageLoaded(e) {
	    count--;
	    if (count === 0) startDraw(); 
	}
	
	function imageChanged(image,img) {
    	image.source = img;
    }
	
	function startDraw() {
    	gifTimer = setInterval((function (c, i) {
  	      return function () {
  	        setGifPicture(c, 10, 10, i);
  	  		};
  	 })(context, imgList), 200);
  	    
    	drawTimer = setInterval((function (c, i) {
            return function () {
            	drawPicture(c, 10, 10, i);
            };
		 })(context, imgList), 10);  
    }
    
	function profileEdit() {
		window.open("profileEdit", "profileEdit", "top=200,left=300,width=450,height=250");
        //(request(get방식/서버로의 요청), 새로운 창의 이름(창 이름이 같으면 그 위에 오버라이딩 가능), 창에 대한 모양)  
	}
	
	function favorite() {
		alert("즐겨찾기에 추가되었습니다!");
		
	}
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
		padding-top: 12px;
		padding-left: 12px;
		padding-right: 0px;
		border-color: #fff9e7;
	}
	
	#mystore {
		width: 863px;
		height: 545px;
		border-radius: 25px;
		background-color: white;
		padding: 1px;
		float : left;
		padding-top: 20px;
	}
	
	#profile {
		width: 200px;
		height: 545px;
		border-radius: 25px;
		background-color: white;
		padding: 1px;
		float : left;
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
		font-family: 'Jeju Gothic';
	}
	
	#zero {
		width: 10px;
		height: 545px;
		padding: 1px;
		float : left;
	}
	
	#edit {
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
		font-family: Eco Sans Mono;
		font-size: 18px;
	}
	
	#edit:hover {
		opacity: .9;
	}
	
	#say {
		font-family: 'Jeju Gothic';
	}
	
	#url {
		font-family: Eco Sans Mono;
	}
</style>
</head>
<body>

<div id="wrapper" align="center">
	<div id="profile">
		<div id="image" style="padding-top: 80px;" align="center">
			<img src="resources/images/girl.jpg" style="width:180px; height:181px;">
		</div>
		<img src="resources/images/favorite.png" style="width:50px; heignt:50px;" onclick="favorite()">
		<div id="say" align="center">
			<textarea rows="8" cols="25" style="resize: none; outline: none; border: white;" readonly="readonly">안녕하세요 나미야 잡화점 입니다. 감사합니다. 
			</textarea>
		</div>
		
		<br/>
		<input id="edit" type="button" value="EDIT" onclick="profileEdit()">
	</div>	
	<div id="zero">
	
	</div>
	<div id="mystore">
		<h1><b>Welcome My Store</b></h1>
		<div id="url" style="border-top: 1px solid #e3e9ed; border-bottom: 1px solid #e3e9ed; background-color:#e3e9ed; width:700px; padding-top:10px; padding-bottom:10px;" align="right">
			www.namiya.com/sosori93 &nbsp;
		</div>
		
		<canvas id="myCanvas"  width="700px" height="350px"></canvas> 
    
		
		<!-- <div id="store" style="width:800px; height:400px; background-color: #97c2e5;">
			<img src="resources/images/example2.PNG" style="width:800px; height:400px;">
		</div> -->
		
	</div>
	
	<div id="list" style="float:left; width: 90px; text-align:right; height:545px; padding-top: 3px;">
		<ul>
			<li><a href="myStore"><img src="resources/images/home.png" style="width:90px; height:50px; margin-bottom: 4px;"></a></li>
			<li><a href="give"><img src="resources/images/give.png" style="width:90px; height:50px; margin-bottom: 4px;"></a></li>
			<li><a href="trade"><img src="resources/images/trade.png" style="width:90px; height:50px; margin-bottom: 4px;"></a></li>
			<li><a href="talent"><img src="resources/images/talent.png" style="width:90px; height:50px; margin-bottom: 4px;"></a></li>
			<li><a href="review"><img src="resources/images/review.png" style="width:90px; height:50px; margin-bottom: 4px;"></a></li>
			<li><a href="setting"><img src="resources/images/setting.png" style="width:90px; height:50px; margin-bottom: 4px;"></a></li>
		</ul>
	</div>
	
</div>
</body>
</html>