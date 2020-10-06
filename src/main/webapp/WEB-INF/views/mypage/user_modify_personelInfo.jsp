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

<script type="text/javascript" src="resources/jquery-3.2.1.min.js"></script>
<script type="text/javascript">
var sel_file;

$(document).ready(function(){
	var gender = '${sessionScope.sessionId.member_gender }';
	var email = '${sessionScope.sessionId.member_email}';
	var emailSplit= email.split('@');
	
	$("#emailFirst").attr("value",emailSplit[0]);
	$("#emailSecond").attr("value",emailSplit[1]);

	if(gender=='M'){
		$("#male").attr('checked',"");
	}else{
		$("#female").attr('checked',"");
	}
	$("#image_file").on("change", handleImgFileSelect);	//이미지 미리보기

 	$("form").on("submit", function() {
		var emailForm = $("#emailFirst").val()+'@'+$("#emailSecond").val();
		$("#member_email").attr('value',emailForm);
		//alert(emailForm);
	 }); 
});

function handleImgFileSelect(e){
	var files = e.target.files;
	var filesArr = Array.prototype.slice.call(files);
	
	filesArr.forEach(function(f){
		if(!f.type.match("image.*")){
			alert("확장자는 이미지확장자만 가능합니다.");
			$("#image_file").val('');
			return false;
		}
		
		sel_file = f;
		
		var reader = new FileReader(); //파일을 읽기 위한 FileReader객체 생성
		reader.onload = function(e){ //파일 읽어들이기를 성공했을때 호출되는 이벤트 핸들러
			$("#myImage").attr("src",e.target.result);
			//이미지 Tag의 SRC속성에 읽어들인 File내용을 지정 //(아래 코드에서 읽어들인 dataURL형식)
		}
		reader.readAsDataURL(f);
		//File내용을 읽어 dataURL형식의 문자열로 저장
	});
}

</script>
<style>
ul{
   list-style:none;
}
#myImage{
    position: relative;
    left: 0;
    top: 0;
    width: 250px;
    height: 250px;
    margin: 0;
    padding: 0;
}

#myTable{
	position: relative;
    left: 0;
    top: 0;
    margin: 0;
    padding: 0;
}
</style>
</head>
<body>
	<jsp:include page="../framemode/FT_header.jsp"/>
	<!-- Page Content -->
	<div class="container">
		<div class="row">	
			<div class="col-lg-3">		
				<jsp:include page="mypage_side.jsp"></jsp:include>
			</div>

			<div class="col-lg-9">
				<div class="card card-outline-secondary my-4">
					<div class="card-header">개인 정보 수정</div>
					<div class="card-body">
					
						<!-- <p>현재 비밀번호 <input type="password" id="" name=""></p>
						<small class="text-muted">비밀번호 수정시에만 입력.</small>
						<hr> -->
						<form id="frm" action="info.mypage" method="post" enctype="multipart/form-data">
						<input type="hidden" name="member_id" value="${sessionScope.sessionId.member_id }">				
						<div>
							<img id="myImage" src='${sessionScope.sessionId.member_image }' >
						</div>
						<table id="myTable" border=0>
							<tbody id="info">							
							<tr>
								<th> 아이디 </th>
								<td id="member_id">${sessionScope.sessionId.member_id }  </td>
							</tr>
							<tr>
								<th> 이메일 </th>
								<td> <input type="text" id="emailFirst" value="" required>@<input type="text" id="emailSecond" value="" required>
								<input type="hidden" name="member_email" id="member_email" value=""/><a href="">인증</a>
								</td>
							</tr>
							<tr>
								<td>
								</td>
							</tr>
							<tr>
								<th> 닉네임 </th>
								<td> <input type="text" id="membernick_name" name="membernick_name" value="${sessionScope.sessionId.membernick_name }" required> </td>
							</tr>
							<tr>
								<th> 핸드폰 </th>
								<td> <input type="text" id="member_phone" name="member_phone" value="${sessionScope.sessionId.member_phone }" required> </td>
							</tr>
							<tr>
								<th> 성별 </th>
								<td> 
									<input type="radio" id="male" class="inp_check" name="member_gender" value="M">남 
									<input type="radio" id="female" class="inp_check" name="member_gender" value="F">여
								</td>
							</tr>
							<tr>
								<th> 이미지 </th>
								<td> 
									<input type="file" id="image_file" name="image_file">
								</td>
							</tr>
							</tbody>
						</table>
						
						<Br>
						<div id="confirmBtn" style="clear:both;">
						<!-- <a href="javascript:;" id="infoModify" class="btn btn-success" onclick="return false;">정보 수정</a> -->
						<button type="submit" id="submit" class="btn btn-primary btn-lg btn3d">수정</button>
<!-- 						<input type="submit" id="submit" value="정보 수정"> 고침-->
						</div>
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
