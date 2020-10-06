<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="resources/css/style.css">
<title>FoodToLuck</title>
<script src="resources/jquery-3.2.1.min.js"></script>
<style type="text/css">
table{
	width: 100%;
	border: 2px solid #f5f5f5;
	box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
td{
	width: 100%;
	/* border-bottom: 1px solid gray !important; */
}
</style>
</head>
<body>
	<jsp:include page="framemode/FT_header.jsp"  flush="false"/>
	
	<br><br><br><br><br><br>
	<br><br>
	
	 <form class="form-inline w3-center" action="<%=request.getContextPath() %>/searchtruck.mybatis" method="get">
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
	
	
	<div class="row">
		<div class="col-xs-3 col-sm-3 col-md-3"></div>

		<div class="col-xs-6 col-sm-6 col-md-6">
			<div class="row">
			
				<div class="col-xs-6 col-sm-6 col-md-6">
					<table class="table table-bordered" style="width:98%">
			  			<thead class="w3-blue">
				  			<tr>
					  			<td>
					  				오늘의 공지<div style="float:right"><input type="button" value="더 보기" onclick="location.href='noticeform.action'" class="w3-blue" ></div>
					  			</td>
				  			</tr>
			  			</thead>
			  			<tbody>
					        <c:forEach var="row" items="${map.noticelist}">
					        <tr>
					            <!-- ** 게시글 상세보기 페이지로 이동시 게시글 목록페이지에 있는 검색조건, 키워드, 현재페이지 값을 유지하기 위해 -->
					            <td><a href="<%=request.getContextPath()%>/view.action?notice_no=${row.notice_no}&curPage=${map.boardPager.curPage}&searchOption=${map.searchOption}&keyword=${map.keyword}">${row.notice_title}</a></td>  
					        </tr>    
	      					</c:forEach>
			  			</tbody>
					</table>
				</div>
				
				<div class="col-xs-6 col-sm-6 col-md-6">
					<table class="table table-bordered" style="width:98%">
			  			<thead class="w3-green">
				  			<tr>
					  			<td>
					  				자유게시판<div style="float:right"><input type="button" value="더 보기" onclick="location.href='boardform.action'" class="w3-green" ></div>
					  			</td>
				  			</tr>
			  			</thead>
			  			<tbody>
					        <c:forEach var="row" items="${map.boardlist}">
					        <tr>
					            <!-- ** 게시글 상세보기 페이지로 이동시 게시글 목록페이지에 있는 검색조건, 키워드, 현재페이지 값을 유지하기 위해 -->
					            <td><a href="<%=request.getContextPath()%>/boardview.action?board_no=${row.board_no}&curPage=${map.boardPager.curPage}&searchOption=${map.searchOption}&keyword=${map.keyword}">${row.board_title}</a></td>  
					        </tr>    
	      					</c:forEach>
			  			</tbody>
					</table>
				</div>
				
			</div>
		</div>
		
		<div class="col-xs-3 col-sm-3 col-md-3"></div>
	
	</div><!-- row end -->
	

	    <!-- Bootstrap core JavaScript -->
    <script src="resources/main3/vendor/jquery/jquery.min.js"></script>
    <script src="resources/main3/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

    <!-- Plugin JavaScript -->
    <script src="resources/main3/vendor/jquery-easing/jquery.easing.min.js"></script>

    <!-- Custom scripts for this template -->
    <script src="resources/main3/js/stylish-portfolio.js"></script>
	
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

			autocomplete = new google.maps.places.Autocomplete(
		            (document.getElementById('autocomplete')),
		            {types: ['geocode']});

		    // 사용자가 드롭다운에서 선택했을 때 폼 채우기
		    autocomplete.addListener('place_changed', fillInAddress);
		    
		    
		    
		    
		    var map = new google.maps.Map(document.getElementById('map'), {
			    zoom: 16,
			    center: new google.maps.LatLng(37.4851461, 126.8989197),
			    mapTypeId: google.maps.MapTypeId.ROADMAP
			});
		    
		    marker = new google.maps.Marker({
				position: new google.maps.LatLng(37.4851461, 126.8989197),
				map: map
			});
			
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
		         
		   }

		}
		
		
	</script>
<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAr7QLozrTNrVFLMsx__PDdmpF0hpVOFFc&libraries=places&callback=initAutocomplete"
        async defer></script>
	
	
	
	
	
</body>
</html>