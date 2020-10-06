<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="resources/jquery-3.2.1.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	alert("안녕하세요");
	
	$("#incBtn").on("click",function(){
		alert("버튼클릭");
		window.location.href = "inc";
		
	});
});
</script>
<title>Insert title here</title>
</head>
<body>
<button type="button" id="incBtn">
버튼입니다
</button>
인터셉터 테스트입니다

</body>
</html>