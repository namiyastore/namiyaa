<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="resources/jquery-3.3.1.min.js" type="text/javascript"></script>
<script>

$(function(){
	alert($('#fullAddr').val());
	 opener.document.getElementById('fullAddr').value = $('#fullAddr').val();
	 opener.document.getElementById('zipcode').value = $('#zipcode').val();
	 window.close();
	 //팝업을 연창(joinForm으로 전달)
});

</script>
</head>
<body>

<input id="inputYn" type="hidden" value="${inputYn}" />
<input id="fullAddr" type="hidden" value="${fullAddr}" />
<input id="roadAddrPart1" type="hidden" value="${roadAddrPart1}" />
<input id="roadAddrPart2" type="hidden" value="${roadAddrPart2}" />
<input id="engAddr" type="hidden" value="${engAddr}" />
<input id="jibunAddr" type="hidden" value="${jibunAddr}" />
<input id="zipcode" type="hidden" value="${zipcode}" />
<input id="addrDetail" type="hidden" value="${addrDetail}" />

</body>
</html>