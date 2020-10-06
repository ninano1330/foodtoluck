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
<style>
ul{
   list-style:none;
   }
</style>
<script type="text/javascript" src="resources/jquery-3.2.1.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	var password_now = false;
	var password = true;
	var password_confirm= true;
	
	$('#member_pw_now').blur(function(){
		//$("#passInfo").html('야야야');
		$.ajax({
			type:"post",
			url:"<%=request.getContextPath()%>/password.check",
			data: {"member_pw_now": $('#member_pw_now').val() },
			success:function(result){
				if(result==true){
					console.log(result);
					$('#passInfo').html("");
					password_now=true;
				}else{
					$('#passInfo').html("비밀번호가 맞지 않습니다.");
					
				}
				
			}
		})
	});

	$("form").submit(function() {
			if (password_now && password&& password_confirm) {
				return true;
			}
			return false;
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
				<jsp:include page="mypage_side.jsp"></jsp:include>
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
					<div class="card-header">비밀번호 수정</div>
					<div class="card-body">
					<form action="password.mypage" method="post">
						<!-- <p>현재 비밀번호 <input type="password" id="" name=""></p>
						<small class="text-muted">비밀번호 수정시에만 입력.</small>
						<hr> -->
						<table border=0>
							<tbody id="pass" name="pass">
							<tr>
								<th> 현재 비밀번호 </th>
								<td> <input type="password" id="member_pw_now" name="member_pw_now" required> 
								<span id="passInfo"></span>
								</td>
							</tr>
							<tr>
								<th> 변경 비밀번호 </th>
								<td> <input type="password" id="member_pw" name="member_pw" required> 
								<span id="passValid"></span>
								</td>
							</tr>
							<tr>
								<th> 변경 비밀번호 확인 </th>
								<td> <input type="password" id="member_pw_confirm" name="member_pw_confirm" required>
								<span id="passConfirm"></span> 
								</td>
							</tr>
							</tbody>
						</table>
						<Br>
						<!-- <a href="javascript:;" id="pwModify" class="btn btn-success" onclick="return false;">비밀번호 수정</a> -->
<!-- 						<input type="submit" value="수정하기"> -->
						<button type="submit" class="btn btn-primary btn-lg btn3d">수정</button>
					</form>
					
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
