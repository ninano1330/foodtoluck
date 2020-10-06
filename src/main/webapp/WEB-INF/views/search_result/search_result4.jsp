<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="initial-scale=1,user-scalable=no,maximum-scale=1,width=device-width">
    <meta name="mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="theme-color" content="#000000">
    <meta name="description" content="">
    <meta name="author" content="">
    <title>검색 결과 화면</title>

    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/leaflet/0.7.7/leaflet.css">
    <link rel="stylesheet" href="https://api.tiles.mapbox.com/mapbox.js/plugins/leaflet-markercluster/v0.4.0/MarkerCluster.css">
    <link rel="stylesheet" href="https://api.tiles.mapbox.com/mapbox.js/plugins/leaflet-markercluster/v0.4.0/MarkerCluster.Default.css">
    <link rel="stylesheet" href="https://api.tiles.mapbox.com/mapbox.js/plugins/leaflet-locatecontrol/v0.43.0/L.Control.Locate.css">
    <link rel="stylesheet" href="resources/search_result/assets/leaflet-groupedlayercontrol/leaflet.groupedlayercontrol.css">
    <link rel="stylesheet" href="resources/search_result/assets/css/app.css">

    <link rel="apple-touch-icon" sizes="76x76" href="resources/search_result/assets/img/favicon-76.png">
    <link rel="apple-touch-icon" sizes="120x120" href="resources/search_result/assets/img/favicon-120.png">
    <link rel="apple-touch-icon" sizes="152x152" href="resources/search_result/assets/img/favicon-152.png">
    <link rel="icon" sizes="196x196" href="resources/search_result/assets/img/favicon-196.png">
    <link rel="icon" type="image/x-icon" href="resources/search_result/assets/img/favicon.ico">
	
	<script src="https://code.jquery.com/jquery-2.1.4.min.js"></script>
<!-- 	<script src="resources/jquery-3.2.1.min.js"></script> -->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/typeahead.js/0.10.5/typeahead.bundle.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.3/handlebars.min.js"></script>
    <!-- <script src="https://cdnjs.cloudflare.com/ajax/libs/list.js/1.1.1/list.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/leaflet/0.7.7/leaflet.js"></script>
    <script src="https://api.tiles.mapbox.com/mapbox.js/plugins/leaflet-markercluster/v0.4.0/leaflet.markercluster.js"></script>
    <script src="https://api.tiles.mapbox.com/mapbox.js/plugins/leaflet-locatecontrol/v0.43.0/L.Control.Locate.min.js"></script>
    <script src="resources/search_result/assets/leaflet-groupedlayercontrol/leaflet.groupedlayercontrol.js"></script> -->
    <script src="resources/search_result/assets/js/app.js"></script>
  </head>

  <body style="padding:0;">
  <jsp:include page="../framemode/FT_header.jsp" />
    <div id="container">
      <div id="sidebar">
      	<br>
     	<button type="submit" style="width:80px" id="menu_type1" name="menu_type" value="전체" class="btn btn-default" onclick="totalbutton(this)">전체</button> 
		<button type="submit" style="width:80px" id="menu_type2" name="menu_type" value="한식" class="btn btn-default" onclick="typebutton(this)">&nbsp;&nbsp;한식&nbsp;&nbsp;</button>
		<button type="submit" style="width:80px" id="menu_type3" name="menu_type" value="치킨" class="btn btn-default" onclick="typebutton(this)">&nbsp;&nbsp;치킨&nbsp;&nbsp;</button>
		<button type="submit" style="width:80px" id="menu_type4" name="menu_type" value="중식" class="btn btn-default" onclick="typebutton(this)">&nbsp;&nbsp;중식&nbsp;&nbsp;</button>
		<button type="submit" style="width:80px" id="menu_type4" name="menu_type" value="피자" class="btn btn-default" onclick="typebutton(this)">&nbsp;&nbsp;피자&nbsp;&nbsp;</button>
		<button type="submit" style="width:80px" id="menu_type4" name="menu_type" value="양식" class="btn btn-default" onclick="typebutton(this)">&nbsp;&nbsp;양식&nbsp;&nbsp;</button>
		<button type="submit" style="width:80px" id="menu_type5" name="menu_type" value="분식" class="btn btn-default" onclick="typebutton(this)">&nbsp;&nbsp;분식&nbsp;&nbsp;</button>
		<button type="submit" style="width:80px" id="menu_type6" name="menu_type" value="디저트" class="btn btn-default" onclick="typebutton(this)">&nbsp;&nbsp;디저트&nbsp;&nbsp;</button>
		<button type="submit" style="width:80px" id="menu_type7" name="menu_type" value="음료" class="btn btn-default" onclick="typebutton(this)">&nbsp;&nbsp;음료&nbsp;&nbsp;</button>
		<button type="submit" style="width:80px" id="menu_type8" name="menu_type" value="주류" class="btn btn-default" onclick="typebutton(this)">&nbsp;&nbsp;주류&nbsp;&nbsp;</button>
	 	
        <div class="sidebar-wrapper" style="padding-left:15px;">
          <div class="panel panel-default" id="features">
            
           <br>
            <div class="row">
            	<div class="col-xs-8 col-md-8">
            		<input type="text" id="truck_name_search" class="form-control search" placeholder="트럭 검색" />
            	</div>
            	<div class="col-xs-4 col-md-2">
                  	<button type="button" class="btn btn-primary pull-right sort" id="sort-btn" onclick="name_search()"><i class="fa fa-sort"></i>&nbsp;&nbsp;검색</button>
                </div>
            </div>
           
			
			<c:forEach items="${searchtrucklist }" var="truckvo">
                  <div id="${truckvo.truck_code }" class="media">
                     
                     <a href='timelines?truck_code=${truckvo.truck_code }'>
                     <br>
                     <img style="width:400px; height:300px" class="d-flex align-self-start" src="${truckvo.truck_image}">
                     <h2><strong>${truckvo.truck_name }</strong>
                     </a>
                     <button onclick="javascript:initMap(${truckvo.truck_x },${truckvo.truck_y})" style="width:80px" class="btn btn-default">지도보기</button>
                     </h2>

                     <h4><span style="color:#00BFFF; font-weight:600;">${truckvo.address_full}</span></h4>
                     
                     <h4><span style="color:#6E6E6E; font-weight:600;">한줄 소개 : ${truckvo.truck_intro}</span></h4>
                     <c:forEach items="${foodlist }" var="foodlist">
                     <c:if test="${foodlist.truck_code == truckvo.truck_code}">
                     <h4><span style="color:#5882FA; font-weight:800;">${foodlist.foodtype_name }</span></h4><br>
                     </c:if>
                     </c:forEach>
                     
                     <br>
                  </div>
         	</c:forEach>
           
          </div>
        </div>
      </div>

	  <!-- map은 여기있다~~~~~~~~~~~~~~~~~~~~~~~~~~!!!!!!!!!!!  -->
      <div id="map">
      	
      </div>

    </div>
 
     
	 
      

<!--     <div class="modal fade" id="aboutModal" tabindex="-1" role="dialog"> -->
<!--       <div class="modal-dialog modal-lg"> -->
<!--         <div class="modal-content"> -->
<!--           <div class="modal-header"> -->
<!--             <button class="close" type="button" data-dismiss="modal" aria-hidden="true">&times;</button> -->
<!--             <h4 class="modal-title">FoodToLuck에 오신 것을 환영합니다!</h4> -->
<!--           </div> -->
<!--           <div class="modal-body"> -->
<!--             <ul class="nav nav-tabs nav-justified" id="aboutTabs"> -->
<!--               <li class="active"><a href="#about" data-toggle="tab"><i class="fa fa-question-circle"></i>&nbsp;About the project</a></li> -->
<!--               <li><a href="#contact" data-toggle="tab"><i class="fa fa-envelope"></i>&nbsp;Contact us</a></li> -->
<!--               <li><a href="#disclaimer" data-toggle="tab"><i class="fa fa-exclamation-circle"></i>&nbsp;업데이트 사항</a></li> -->
           
<!--             </ul> -->
<!--             <div class="tab-content" id="aboutTabsContent"> -->
<!--               <div class="tab-pane fade active in" id="about"> -->
<!--                 <p>푸드트럭 관련 정보를 푸드트럭 소유자(푸드트럭 사장), 일반유저, 사이트 관리자 등 사용자별로 맞춤 제공하는 Service 입니다.<br> <a href="https://github.com/goyu8744/FoodToLuck" target="_blank">GitHub</a>에서 관련 자료를 열람하실 수 있습니다.</p> -->
<!--                 <div class="panel panel-primary"> -->
<!--                   <div class="panel-heading">구성</div> -->
<!--                   <ul class="list-group"> -->
<!--                     <li class="list-group-item">푸드트럭 검색, 푸드트럭 위치조회, 푸드트럭 등록을 갖춘 시스템 구축</li> -->
<!--                     <li class="list-group-item">메뉴조회, 메뉴등록, 메뉴수정/삭제 기능을 갖춘 시스템 구축</li> -->
<!--                     <li class="list-group-item">타임라인 조회, 타임라인 글 등록, 타임라인 글 수정/삭제 기능을 갖춘 시스템 구축 </li> -->
<!--                     <li class="list-group-item">메뉴평가, 메뉴평가 수정/삭제 기능을 갖춘 시스템 구축</li> -->
<!--                     <li class="list-group-item">공지게시판/자유게시판 게시글등록, 수정/삭제 기능을 갖춘 시스템 구축</li> -->
<!--                     <li class="list-group-item">Controller를 기점으로 Model과 사용자 View에 접근 하도록 구축</li> -->
<!--                   </ul> -->
<!--                 </div> -->
<!--               </div> -->
<!--               <div id="disclaimer" class="tab-pane fade text-danger"> -->
<!--                 <p>으아아아아아아아랑랑ㄹ알알알아아아아아아아아아아</p> -->
<!--                 <p>호에에에에에에에에엫엫엫ㅇㅎㅇ헝헹헹ㅎ에엥</p> -->
<!--               </div> -->
<!--               <div class="tab-pane fade" id="contact"> -->
<!--                 <form id="contact-form"> -->
<!--                   <div class="well well-sm"> -->
<!--                     <div class="row"> -->
<!--                       <div class="col-md-4"> -->
<!--                         <div class="form-group"> -->
<!--                           <label for="first-name">이름 </label> -->
<!--                           <input type="text" class="form-control" id="first-name"> -->
<!--                         </div> -->
<!--                         <div class="form-group"> -->
<!--                           <label for="last-name">제목 </label> -->
<!--                           <input type="text" class="form-control" id="last-email"> -->
<!--                         </div> -->
<!--                         <div class="form-group"> -->
<!--                           <label for="email">Email:</label> -->
<!--                           <input type="text" class="form-control" id="email"> -->
<!--                         </div> -->
<!--                       </div> -->
<!--                       <div class="col-md-8"> -->
<!--                         <label for="message">Message:</label> -->
<!--                         <textarea class="form-control" rows="8" id="message"></textarea> -->
<!--                       </div> -->
<!--                       <div class="col-md-12"> -->
<!--                         <p> -->
<!--                           <button type="submit" class="btn btn-primary pull-right" data-dismiss="modal">Submit</button> -->
<!--                         </p> -->
<!--                       </div> -->
<!--                     </div> -->
<!--                   </div> -->
<!--                 </form> -->
<!--               </div> -->
<!--               <div class="tab-pane fade" id="boroughs-tab"> -->
<!--                 <p>Borough data courtesy of <a href="http://www.nyc.gov/html/dcp/pdf/bytes/nybbwi_metadata.pdf" target="_blank">New York City Department of City Planning</a></p> -->
<!--               </div> -->
<!--               <div class="tab-pane fade" id="subway-lines-tab"> -->
<!--                 <p><a href="http://spatialityblog.com/2010/07/08/mta-gis-data-update/#datalinks" target="_blank">MTA Subway data</a> courtesy of the <a href="http://www.urbanresearch.org/about/cur-components/cuny-mapping-service" target="_blank">CUNY Mapping Service at the Center for Urban Research</a></p> -->
<!--               </div> -->
<!--               <div class="tab-pane fade" id="theaters-tab"> -->
<!--                 <p>Theater data courtesy of <a href="https://data.cityofnewyork.us/Recreation/Theaters/kdu2-865w" target="_blank">NYC Department of Information & Telecommunications (DoITT)</a></p> -->
<!--               </div> -->
<!--               <div class="tab-pane fade" id="museums-tab"> -->
<!--                 <p>Museum data courtesy of <a href="https://data.cityofnewyork.us/Recreation/Museums-and-Galleries/sat5-adpb" target="_blank">NYC Department of Information & Telecommunications (DoITT)</a></p> -->
<!--               </div> -->
<!--             </div> -->
<!--           </div> -->
<!--           <div class="modal-footer"> -->
<!--             <button type="button" class="btn btn-default" data-dismiss="modal">Close</button> -->
<!--           </div> -->
<!--         </div>/.modal-content -->
<!--       </div>/.modal-dialog -->
<!--     </div>/.modal -->

    <div class="modal fade" id="legendModal" tabindex="-1" role="dialog">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
            <h4 class="modal-title">Map Legend</h4>
          </div>
          <div class="modal-body">
            <p>Map Legend goes here...</p>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
          </div>
        </div><!-- /.modal-content -->
      </div><!-- /.modal-dialog -->
    </div><!-- /.modal -->

<!-- 로그인입력 결과 출력 스크립트 -->
<!-- right login -->
<!-- <script type='text/javascript'> -->
<%-- 	var loginResult = '<c:out value="${loginResult}"/>'; --%>
<!-- 	if(loginResult == "NoId"){ -->
<!-- 		console.log('아이디를 확인하세요'); -->
<!-- 		alert('아이디를 확인하세요'); -->
<!-- 		} -->
<!-- 	if(loginResult == "NoPw"){  -->
<!-- 		console.log('비밀번호를 확인하세요'); -->
<!-- 		alert('비밀번호를 확인하세요'); -->
<!-- 		} -->
<!-- </script> -->

	<!-- 로그인 버튼~~~~~~~~~~~~~~~~ -->
<!--     <div class="modal fade" id="loginModal" tabindex="-1" role="dialog"> -->
<!--       <div class="modal-dialog modal-sm"> -->
<!--         <div class="modal-content"> -->
<!--           <div class="modal-header"> -->
<!--             <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button> -->
<!--             <h4 class="modal-title">Login</h4> -->
<!--           </div> -->
<!--           <div class="modal-body"> -->
<!--             <form id="contact-form" action="loginCheck" method="post"> -->
<!--               <fieldset> -->
<!--                 <div class="form-group"> -->
<!--                   <label for="name">Username:</label> -->
<!--                   <input type="text" name="member_id" class="form-control" id="username"> -->
<!--                 </div> -->
<!--                 <div class="form-group"> -->
<%--                   <label for="email">Password:</label>
<%--                   <input type="password" name="member_pw" class="form-control" id="password"> --%>
<%--                   <input type="hidden" name="parent" value="searchtruck.mybatis"/> --%>
<%--          		  <input type="hidden" name="searchkeyword" value="${searchkeyword}"/> --%>
<%--          		  <input type="hidden" name="lat" value="${lat}"/> --%>
<%--          		  <input type="hidden" name="lng" value="${lng}"/> --%> --%>
<!--                 </div> -->
<!--               </fieldset> -->
<!-- 	          <div class="modal-footer"> -->
<!-- 	            <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button> -->
<!-- 	            <button type="submit" class="btn btn-primary" data-dismiss="modal">Login</button> -->
<!-- 	          </div> -->
<!--             </form> -->
<!--           </div> -->
<!--         </div>/.modal-content -->
<!--       </div>/.modal-dialog -->
<!--     </div>/.modal -->
    
    

<!--     <div class="modal fade" id="featureModal" tabindex="-1" role="dialog"> -->
<!--       <div class="modal-dialog"> -->
<!--         <div class="modal-content"> -->
<!--           <div class="modal-header"> -->
<!--             <button class="close" type="button" data-dismiss="modal" aria-hidden="true">&times;</button> -->
<!--             <h4 class="modal-title text-primary" id="feature-title"></h4> -->
<!--           </div> -->
<!--           <div class="modal-body" id="feature-info"></div> -->
<!--           <div class="modal-footer"> -->
<!--             <button type="button" class="btn btn-default" data-dismiss="modal">Close</button> -->
<!--           </div> -->
<!--         </div>/.modal-content -->
<!--       </div>/.modal-dialog -->
<!--     </div>/.modal -->

<!--     <div class="modal fade" id="attributionModal" tabindex="-1" role="dialog"> -->
<!--       <div class="modal-dialog"> -->
<!--         <div class="modal-content"> -->
<!--           <div class="modal-header"> -->
<!--             <button class="close" type="button" data-dismiss="modal" aria-hidden="true">&times;</button> -->
<!--             <h4 class="modal-title"> -->
<!--               Developed by <a href=''>FoodToLuck</a> -->
<!--             </h4> -->
<!--           </div> -->
<!--           <div class="modal-body"> -->
<!--             <div id="attribution"></div> -->
<!--           </div> -->
<!--         </div>/.modal-content -->
<!--       </div>/.modal-dialog -->
<!--     </div>/.modal -->


    <script>

                            var foodtypeclickArray = new Array();
                			function typebutton(obj){
                				//console.log(obj.value);
                				//console.log(foodtypeclickArray);
                				
                				if((foodtypeclickArray.length === 0) || (foodtypeclickArray.indexOf(obj.value) == -1)){//배열이 비어있거나 obj.value가 들어있지 않다면
                					$(obj).css("background-color", "#01A9DB");
                					$(obj).css("color", "white");
                					foodtypeclickArray.push(obj.value);
                					//alert("음식 분류는"+obj.value+"이다.");
                				}else{//배열에 들어있다면, 즉 한번 클릭한 상태라면
                					$(obj).css("background-color", "white");
                					$(obj).css("color", "#000000");
                					foodtypeclickArray.splice(foodtypeclickArray.indexOf(obj.value),1);
                				}
                				
                				console.log(foodtypeclickArray);
                				
                				if(foodtypeclickArray.length === 0){
                					$(".media").css('display','');
                				}else{
                					foodfilter(foodtypeclickArray);
                				}
                				
                			}
                			
                			//var foodlistArray = new Array();
                			<c:forEach items="${foodlist}" var="foodlist">
                				var foodtype = "${foodlist.foodtype_name}".split(" ");
                				console.log("${foodlist.truck_code}"+'트럭의 '+foodtype);
                				//foodlistArray.push(foodtype);
                			</c:forEach>
                			//console.log(foodlistArray);
                			
                			
                			function foodfilter(foodbttnArray){
                				var filterArray = new Array();
                				<c:forEach items="${foodlist}" var="foodlist">
                					var foodtype = "${foodlist.foodtype_name}".split(" ");
                					
                					for(var i=0; i<foodbttnArray.length; i++){
                						for(var j=0; j<foodtype.length; j++){
                							if(foodbttnArray[i] === foodtype[j]){
                								if(filterArray.indexOf("${foodlist.truck_code}") == -1){
                									console.log("${foodlist.truck_code}"+'트럭 bingo');
                									filterArray.push("${foodlist.truck_code}");
                								}
                							}
                						}
                					}
                				</c:forEach> 
                			
                				
                				console.log(filterArray);
                				
                				
                				$(".media").css('display','none');
                				
                				for(var a=0; a<filterArray.length; a++){
                					var temp = filterArray[a];
                					$('#'+temp).css('display','');
                				} 
                				
                				
                			}
                			
                			function name_search(){
                				var searchname = $('#truck_name_search').val();
                				$(".media").css('display','none');
                				<c:forEach items="${searchtrucklist}" var="truckvo">
                					/* if($('#truck_name_search').val() == "${truckvo.truck_name}"){
                						$('#'+'${truckvo.truck_code}').css('display','');
                					} */
                					var listname = "${truckvo.truck_name}";
                					
	                				if(listname.indexOf(searchname) != -1){
	            						$('#'+'${truckvo.truck_code}').css('display','');
	            					}
                				</c:forEach>
                			}
                			
                			function totalbutton(obj){
                				$('button[name=menu_type]').css('background-color','white');
                				$(".media").css('display','');
                				$(obj).css("color", "#01A9DB");
                				foodtypeclickArray = [];
                			}
                			
                			var placeSearch, autocomplete;
                		 	var componentForm = {
                			        street_number: 'short_name',
                			        route: 'long_name',
                			        locality: 'long_name',
                			        administrative_area_level_1: 'short_name',
                			        country: 'long_name',
                			        postal_code: 'short_name'
                			};
                		 	

                			function initMap(laa,lnn,event){
                				
                				
                				var searchkeyword = "${searchkeyword}";
                				var lat = "${lat}";
                				var lng = "${lng}";
                					
                				$('#re_searchkeyword').val(searchkeyword);
                				$('#lat').val(lat);
                				$('#lng').val(lng);
    
                				
                				
                				
                				
                				autocomplete = new google.maps.places.Autocomplete(
                			            (document.getElementById('autocomplete')),
                			            {types: ['geocode']});

                			    // 사용자가 드롭다운에서 선택했을 때 폼 채우기
                			    autocomplete.addListener('place_changed', fillInAddress);
                			    
                			    function fillInAddress(){
	            					var place = autocomplete.getPlace();
	            					console.log('place: ',place);
	            					console.log('주소 풀네임: ',place.formatted_address);
	            					var fulladd = place.formatted_address.split(" ");
	            					for(var a = 0; a < fulladd.length; a++){
	            						if(fulladd[a].charAt(fulladd[a].length-1) === '시' || fulladd[a].charAt(fulladd[a].length-1) === '군'){
	            							console.log(fulladd[a]);
	            							$('#re_searchkeyword').val(fulladd[a]);//시 or 군 뽑아내기
	            						}
	            					}
	            					console.log('키워드: ',place.name);
	            					console.log('위도: ', place.geometry.location.lat());
	            					console.log('경도: ', place.geometry.location.lng());
	            					$('#lat').val(place.geometry.location.lat());
	            					$('#lng').val(place.geometry.location.lng());
	            					$('#autocomplete').val(place.name);
	            					for (var i = 0; i < place.address_components.length; i++) {
	            				          var addressType = place.address_components[i].types[0];
	            				          console.log(place.address_components[i].long_name);
	            				   }

            					}
                			    
                			    
                			    
                			    
                			    
                				var markerArray = new Array();
                				var count = 0;
                				
                				//alert(laa+", "+lnn);
                				
                				if(!laa && !lnn){
                					var map = new google.maps.Map(document.getElementById('map'), {
                					    zoom: 15,
                					    center: new google.maps.LatLng(lat, lng),
                					    mapTypeId: google.maps.MapTypeId.ROADMAP
                					});
                				}else{
                					var map = new google.maps.Map(document.getElementById('map'), {
                					    zoom: 15,
                					    center: new google.maps.LatLng(laa, lnn),
                					    mapTypeId: google.maps.MapTypeId.ROADMAP
                					});
                				}
                				
                				$(function(){
                		
                					<c:forEach items="${searchtrucklist}" var="truckvo">
                						var marker_info = new Array();
                						marker_info[0] = "${truckvo.truck_x}";
                						marker_info[1] = "${truckvo.truck_y}";
                						marker_info[2] = "${truckvo.truck_name}";
                						marker_info[3] = "${truckvo.truck_code}";
                						markerArray.push(marker_info);
                						count++;
                					</c:forEach>
                		
                				});
                				
                				for(var i=0; i < markerArray.length; i++){
                					/* var content = markerArray[i][2]; //말풍선 안에 들어갈 내용
                					var infowindow = new google.maps.InfoWindow({content: content});
                					marker = new google.maps.Marker({
                						position: new google.maps.LatLng(markerArray[i][0], markerArray[i][1]),
                						map: map
                					});
                					google.maps.event.addListener(marker, "click", function(){
                						alert(markerArray[i][2]);
                					}); */
                					addMarker(i);
                				} 
                				
                				var markerclickArray = new Array();
                				function addMarker(i){
                					/* var content = markerArray[i][2]; //말풍선 안에 들어갈 내용 */
                					var infowindow = new google.maps.InfoWindow({content: markerArray[i][2]});
                					var marker = new google.maps.Marker({
                						position: new google.maps.LatLng(markerArray[i][0], markerArray[i][1]),
                						map: map
                					});
                					var ttt = markerArray[i][3];
                					google.maps.event.addListener(marker, "click", function(){
                						infowindow.open(map,marker);
                						
                						/* $(".media").css('display','none');
                						$('#'+ttt).css('display',''); */
                						if((markerclickArray.length === 0) || (markerclickArray.indexOf(ttt) == -1)){
                							markerclickArray.push(ttt);
                						}else{
                							markerclickArray.splice(markerclickArray.indexOf(ttt),1);
                						}
                						
                						if(markerclickArray.length === 0){
                							$(".media").css('display','');
                						}else{
                							$(".media").css('display','none');
                						}
                						
                						for(var a=0; a<markerclickArray.length; a++){
                							
                							$('#'+markerclickArray[a]).css('display','');
                						} 
                						
                					});
                				}
                				
                			}
                			
                		
</script>

<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAr7QLozrTNrVFLMsx__PDdmpF0hpVOFFc&libraries=places&callback=initMap" async defer></script>
</body>
</html>