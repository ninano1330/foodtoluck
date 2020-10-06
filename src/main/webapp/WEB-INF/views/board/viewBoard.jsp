<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="../framemode/FT_header.jsp">
	<jsp:param value="board/viewBoard" name="parent"/>
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
	border: 1px solid;
}
.content{
	
}
</style>
<script src="//code.jquery.com/jquery.min.js"></script>
</head>
<script type="text/javascript">
$(document).ready(function(){
	//alert('${sessionScope.sessionId.member_id eq "'++'"}')
	listReply(); 
});
function listReply(){
    $.ajax({
        type: "get",
        url: "listJson.action?board_no=${read.board_no}",
        success: function(result){
        	console.log(result);
            var output = "<table>";
            /* var session = ${sessionScope.member_id}; */
            for(var i in result){
            	var is = "${sessionScope.sessionId.member_id eq '"+result[i].member_id+"' }";
//             	alert(is);
            
                output+="<div class='cmtbox'>"
                +"<div class='row comment'>"
                +"<div class='col-md-1'>"
				+result[i].member_id
				+"</div>"				
				+"<div class='col-md-10'>"
				+result[i].bcomment_date
				+"</div>"				
				+"<div class='col-md-1'>";
				if(is){
					
					output+="<a href='#' onclick=replydeletebtn("+result[i].bcomment_no+") id="+result[i].bcomment_no+">삭제</a>";
					
				}
				 output+="</div>"
				+"</div>"
				+"<div class='row comment'>"
				+"&nbsp;"+result[i].bcomment_content
				+"</div>"
				+"</div>";
            }
            output += "</table>";
            $("#listReply").html(output);
        }
    });
}

function replydeletebtn(no){
	var replyId = $("#"+no).attr("id");
	location.href="replydelete.action?bcomment_no="+replyId+"&board_no=${read.board_no}";
}

function deletebtn(){
	location.href="boarddeleteform.action?board_no=${read.board_no}"
}
function replywritebtn(){
	if(${sessionScope.sessionId.member_id != null}){
	var bcomment_content=$("#bcomment_content").val();
    var board_no="${read.board_no}"
    var member_id="${sessionScope.sessionId.member_id}"
    var param="bcomment_content="+bcomment_content+"&board_no="+board_no+"&member_id="+member_id;
    $.ajax({
    	type: "POST",
    	url: "replyinsert.action",
        data: param,
        success: function(){
            alert("댓글이 등록되었습니다.");
            listReply();
        }
        });
    }else{
    	alert("로그인이 필요합니다.");
    }
}
</script>
<body>
<!-- <div style="text-align: right" class="top-align right- legin top-margin">
		<button class="w3-btn w3-round w3-border w3-padding-small">회원가입</button>
		<button class="w3-btn w3-round w3-border w3-padding-small">로그인</button>
</div> -->

	<!-- Search bar -->
	<div class="w3-margin">
		<form class="form-inline" action="main.action">
	  		<!-- <div class="form-group" style="text-align:right;">
	  			<button type="submit" class="btn btn-default">메인화면</button>
	  		</div> -->
	  		<input type="button" value="게시판 목록" class="btn btn-default" onclick="location.href='boardform.action'">
		</form>
	</div>
	<h1 align="center" style="font: bold;font-family: cursive;">자유게시판</h1>

<div class="container">
<div class="row">
    <div class="col-sm-12 no-gutter">
    	<div class="panel panel-default" >
			<div class="panel-heading">
				<h3 class="panel-title">${read.board_title }<div class="small pull-right text-right">${read.member_id}<br>${read.board_date }</div></h3>
		

			</div>
			<div class="panel-body content" style="height: auto;">
					${read.board_content}
			</div>
	  
			<div style="text">
					<i class="glyphicon glyphicon-comment" >
					<input type="text" name="bcomment_content" id="bcomment_content" /><span>
					<input type="button" id="btnReplywrite" onclick=replywritebtn(); class="btn btn-default" value="댓글작성"/></span></i>
					</div><br>
					<div id="listReply" class='comment_list'>
			</div>  
		</div>
			<div style="text-align: right">
					<c:if test="${sessionScope.sessionId.member_id == read.member_id }">
						<input type="button" onclick="location.href='<%=request.getContextPath()%>/boardread.action?board_no=${read.board_no}'" class="btn btn-default" value="수정" />
						<input type="button" id="btnDelete" onclick=deletebtn(); name="btnDelete" class="btn btn-default" value="삭제">
					</c:if>
					</div><br><br>
	</div>
</div>
</div>
</body>
</html>