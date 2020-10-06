<%@ page language="java" 
	contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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

<!-- font-awesome (css icon) -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.6.3/css/font-awesome.min.css">

<!-- BootStrap -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<!-- JQuery  -->
<!-- <script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script> -->

<script type="text/javascript" src="resources/jquery-3.2.1.min.js"></script> 
<script>
	
	$(document).ready(function(){
		var allTruckSize = ${Alltruck.size()};
		if(allTruckSize==0){
			$('#isEmpty').html('등록된 트럭이 없습니다');
		};
		$("#Addtruck").click(function(){
			//$('.layer_identify').css("display","block");
			<%-- location.replace('<%=request.getContextPath()%>/addTruck'); --%>
			location.href='<%=request.getContextPath()%>/addTruck';
		})
		
		$(".btn_layer_close").click(function(){
			$('.layer_identify, .modify_truck').css("display","none");
			//$("form")[0].reset(); 
		})
		
		$(".truck_modify_btn").click(function(){
// 		$("#truck_modify_btn").click(function(){

			var truck_code = $(this).siblings("input[type='hidden']").val();
			//$('#modify_truck_'+btnId).css("display","block");
			location.href='<%=request.getContextPath()%>/modifyTruck?truck_code='+truck_code;
		});
		
		$(".truck_delete_btn").click(function(){
// 		$("#truck_delete_btn").click(function(){
			var truck_code = $(this).siblings("input[type='hidden']").val();
			var yesNo = confirm('삭제하시겠습니까?');
			if(yesNo) { 
				$.ajax({
					type:"post",
					url:"<%=request.getContextPath()%>/deleteTruck",
					data: {"truck_code": truck_code },
					success:function(result){
						if(result==0){
							alert("삭제 실패");
						}else{
							location.replace('<%=request.getContextPath()%>/truckCondition');
						}
						
					}
				})
				
			} 
		});	
	});
	</script>
	
<style>
ul{
   list-style:none;
} 

.layer_identify{
    box-sizing: border-box;
    padding: 35px 30px 30px;
    width: 456px;
    border: 1px solid #444;
    margin-left: -228px;
    position: absolute;
    top: 100px;
    left: 29%;
    display: none;
    box-shadow: 0 1px 1px 1px rgba(0,0,0,0.12);
    background: #fff;
    z-index: 40;
}
.modify_truck {
	box-sizing: border-box;
    padding: 35px 30px 30px;
    width: 456px;
    border: 1px solid #444;
    margin-left: -228px;
    position: relative;
    top: 5px;
    left: 29%;
    display: none;
    box-shadow: 0 1px 1px 1px rgba(0,0,0,0.12);
    background: #fff;
    z-index: 40;
}
.layer_identify h4 ,.modify_truck h4{
    margin-bottom: 12px;
    color: #444;
    font-size: 20px;
    font-weight: bold;
    text-align: left;
    letter-spacing: -1px;
}
.layer_identify .btn_layer_close ,.modify_truck .btn_layer_close{
    position: absolute;
    top: 14px;
    right: 14px;
    width: 17px;
    height: 17px;
    border: 0 none;

}
</style>


</head>
<body>
	<jsp:include page="../framemode/FT_header.jsp"/>

	<!-- Page Content -->
	<div class="container">

		<div class="row">

			<div class="col-lg-3">
				<h1 class="my-4">MyPage</h1>
				<div class="list-group">
					<a href="info.mypage" class="list-group-item">정보 수정</a>
						<ul>
							<li><a href="info.mypage"> 개인정보 수정</a></li>
							<li><a href="password.mypage">비밀번호 수정</a></li>
						</ul>
					<a href="favorite" class="list-group-item">즐겨찾기</a> 
					<a href="truckCondition" class="list-group-item active">트럭현황</a>
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
					<div class="card-header">트럭 현황</div>				
					<div class="card-body">
					
					<button type="button" id="Addtruck" class="btn btn-primary btn-lg btn3d">트럭 등록</button>
<!-- 					<input type="button" id="Addtruck" value="트럭 등록"> -->
					<div id="">
	    				<h3>
		    				<div id="isEmpty"></div>
		    			</h3>
		    		</div>
		    		<Br>
						<ul>
							<c:forEach items="${Alltruck}" var="foodtruck">
							<div class="truck_list">											
								<li>
								<a href="timelines?truck_code=${foodtruck.truck_code }">
								<img src="${foodtruck.truck_image }" width=300px height=200px /><br>
									<h3>${foodtruck.truck_name }</h3>
									<c:forEach items="${foodlist }" var="foodlist">
			                              <c:if test="${foodlist.truck_code == foodtruck.truck_code}">
			                                 ${foodlist.foodtype_name }
			                              </c:if>
			                        </c:forEach><br>
									${foodtruck.truck_intro }<br>	
									${foodtruck.address_full }<Br>
								</a>
								
								<button type="button" class="truck_modify_btn btn btn-primary btn-lg btn3d">수정</button>
<%-- 								<input id="${foodtruck.truck_code }" class="truck_modify_btn" type="button" value="수정"> --%>
								&nbsp;
								<button type="button" class="truck_delete_btn btn btn-primary btn-lg btn3d">삭제</button>
<%-- 								<input id="${foodtruck.truck_code }" class="truck_delete_btn" type="button" value="삭제"> --%>
								<input type="hidden" id="truck_code" value="${foodtruck.truck_code }"> <!-- 추가 -->
								</li>
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
	<!-- /.container -->

	<!-- <!-- Footer 
	<footer class="py-5 bg-dark">
		<div class="container">
			<p class="m-0 text-center text-white">Copyright &copy; FoodToLuck 2017</p>
		</div>
		/.container
	</footer> -->

	
	<!-- Bootstrap core JavaScript -->
	<script src="resources/jquery-3.2.1.min.js"></script>
	<script src="resources/js/bootstrap.bundle.min.js"></script>  
</body>
</html>
