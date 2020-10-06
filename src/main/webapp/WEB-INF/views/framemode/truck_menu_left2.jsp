<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>FoodToLuck</title>
<!-- <script src="resources/jquery-3.2.1.min.js"></script> -->
<script src="resources/jquery-3.2.1.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	var isFavorite = ${isFavorite};
	
	if(isFavorite==1){
		$('.favorite').val('즐겨찾기 해제');
	}else{
		$('.favorite').val('즐겨찾기');
	}
		
// 	function fn_goMenu(){
// 		var param= "?truck_code="+"${truck_code}";
// 		alert(param);
		
// 		window.location.href = "truck.menu"+param;
// 	};
	
		//즐찾추가,삭제
	$('.favorite').on("click",function(){
		var sesssionId = "${sessionScope.sessionId}";      
	     if(sesssionId== ""){
	        alert("로그인 해주세요.");
	        return false;
	    }
		
		if($('.favorite').val()=='즐겨찾기'){
			$.ajax({
				type:"post",
				url:"<%=request.getContextPath()%>/addFavorite",
				data: {"truck_code": $(this).attr("id") },
				success:function(result){
					if(result==1){
						$('.favorite').val('즐겨찾기 해제');						
					}else{
						alert("다시 시도해주세요.");
					}
					
				}
			});
		}else if($('.favorite').val()=='즐겨찾기 해제'){
			$.ajax({
				type:"post",
				url:"<%=request.getContextPath()%>/deleteFavorite",
				data: {"truck_code": $(this).attr("id") },
				success:function(result){
					if(result==1){
						$('.favorite').val('즐겨찾기');		
					}else{
						alert("다시 시도해주세요.");
					}					
				}
			});
		}
	});
	
	
})

</script>
<style>

</style>
<body>			
	<!-- 메인창 -->
	<div class="row">
		<!-- 왼쪽 -->
   		<div class="col-xs-12 col-md-12">
   			<div style="width:100%">
   				<h2 align="center">${foodtruck.truck_name }</h2>
   				<button type="button" id="22" name="favorite" class="btn btn-info btn-lg btn3d favorite"> <!-- 고침 -->
   				<i id="favoriteStar" class="fa fa-star-o favoriteOff" aria-hidden="true"></i>0 
   				<span id="favor">즐겨찾기</span></button>
   				<input type="button" id="${foodtruck.truck_code }" name="favorite" class="favorite" value="">
    			
    			<img src="${foodtruck.truck_image }" style="width: 100%; height: auto;"/>
				<br/><br/>
				<p class="bg-success">${foodtruck.truck_intro }</p>
   			</div>
   			<button type="button" id="truck_menu" class="btn btn-default" style="width:100%" onclick="location.href='truck.menu?truck_code=${truck_code}'">MENU</button>
<!--    				onclick="fn_goMenu()">MENU</button> -->
   			<br/><br/>
   			<img src="resources/img/owner_map_img.JPG" style="width: 100%; height: auto;"/>
   		</div> 
   		<!-- 왼쪽 end-->   		    		
	</div>
</body>
</html>