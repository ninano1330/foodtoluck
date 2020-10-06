<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="../framemode/FT_header.jsp">
	<jsp:param value="notice/viewNotice" name="parent"/>
</jsp:include>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="resources/css/style.css">
<title>Insert title here</title>
<style type="text/css">
.things{
opacity:0.3;
}


.panel:hover .things{
display:block;
opacity: 1;
transition: width, border opacity .0s linear .2s;
-webkit-transition: width, border opacity .0s linear .2s;
-moz-transition: width, border opacity .0s linear .2s;
-ms-transition: width, border opacity .0s linear .2s;

transition: opacity .2s linear .2s;
-webkit-transition: opacity .2s linear .2s;
-moz-transition: opacity .2s linear .2s;
-ms-transition: opacity .2s linear .2s;
}

.panel-footer{
background-color:#ffffff !important;
font-size:16px;
}
.comment{
	margin-left : 0px !important;
	margin-right : 0px !important;
	margin-bottom: 10px;
}
.cmtbox{
	border-bottom: 1px solid;
}
</style>
</head>
<script type="text/javascript">
function deletebtn(){
	var isDelete = confirm("삭제하시겠습니까?");
	if(isDelete){
		location.href="deleteform.action?notice_no=${read.notice_no}"
	}
	
}
</script>
<body>

	<!-- Search bar -->
	<div class="w3-margin">
		<form class="form-inline" action="main.action">
	  		<input type="button" value="게시판 목록" class="btn btn-default" onclick="location.href='noticeform.action'">
		</form>
	</div>
	<div>
	<h1 align="center" style="font: bold;font-family: cursive;">공지게시판 글</h1>
	<div class="container">
<div class="row">
    <div class="col-sm-12 no-gutter">
    	<div class="panel panel-default">
			<div class="panel-heading">
				<h3 class="panel-title">${read.notice_title }<div class="small pull-right text-right">${read.admin_id}<br>${read.notice_date }</div></h3>
		

			</div>
			<div class="panel-body">
					${read.notice_content}
			</div>  
		</div>
		<div style="text-align: right">
		<c:if test="${sessionScope.sessionId.member_code == 'A' }">
			<input type="button" onclick="location.href='<%=request.getContextPath()%>/read.action?notice_no=${read.notice_no}'" class="btn btn-default" value="수정" />
			<input type="button" id="btnDelete" onclick=deletebtn(); name="btnDelete" class="btn btn-default" value="삭제">
		</c:if>
		</div><br><br>
	</div>
</div>
</div>
	
	
	
	
	
	
	
	
	
	
	
	
	<%-- <div class="center-block" style="width:50%">
	<div class="panel panel-default">
	<div class="panal-heading">공지 게시글<br/></div>
	<div class="panel-body">
<form name="form" method="GET">
		<tr>
		<td>글번호${read.notice_no }</td>
		<td>${read.notice_title }</td><br><br>
		<td>내용:${read.notice_content}</td> <br>
		<td>작성자:${read.admin_id }</td><br>
		<td>날짜:${read.notice_date }</td><br>
		</tr>
	<c:if test="${sessionScope.Id == read.admin_id }">
	<input type="button" onclick="location.href='<%=request.getContextPath()%>/read.action?notice_no=${read.notice_no}'" class="btn btn-default" value="수정" />
	<input type="button" id="btnDelete" onclick=deletebtn(); name="btnDelete" class="btn btn-default" value="삭제">
	</c:if>
	<input type="button" value="게시판 목록" class="btn btn-default" onclick="location.href='noticeform.action'">
</form> --%>
</div>
</div>
</div>
</div>
</body>
</html>