<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
<title>FoodToLuck</title>
<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>
<script type="text/javascript">

</script>
</head>
<body>

	<div style="text-align: right" class="top-align right-margin top-margin">
		<button class="w3-btn w3-round w3-border w3-padding-small">회원가입</button>
		<button class="w3-btn w3-round w3-border w3-padding-small">로그인</button>
	</div>
	
	<br><br><br><br><br><br>
	
	<div style="text-align: center">
		<img src="resources/img/foodtoluck.JPG" style="width:250px"/>
	</div>
	
	<br><br>

	<form class="form-inline w3-center" action="<%=request.getContextPath() %>/searchtruck.mybatis" method="post">
	

		<div class="form-group">

			<input type="text" class="form-control" id="autocomplete" style="width:350px" placeholder="구,동을 입력해주세요" name="searchname"><br>
			<input type=hidden id="searchkeyword" name="searchkeyword">
			<input type="hidden" id="lat" name="lat">
			<input type="hidden" id="lng" name="lng">
	
	  	</div>
				
			

  		<button type="submit" class="btn btn-default">&nbsp;&nbsp;검색&nbsp;&nbsp;</button>
  		
  		
  		
  		
	</form>


	<br><br>
	<br><br>
	<div class="center-block" style="width:600px">
			<table class="table table-bordered">
	  			<tr>
		  			<th class="w3-blue">오늘의 공지</th>
	  			</tr>
				<tr>
		  			<td>이러쿵 저러쿵</td>
				</tr>
			</table>
	</div>
	
	<br><br>
	<br><br>
	
	<div class="center-block" style="width:600px">
			<table class="table table-bordered">
	  			<tr>
		  			<th class="w3-green">오늘의 트럭</th>
	  			</tr>
				<tr>
		  			<td>어쩌구 저쩌구</td>
				</tr>
			</table>
	</div>
	
	
	<script>
		
	 	var placeSearch, autocomplete;
	 	var componentForm = {
		        street_number: 'short_name',
		        route: 'long_name',
		        locality: 'long_name',
		        administrative_area_level_1: 'short_name',
		        country: 'long_name',
		        postal_code: 'short_name'
		};
	 	
		function initAutocomplete() {
			
			/* var geocoder = new google.maps.Geocoder;
		    var infowindow = new google.maps.InfoWindow;
		    
		    var input = document.getElementById('autocomplete');
			var searchBox = new google.maps.places.SearchBox(input);
			
			map.controls[google.maps.ControlPosition.TOP_LEFT].push(input);


			map.addListener('bounds_changed', function() {
			
			   searchBox.setBounds(map.getBounds());
			
			});
			
			searchBox.addListener('places_changed', function(){
				var places = searchBox.getPlaces();
				
				if(places.length == 0){
					return;
				}
			}); */
			
			autocomplete = new google.maps.places.Autocomplete(
		            (document.getElementById('autocomplete')),
		            {types: ['geocode']});

		    // 사용자가 드롭다운에서 선택했을 때 폼 채우기
		    autocomplete.addListener('place_changed', fillInAddress);
			
		}
		
		function fillInAddress(){
			var place = autocomplete.getPlace();
			console.log('place: ',place);
			console.log('주소 풀네임: ',place.formatted_address);
			var fulladd = place.formatted_address.split(" ");
			for(var a = 0; a < fulladd.length; a++){
				if(fulladd[a].charAt(fulladd[a].length-1) === '시' || fulladd[a].charAt(fulladd[a].length-1) === '군'){
					console.log(fulladd[a]);
					//console.log(fulladd[a].charAt(fulladd[a].length-1));
					$('#searchkeyword').val(fulladd[a]);//시 or 군 뽑아내기
				}
			}
			console.log('키워드: ',place.name);
			console.log('위도: ', place.geometry.location.lat());
			console.log('경도: ', place.geometry.location.lng());
			//$('#searchkeyword').val(place.name);//키워드 뽑아내기
			$('#lat').val(place.geometry.location.lat());
			$('#lng').val(place.geometry.location.lng());
			for (var i = 0; i < place.address_components.length; i++) {
		          var addressType = place.address_components[i].types[0];
		          //console.log('콤포넌트:',place.address_components[i]); //**********주소 풀네임 콤포넌트들을 따로 출력하기************
		          //console.log(addressType,': ',place.address_components[i].long_name);
		          console.log(place.address_components[i].long_name);
		          /* if (componentForm[addressType]) {
		            var val = place.address_components[i][componentForm[addressType]];
		           
		            //document.getElementById(addressType).value = val;
		          } */
		   }
	
			/* var address = document.getElementById('autocomplete').value;
			console.log('address:', address);
			var geocoder = new google.maps.Geocoder();
			geocoder.geocode({'address': address}, function(results, status){
				if(status == 'OK' && results.length > 0){
					console.log(results[0]);
					console.log(results[0].geometry.location.lat());
					console.log(results[0].geometry.location.lng());
				}else{
					console.log("이와 같은 이유땜시 지오코드 실행안됨 :", status);
				}
			}); */
			
			
		}
		
		
	</script>
<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAr7QLozrTNrVFLMsx__PDdmpF0hpVOFFc&libraries=places&callback=initAutocomplete"
        async defer></script>	
</body>
</html>