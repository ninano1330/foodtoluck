<%@ page language="java" 
	contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html> 
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="resources/css/timeline/bootstrap.3.3.7.css">
<script type="text/javascript" src="resources/js/jquery-3.2.1.min.js"></script>
<style type="text/css">
.return_main{
	text-align: center;
}
.gotomain{

}
</style>
<script type="text/javascript">

$(document).ready(function(){

	$("#gotomain").on("click", function(){
		location.href = "<%=request.getContextPath()%>/";		
	});
});



//F5 및 Ctrl+R 새로고침 방지. input태그 포커싱중엔 백스페이스 가능하도록
$(document).keydown(function(e) {
    key = (e) ? e.keyCode : event.keyCode;
     
    var t = document.activeElement;
     
    if (key == 8 || key == 116 || key == 17 || key == 82) {
        if (key == 8) {
            if (t.tagName != "INPUT") {
                if (e) {
                    e.preventDefault();
                } else {
                    event.keyCode = 0;
                    event.returnValue = false;
                }
            }
        } else {
            if (e) {
                e.preventDefault();
            } else {
                event.keyCode = 0;
                event.returnValue = false;
            }
        }
    }
});
</script>
<title>회원가입을 환영합니다!</title>
</head>
<body>
<%-- <h1>${memberName }님환영합니다.</h1> --%>
<div class='return_main'>
<img alt="회원가입 환영" src="resources/img/join_welcome.png">
<br>
<button id="gotomain" type="button" class="btn btn-primary btn-success gotomain">
메인으로
</button>
</div>
</body>
</html>
