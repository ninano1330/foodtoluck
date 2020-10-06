<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="resources/css/timeline/bootstrap.3.3.7.css" rel="stylesheet">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="resources/css/style.css">
<link rel="stylesheet" type="text/css"
	href="resources/css/starability-all.min.css" />

<title>FoodToLuck</title>
<style>
body{
	margin: 0 auto 0 auto;
	padding: 5px;
}

</style>
<script src="resources/jquery-3.2.1.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){	
	
	getReviewFeedbackList(1);
	
	function getReviewFeedbackList(currentPage){
		var menu_no = "${menuVO.menu_no}";
		var truck_code = "${truck_code}";
		$.ajax({
			type:"GET",
			url:"reviewPage.do",
			data:"menu_no="+menu_no+"&currentPage="+currentPage+"&truck_code="+truck_code,
			success:function(result){
				appendReviewList(result);
				appendPaging(result);
				$("#currentPage").val(currentPage);
			}
		});
	}
	
	$(document).on("click","#pageNum > a",function(){
		var currentPage = $(this).children(".page").val();
		getReviewFeedbackList(currentPage);
	});
	
	
	$(document).on("click","#reviewList .feedbackFormBtn",function(){
		
		var feedback_content = $(this).siblings(".feedback_content").val();
		var menu_no = "${menuVO.menu_no}";
		var currentPage = $("#currentPage").val();
		var member_id = $(this).parent().siblings(".member_id").val();
		var truck_code = "${truck_code}";
		
		var data = "feedback_content="+feedback_content+"&menu_no="+menu_no+"&currentPage="+currentPage+"&member_id="+member_id
		+"&truck_code="+truck_code;
		
		$.ajax({
			type: "POST",
			url : "feedback.do",
			data: data,
			success: function(){
				getReviewFeedbackList(currentPage);
			}
		});
	});
	
	
	$(document).on("click",".feedbackDiv a",function(){
		var menu_no = "${menuVO.menu_no}";
		var member_id = $(this).parent().siblings(".member_id").val();
		var currentPage = $("#currentPage").val();
		var truck_code = "${truck_code}";
		
		var data = "menu_no="+menu_no+"&member_id="+member_id+"&currentPage="+currentPage+"&truck_code="+truck_code;
		
		$.ajax({
			type: "POST",
			url: "deleteMyFeedback.do",
			data: data,
			success: function(){
				getReviewFeedbackList(currentPage);
			}
		});
	});
	
	
	function appendPaging(result){
		var startPage = result.pageMap.startPage;
		var endPage = result.pageMap.endPage;
		var recogNextBlock = result.pageMap.recogNextBlock;
		
		$("#pageNum").html("");
		for(var j=startPage; j<=endPage; j++){
			if(j == startPage){
				if(startPage>5){
					$("#pageNum").append(
					"<a><input type='hidden' value='"+(j-1)+"' class='page'>이전</a>&emsp;"
					);
				}
			}
			
			$("#pageNum").append(
					"<a><input type='hidden' value='"+j+"' class='page'>"+j+"</a>&emsp;");
			
			if(j == endPage){
				if(recogNextBlock ==1){
					$("#pageNum").append(
							"<a><input type='hidden' value='"+(j+1)+"' class='page'>다음</a>");
				}	
			}			
		}
	}
	
	function appendReviewList(result){
		var menu_no = result.reviewFeedbackList[0].menu_no;
		
		$("#reviewList").html("");
		for(var i=0; i<result.reviewFeedbackList.length; i++){
			var member_id = result.reviewFeedbackList[i].member_id;
			var member_image = result.reviewFeedbackList[i].member_image;
			var menu_star = result.reviewFeedbackList[i].menu_star;
			var review_content = result.reviewFeedbackList[i].review_content;
			var review_date = result.reviewFeedbackList[i].review_date;
			
			var owner_id = result.reviewFeedbackList[i].owner_id;
			var feedback_date = result.reviewFeedbackList[i].feedback_date;
			var feedback_content = result.reviewFeedbackList[i].feedback_content;
			
			var tag = "";
			if($("#checkOwner").val() == "true"){ //사장일 때
				if(owner_id !=""){ //피드백 있을 때
					tag = "<div class='feedbackDiv' style='background-color:#EAEAEA; clear:both;'>" 
						+"사장님&emsp;" + feedback_date + "&emsp;<a>삭제</a>"
						+"<br>"
						+feedback_content
						+"</div>"
				}else{ //피드백 없을 때
					tag = "<div class='feedbackDiv' style='clear:both;'>" 
						+ "<input type='text' class= 'feedback_content' value='답글쓰기'/>"
						+ "<input type='button' class='feedbackFormBtn' value='확인'/>"
						+ "</div>" 
				}
			}else{ //일반사용자 일 때
				if(owner_id !=""){ //피드백 있을 때
					tag = "<a>댓글보기</a>"
					  + "<div class='feedbackDiv' style='background-color:#EAEAEA; clear:both; display:none'>"
					  + "사장님&emsp;" + feedback_date + "<br>"
					  + feedback_content
					  + "</div>"
				}else{ //피드백 없을 때
					tag = "<div class='feedbackDiv' style='background-color:#EAEAEA; clear:both; display:none'>"
						+ "사장님&emsp;" + feedback_date + "<br>"
						+ feedback_content
						+ "</div>"
				}
			}
	
			$("#reviewList").append(
					"<form class='form-inline'>"
						+"<div class='form-group left-margin' >"
							+"<img src='" + member_image + "' width='40' height='40'/>"
							+ member_id + "&emsp;&emsp; "+review_date + "<br>"
							+ "<div>" + review_content + "</div>"
							+"<div class='starability-result' data-rating=" + menu_star+ " aria-describedby='result1' style='float:left'></div>&emsp;"
							+ "<input type='hidden' value='"+member_id+"' class='member_id'/>"
							+ tag
						+ "</div>"
					+"</form>"
			);
		}
	}

	
	$(document).on("click","#reviewList a",function(){
		if($(this).text() == "댓글보기"){
			$(this).next().show();
			$(this).text("숨기기");
		}
		else if($(this).text() == "숨기기"){
			$(this).next().hide();
			$(this).text("댓글보기");
		}
		
	});
	
	$("#reviewFormBtn").on("click",function(){  //동적 이벤트로 바꾸기
		      var sesssionId = "${sessionScope.sessionId}";      
		      if(sesssionId== ""){
		         alert("로그인 해주세요.");
		         return false;
		      }

		      if("${checkReview}" == "true"){
		         alert("이미 리뷰를 작성하셨습니다.")
		         return false;
		      }
	});
	
});
</script>
</head>
<body>				
<div style="padding:30px;">	
				<div style="margin:0 auto;">
				<input type= "hidden" id="checkReview" value="${checkReview }"/>
				<input type= "hidden" id="checkOwner" value="${checkOwner }"/>
				<input type= "hidden" id="currentPage" value="1"/>
				<img src="${menuVO.menu_image }" style= "width:450px; height:370px; margin:0 auto;"/>
				<br/><br/>
			
<!-- 				<div class="row"> -->
			<!-- 	<div class="w3-container"> -->
					<table class="table"  style= "width:450px;">
						<tr>
							<td>
								<h5><strong>${menuVO.menu_name}</strong></h5>
								<h6><strong>${menuVO.menu_price}원</strong></h6>
							</td>
						</tr>	
								
						<tr><td>원산지 : ${menuVO.menu_origin}<br /> ${menuVO.menu_intro} </td></tr>
						<tr><td><h2><img src="resources/image/star.jpg" width='30' height='30'> ${avgStar }</h2></td></tr>
					</table>
					</div>
<!-- 				</div> -->
				
				<!-- 코멘트 -->
				<h2>Comment</h2>
				<div style="width: 450px" class="w3-panel w3-card-2">
					<div class="row">
						<c:if test="${checkOwner eq 'false'}">
				<!-- 		<div class="col-md-12"> -->
							<form action="review.do"  id="reviewForm" class="form-inline" style="text-align: left" method="post">
								<div class="form-group">
									<input type="hidden" name="menu_no" value="${menuVO.menu_no }"/>
									<fieldset class="starability-basic">
										<input type="radio" id="no-rate" class="input-no-rate" name="menu_star" value="0" checked aria-label="No rating." />
										<input type="radio" id="rate1" name="menu_star" value="1" />
										<label for="rate1">1 star.</label> 
										<input type="radio" id="rate2" name="menu_star" value="2" /> 
										<label for="rate2">2stars.</label> 
										<input type="radio" id="rate3" name="menu_star" value="3" /> 
										<label for="rate3">3 stars.</label> 
										<input type="radio" id="rate4" name="menu_star" value="4" /> 
										<label for="rate4">4 stars.</label> 
										<input type="radio" id="rate5" name="menu_star" value="5" /> 
										<label for="rate5">5stars.</label>
									</fieldset>
									<input type="hidden" name="truck_code" value="${truck_code}"/>
									<input type="text" name="review_content" class="form-control" style="width: 290px" placeholder="글 남기기">
									<button type="submit" id="reviewFormBtn" class="btn btn-default">입력</button>
								</div>
							</form>
				<!-- 		</div> -->
						</c:if>
					</div>
					<hr/>
					<div class="row">
						<c:if test="${myReview ne null }">
							<div id= "myReview" class="col-md-11" style="background-color: #D4F4FA; width:100%;">
								<form class="form-inline">
									<div class="form-group left-margin">
										<img src="${myReview.member_image }" width='40' height='40' />
										나의 리뷰&emsp;&emsp; ${myReview.review_date } 
										<a href="deleteMyReview.do?menu_no=${myReview.menu_no }&truck_code=${truck_code}" method="GET">삭제</a>
										<div>
											${myReview.review_content}
										</div>
										<div class="starability-result" data-rating=${myReview.menu_star } 
											aria-describedby="result1" style="float:left"></div>&emsp;
										<input type="hidden" value="${myReview.member_id }" class="member_id"/>
										<c:if test="${myReview.owner_id != ''}"> <!-- 피드백이 있을 때 -->
											<div style="background-color:#EAEAEA; clear:both;">
											사장님&emsp;${myReview.feedback_date } <br> ${myReview.feedback_content }
											</div>	
										</c:if> 		
									</div>
								</form>
							</div>
						</c:if>
						<div id= "reviewList" class="col-md-11"> 


						</div>
								
							<div id="pageNum" class="col-md-11">
							</div>
						</div>
					</div>

</div>
</body>
</html>