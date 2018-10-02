<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="resources/search/js/common/jquery-1.12.4.js"></script>
<title></title>
<script>

	$(function(){
		var lang = $('#lang').val();
		
		$.ajax({
			method : "get",
			url : "majorCategory?lang=" + lang,
			success : function(resp){
				var val = "";
				
				for(var i in resp) {
					val += '<option value="' + resp[i].categorynum + '">' + resp[i].categoryname + '</option>';
				}
				
				$("#major").append(val);
				
				medium(1);
			}
		});
		
		function medium(num) {
			$('#medium').html('');
			
			$.ajax({
				method : "get",
				url : "mediumCategory",
				async: false,
				data : "categorynum=" + num + "&lang=" + lang,
				success : function(resp) {
					var val = "";
					
					for(var i in resp) {
						val += '<option value="' + resp[i].categorynum + '">' + resp[i].categoryname + '</option>';
					}
					
					$("#medium").append(val);
					minor( $("#medium").eq(0).val() );
				}
			});
		}
		
		function minor(num) {
			$('#minor').html('');
			
			$.ajax({
				method : "get",
				url : "minerCategory",
				async: false,
				data : "categorynum=" + num + "&lang=" + lang,
				success : function(resp) {
					var val = "";
					
					for(var i in resp) {
						val += '<option value="' + resp[i].categorynum + '">' + resp[i].categoryname + '</option>';
					}
					
					$("#minor").append(val);
				}
			});
		}
		
		$("#major").change(function(){
			var mediumIdx = $(this).val();
			medium(mediumIdx);
		});
		
		$("#medium").change(function(){
			var minorIdx = $(this).val();
			minor(minorIdx);
		});
		
		$(".add").on('click', function(){
			var keywordname = $('#keywordInputContent').val();
			var categorynum = parseInt($('#minor').val());
			
			var dataList = {
				'keywordname':keywordname,
				'categorynum':categorynum
			};
			
			$.ajax({
				type : "get",
				url : "kInserTdata",
				data : dataList,
				success : function(resp){
					
					if(resp == '1') {
						//$(opener.document).reFn();
						window.opener.location.reload();
						window.close();	
					}
					else {
						alert("이미 등록되어 있습니다");
					}
					
				}
			
			});
		});
		
	});
	
	
	
</script>
<style type="text/css">

	body {
		background-color: #2A3D4E;
	}
	
	.positionSetting {
		float: left;
	}
	
	.titleCSS {
		color: #FFFFFF;
	}
	
	.menuName1 {
	    border: 1px solid #79bfe5;
	    border-radius: 7px;
	    background-color: #79bfe5;
	    margin: 0 auto;
	    font-size: 14px;
	    padding: 3px;
	    width: 100px;
	    float: left;
	    text-align: center;
	}
	
	.menuName2 {
	    border: 1px solid #79bfe5;
	    border-radius: 7px;
	    background-color: #79bfe5;
	    font-size: 14px;
	    padding: 3px;
	    width: 100px;
	    float: both;
	    text-align: center;
	    position: absolute;
	    top: 40px;
	}
	
	.categorySelectCombo {
		border: 1px solid #79bfe5;
	    border-radius: 7px;
	    background-color: #FFFFFF;
	    margin: 0 auto;
	    font-size: 14px;
	    padding: 3px;
	    width: 415px;
	    float: left;
	}
	
	.keyword {
		border: 1px solid #79bfe5;
	    border-radius: 7px;
	    background-color: #FFFFFF;
	    margin: 0 auto;
	    font-size: 14px;
	    padding: 3px;
	    width: 415px;
	    float: left;
	
		position: absolute;
	    top: 40px;
	    left: 116px;
	}
	
	.add {
		background-color: white;
	    position: absolute;
	    top: 80px;
	    left: 240px;
	    width: 100px;
	    text-align: center;
	    border: thin solid white;
	    border-radius: 5px;
	    cursor: pointer;
	}
</style>

</head>
<body>
<input id="lang" type="hidden" value="<spring:message code="common.lang" />">

<div class="menuName1"><b>카테고리</b></div>
<div class="categorySelectCombo">
	<div class="positionSetting">
		<span class="titleCSS">&nbsp; </span>
		<select id="major">
		</select>
	</div>
	<div class="positionSetting">
		<span class="titleCSS">&nbsp; </span>
		<select id="medium">
		</select>
	</div>
	<div class="positionSetting">
		<span class="titleCSS">&nbsp; </span>
		<select id="minor">
		</select>
	</div>
</div>

<div class="menuName2"><b>키워드 입력</b></div>
<div class="keyword">
	<input id="keywordInputContent" type="text" />
</div>

<div class="add">추가</div>

</body>
</html>