<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css"> -->
<link href="resources/css/timeline/bootstrap.3.3.7.css" rel="stylesheet">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="resources/css/style.css">
  <link rel="stylesheet" type="text/css" href="resources/css/starability-all.min.css"/>

<!-- <link rel="stylesheet" href="resources/css/component.css">
<link rel="stylesheet" href="resources/css/normalize.css">
<script src="resources/js/classie.js"></script>
<script src="resources/js/colorfinder-1.1.js"></script>
<script src="resources/js/gridScrollFx.js"></script>
<script src="resources/js/imagesloaded.pkgd.min.js"></script>
<script src="resources/js/masonry.pkgd.min.js"></script>
<script src="resources/js/modernizr.custom.js"></script>
 -->
<title>FoodToLuck</title>
<script src="resources/jquery-3.2.1.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	//alert(${memberMenu.size()});

	var isOwner = ${isOwner};
	alert("isOwner = " + isOwner);
	
	var allMenuSize = ${allMenu.size()};
	if(allMenuSize==0){
		$('#isEmpty').html('등록된 메뉴가 없습니다.');
	};
	
	if(isOwner==true){
		$('#addMenu').attr("type","button");
// 		$('.menu_modify_btn').attr("type","button"); 고침
// 		$('.menu_delete_btn').attr("type","button");
		$('.menu_modify_btn').css("display","");
		$('.menu_delete_btn').css("display","");
	};
	
	$("#addMenu").click(function(){
		$('.layer_identify').css("display","block");
	});
	
	$(".btn_layer_close").click(function(){
		$('.layer_identify, .modify_menu').css("display","none");
		//$("form")[0].reset(); 
	});
	
	//메뉴수정
	$(".menu_modify_btn").click(function(){
		var btnId = $(this).attr("id");
		$('#modify_menu_'+btnId).css("display","block");
		
		//textarea 부분 엔터키 처리
		var menu_origin_modify = $(".menu_origin_"+btnId).html();
		var menu_intro_modify = $(".menu_intro_"+btnId).html();
		
		menu_origin_modify = menu_origin_modify.replace(/&lt;br&gt;/g,'\n');
		$(".menu_origin_"+btnId).html(menu_origin_modify);
		
		menu_intro_modify = menu_intro_modify.replace(/&lt;br&gt;/g,'\n');
		$(".menu_intro_"+btnId).html(menu_intro_modify);
		//--end-- textarea 부분 엔터키 처리
	});
	
	//메뉴삭제
	$(".menu_delete_btn").click(function(){
		//var that = this;
		var btnId = $(this).attr("id");
		var truck_code = $('#truck_code_val').val();
		var yesNo = confirm('삭제하시겠습니까?');
		if(yesNo) { 
			$.ajax({
				type:"post",
				url:"<%=request.getContextPath()%>/deleteMenu",
				data: {"menu_no": btnId , "truck_code" : truck_code},
				success:function(result){
					if(result==0){
						alert("삭제 실패");
					}else{
						$('#menu_'+btnId).remove();
					}
					
				}
			});
			
		} 
	});	
	
	//메뉴추가
	$("#addMenuForm").on("submit", function() {
		var menu_origin_input = $(".menu_origin_input").val();
		var menu_intro_input = $(".menu_intro_input").val();
		menu_origin_input = menu_origin_input.replace(/(?:\r\n|\r|\n)/g, '<br>');
		menu_intro_input = menu_intro_input.replace(/(?:\r\n|\r|\n)/g, '<br>');
		$(".menu_origin").val(menu_origin_input);
		$(".menu_intro").val(menu_intro_input);
	}); 
	
	//좋아요
	$('button[name=menu_like]').on("click",function(){
		var id = $(this).attr("id");
		if($(this).children("img").attr("src")=="resources/img/like/like_icon.png"){
			$.ajax({
				type:"post",
				url:"<%=request.getContextPath()%>/addMemberMenu",
				data: {"menu_no": $(this).attr("id") },
				context:this,
				success:function(result){	
						$(this).children("img").attr("src","resources/img/like/unlike_icon.png");
						$("#like_span_"+id).text(result);
				},
				error:function(error){
					alert("로그인이 필요합니다.");
				}
			});
		}else if($(this).children("img").attr("src")=="resources/img/like/unlike_icon.png"){
			$.ajax({
				type:"post",
				url:"<%=request.getContextPath()%>/deleteMemberMenu",
				data: {"menu_no": $(this).attr("id") },
				context:this,
				success:function(result){
					$(this).children("img").attr("src","resources/img/like/like_icon.png");
					$("#like_span_"+id).text(result)
				},
				error:function(error){
					alert("로그인이 필요합니다.");
				}
			});
		}
	});
	

}); /* document.ready */

//넘어온 값이 빈값인지 체크합니다. 
// !value 하면 생기는 논리적 오류를 제거하기 위해
// 명시적으로 value == 사용 
// [], {} 도 빈값으로 처리 
/* var isEmpty = function(value){ 
	if( value == "" || value == null || value == undefined 
			|| ( value != null && typeof value == "object" && !Object.keys(value).length ) ){ 
		return true 
		}else{ 
			return false 
		} 
	}; */

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
    margin-left: 0px;
    position: absolute;
    top: 100px;
    left: 29%;
    display: none;
    box-shadow: 0 1px 1px 1px rgba(0,0,0,0.12);
    background: #fff;
    z-index: 40;
}
.modify_menu {
	box-sizing: border-box;
    padding: 35px 30px 30px;
    width: 456px;
    border: 1px solid #444;
    margin-left: -100px;
    position: relative;
    top: 0px;
    left: 22%;
    display: none;
    box-shadow: 0 1px 1px 1px rgba(0,0,0,0.12);
    background: #fff;
    z-index: 40;
}
.layer_identify h4 ,.modify_menu h4{
    margin-bottom: 12px;
    color: #444;
    font-size: 20px;
    font-weight: bold;
    text-align: left;
    letter-spacing: -1px;
}
.layer_identify .btn_layer_close ,.modify_menu .btn_layer_close{
    position: absolute;
    top: 14px;
    right: 14px;
    width: 17px;
    height: 17px;
    border: 0 none;

}
.layer_identify h4 ,.modify_menu h4{
    margin-bottom: 12px;
    color: #444;
    font-size: 20px;
    font-weight: bold;
    text-align: left;
    letter-spacing: -1px;
}
.layer_identify .btn_layer_close ,.modify_menu .btn_layer_close{
    position: absolute;
    top: 14px;
    right: 14px;
    width: 17px;
    height: 17px;
    border: 0 none;

}
</style>
<body>
<!-- Navigation -->
<!-- <div class='container navigation'> -->
<!-- 	<div class="row navbar"> -->
		<!-- 여기는 네브바 include -->
	<!-- 
		<div class='row'>헤더 부분
	 		<form class="form-inline">
		  		<div class="form-group">
		    		<input type="text" class="form-control" style="width:290px" placeholder="Search">
		  		</div>
		  		<button type="submit" class="btn btn-default">&nbsp;&nbsp;검색&nbsp;&nbsp;</button>
			</form>
		</div> -->
<!-- 	</div> -->
<!-- </div> -->


<!-- Center Main -->
	<!-- 상단 로그인 메뉴 -->
<!-- 	<div class='container'> -->

<!-- 		<div class='row'> -->
			<!-- 왼쪽  -->
<!-- 			<div class='col-xs-12 col-md-3' style='overflow: hidden'> -->
<%-- 	    		<jsp:include page="../framemode/truck_menu_left.jsp"> --%>
<%-- 	    			<jsp:param value="${isFavorite }" name="isFavorite"/> --%>
<%-- 	    		</jsp:include> --%>
<!-- 			</div> -->
			
			<!-- 중  -->
<!-- 			<div class='col-xs-12 col-md-6'> -->
<!-- 				<div class="row"> -->
			    		<input type="hidden" id="addMenu" value="메뉴추가" class="btn btn-warning btn-lg btn3d" style="width:90% !important;">
<!-- 	    			<div id=""> -->
<!-- 		    			<h3> -->
<!-- 		    				<div id="isEmpty"></div> -->
<!-- 		    			</h3> -->
<!-- 	    			</div> -->
	    			<Br>
	    			<br>
	    			<br>		
<!-- 					<ul> -->
					
						<c:forEach items="${allMenu}" var="menu">
						
<!-- 							<li> -->
<%-- 								<div class="col-xs-6 col-sm-4" id="menu_${menu.menu_no }"> --%>
<%-- 								<div id="menu_${menu.menu_no }">  <!-- 고침 --> --%>
			    				<div id="menu_${menu.menu_no }" style="width:180px;float:left;margin:2px" class="w3-card-4">
<!-- 			    				<div style="width:200px"> -->
									<img src="${menu.menu_image }" alt="Norway" style="width:180px; height:180px">
									<div class="w3-container">
									<h4>${menu.menu_name }</h4>
									<h5>₩ ${menu.menu_price }</h5>
										<c:choose>
											<c:when test="${menu.user_like eq 'unlike'}">
												<button type="button" id="${menu.menu_no }" name='menu_like' class="menu_like_${menu.menu_no }" style="border:0;background-color:white">
													<img src="resources/img/like/like_icon.png" style="width:60px;height:30px"/>
												</button>
												<span id='like_span_${menu.menu_no }' class="like_number"> ${menu.menu_like }</span>
											</c:when>
											<c:when test="${menu.user_like eq 'like' }">
												<button type="button" id="${menu.menu_no }" name='menu_like' class="menu_like_${menu.menu_no }" style="border:0;background-color:white">
													<img src="resources/img/like/unlike_icon.png" style="width:60px;height:30px"/>
												</button>
												<span id='like_span_${menu.menu_no }' class="like_number"> ${menu.menu_like }</span>
											</c:when>
										</c:choose>
										&nbsp;&nbsp;&nbsp;&nbsp;
									<a href="detailedmenu?menu_no=${menu.menu_no }&truck_code=${foodtruck.truck_code}">>></a>
			  						<br/>
<%-- 			  						<input type="hidden" id="${menu.menu_no }" class="menu_modify_btn" value="수정"> 고침--%>
			  						<button type="button" id="${menu.menu_no }" class="menu_modify_btn btn btn-primary btn-lg btn3d" style="display:none; width:65px;">수정</button>
			  						
<%-- 			  						<input type="hidden" id="${menu.menu_no }" class="menu_delete_btn" value="삭제"> --%>
			  						<button type="button" id="${menu.menu_no }" class="menu_delete_btn btn btn-primary btn-lg btn3d" style="display:none; width:65px;">삭제</button>
			  						<br/>
			  						<br>				
									</div>
									
									
									
										<div class="modify_menu" id="modify_menu_${menu.menu_no }">
											<h4>메뉴 수정</h4>
											<button type="button" class="btn_layer_close">
												<span>X</span>
											</button>
											<p class="txt" id="email_layer_sub_title">메뉴정보를 수정합니다.
											</p>
											<form action="modifyMenu" method="post" enctype="multipart/form-data">
											<input type="hidden" name="menu_no" value="${menu.menu_no }">
											<input type="hidden" id="truck_code_val" name="truck_code" value='${foodtruck.truck_code }'>
											<table class="tbl_fieldset">
												<caption></caption>
												<colgroup>
													<col style="width: 130px;">
													<col>
												</colgroup>
												<tbody>
													<tr>
														<th>이름</th>
														<td>
															<input type="text" id="menu_name" name="menu_name" value="${menu.menu_name }">
														</td>
													</tr>
													<tr>
														<th>원산지 <br>표시</th>
														<td>
															<textarea rows="7" cols="20" class="menu_origin_${menu.menu_no }" name="menu_origin">${menu.menu_origin }</textarea>
														</td>
													</tr>
													<tr>
														<th>가격</th>
														<td>
															<input type="text" id="menu_price" name="menu_price" value="${menu.menu_price }">원
														</td>
													</tr>
													<tr>
														<th>소개</th>
														<td>
															<textarea rows="7" cols="20" class="menu_intro_${menu.menu_no }" name="menu_intro">${menu.menu_intro}</textarea>
														</td>
													</tr>
													<tr>
														<th>이미지</th>
														<td><input type="file" id="image_file" name="image_file"/></td>
													</tr>
												</tbody>
											</table>
											<div class="bottom_btn_wrap">
<!-- 												<input type="submit" class="btn_basic_type01" value="수정"/> -->
												<button type="submit" class="menu_modify_btn btn btn-primary btn-lg btn3d">수정</button>
											</div>
											</form>
										</div>
								</div>	    		
<!-- 								</div>  고침 -->
								
<!-- 							</li> -->
						</c:forEach>
					
<!-- 					</ul> -->
					<!-- 메뉴등록 모달 -->
					<div class="layer_identify open" id="layer_pop_byemail">
						<h4>메뉴 등록</h4>
						<button type="button" class="btn_layer_close">
							<span>X</span>
						</button>
						<p class="txt" id="email_layer_sub_title">메뉴 정보를 상세히 입력해주세요.</p>
						<form id="addMenuForm" action="addMenu" method="post" enctype="multipart/form-data">
						<input type="hidden" name="truck_code" value="${foodtruck.truck_code }">
						<table class="tbl_fieldset">
							<caption></caption>
							<colgroup>
								<col style="width: 200px;">
								<col>
							</colgroup>
							<tbody>
								<tr>
									<th>이름</th>
									<td>
										<input type="text" id="menu_name" name="menu_name">
									</td>
								</tr>
								<tr>
									<th>원산지 표시</th>
									<td>
										<textarea rows="7" cols="20" class="menu_origin_input"></textarea>
										<input type="hidden" class="menu_origin" name="menu_origin" value=""/>
									</td>
								</tr>
								<tr>
									<th>가격</th>
									<td>
										<input type="text" id="menu_price" name="menu_price">원
									</td>
								</tr>
								<tr>
									<th>소개</th>
									<td>
										<textarea rows="7" cols="20" class="menu_intro_input"></textarea>
										<input type="hidden" class="menu_intro" name="menu_intro" value=""/>
									</td>
								</tr>
								<tr>
									<th>이미지</th>
									<td><input type="file" id="image_file" name="image_file"/></td>
								</tr>
							</tbody>
						</table>
						<div class="bottom_btn_wrap">
							<button type="submit" class="menu_modify_btn btn btn-primary btn-lg btn3d">등록</button>
						</div>
						</form>
					</div>		
			  
<!-- 				</div> -->
<!-- 			</div> -->
			
			<!-- 오른쪽  -->
<!-- 			<div class='col-xs-12 col-md-3'> -->
			
<!-- 			</div> -->
<!-- 		</div> -->
		
<!-- 	</div> container end -->	
</body>
</html>