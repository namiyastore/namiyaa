<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="initial-scale=0.60, minimum-scale=0.60, maximum-scale=0.60">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<title>FAVORITE</title>
<!-- <script type="text/javascript" src="resources/jquery-3.3.1.min.js"></script> -->

<style type="text/css">


   #stage {
     width: 600px;
     height: 400px;
    margin-left: 0px;
    margin-right: 0px;
     
        /*
        
        Setting the perspective of the contents of the stage
        but not the stage itself
        
        */
     -webkit-perspective: 600;
   }

   #rotate {
     margin-top: 200px;
     width: 600px;
     height: 400px;
        /* Ensure that we're in 3D space */
     -webkit-transform-style: preserve-3d;
        /*
        Make the whole set of rows use the x-axis spin animation
        for a duration of 7 seconds, running infinitely and linearly
        */
       /*  -webkit-animation-name: x-spin; */
     -webkit-animation-duration: 7s;
     -webkit-animation-iteration-count: infinite;
     -webkit-animation-timing-function: linear;
   }

      .ring {
        height: 110px;
        width: 600px;
        -webkit-transform-style: preserve-3d;
        -webkit-animation-iteration-count: infinite;
        -webkit-animation-timing-function: linear;
      }
      
      .ring > :nth-child(odd) {
        background-color: #995C7F;
      }

      .ring > :nth-child(even) {
        background-color: #835A99;
      }

      .poster {
        position: absolute;
        left: 250px;
        width: 50px;
        height: 50px;
        opacity: 0.7;
        color: rgba(0,0,0,0.9);
        -webkit-border-radius: 10px;
      }
      
      .poster > p {
        font-family: 'Georgia', serif;
        font-size: 36px;
        font-weight: bold;
        text-align: center;
        margin-top: 28px;
      }

      /*
      Set up each row to have a different animation duration
      and alternating y-axis rotation directions.
      */
      /*
      #ring-1 {
        -webkit-animation-name: y-spin;
        -webkit-animation-duration: 5s;
      }

      #ring-2 {
        -webkit-animation-name: back-y-spin;
        -webkit-animation-duration: 4s;
      }

      #ring-3 {
        -webkit-animation-name: y-spin;
        -webkit-animation-duration: 3s;
      }
	*/
      /*

      Here we define each of the three individual animations that
      we will be using to have our 3D rotation effect. The first
      animation will perform a full rotation on the x-axis, we'll
      use that on the whole set of objects. The second and third
      animations will perform a full rotation on the y-axis in
      opposite directions, alternating directions between rows.
    
      Note that you currently have to specify an intermediate step
      for rotations even when you are using individual transformation
      constructs.

      */
      @-webkit-keyframes x-spin {
        0%    { -webkit-transform: rotateX(0deg); }
        50%   { -webkit-transform: rotateX(180deg); }
        100%  { -webkit-transform: rotateX(360deg); }
      }

      @-webkit-keyframes y-spin {
        0%    { -webkit-transform: rotateY(0deg); }
        50%   { -webkit-transform: rotateY(180deg); }
        100%  { -webkit-transform: rotateY(360deg); }
      }

      @-webkit-keyframes back-y-spin {
        0%    { -webkit-transform: rotateY(360deg); }
        50%   { -webkit-transform: rotateY(180deg); }
        100%  { -webkit-transform: rotateY(0deg); }
      }
  
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
		background: url('${pageContext.request.contextPath}/resources/images/mystore.png') no-repeat center center fixed; 
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
		width:1180;
		height:545px;
		padding-top: 12px;
		padding-left: 12px;
		padding-right: 0px;
		border-color: #fff9e7;
	}
	
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
</style>


<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript">

      const POSTERS_PER_ROW = 20;
      const RING_RADIUS = 200;
	  const GAP = 360 / POSTERS_PER_ROW;;
	  var moving = 0;
	  var degreeX = 0;
	  var degreeY = 0;
	  var dragging = false;
	  var img = new Image();
	  var name = 'resources/images/gora0.png';
	  var count = 0;
	  var row, col;
	  
      function setup_posters (row)
      {
        var posterAngle = 360 / POSTERS_PER_ROW;
        //for (var i = 0; i < POSTERS_PER_ROW; i ++) {
        <c:forEach var="item" items="${list}" varStatus="status">
        	if(count == 0)
        		return;
        	var poster = document.createElement('div');
        	poster.className = 'poster';
          // compute and assign the transform for this poster
        	var transform = 'rotateY(' + (posterAngle * ${status.count}) + 'deg) translateZ(' + RING_RADIUS + 'px)';
        	poster.style.webkitTransform = transform;
          // setup the number to show inside the poster
          var atag = poster.appendChild(document.createElement('a'));
          atag.href="${pageContext.request.contextPath}/myStore/${item.MYURL}/home";
         	var content = atag.appendChild(document.createElement('img'));
         	content.setAttribute("width",60);
         	content.setAttribute("height",60);
         	//var img = new Image();
         	<c:if test="${not empty item.SAVEDFILE}">
         	content.src = "${pageContext.request.contextPath}/profile/${item.SAVEDFILE}";
         	</c:if>
         	<c:if test="${empty item.SAVEDFILE}">
         	content.src = "${pageContext.request.contextPath}/resources/images/human.png";
         	</c:if>
         	
         	
       	 	/* img.src = name;
       		img.onload = imageLoaded(content,img); */
       		
          //	content.src = i;
          // add the poster to the row
          //content.href="http://www.naver.com";
         /*  $('#ring-1 div').on('mousedown', function(e) {
              e.preventDefault();
              sx = e.pageX;
              sy = e.pageY;
              
              ix = $(this).offset().left;
              iy = $(this).offset().top;
              var px = sx -ix; // 상대좌표
              var py = sy -iy; // 상대좌표
              dx=dy=0;
                        
              alert("ssss");
            }); */
          row.appendChild(poster);
          count--;
        //}
          </c:forEach>
     
      }
      
      function imageLoaded(content,img) {
    		content.src = img.src;
      }

      function init ()
      {
    	  var sx, sy, dx, dy, ix, iy;
          var ox,oy;
        count = ${list.size()};
        row = Number(count) / Number(POSTERS_PER_ROW);
        col = count % POSTERS_PER_ROW;
        //alert(col);
        setup_posters(document.getElementById('ring-1'));
        setup_posters(document.getElementById('ring-2'));
        setup_posters(document.getElementById('ring-3'));
        $('.ring div').on('mousedown', function(e) {
          
                      
            //alert($(this).html());
          });  
        
       /*  $('body').on('mousedown', function(e) {
          
           // alert($(this).html());
        	// var poster = document.createElement('div');
            // poster.className = 'poster';
            //document.getElementById('ring-1').children
          // var poster = document.getElementsByClassName('poster');
           
             // compute and assign the transform for this poster
             //posterAngle = posterAngle 
             ////var transform = 'rotateY(' +  '20deg) translateZ(' + RING_RADIUS + 'px)';
             //document.getElementById('ring-1').children[0].style.webkitTransform = transform;
           	//$('#ring-1').children().css("webkitTransform", transform);
           	//alert(	$('#ring-1').children().css("transform"));
           	
           	// 메소드로 따로 빼기
           	moving += 30;
           	if(moving >=360)
           		moving = 0;
           	var ring = document.getElementById('ring-1');
           	 for (var i = 0; i < POSTERS_PER_ROW; i ++) {
           		var transform = 'rotateY(' + (GAP*i + moving )+'deg) translateZ(' + RING_RADIUS + 'px)';
           		ring.children[i].style.webkitTransform = transform;
           	 }
          });  */
          
          
        $('body').on('mousedown', function(e) {
            e.preventDefault();
            sx = e.pageX;
            sy = e.pageY;
            
            ix = $(this).offset().left;
            iy = $(this).offset().top;
            var px = sx -ix; // 상대좌표
            var py = sy -iy; // 상대좌표
            dx=dy=0;
            
            ox = degreeX;
            oy = degreeY;          
           
            
            dragging = true;
            // px, py로  선택
           
          }).on('mousemove', function(e) {
         		// 선택한 특정 그림의 x,y값 변경
         		
            	if(dragging) {
                  dx = e.pageX - sx;
                  dy = e.pageY - sy;
              	
              		
              	//imgList[selected].px =  Number(ox) +  Number(dx);
              	//imgList[selected].py =  Number(oy) +  Number(dy);
              	//moving += 30;
              	degreeX = Number(ox) + Number(dx/5);
              	degreeY = Number(oy) + Number(dy/10);
               	if(degreeX >=360 && degreeX <= -360)
               		degreeX = 0;
              	if(degreeY >=360 && degreeY <= -360)
               		degreeY = 0;
               	var rotate = document.getElementById('rotate');
               	rotate
               	for(var k = 0; k<=row ;k++) {
               	 	for (var i = 0; i < col; i ++) {
               			var transform = 'rotateX(' + ( degreeY )+'deg) rotateY(' + (GAP*i + degreeX )+'deg) translateZ(' + RING_RADIUS + 'px)';
               			rotate.children[k].children[i].style.webkitTransform = transform;
               		}
               	}
            }
            
          }).on('mouseup', function(e){
          		
            	dragging = false;
          		//dx = e.pageX - sx;
              	//dy = e.pageY - sy;
            });
        
      
          
          
      }

      // call init once the document is fully loaded
      window.addEventListener('load', init, false);

    </script>
    
</head>
<body>
<div id="wrapper" align="center">
<div id="pan" style="float:left; width: 1073px; height:545px; border-radius: 25px; background-color: white;">
	즐겨찾기 3D구현
	 <div id="stage"> 
      <div id="rotate"> 
        <div id="ring-1" class="ring"></div>
        <div id="ring-2" class="ring"></div>
        <div id="ring-3" class="ring"></div>
      </div>
    </div>
</div>  

<div id="list" style="float:left; width: 90px; text-align:right; height:545px; padding-top: 3px; margin-top: 14px;">
		<ul style="padding-left: 0px;">
			<li><a href="home"><img src="${pageContext.request.contextPath}/resources/images/home.png" style="width:90px; height:50px; margin-bottom: 4px;"></a></li>
			<li><a href="give"><img src="${pageContext.request.contextPath}/resources/images/give.png" style="width:90px; height:50px; margin-bottom: 4px;"></a></li>
			<li><a href="trade"><img src="${pageContext.request.contextPath}/resources/images/trade.png" style="width:90px; height:50px; margin-bottom: 4px;"></a></li>
			<li><a href="talent"><img src="${pageContext.request.contextPath}/resources/images/talent.png" style="width:90px; height:50px; margin-bottom: 4px;"></a></li>
			<li><a href="review"><img src="${pageContext.request.contextPath}/resources/images/review.png" style="width:90px; height:50px; margin-bottom: 4px;"></a></li>
			<li><a href="favorite"><img src="${pageContext.request.contextPath}/resources/images/favoritemenu.png" style="width:90px; height:50px; margin-bottom: 1px;"></a></li>
			<c:if test="${userid == sessionScope.loginId}">
			<li><a href="setting"><img src="${pageContext.request.contextPath}/resources/images/setting.png" style="width:90px; height:50px; margin-bottom: 4px;"></a></li>
			</c:if>
		</ul>
</div>  
</div>
</body>
</html>