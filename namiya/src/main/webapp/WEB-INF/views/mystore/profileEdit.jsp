<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE>
<html lang="ko"><head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=Edge">
	<meta name="format-detection" content="telephone=no">
	<meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0">
	<meta http-equiv="Cache-Control" content="no-store, no-cache, must-revalidate">
	<meta http-equiv="Cache-Control" content="post-check=0, pre-check=0">
	<meta http-equiv="Pragma" content="No-Cache">

	<title>프로필 수정</title>

	<script type="text/javascript" src="resources/inc/common/js/jquery.min.js"></script>
	<link rel="stylesheet" type="text/css" href="resources/profile/css/profile.css">
	<link rel="stylesheet" type="text/css" href="resources/inc/user/css/ko/help_member.css?180222">
	<script type="text/javascript" src="https://nid.naver.com/js/clickcr.js"></script>
	<script type="text/javascript" src="resources/inc/common/js/lcslog.js"></script>
	<script type="text/javascript" src="resources/inc/common/js/lua.js"></script>

	<meta name="decorator" content="USER_PROFILE">

<style type="text/css">@keyframes resizeanim { from { opacity: 0; } to { opacity: 0; } } .resize-triggers { animation: 1ms resizeanim; visibility: hidden; opacity: 0; } .resize-triggers, .resize-triggers > div, .contract-trigger:before { content: " "; display: block; position: absolute; top: 0; left: 0; height: 100%; width: 100%; overflow: hidden; } .resize-triggers > div { background: #eee; overflow: auto; } .contract-trigger:before { width: 200%; height: 200%; }</style>
<style type="text/css">
	.scontent {
		background-color: #fcfbf9;
		margin : 0 auto;
		border: 1px solid #fcfbf9;
   		border-radius: 10px;
   		background-color: #fcfbf9;
   		width: 800px;
   		outline: none;
	}
</style>
<script src="https://ssl.pstatic.net/static.gn/js/clickcrD.js" id="gnb_clickcrD" charset="utf-8"></script>
<script type="text/javascript" src="resources/inc/common/js/base64.js"></script>
<script type="text/javascript" src="resources/inc/common/js/jquery.form.min.js"></script>
<script type="text/javascript" src="resources/inc/common/js/commonUtil.js"></script>
<script type="text/javascript" src="resources/inc/user/js/profileChange.js?20180221"></script>
<script type="text/javascript" src="resources/inc/user/js/avatarUtils.js?2018_0206"></script>

<script type="text/javascript">
  

    $(document).ready(function() {
    	
    	var fileTypes = [
    		  'image/jpeg',
    		  'image/gif',
    		  'image/png'
    		];

    	function validFileType(file) {
    		for(var i = 0; i < fileTypes.length; i++) {
    		  if(file.type === fileTypes[i]) {
    		    return true;
    		  }
    		}

    		return false;
    	}
    	
    	var files = document.getElementById('file');
    	files.addEventListener("change", function () {
    		if(validFileType(files.files[0])) {
    			var imagetag = document.getElementById('imgThumb');
    			imagetag.src = window.URL.createObjectURL(files.files[0]);
    			//alert(files.files[0].name);	
    		}
    			
    	});
    });
    
    function  formCheck() {
    	var content = document.getElementById("content");
    	var myurl = document.getElementById("myurl");

    	if (content.value == '' || myurl.value == '') {
    		alert('코멘트,URL을 입력하세요.');
    		return false;
    	}
    	
    	
    	
    	 var form = $('#profileForm')[0];
         var formData = new FormData(form);
         formData.append("fileObj", $("#file")[0].files[0]);
		
         $.ajax({
             url: 'profileEdit',
                     processData: false,
                     contentType: false,
                     data: formData,
                     type: 'POST',
                     success: function(myurl){
                         //alert("업로드 성공!!");
                         if(myurl != "") {
                         	opener.location.href = "${pageContext.request.contextPath}/myStore/"+myurl+"/home";
                         	window.close();
                         }else {
                        	 alert("이미있는 URL "+myurl);
                         }
                     }
             });

    	return true;
    }
    	
   
</script>
</head>

<body id="mainBody">
<div id="wrap">



	<div id="container" style="height: 637px;">
		<!-- CONTENTS -->
		<div id="content">
    <div class="c_header">
        <h2>프로필 수정</h2>
    </div>
    <form action=""  id="profileForm" method="post" enctype="multipart/form-data">
        <fieldset>
            <legend>프로필 수정</legend>
            <table border="1" class="tbl_model">
                <caption><span class="blind">프로필 수정</span></caption>
                <colgroup>
                    <col style="width:22%"><col>
                </colgroup>
                <tbody>
                <tr>
                    <th scope="row">
                        <div class="thcell">프로필 사진</div>
                    </th>
                    <td >
                        <div class="tdcell">
                            <div class="profile_photo">
                            	<c:if test="${empty profile.originalfile}">
                               		<img id="imgThumb" src="https://static.nid.naver.com/images/web/user/default.png?type=s160" width="100" height="80">
                                </c:if>
                                <c:if test="${not empty profile.originalfile}">
                                 	<img id="imgThumb" src="profile/${profile.savedfile}" width="100" height="80">
                                </c:if>
                                <!-- 기 첨부된 파일이 존재할 경우 출력 -->
								<c:if test="${profile.originalfile != null}">
									&nbsp;<a style="color:red" href="deletefile?boardnum=1"><span>x</span></a>
								</c:if>
                                
                                <span class="mask"></span>
                            </div>
                            <div class="btn_area_btm">
									<input type="file" name="upload" id="file" accept="image/jpeg, image/png, image/gif">
									<p style="font-family: 'Jeju Gothic'; font-size: 12px; color:red;">이미지 파일만 등록가능합니다.</p>
                             </div>
                                <!-- <a href="javascript:;" class="btn_model"><b id="btnDelete" class="btn2 btn_disable" onclick="">삭제</b></a> -->
                          </div>
                    </td>
                </tr>
                <tr>
                    <th scope="row">
                        <div class="thcell"><label for="inpUrl">URL</label></div>
                    </th>
                    <td>
                        <div class="tdcell">
                            <p class="contxt_webctrl nickname">
                                <input type="text" name="myurl" id="myurl" value="${myurl}" style="width:254px" >
                            </p>
                        </div>
                    </td>
                </tr>
                 <tr>
                    <th scope="row">
                        <div class="thcell"><label for="inpNickname">코멘트</label></div>
                    </th>
                    <td>
                        <div class="tdcell">
                           <!--  <p class="contxt_webctrl nickname"> -->
                                <textarea name="content" id="content" style="width: 250px; height: 200px; padding-top: 0px;padding-left: 0px;padding-right: 0px;padding-bottom: 0px;">${profile.content}</textarea>
                            <!-- </p> -->
                        </div>
                    </td>
                </tr>
                </tbody>
            </table>
            <div class="btn_wrap" style="height: 100px;">
                <a href="javascript:;" class="btn_model"><b id="btnConfirm" class="btn2" onclick="return formCheck()" >적용</b></a>
                <a href="javascript:;" class="btn_model"><b id="btnCancel" class="btn2" onclick="window.close()">닫기</b></a>
                <br>
            </div>
        </fieldset>
    </form>
<div class="resize-triggers"><div class="expand-trigger"><div style="width: 955px; height: 598px;"></div></div><div class="contract-trigger"></div></div></div>



</div>
</div>


</body>
</html>