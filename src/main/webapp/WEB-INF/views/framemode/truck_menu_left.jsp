<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="resources/css/3d_button.css" rel="stylesheet">
<link href="http://fonts.googleapis.com/earlyaccess/hanna.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Aldrich|Bangers|Black+Ops+One|Bowlby+One+SC|Bungee|Bungee+Inline|Days+One|Fredoka+One|Fugaz+One|Graduate|Jockey+One|Press+Start+2P|Racing+Sans+One|Squada+One" rel="stylesheet">

<!-- 
font-family: 'Bungee', cursive;
font-family: 'Fredoka One', cursive;
font-family: 'Bangers', cursive;
font-family: 'Aldrich', sans-serif;
font-family: 'Fugaz One', cursive;
font-family: 'Press Start 2P', cursive;
font-family: 'Days One', sans-serif;
font-family: 'Bowlby One SC', cursive;
font-family: 'Squada One', cursive;
font-family: 'Black Ops One', cursive;
font-family: 'Jockey One', sans-serif;
font-family: 'Graduate', cursive;
font-family: 'Racing Sans One', cursive;
font-family: 'Bungee Inline', cursive; 
-->
<title>FoodToLuck</title>
<!-- <script src="resources/jquery-3.2.1.min.js"></script> -->

<script type="text/javascript">
$(document).ready(function(){
	var isFavorite = ${isFavorite}
	var truck_like=${foodtruck.truck_like};
	
	$('#favoriteStar').removeClass();
	
	if(isFavorite==1){
		$('.favorite').html('<i id="favoriteStar" class="fa fa-star favoriteOn" aria-hidden="true"></i>'+truck_like+' <span id="favor">즐겨찾기 해제</span>');
		//$('#favoriteStar').addClass('fa fa-star favoriteOn');
	}else{
		$('.favorite').html('<i id="favoriteStar" class="fa fa-star-o favoriteOff" aria-hidden="true"></i>'+truck_like+' <span id="favor">즐겨찾기</span>');
		//$('#favoriteStar').addClass('fa fa-star-o favoriteOff');
	}
		
		//즐찾추가,삭제
	$('.favorite').on("click",function(){
		if($('#favor').text()=='즐겨찾기'){
			$.ajax({
				type:"post",
				url:"<%=request.getContextPath()%>/addFavorite",
				data: {"truck_code": $(this).attr("id") },
				success:function(result){
						$('.favorite').html('<i id="favoriteStar" class="fa fa-star favoriteOn" aria-hidden="true"></i>'+result+' <span id="favor">즐겨찾기 해제</span>');						
						//$('#favoriteStar').removeClass();
						//$('#favoriteStar').addClass('fa fa-star favoriteOn');	
				}
			});
		}else if($('#favor').text()=='즐겨찾기 해제'){
			$.ajax({
				type:"post",
				url:"<%=request.getContextPath()%>/deleteFavorite",
				data: {"truck_code": $(this).attr("id") },
				success:function(result){
						$('.favorite').html('<i id="favoriteStar" class="fa fa-star-o favoriteOff" aria-hidden="true"></i>'+result+' <span id="favor">즐겨찾기</span>');		
						//$('#favoriteStar').removeClass();
						//$('#favoriteStar').addClass('fa fa-star-o favoriteOff');				
				}
			});
		}
	});
})

</script>
<style type="text/css">
.favorite{
	background-color: #4285f4;
	color: white;
	width:98%;
}
.favoriteOn{
	color: yellow;
}
.favoriteOff{
	color: gray;
}

.google-maps iframe {
position: absolute;
top: 0;
left: 0;
width: 100% !important;
height: 100% !important;
}

.google-maps {
position: relative;
padding-bottom: 75%;
height: 0;
overflow: hidden;
}
.leftrow{
	padding-bottom: 5px;
	text-align: center;
}
.owner_nick{
	font-size: 150%;
	font-family: 'Hanna', serif !important;
}
.foodtruck_name{
	font-family: 'Hanna', serif !important;
	font-weight:bolder;
	font-size: 300%;
}
</style>
<body>			
	<!-- 메인창 -->
	<div class="row leftmenubox">
		<!-- 왼쪽 -->
   		<div class="col-xs-12 col-md-12">

   			<!-- 이전버전 끝 -->
   				<a href="timelines?truck_code=${foodtruck.truck_code }" style="color:black">
<!-- 	   			<div class="row leftrow"> -->
<!-- 		   			<span class="owner_nick"> -->
<%-- 		   				${owner_nickname} --%>
<!-- 		   			</span>&nbsp;님의 -->
<!-- 	   			</div> -->
	   			<div class="row leftrow">
	   				<span class="foodtruck_name">
	   					${foodtruck.truck_name }
					</span>
	   			</div>
	   			</a>
	   			<div class="row leftrow" style="text-align: center;">
		   			<c:if test="${sessionId != null}">
		   				<button type="button" id="${foodtruck.truck_code }" name="favorite" class="btn btn-info btn-lg btn3d favorite">
	   						<i id="favoriteStar" class="fa fa-star-o" aria-hidden="true"></i>
<!-- 	   						<i id="favoriteStar" class="fa fa-star-o" aria-hidden="true"/> -->
								　
		   				</button>
		   			</c:if>
	   			</div>
	   			<div class="row leftrow">
	   				<img src="${foodtruck.truck_image }" style="width: 100%; height: auto;"/>
	   			</div>
	   			<div class="row leftrow">
	   				<p class="bg-success">${foodtruck.truck_intro }</p>
	   			</div>
	   			<div class="row leftrow">
	   				<div class="col-xs-6 col-md-6">
<%-- 	   					<a href="timelines?truck_code=${foodtruck.truck_code}"><button style="width:100%;" type="button" id="timelineView" class="btn btn-default">TimeLine</button></a> --%>
	   					<button style="width:100%;" type="button" id="timelineView" class="btn btn-default" onclick="location.href='timelines?truck_code=${foodtruck.truck_code}'">TimeLine</button>
	   				</div>
	   				<div class="col-xs-6 col-md-6">
	   					<button type="button" id="truck_menu" class="btn btn-default" style="width:100%" onclick="location.href='truck.menu?truck_code=${truck_code}'">MENU</button>
<%-- 		   				<a href="truck.menu?truck_code=${foodtruck.truck_code}"><button style="width:100%;" type="button" id="truck_menu" class="btn btn-default">MENU</button></a> --%>
	   				</div>
	   			</div>
	   			<br>
	   			<div class="row leftrow">
	   			<div class="col-xs-12 col-md-12">
	   				<img src="https://maps.googleapis.com/maps/api/staticmap?center=${foodtruck.truck_x },${foodtruck.truck_y }&zoom=16&size=290x300&markers=color:blue|${foodtruck.truck_x },${foodtruck.truck_y }&key=AIzaSyBvsrGARPPg9TLm6blBdS96rPXCgfmCuWo"/>
	   			</div>
	   			</div>
   			
   			</div>
   			
   		<!-- </div>  -->
   		<!-- 왼쪽 end-->   		    		
	</div>
</body>
</html>