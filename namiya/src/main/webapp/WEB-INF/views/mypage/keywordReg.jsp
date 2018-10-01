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
</style>

</head>
<body>
<input id="lang" type="hidden" value="<spring:message code="common.lang" />">

<div class="positionSetting">
	<span class="titleCSS">대분류: </span>
	<select id="major">
	</select>
</div>
<div class="positionSetting">
	<span class="titleCSS">중분류: </span>
	<select id="medium">
	</select>
</div>
<div class="positionSetting">
	<span class="titleCSS">소분류: </span>
	<select id="minor">
	</select>
</div>

</body>
</html>