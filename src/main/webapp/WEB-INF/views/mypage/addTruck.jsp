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
	
	$("#image_file").on("change", handleImgFileSelect);	//이미지 미리보기

 	$("form").on("submit", function() {
 		
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

function initAutocomplete() {

	 var map = new google.maps.Map(document.getElementById('map'), {
	
	   center: {lat: 37.946295, lng: 126.000023},
	
	   zoom: 8,
	
	   mapTypeId: google.maps.MapTypeId.ROADMAP
	
	 });


	var geocoder = new google.maps.Geocoder;
    var infowindow = new google.maps.InfoWindow;

	 
	
	 var input = document.getElementById('pac-input');
	 var searchBox = new google.maps.places.SearchBox(input);
	
	 map.controls[google.maps.ControlPosition.TOP_LEFT].push(input);


	 map.addListener('bounds_changed', function() {
	
	   searchBox.setBounds(map.getBounds());
	
	 });



	 var markers = [];//이전 마커 지우기용
	 var marker;
	 
	 searchBox.addListener('places_changed', function() {
	
		   var places = searchBox.getPlaces();
	
		   if (places.length == 0) {
		
		     return;
		
		   }
	
		   // 이전 마커 지우기
		   markers.forEach(function(marker) {
		
		     marker.setMap(null);
		
		   }); 
		
		   	markers = [];
	
	
	   		var bounds = new google.maps.LatLngBounds();
	   		
	   
		   places.forEach(function(place) {
		
			     //마커 푸쉬
			     /*  markers.push(new google.maps.Marker({
				       map: map,
				       //icon: icon,
				       title: place.name,
				       position: place.geometry.location,
				       draggable: true
			     })); */ 
			     
			     marker = new google.maps.Marker({
			    	 map: map,
			    	 title: place.name,
			    	 position: place.geometry.location,
			    	 draggable: true
			     });
			     
			     markers.push(marker);
			     
			     google.maps.event.addListener(marker, 'dragend', function(){
			        	console.log(marker.getPosition().lat());
			        	console.log(marker.getPosition().lng());
			        	$('#truck_x').val(marker.getPosition().lat());
			        	$('#truck_y').val(marker.getPosition().lng());
			        	var latlng = {lat: marker.getPosition().lat(), lng: marker.getPosition().lng()};
			        	geocoder.geocode({'location': latlng}, function(results, status){
			        		if(status === 'OK'){
			        			if(results[1]){
			        				console.log('전체 주소: ',results[1].formatted_address);//전체 주소 출력
			        				$('#address_full').val(results[1].formatted_address);
			        				console.log('주소 배열: ',results);
			        				for(var i=0; i<results[1].address_components.length; i++){
			        					console.log(results[1].address_components[i].long_name);
			        				}
			        				$('#address_first').val(results[1].address_components[0].long_name);
			        				$('#address_second').val(results[1].address_components[1].long_name);
			        				$('#address_third').val(results[1].address_components[2].long_name);
			        			}else{
			        				console.log('No results found');
			        			}
			        		}else{
			        			console.log('Geocoder failed due to: ' + status);
			        		}
			        	})
			      });
			     
		
			     //검색했을 때 지도 초점 잡아주기
			     if (place.geometry.viewport) {
			
			       bounds.union(place.geometry.viewport);
			
			     } else {
			
			       bounds.extend(place.geometry.location);
			
			     } 
		
		   });
	
	   		map.fitBounds(bounds);



	});

}

//모달창이 띄어질 경우 구글 맵 리사이즈
function resize(){

$('#myModal').on('shown.bs.modal', function () {

google.maps.event.trigger(map, "resize");

});

}
</script>
<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyB7P2EIMIxzmfTrIdz0qQx8Ftfn2jIhlNA&libraries=places&callback=initAutocomplete"
       async defer></script>
<style>
ul {
	list-style: none;
}

#myImage {
	position: relative;
	left: 0;
	top: 0;
	width: 250px;
	height: 250px;
	margin: 0;
	padding: 0;
}

#myTable {
	position: relative;
	left: 0;
	top: 0;
	margin: 0;
	padding: 0;
}

/***** Google maps CSS *****/
#map {
	height: 100%;
	width: 100%;
	border: 2px solid darkgrey;
}

.controls {
	margin-top: 10px;
	border: 1px solid transparent;
	border-radius: 2px 0 0 2px;
	box-sizing: border-box;
	-moz-box-sizing: border-box;
	height: 32px;
	outline: none;
	box-shadow: 0 2px 6px rgba(0, 0, 0, 0.3);
}

#pac-input {
	background-color: #fff;
	font-family: Roboto;
	font-size: 15px;
	font-weight: 300;
	margin-left: 12px;
	padding: 0 11px 0 13px;
	text-overflow: ellipsis;
	width: 300px;
}

#pac-input:focus {
	border-color: #4d90fe;
}

.pac-container {
	font-family: Roboto;
}

#type-selector {
	color: #fff;
	background-color: #4d90fe;
	padding: 5px 11px 0px 11px;
}

#type-selector label {
	font-family: Roboto;
	font-size: 13px;
	font-weight: 300;
}

.pac-container {
	background-color: #FFF;
	z-index: 20;
	position: fixed;
	display: inline-block;
	float: left;
}

.modal {
	z-index: 20;
}

.modal-backdrop {
	z-index: 10;
}
/***** Google maps CSS end *****/
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
							<li><a href="password.mypage"> 비밀번호 수정</a></li>
						</ul> 
					<a href="favorite" class="list-group-item">즐겨찾기</a>
					<a href="truckCondition" class="list-group-item active">▶트럭현황</a>  
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
					<div class="card-header">트럭 추가</div>
					<div class="card-body">
					
						<!-- <p>현재 비밀번호 <input type="password" id="" name=""></p>
						<small class="text-muted">비밀번호 수정시에만 입력.</small>
						<hr> -->
						<form action="addTruck" method="post" enctype="multipart/form-data">
							
							<table class="tbl_fieldset">
								<caption></caption>
								<colgroup>
									<col style="width: 130px;">
									<col>
								</colgroup>
								<tbody>
									<tr>
										<th>트럭 이름</th>
										<td>
											<input type="text" id="truck_name" name="truck_name">
										</td>
									</tr>
									<tr>
										<th>트럭 소개</th>
										<td>
											<textarea row="20" cols="50" name="truck_intro"></textarea>
										</td>
									</tr>
									<tr>
										<th>트럭 음식 분류</th>
										<td>
											<c:forEach items="${foodlist}" var="foodlist">
												<input type="checkbox" id="MenuCheckbox" name="MenuCheckbox" value="${foodlist.foodtype_code}"> ${foodlist.foodtype_name}
											</c:forEach>
										</td>
									</tr>
									<tr>
										<th>위치 정보</th>
										<td>
										<!-- 모달창을 띄울 버튼 -->
											<button type="button" class="btn btn-info btn-lg" data-toggle="modal" data-target="#myModal" onClick="resize()">주소검색</button><br>
											<!-- 지도 모달 -->
											<div class="modal fade" id="myModal" role="dialog">
						
											    <div class="modal-dialog">
											
													<!-- Modal content-->
													
													<div class="modal-content" style="width: 730px; height: 750px;">
													
														<!-- 주소찾기 -->
														<div class="modal-header" style="">
															<button type="button" class="close" data-dismiss="modal">&times;</button>
															<h4 class="modal-title">
																<i class="fa fa-map-o" style="font-size: 24px"></i>주소찾기
															</h4>
														</div>
													
														<div class="modal-body" style="height: 84%; padding: 10px;">
														
															<!-- 구글 맵 검색input -->
															<input id="pac-input" class="controls" type="text" placeholder="주소 검색">
														
															<!-- 구글 맵  -->
															<div id="map"></div>
														
														</div>
													
														<div class="modal-footer">
															<button type="button" class="btn btn-default" data-dismiss="modal">적용</button>
														</div>
													
													</div>
											
												</div>
					
											</div>
											<!-- 모달창 -->
											<input type="text" name="address_full" id="address_full"/><br>
											<!-- 여기서부터 타입을 나중에 hidden으로 바꿔주기 -->
											<input type=text id="truck_x" name="truck_x"/><br>
											<input type=text id="truck_y" name="truck_y"/><br>
											<input type=text id="address_first" name="address_first"/><br>
											<input type=text id="address_second" name="address_second"/><br>
											<input type=text id="address_third" name="address_third"/><br>
										</td>
									</tr>
									<tr>
										<th>트럭 이미지</th>
										<td><input type="file" id="image_file" name="image_file"/></td>
									</tr>
								</tbody>
							</table>
							<div class="bottom_btn_wrap">
								<input type="submit" class="btn_basic_type01" value="등록"/>
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
