<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="resources/jquery-3.2.1.min.js"></script>
<link href="resources/css/timeline/bootstrap.3.3.7.css" rel="stylesheet">
<link href="resources/css/font-awesome.min.css" rel="stylesheet">
<link href="resources/css/timeline.css" rel="stylesheet">
<script src="resources/js/bootstrap.3.3.7.js"></script>
<script type="text/javascript">

$(document).ready(function() {
	$("#btn").on("click",function(){
		alert("성공");
		window.location.reload();
	});
	
	$("#test_btn").on("click",function(){
		if($(this).children("img").attr("src") == "resources/img/like/like_icon.png"){
			$(this).children("img").attr("src","resources/img/like/unlike_icon.png")
		}else if($(this).children("img").attr("src") == "resources/img/like/unlike_icon.png"){
			$(this).children("img").attr("src","resources/img/like/like_icon.png")
		}
		
// 		alert("메롱이라구");
// 		$(this).children("img").attr("src","resources/img/like/like_icon.png");
	});
	
	$("#ajaxBtn").on("click",function(){
		alert("클릭성공");
		var a = "a";
		$.ajax({
			type:"get",
			url:"test.main.ajax",
			data:{"a": a},
			success:function(result){
				alert("ajax 성공했습니다");
				$("#testDiv").remove();
			}
		});
	});
});


</script>
</head>
<body>

<button type= "button" id="test_btn"><img src="resources/img/like/like_icon.png" style="width:30px;height:30px">
<h5>좋아요</h5>
</button>

<button type="button" id="ajaxBtn" >ajax입니다</button>

<div id="testDiv">testDiv입니다</div>

<div class="modal fade" id="mdfTimelineModal" >
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
							<h4 class="modal-title">타임라인 수정하기</h4>
							<form id='mdfForm' action='/foodtoluck/mdfTimeline' method="post" enctype="multipart/form-data">
								<div class="modal-body">
									<input type="hidden" id='mdfTruck_code' name='truck_code' value="1">
									<input type="hidden" id='mdfTimelineNo' name='timeline_no'>
									<input type="file" name="timeline_image_file" id="mdfTimelineImageInput" onchange='timelineFNC.checkImage(this, "#mdfTimelineImageSrc")'>
									<img alt="이전 이미지" src="" class='timeline_image' id='mdfTimelineImageSrc'>
									<textarea name="timeline_content" class='writeComment' id="mdfTimelineContent" rows="5" cols="50"></textarea>
								</div>
								<div class="modal-footer">
									<button type="button" id="mdfTimelineAjax" class="btn btn-default" onclick="timelineFNC.mdfTimelineAj()">저장</button>
									<button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
			
			<div class="modal fade" id="mdfCommentModal" >
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
							<h4 class="modal-title">댓글 수정하기</h4>
						</div>
						<form id='mdfCommentForm'>
							<div class="modal-body">
								<input type="hidden" id='mdfCommentMemid' name='member_id' value=<c:out value="${sessionScope.sessionId.member_id}"/>>
								<input type="hidden" id='mdfCommentTrcd' name='truck_code' value="${truck_code}">
								<input type="hidden" id='mdfCommentTcno' name='tcomment_no'>
								<textarea id="mdfCommentContent" class='writeComment' name="tcomment_content" rows="5" cols="50"></textarea>
							</div>
							<div class="modal-footer">
								<button type="button" id="mdfCommentInput" class="btn btn-default" onclick="commentFNC.mdfCommentAj()">저장</button>
								<button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
							</div>
						</form>
					</div>
				</div>
			</div>
</div>
<div>
인클루드입니다
<jsp:include page="testsub.jsp"/>

</div>

</body>
</html>