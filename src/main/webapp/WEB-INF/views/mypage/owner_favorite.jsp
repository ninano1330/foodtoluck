<%@ page language="java" 
	contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%-- <%@include file="../mainFrame/mainFrame.jsp"%> --%>
<!DOCTYPE html> 
<html>
<head>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>FoodToLuck - MyPage</title>

<!-- Bootstrap core CSS -->
<link href="resources/css/bootstrap.min.css" rel="stylesheet">
<style>
ul{
   list-style:none;
   }
</style>
<script type="text/javascript" src="resources/jquery-3.2.1.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	var favoriteTruckSize = ${favoriteFoodtruck.size()};
	if(favoriteTruckSize==0){
		$('#isEmpty').html('아직 즐겨찾기된 트럭이 없습니다');
	};
	
	$("#delFavoriteBtn").on("click",function(){
		alert("버튼클릭");
		var truck_code = $(this).prev("input[type='hidden']").val();
		alert("truck_code = " + truck_code);
		$.ajax({
			type:"post",
			url:"<%=request.getContextPath()%>/deleteFavorite",
			data: {"truck_code": truck_code },
			context:this,
			success:function(result){
				alert("success 시작");
				$(this).parent(".truck_list").remove();
				if(favoriteTruckSize = 1){
					$('#isEmpty').html('아직 즐겨찾기된 트럭이 없습니다');
				}
			
			}
		});
	});

});
</script>
</head>
<body>
	<jsp:include page="../framemode/FT_header.jsp"/>
	<!-- Page Content -->
	<div class="container">

		<div class="row">

			<div class="col-lg-3">
				<h1 class="my-4">MyPage</h1>
				<div class="list-group">
					<a href="#" class="list-group-item">정보 수정</a>
						<ul>
							<li><a href="info.mypage"> 개인정보 수정</a></li>
							<li><a href="password.mypage">비밀번호 수정</a></li>
						</ul>
					<a href="favorite" class="list-group-item active">▶즐겨찾기</a> 
					<a href="truckCondition" class="list-group-item">트럭현황</a>
					<a href="#" class="list-group-item">회원 탈퇴</a>
				</div>
			</div>
			<!-- /.col-lg-3 -->

			<div class="col-lg-9">

				<!-- <div class="card mt-4">
					<img class="card-img-top img-fluid"
						src="http://placehold.it/900x400" alt="">
					<div class="card-body">
						<h3 class="card-title">Product Name</h3>
						<h4>$24.99</h4>
						<p class="card-text">회원정보다</p>
						<span class="text-warning">&#9733; &#9733; &#9733; &#9733;
							&#9734;</span> 4.0 stars
					</div>
				</div> -->
				<!-- /.card -->

				<div class="card card-outline-secondary my-4">
					<div class="card-header">즐겨찾기 목록</div>
					<div class="card-body">
					<div id="">
	    				<h3>
		    				<div id="isEmpty"></div>
		    			</h3>
		    		</div>
		    		<Br>
						<ul>
							<c:forEach items="${favoriteFoodtruck}" var="foodtruck">
							<div class="truck_list">											
								<a href="timelines?truck_code=${foodtruck.truck_code }">
								<img src="${foodtruck.truck_image }" width=300px height=200px /><br>
									 <h2><strong>${foodtruck.truck_name }</strong></h2>
									<h4>
									<c:forEach items="${foodlist }" var="foodlist">
			                              <c:if test="${foodlist.truck_code == foodtruck.truck_code}">
			                              	<span style="color:#5882FA; font-weight:800;"> ${foodlist.foodtype_name }</span>
			                              </c:if>
			                        </c:forEach>
			                        </h4>
									<h4><span style="color:#6E6E6E; font-weight:600;">${foodtruck.truck_intro }</span></h4>
									<h4><span style="color:#00BFFF; font-weight:600;">${foodtruck.address_full }</span></h4>
								</a>
								<input type="hidden" id="truck_code" value="${foodtruck.truck_code }"/>
								<button type="button" id="delFavoriteBtn" class="btn btn-primary btn-lg btn3d">삭제</button>
								<br><br>
							</div>		
							</c:forEach>
						</ul>						
						<Br>
							
					
					</div>
				</div>
				<!-- /.card -->

			</div>
			<!-- /.col-lg-9 -->

		</div>

	</div>
	<script src="resources/jquery-3.2.1.min.js"></script>
	<script src="resources/js/bootstrap.bundle.min.js"></script>

</body>
</html>
