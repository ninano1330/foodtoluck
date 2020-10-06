<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- 
<script src="resources/js/jquery-3.2.1.min.js"></script>
<script src="resources/js/bootstrap.3.3.7.js"></script>
<link href="resources/css/timeline/bootstrap.3.3.7.css" rel="stylesheet">
<link href="resources/css/timeline.css" rel="stylesheet">
<link href="resources/css/font-awesome.min.css" rel="stylesheet"> -->
<!-- <script src="resources/jquery-3.2.1.min.js"></script> -->

<!-- <script src="http://code.jquery.com/jquery-latest.js"></script> -->
<!-- <script src="resources/jquery-3.2.1.min.js"></script> -->
<!-- <link href="resources/css/timeline/bootstrap.3.3.7.css" rel="stylesheet"> -->
<!-- <link href="resources/css/font-awesome.min.css" rel="stylesheet"> -->
<!-- <link href="resources/css/timeline.css" rel="stylesheet"> -->
<!-- <script src="resources/js/bootstrap.3.3.7.js"></script> -->
<!-- <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script> -->

<title>타임라인</title>






<!-- 임시로 입력한 로그인 세션 -->
<%

/* kitri.project.model.MemberVO memberVO1 = 
new kitri.project.model.MemberVO("food777", "777", "010-7777-7777", "food777@kitri.com", "m", "holyshit7", "o", "img07.jpg");
session.setAttribute("sessionId", memberVO1);
 */
%>
<!-- <script src="resources/jquery-3.2.1.min.js"></script> -->
<!-- script시작 -->



<!-- ========================================================================================================= -->

</head>
<body>





<!-- Navigation -->
<div class='container navigation'>
	<div class="row navbar">
		<!-- header login -->
		<jsp:include page="../framemode/FT_header.jsp" flush="false">
			<jsp:param name="parent" value='timeline'/>
			<jsp:param name="truck_code" value='${truck_code}'/>
		</jsp:include>
	</div>
	
</div>
<!-- end Navigation -->

<!-- Center Main -->
<div class='container main'>
	<div class='row'>
	
		<!-- Left menu -->
		<div class='col-xs-12 col-md-3 leftmenu'>
			<jsp:include page="../framemode/truck_menu_left.jsp">
				
				<jsp:param value="${isFavorite }" name="isFavorite"/>
				<jsp:param value="${truck_code }" name="truck_code"/>
			</jsp:include>
			<!-- <img alt="left_menu" src="resources/img/leftmenu2.jpg">	 -->	
		</div>
		<!-- end Left menu -->
		
		<!-- timelinelist  -->
		<div class='col-xs-12 col-md-6 middle'>
			<jsp:include page="${includeViewName }"/>
<%-- 				<jsp:param value="${truck_code}" name="truck_code"/> --%>
<%-- 			</jsp:include> --%>
		</div> 
		<!-- end timelinelist  -->
	


		<div class='col-xs-12 col-md-3 rightmenu'>
			<img alt="right_chat" src="resources/img/chat.jpg">
		</div>
	
	</div>
	<!-- end row  -->	

		
</div>
<!-- Center Main -->

<!-- Footer -->
<!-- <div class='container footer'> -->
<!-- 	<div class='row footer'> -->
		
		
		
<!-- 		<!-- ==================== 탑 버튼 ==== ================ --> 
<!-- 		<button onclick="topFunction()" id="topbtn" title="Go to top">Top</button> -->
		
		
<!-- 		<!-- 로그인 사용자만 --> 
<%-- 		<c:if test="${sessionScope.sessionId != '' && sessionScope.sessionId != null}"> --%>
<!-- 			<!-- ===========================타임라인 수정 용 모달 창 띄우기 ========================================================================== --> 
<!-- 			<!-- <button class="btn btn-default" id="mdfbutton">글 수정</button> --> 
<!-- 			<div class="modal fade" id="mdfTimelineModal" > -->
<!-- 				<div class="modal-dialog"> -->
<!-- 					<div class="modal-content"> -->
<!-- 						<div class="modal-header"> -->
<!-- 							<h4 class="modal-title">타임라인 수정하기</h4> -->
<!-- 							<form id='mdfForm' action='/foodtoluck/mdfTimeline' method="post" enctype="multipart/form-data"> -->
<!-- 								<div class="modal-body"> -->
<%-- 									<input type="hidden" id='mdfTruck_code' name='truck_code' value="${truck_code}"> --%>
<!-- 									<input type="hidden" id='mdfTimelineNo' name='timeline_no'> -->
<!-- 									<input type="file" name="timeline_image_file" id="mdfTimelineImageInput" onchange='timelineFNC.checkImage(this, "#mdfTimelineImageSrc")'> -->
<!-- 									<img alt="이전 이미지" src="" class='timeline_image' id='mdfTimelineImageSrc'> -->
<!-- 									<textarea name="timeline_content" class='writeComment' id="mdfTimelineContent" rows="5" cols="50"></textarea> -->
<!-- 								</div> -->
<!-- 								<div class="modal-footer"> -->
<!-- 									<button type="button" id="mdfTimelineAjax" class="btn btn-default" onclick="timelineFNC.mdfTimelineAj()">저장</button> -->
<!-- 									<button type="button" class="btn btn-default" data-dismiss="modal">취소</button> -->
<!-- 								</div> -->
<!-- 							</form> -->
<!-- 						</div> -->
<!-- 					</div> -->
<!-- 				</div> -->
<!-- 			</div> -->
<!-- 			<!-- ======================  end 타임라인 수정 용 모달 창 띄우기 ========================================================================== --> 
			
<!-- 			<!-- ====================== 댓글, 대댓글 수정용 모달창 ================================================================================= --> 
<!-- 			<div class="modal fade" id="mdfCommentModal" > -->
<!-- 				<div class="modal-dialog"> -->
<!-- 					<div class="modal-content"> -->
<!-- 						<div class="modal-header"> -->
<!-- 							<h4 class="modal-title">댓글 수정하기</h4> -->
<!-- 						</div> -->
<!-- 						<form id='mdfCommentForm'> -->
<!-- 							<div class="modal-body"> -->
<%-- 								<input type="hidden" id='mdfCommentMemid' name='member_id' value=<c:out value="${sessionScope.sessionId.member_id}"/>> --%>
<%-- 								<input type="hidden" id='mdfCommentTrcd' name='truck_code' value="${truck_code}"> --%>
<!-- 								<input type="hidden" id='mdfCommentTcno' name='tcomment_no'> -->
<!-- 								<textarea id="mdfCommentContent" class='writeComment' name="tcomment_content" rows="5" cols="50"></textarea> -->
<!-- 							</div> -->
<!-- 							<div class="modal-footer"> -->
<!-- 								<button type="button" id="mdfCommentInput" class="btn btn-default" onclick="commentFNC.mdfCommentAj()">저장</button> -->
<!-- 								<button type="button" class="btn btn-default" data-dismiss="modal">취소</button> -->
<!-- 							</div> -->
<!-- 						</form> -->
<!-- 					</div> -->
<!-- 				</div> -->
<!-- 			</div> -->
<!-- 			<!-- ======================  end 댓글, 대댓글 수정용 모달창 ============================================================================= --> 
		
<%-- 		</c:if> --%>
<!-- 	</div> -->
<!-- </div> -->
<!-- end Footer -->


</body>
</html>