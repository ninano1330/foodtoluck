<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>FoodToLuck</title>
<!-- <script src="resources/jquery-3.2.1.min.js"></script> -->
<script type="text/javascript">
var isFavorite = ${isFavorite}
	//즐찾 되있나 확인
if(isFavorite==1){
	$('.favorite').val('즐겨찾기 해제');
}else{
	$('.favorite').val('즐겨찾기');
}
	
	//즐찾추가,삭제
$('.favorite').on("click",function(){
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
   				<input type="button" id="${foodtruck.truck_code }" name="favorite" class="favorite" value="">
    			<img src="${foodtruck.truck_image }" style="width: 100%; height: auto;"/>
				<br/><br/>
				<p class="bg-success">${foodtruck.truck_intro }</p>
   			</div>
   			<a href="truck.menu?truck_code=${foodtruck.truck_code }"><button type="button" id="truck_menu" class="btn btn-default" style="width:100%">MENU</button></a>
   			<br/><br/>
   			<img src="resources/img/owner_map_img.JPG" style="width: 100%; height: auto;"/>
   		</div> 
   		<!-- 왼쪽 end-->   		    		
	</div>
</body>
</html>