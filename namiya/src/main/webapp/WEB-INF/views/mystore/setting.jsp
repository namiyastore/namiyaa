<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 
<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<title>SETTING</title>
<!-- <script type="text/javascript" src="resources/jquery-3.3.1.min.js"></script> -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script>
var background = {
	'width' : 700,
	'height': 350
};
var currentBackgroundPage = 1;
var currentFurniturePage = 1;
var currentHeadPage = 1;
var currentTopPage = 1;
var currentBottomPage = 1;
var furnitureSliderWidth = 500;
var furnitureSliderHeight = 200;
var selectedMenu = [];
var i = 0;
var canvas ;
var context ;
var imgList = [];
var selected = -1; 
var dragging = false; // moveon 이벤트 control 변수
var ismoving =false; // 이미지 이동후 화면에 메뉴 안띄우기 위한 변수
var count =-1;
var isMenu = false;
var gifTimer = null;
var drawTimer = null;
var tempList = []; // 가비지 콜렉터가 현재 gif배경에서는 안일어나게 하기위해....
var clothesList = [];

// 이미지 슬라이더 setting
function Imageinit() {
	
	$(".container").css('width',furnitureSliderWidth);
	$(".container").css('height',furnitureSliderHeight);
	pagingItem('type','background',0);
}

function imageOutput(resp) {
	var c =4;
	if(resp["list"].length <=0)
		return;
	if(resp["list"][0]["TYPE"] == "background")
		currentBackgroundPage = resp["navi"].currentPage;
	else
		currentFurniturePage = resp["navi"].currentPage;
	var result = '';
	result +=  '<tr>';
	result +=  '<td align="center">';
	if(resp["list"][0]["TYPE"] == "background")
		result +=  '<a href=javascript:pagingItem("type","background"'+',-1)>';
	else if(resp["list"][0]["TYPE"] == "furniture")
		result +=  '<a href=javascript:pagingItem("type","furniture"'+',-1)>';
	else if(resp["list"][0]["TYPE"] == "head")
    	result +=  '<a href=javascript:pagingItem("type","head"'+',-1)>';
    else if(resp["list"][0]["TYPE"] == "top")
    	result +=  '<a href=javascript:pagingItem("type","top"'+',-1)>';
    else if(resp["list"][0]["TYPE"] == "bottom")
        result +=  '<a href=javascript:pagingItem("type","bottom"'+',-1)>';
	result +=  '	<img alt="" src="resources/images/arrow5.png" width="50" height="30">';
	result +=  '</a>';
	result +=  '</td>';
	result +=  '</tr>'; 
    $.each(resp["list"],function(index, item) {
   		result +=  '<tr >';
    	result +=  '<td id="line" align="center">';
        result +=  '	<a href=javascript:createTexture('+item["TOTALFRAMES"]+','+
        item["WIDTH"]+','+item["HEIGHT"]+',"'+item["FILENAME"]+'","'+item["TYPE"]+'",'+
        item["ITEMNUM"]+')>';
        if(item["TYPE"] == "background")
        	result +=  '		<img src="resources/img/'+item["TYPE"]+'/'+item["FILENAME"]+'/'+item["FILENAME"]+'0.png" width="90" height="90">';
        else
        	result +=  '		<img src="resources/img/'+item["TYPE"]+'/'+item["FILENAME"]+'0.png" width="90" height="90">';	
        result +=  '	</a>';
        result +=  '</td>';  
        result +=  '</tr>';
        c--;
    });
    
    for(var i =0; i<c; i++) {
    	result +=  '<tr>';
		result +=  '<td id="line" align="center">';
		result += '<img src="resources/img/bottom/invisibleBottom0.png" width="90" height="90">';
		result +=  '</td>';  
    	result +=  '</tr>';
    	//alert("ssss");
    }
    
    result +=  '<tr>';
    result +=  '<td align="center">';
    if(resp["list"][0]["TYPE"] == "background")
		result +=  '<a href=javascript:pagingItem("type","background"'+',1)>';
	else if(resp["list"][0]["TYPE"] == "furniture")
		result +=  '<a href=javascript:pagingItem("type","furniture"'+',1)>';
	else if(resp["list"][0]["TYPE"] == "head")
       	result +=  '<a href=javascript:pagingItem("type","head"'+',+1)>';
    else if(resp["list"][0]["TYPE"] == "top")
       	result +=  '<a href=javascript:pagingItem("type","top"'+',+1)>';
    else if(resp["list"][0]["TYPE"] == "bottom")
            result +=  '<a href=javascript:pagingItem("type","bottom"'+',+1)>';
    result +=  '		<img alt="" src="resources/images/arrow6.png" width="50" height="30">';
    result +=  '	</a>';
    result +=  '</td>'; 
    result +=  '</tr>';
    $("#bk").html(result);
}

function drawPicture(context, x, y, list, menu) { // context is the canvas 2d context.
	    for(var a = 0; a<list.length; a++) {
	    	
	    	context.drawImage(list[a].source,list[a].px,list[a].py,list[a].width,list[a].height);
	    	if(list[a].type == "minimi") { // 옷그리기
	    		drawCloth(context,list[a]);
	    	}
	    	if(isMenu) {
	    		context.strokeRect(list[selected].px,list[selected].py,list[selected].width,list[selected].height);
	    		for(var b = 0; b<menu.length; b++) {
	    			context.drawImage(selectedMenu[b].source,selectedMenu[b].px,selectedMenu[b].py,selectedMenu[b].width,selectedMenu[b].height);
	    		
	    		}
	    	}
	    }
	
 }

function drawCloth(context, minimiImage) {	
			/* context.drawImage(clothesList[0].source,minimiImage.px,minimiImage.py,clothesList[0].width,clothesList[0].height);	
			context.drawImage(clothesList[1].source,minimiImage.px,Number(minimiImage.py) + 65,clothesList[1].width,clothesList[1].height);
			context.drawImage(clothesList[2].source,minimiImage.px,Number(minimiImage.py) + 90 ,clothesList[2].width,clothesList[2].height); */
	context.drawImage(clothesList[2].source,minimiImage.px,minimiImage.py,minimiImage.width,minimiImage.height);	
	context.drawImage(clothesList[1].source,minimiImage.px,minimiImage.py,minimiImage.width,minimiImage.height);	
	context.drawImage(clothesList[0].source,minimiImage.px,minimiImage.py,minimiImage.width,minimiImage.height);	
}

function setSelectedMenu() {

	setMenu('curve',50,50,32,32);
	setMenu('trashbin',50,50,32,32);
	setMenu('back',50,50,32,32);
	setMenu('front',50,50,32,32);
}
	
function setGifPicture(context, x, y, list) { // context is the canvas 2d context.
	    for(var a = 0; a<list.length; a++) {
	    	if(list[a].type == "background") {
	    		list[a].currentframe = (list[a].currentframe + 1) % list[a].totalframes;
	    	// onload event 써서 수정할것
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
	count = ${fn:length(list)} + ${list[0].TOTALFRAMES} + 4 -1; // 메뉴 4개 추가 + 배경이 gif일때
	 <c:forEach items="${list}" var="item" varStatus ="status">
	setImage("${item.TOTALFRAMES}","${item.CURRENTFRAME}","${item.WIDTH}","${item.HEIGHT}",
		"${item.FILENAME}","${item.PX}","${item.PY}","${item.IMAGEORDER}","${item.TYPE}","${item.ITEMNUM}");
	</c:forEach>

	loadGifPicture();
	setSelectedMenu();
	
	Imageinit();
	
}

function colli(image,x,y){
	//alert(image.px+", ");
	var x1 = image.px;
	var x2 =  Number(image.px) + Number(image.width);
	var y1 = image.py;
	var y2 =  Number(image.py)+ Number(image.height);

	if(x1<=x && x2>=x) {
		if(y1<=y && y2>=y) {	
			return true;
		}
	}
	return false;
}

$(document).ready(function() {
 $(".nav-tabs a").click(function(event){
	 	$(event).tab('show');
    });
    $('.nav-tabs a').on('shown.bs.tab', function(event){
        var x = $(event.target).text();         // active tab
        var y = $(event.relatedTarget).text();  // previous tab
        $(".act span").text(x);
        $(".prev span").text(y);
    });
	
	onBodyLoad();
	 
  var sx, sy, dx, dy, ix, iy;
  var ox,oy;
  
	
  /* $("#wait").attrchange({
	    trackValues: true, // set to true so that the event object is updated with old & new values
	    callback: function(evnt) {
	        if(evnt.attributeName == "width") { // which attribute you want to watch for changes
	        	var sendData = [];
	        	
	        	sendData = imgList.concat(clothesList);
	        	$.ajax({
	        		method : 'POST'
	        		,async : false
	        		,url : 'saveMiniRoom' 
	        		,data : JSON.stringify(sendData)
	        		,dataType : "json"
	        		,contentType: "application/json"
	        		,success : output
	        		
	        	}
	        	);
	        }
	    }
	}); */
  
  
  $('#myCanvas').on('mousedown', function(e) {
      e.preventDefault();
      sx = e.pageX;
      sy = e.pageY;
      
      ix = $(this).offset().left;
      iy = $(this).offset().top;
      
      var px = sx -ix; // 상대좌표
      var py = sy -iy; // 상대좌표
      
      dx=dy=0;
                
      if(selected != -1) { // 선택되었을때
    	  if(colli(selectedMenu[0],px,py)) { // 기능 1
    		  changeDirection(selected);
    	  	  return ;
    	  }else if(colli(selectedMenu[1],px,py)) { // 기능 2
    		  deleteItem(selected);
    		  return ;
    	  }else if(colli(selectedMenu[2],px,py)) { // 기능 3
    		  changeOrder(selected,0);
    		  return ;
    	  }else if(colli(selectedMenu[3],px,py)) { // 기능 4
    		  changeOrder(selected,1);
    		  return ;
    	  }
      }
      
      ismoving = false;
      dragging = true;
      selected = -1; //초기화
      // px, py로  선택
      for(var i = imgList.length-1; i>0;i--) {
    	  if(colli(imgList[i],px,py)) {
    		 ox = imgList[i].px; // 선택된 그림의 상대좌표
    		 oy = imgList[i].py; // 선택된 그림의 상대좌표
    		 selected = i;
    		 
    		 selectedMenu[0].px =  Number(imgList[i].px) -  Number(selectedMenu[0].width);
    		 selectedMenu[0].py =  Number(imgList[i].py) -  Number(selectedMenu[0].height);
    		 
    		 selectedMenu[1].px =  Number(imgList[i].px) +  Number(imgList[i].width) ;
    		 selectedMenu[1].py =  Number(imgList[i].py) -  Number(selectedMenu[1].height);
    		 
    		 selectedMenu[2].px =  Number(imgList[i].px) -  Number(selectedMenu[2].width);
    		 selectedMenu[2].py =  Number(imgList[i].py) +  Number(imgList[i].height) ;
    		 
    		 selectedMenu[3].px =  Number(imgList[i].px) +  Number(imgList[i].width) ;
    		 selectedMenu[3].py =  Number(imgList[i].py) +  Number(imgList[i].height) ;
    		 break;
    	  }
      }
      if(selected == -1) // 선택되지않았으면 메뉴 종료
    	  isMenu = false;
      
    }).on('mousemove', function(e) {
   		// 선택한 특정 그림의 x,y값 변경
   		
      	if(dragging) {
            dx = e.pageX - sx;
            dy = e.pageY - sy;
        	if(selected != -1) {
        		if(dx !=0 || dy !=0) { // 이동중엔 메뉴 종료
        			isMenu = false;
        			ismoving = true;
        		}
        		
        		imgList[selected].px =  Number(ox) +  Number(dx);
        		imgList[selected].py =  Number(oy) +  Number(dy);
        		for(var a = 0; a<4; a++) {
            		selectedMenu[a].px +=  dx;
            		selectedMenu[a].py +=  dy;
            	}
        	}
      	}
      
    }).on('mouseup', function(e){
    		
        dragging = false;
    	dx = e.pageX - sx;
        dy = e.pageY - sy;
       
        if(ismoving)     // 움직였으면 취소
        	selected = -1;
       if(selected != -1) // 선택되었다면
    	   isMenu = true;
      })
  
});


function createTexture(totalframes, width, height, filename, type, itemnum) {
 var imgObject = {
        'source': null,
        'totalframes': 1,
        'currentframe': 0,
        'width': 0,
        'height': 0,
   	    'filename' : null,
   	    'px' : 0,
        'py' : 0,
        'imageorder' : 1,
        'type' : 'furniture',
        'itemnum' : 5
   	}; 

	imgObject.totalframes = totalframes;
	imgObject.width = width;
	imgObject.height = height;
	imgObject.currentframe = 0;
	imgObject.px = background.width/2; 
	imgObject.py = background.height/2; 
	imgObject.filename = filename;
	imgObject.imageorder = imgList.length;
	imgObject.type = type;
	imgObject.itemnum = itemnum;
	var name;
	if(type == "background")
		name = 'resources/img/'+imgObject.type+'/'+imgObject.filename+'/'+imgObject.filename+imgObject.currentframe+'.png';
	else	
		name = 'resources/img/'+imgObject.type+'/'+imgObject.filename+imgObject.currentframe+'.png';

	var img = new Image();
	img.src = name;
	imgObject.source = img;
	img.onload = newImageLoaded(imgObject,type);
	
}


function setMenu(filename,px,py,width,height) {
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
            'type' : null
       	};
	
	imgObject.width = width;
	imgObject.height = height;
	imgObject.px = px;
	imgObject.py = py;
	imgObject.filename = filename;
	var name = 'resources/img/item/'+imgObject.filename+imgObject.currentframe+'.png';
	var img = new Image();
	img.src = name;
	img.onload = imageLoaded;
	imgObject.source = img;
	selectedMenu.push(imgObject);
}

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

function newImageLoaded(imgObject,type) {
	if(type == "background") {
		imgObject.px = 0;
		imgObject.py = 0;
		tempList = [];
    	imgList[0] = imgObject;
    	tempList.push(imgObject.source);
    	window.clearInterval(drawTimer);
    	window.clearInterval(gifTimer);
    	drawTimer = null;
    	gifTimer = null;
    	count = imgList[0].totalframes-1;  // 하나는 이미 로드된 상태(방금)
    	loadGifPicture();
	} else if(type == "furniture"){
		imgList.push(imgObject);
	}else if(type == "head") {
    	clothesList[0] = imgObject;	
	}else if(type == "top") {
		clothesList[1] = imgObject;	
	}else if(type == "bottom") {
		clothesList[2] = imgObject;	
	}
 
}

function imageChanged(image,img) {
	image.source = img;
}

function gifChanged(image,imgObject) {
	
	tempList = [];
	imgList[0] = imgObject;
	tempList.push(imgObject.source);
	window.clearInterval(drawTimer);
	window.clearInterval(gifTimer);
	drawTimer = null;
	gifTimer = null;
	count = imgList[0].totalframes-1;  // 하나는 이미 로드된 상태(방금)
	loadGifPicture();
}

function changeDirection(sel) {
	imgList[sel].currentframe = (Number(imgList[sel].currentframe) + 1) % imgList[sel].totalframes;
	
		var img = new Image();
		var name = 'resources/img/'+imgList[sel].type+'/'+imgList[sel].filename+imgList[sel].currentframe+'.png';
		img.src = name;
		img.onload = imageChanged(imgList[sel],img); 
	
}

function deleteItem(sel) {
	if(imgList[sel].type == "minimi") {
		alert("삭제 불가");
		return;
	}
	imgList.splice(sel,1);
	isMenu = false;
	selected = -1;
}

function changeOrder(sel,front) {
	var cnt = -1;
	cnt = isItemColli(sel,imgList[sel].px,imgList[sel].py,imgList[sel].width,imgList[sel].height,front);
	if(cnt != -1) { // 겹치는 그림이 있을때
		var temp = imgList[sel];
		imgList[sel] = imgList[cnt];
		imgList[cnt] = temp;
		selected = cnt;
	}
}

function isItemColli(sel,px,py,width,height,front) {
	var x1 = px;
		var x2 =  Number(px) + Number(width);
		var y1 = py;
	 	var y2 =  Number(py)+ Number(height);
	 
	 if(front == 0) {
	  for(var i = sel-1; i>0;i--) {
		var _x1 = imgList[i].px;
		var _x2 = Number(imgList[i].px) + Number(imgList[i].width);
		var _y1 = imgList[i].py;
		var _y2 = Number(imgList[i].py) + Number(imgList[i].height);
	    
		if(x1 < _x2 && x2 > _x1 && y1 < _y2 && y2 > _y1)
			return i;
  	  }
	 }else {
		 for(var i = sel+1; i<imgList.length;i++) {
				var _x1 = imgList[i].px;
				var _x2 = Number(imgList[i].px) + Number(imgList[i].width);
				var _y1 = imgList[i].py;
				var _y2 = Number(imgList[i].py) + Number(imgList[i].height);
			    
				if(x1 < _x2 && x2 > _x1 && y1 < _y2 && y2 > _y1)
					return i;
		  	  } 
	 }
	  return -1;
}


function startDraw() {
	gifTimer = setInterval((function (c, i) {
	      return function () {
	        setGifPicture(c, 10, 10, i);
	  		};
	 })(context, imgList), 200);
	    
	drawTimer = setInterval((function (c, i, k) {
        return function () {
        	drawPicture(c, 10, 10, i, k);
        };
	 })(context, imgList, selectedMenu), 10);  
}

function saveTexture() {
	
	setTimeout( function(){
		$("#loadingImage").css('width',100);
		$("#loadingImage").css('height',100);
		}, 10 );
	
	
	setTimeout( function(){
		var sendData = [];
		
		sendData = imgList.concat(clothesList);
		$.ajax({
			method : 'POST'
			,async : false
			,url : 'saveMiniRoom' 
			,data : JSON.stringify(sendData)
			,dataType : "json"
			,contentType: "application/json"
			,success : output
			
		}
		);
		}, 30 );
	
	/* var sendData = [];
	
	sendData = imgList.concat(clothesList);
	$.ajax({
		method : 'POST'
		,async : false
		,url : 'saveMiniRoom' 
		,data : JSON.stringify(sendData)
		,dataType : "json"
		,contentType: "application/json"
		,success : output
		
	}
	); */
	
	/* setTimeout( function(){
		  var s = document.createElement( 'script' );
		  document.getElementsByTagName('head')[0].appendNode( s );
		  s.src = "main.js";
		}, 50 ); */

}

function output(resp) {
	$("#loadingImage").css('width',0);
	$("#loadingImage").css('height',0);
	//alert("저장완료");
	
}



function pagingItem(searchItem,searchWord,gap) {
	var currentPage;
	if(searchWord == "background") {
		currentBackgroundPage = Number(currentBackgroundPage) + Number(gap);  
		currentPage = currentBackgroundPage;
	}
	else if (searchWord == "furniture") {
		currentFurniturePage = Number(currentFurniturePage) + Number(gap);
		currentPage = currentFurniturePage;
	}
	else if (searchWord == "head") {
		currentHeadPage = Number(currentHeadPage) + Number(gap);
		currentPage = currentHeadPage;
	}
	else if (searchWord == "top") {
		currentTopPage = Number(currentTopPage) + Number(gap);
		currentPage = currentTopPage;
	}
	else if (searchWord == "bottom") {
		currentBottomPage = Number(currentBottomPage) + Number(gap);
		currentPage = currentBottomPage;
	}
	
    	$.ajax({
    		method : 'GET'
    		,url : 'reqFurniture'
    		,data : 'currentPage='+currentPage+'&searchItem='+searchItem+'&searchWord='+searchWord
    		,success : imageOutput}
    	);
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
  		overflow: hidden;
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
	
	/* #edit {
		border-radius: 25px;
		background-color: white;
		padding-top: 5px;
		padding-bottom: 5px;
	} */
	
	
	.menulist{
    	display: block;
   		list-style-type: disc;
    	-webkit-margin-before: 1em;
    	-webkit-margin-after: 1em;
   	 	-webkit-margin-start: 0px;
   	 	-webkit-margin-end: 0px;
    	-webkit-padding-start: 0px;
    	-webkit-padding-end: 0px;
	}
	
	list, dir {
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
		font-family: 'Jeju Gothic', Eco Sans Mono;
	}

	#save {
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
	
	#save:hover {
		opacity: .9;
	}

	
	img#loadingImage {
		display: inline-block;
 		position : absolute;
		width: 0px;
    	height: 0px;
    	top: 300px;
  		left:600px;
  		-webkit-animation: fadein 2s ease-in alternate infinite;
   		 -moz-animation: fadein 2s ease-in alternate infinite;
 		   animation: fadein 2s ease-in alternate infinite;
   		
	}
 
	
	@-webkit-keyframes fadein {
	    from { opacity: 0; }
	    to { opacity: 1; }
	}
	
	@-moz-keyframes fadein {
	    from { opacity: 0; }
	    to { opacity: 1; }
	}
	
	@keyframes fadein {
	    from { opacity: 0; }
	    to { opacity: 1; }
	}
</style>
</head>
<body>
<img id="loadingImage" alt="" src="resources/img/furniture/tori0.png">
 <div id="wrapper" align="center">
	<div id="scroll" style="float:left; width: 1073px; height:545px; border-radius: 25px; background-color: white;">
		
		<h1><b>Edit My Store</b></h1>
		<hr style="width: 1040px; border-color:black;"/>
		<div id="selected" style="float:left; width:280px; height:430px; padding-left: 20px;">
			<div id="list" style="float:left; width: 100px; text-align:right; height:430px; padding-top: 30px; margin-left :10px;">
				<ul class="nav nav-pills nav-stacked">
				    <li >
				   		 <a href="javascript:pagingItem('type','background',0)">Background</a>
				    </li>
				    <li >
				    	<a href="javascript:pagingItem('type','furniture',0)">Furniture</a>
				    </li>
				    <li >
				    	<a href="javascript:pagingItem('type','head',0)">Hair</a>
				    </li>
				    <li >
				    	<a href="javascript:pagingItem('type','top',0)">Top</a>
				    </li>
				    <li >
				    	<a href="javascript:pagingItem('type','bottom',0)">Bottom</a>
				    </li>
				 </ul>
			</div>
			<div class="tab-content" style="float:left; width:150px; height:430px; margin: 0px;">
	   			<div id="background" class="tab-pane active" style="height:430px;">
	    			<table id ="bk">
	    				
	      			</table>  
	   		 	</div>
	   		 	<div id="fu" class="tab-pane"></div>
	 		</div>
		</div>
		
		<div id="edit" style="width:750px;float:left;margin-top: 35px;">
			<canvas id="myCanvas"  width="700" height="350"></canvas>
			<br/>
			<br/>
			<input id="save" type="button" value="Save" onclick="saveTexture()">
		</div>
	</div>
	
	
	<div id="list" style="float:left; width: 90px; text-align:right; height:545px; padding-top: 3px;">
		<ul class="menulist">
			<li><a href="myStore"><img src="resources/images/home.png" style="width:90px; height:50px; margin-bottom: 3px;"></a></li>
			<li><a href="give"><img src="resources/images/give.png" style="width:90px; height:50px; margin-bottom: 3px;"></a></li>
			<li><a href="trade"><img src="resources/images/trade.png" style="width:90px; height:50px; margin-bottom: 3px;"></a></li>
			<li><a href="talent"><img src="resources/images/talent.png" style="width:90px; height:50px; margin-bottom: 3px;"></a></li>
			<li><a href="review"><img src="resources/images/review.png" style="width:90px; height:50px; margin-bottom: 3px;"></a></li>
			<li><a href="setting"><img src="resources/images/setting.png" style="width:90px; height:50px; margin-bottom: 3px;"></a></li>
		</ul>
	</div>
	
</div>
</html>