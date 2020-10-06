<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="resources/css/style.css">
<title>FoodToLuck</title>
<script src="resources/jquery-3.2.1.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	$('#join').click(function(){
		window.location.replace('join');
	});
})
</script>
</head>
<body>
	<div style="text-align: right" class="top-align right-margin top-margin">
		<button id="join" class="w3-btn w3-round w3-border w3-padding-small">회원가입</button>
		<button class="w3-btn w3-round w3-border w3-padding-small">로그인</button>
	</div>
	

	
	
</body>
</html>