<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css"> -->
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="resources/css/style.css">
<link rel="stylesheet" type="text/css" href="resources/css/starability-all.min.css"/>
<script>
function logo_click(){
	window.location.href = "main";
}

function logout_href(){
	var request_uri;
	var queryString = "<%= request.getQueryString()%>";
	if(queryString == null || queryString ==""){
		request_uri = "<%= request.getAttribute( "javax.servlet.forward.request_uri" )%>";
	}else if(queryString !=null && queryString !=""){
		request_uri = "<%= request.getAttribute( "javax.servlet.forward.request_uri" )%>?<%= request.getQueryString()%>";
	}
	window.location.href = "logout?request_uri=" + request_uri;
}

function getRequest_uri(){
	var request_uri;
	var queryString = "<%= request.getQueryString()%>";
	if(queryString == null || queryString ==""){
		request_uri = "<%= request.getAttribute( "javax.servlet.forward.request_uri" )%>";
	}else if(queryString !=null && queryString !=""){
		request_uri = "<%= request.getAttribute( "javax.servlet.forward.request_uri" )%>?<%= request.getQueryString()%>";
	}
	$("#request_uri").val(request_uri);
}

$("#loginForm").on("submit",function(){
	var formData = $(this).serialize();
	$.ajax({
		type: "POST",
		url : "loginCheck",
		data : formData,
		success : function(result){
			if(result=="success"){
				window.location.reload();
			}else if(result=="false"){
				alert("아이디와 비밀번호가 일치하지 않습니다.");
			}
		}
		
	});
	
	return false;
});

$(document).ready(function(){
	getRequest_uri();	
});
</script>
</head>
<body>
	<!-- 상단 로그인 메뉴 -->
	<div class="container">
		<div class="row">
			<!-- left logo -->
  			<div class="col-md-6">
  				<div class="left-margin top-margin">
    				<img src="resources/img/foodtoluck_word.JPG" style="width:150px" onclick="javascript:logo_click();"/>
    			</div>
  			</div>
  			
			<c:choose>		
				<c:when test ="${sessionId == null}">
					<div class="col-md-6">
		 				<div class="top-align right-margin top-margin">
							<a href="join"><button class="w3-btn w3-round w3-border w3-padding-small">회원가입</button></a>
							<button onclick="document.getElementById('id01').style.display='block'" 
							class="w3-btn w3-round w3-border w3-padding-small">로그인</button>
						</div>
		  			</div>
				</c:when>
				
		  		<c:otherwise>
					<div class="col-md-6">
		 				<div class="top-align right-margin top-margin">
							${sessionId.member_id} 님 안녕하세요~ <a href="info.mypage"><button class="w3-btn w3-round w3-border w3-padding-small">내정보</button></a>
							<a href="#" onclick="javascript:logout_href()">
							<button class="w3-btn w3-round w3-border w3-padding-small" id="logoutBtn">로그아웃</button>
							</a>
						</div>
		  			</div>
				</c:otherwise>
			</c:choose>
		</div>
		<!-- <form class="form-inline">
	  		<div class="form-group">
	    		<input type="text" class="form-control" style="width:290px" placeholder="Search">
	  		</div>
	  		<button type="submit" class="btn btn-default">&nbsp;&nbsp;검색&nbsp;&nbsp;</button>
		</form> -->
	</div>
	
	<!-- 로그인 모달창 -->
	<div id="id01" class="w3-modal">
    <div class="w3-modal-content w3-card-4 w3-animate-zoom" style="max-width:600px">
      <div class="w3-center"><br>
        <span onclick="document.getElementById('id01').style.display='none'" class="w3-button w3-xlarge w3-hover-red w3-display-topright" title="Close Modal">&times;</span>
      </div>
      <form class="w3-container" id="loginForm">
        <div class="w3-section">
          <label><b>아이디</b></label>
          <!-- name에 필드명 맞춰주면 알아서 vo 객체 생성하고 보낼 수 있다. -->
          <input class="w3-input w3-border w3-margin-bottom" type="text" placeholder="아이디" name="member_id" >
          <label><b>비밀번호</b></label>
          <input class="w3-input w3-border" type="password" placeholder="**********" name="member_pw">
          <input type="hidden" id="request_uri" name="request_uri" />
<%--           <input type="hidden" name="truck_code" value="${param.truck_code}"/> --%>
          
          <button class="w3-button w3-block w3-green w3-section w3-padding" id="loginBtn" type="submit">로그인</button>
        </div>
      </form>

      <div class="w3-container w3-border-top w3-padding-16 w3-light-grey">
        <button onclick="document.getElementById('id01').style.display='none'" type="button" class="w3-button w3-red">취소</button>
      </div>

    </div>
  </div>
	
</body>
</html>