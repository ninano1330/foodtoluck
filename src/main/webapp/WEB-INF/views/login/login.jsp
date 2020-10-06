<%@ page language="java" 
	contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html> 
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="resources/css/style.css">
<link rel="stylesheet" type="text/css" href="resources/css/starability-all.min.css"/>
<script type="text/javascript">

</script>
<title>Insert title here</title>
</head>
<body>
<!-- 로그인 모달창 -->
	
    <div class="w3-modal-content w3-card-4 w3-animate-zoom" style="max-width:600px">
      
      <form class="w3-container" action="loginCheck" method="post">
        <div class="w3-section">
          <label><b>아이디</b></label>
          <!-- name에 필드명 맞춰주면 알아서 vo 객체 생성하고 보낼 수 있다. -->
          <input class="w3-input w3-border w3-margin-bottom" type="text" placeholder="아이디" name="member_id" required value="goyu8744">
          <label><b>비밀번호</b></label>
          <input class="w3-input w3-border" type="password" placeholder="**********" name="member_pw" required value="zlxmfl12!@">
          <input type="hidden" name="parent" value="main/main3"/>
          <input type="hidden" name="truck_code" value="${param.truck_code}"/>
          
          <button class="w3-button w3-block w3-green w3-section w3-padding" type="submit">로그인</button>
        </div>
      </form>


    </div>

</body>
</html>
