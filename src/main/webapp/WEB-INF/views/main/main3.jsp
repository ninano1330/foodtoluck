<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>메인페이지</title>

    <!-- Bootstrap Core CSS -->
    <link href="resources/main3/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom Fonts -->
    <link href="resources/main3/vendor/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
    <link href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,700,300italic,400italic,700italic" rel="stylesheet" type="text/css">

    <!-- Custom CSS -->
    <link href="resources/main3/css/stylish-portfolio.css" rel="stylesheet">

   <style>
   .form-control{
      margin: 0 auto;
   }
   </style>
   
   <script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>
   
   
   <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
   
   
  </head>

  <body>
    <!-- Navigation -->
    <a id="menu-toggle" href="" class="btn btn-dark btn-lg toggle">
      <i class="fa fa-bars"></i>
    </a>
    <nav id="sidebar-wrapper">
      <ul class="sidebar-nav">
        <a id="menu-close" href="" class="btn btn-light btn-lg pull-right toggle">
          <i class="fa fa-times"></i>
        </a>
        <li class="sidebar-brand">
          <a class="js-scroll-trigger" href="#top">FoodToLuck</a>
        </li>
        <li>
          <a class="js-scroll-trigger" href="#top">Home</a>
        </li>
        <li>
          <a class="js-scroll-trigger" href="#about">About</a>
        </li>
        <li>
          <a class="js-scroll-trigger" href="#services">Services</a>
        </li>
        <li>
          <a class="js-scroll-trigger" href="#portfolio">스크린샷</a>
        </li>
        <li>
          <a class="js-scroll-trigger" href="#map" onclick=$('#menu-close').click();>오시는 길</a>
        </li>
      </ul>
    </nav>

    <!-- Header -->
    <header class="header" id="top">
      <div class="text-vertical-center">
        <h1><span style="color:white">FoodToLuck</span></h1>
        <h3><span style="color:white">푸드트럭의 정보를 찾고 다양한 사람들과 소통해보세요</span></h3>
        <br>

         <form action="<%=request.getContextPath() %>/searchtruck.mybatis" method="post">
                                      
            <input type="text" class="form-control" id="autocomplete" style="width:350px" placeholder="구,동을 입력해주세요" name="searchname"><br>
            <input type=hidden id="searchkeyword" name="searchkeyword">
            <input type="hidden" id="lat" name="lat">
            <input type="hidden" id="lng" name="lng">
            <button type="submit" class="btn btn-dark btn-lg js-scroll-trigger">&nbsp;&nbsp;검색&nbsp;&nbsp;</button>
         </form>

         <!-- <a href="#about" class="btn btn-dark btn-lg js-scroll-trigger">Find Out More</a> -->

      </div>
    </header>


   <!-- Call to Action -->
    <aside class="call-to-action bg-primary text-white">
      <div class="container text-center">
        <h3></h3>
        <a href="login" class="btn btn-lg btn-light">로그인</a>
        <a href="join" class="btn btn-lg btn-dark">회원가입</a>
      </div>
    </aside>
    
    <!-- About -->
    <section id="about" class="about">
      <div class="container text-center">
        <h2>푸드트럭에 대한 위치 정보와 메뉴, 그리고 다양한 사람들과 평을 남기면서 소통할 수 있는 서비스를 제공하는 사이트입니다.</h2>
        <p class="lead">단순히 음식을 파는 트럭이 아닌 예술적인 디자인과 맛 으로써 도시문화의 한 부분으로 자리잡은 푸드트럭과 함께 시작하세요
        </p>
      </div>
      <!-- /.container -->
    </section>

    <!-- Services -->
    <section id="services" class="services bg-primary text-white">
      <div class="container">
        <div class="row text-center">
          <div class="col-lg-10 mx-auto">
            <h2>Our Services</h2>
            <hr class="small">
            <div class="row">
              <div class="col-md-3 col-sm-6">
                <div class="service-item">
                  <span class="fa-stack fa-4x">
                    <!-- <i class="fa fa-circle fa-stack-2x"></i> -->
                    <i class="fa fa-newspaper-o"></i>
                  </span>
                  <h4>
                    <strong>공지 게시판</strong>
                  </h4>
                  <p>게시판 게시판 게시판</p>
                  <a href="" class="btn btn-light">바로가기</a>
                </div>
              </div>
              <div class="col-md-3 col-sm-6">
                <div class="service-item">
                  <span class="fa-stack fa-4x">
                   <!--  <i class="fa fa-circle fa-stack-2x"></i> -->
                    <i class="fa fa-map-marker"></i>
                  </span>
                  <h4>
                    <strong>위치 정보</strong>
                  </h4>
                  <p>트럭 위치 정보 제공</p>
                  <a href="" class="btn btn-light">바로가기</a>
                </div>
              </div>
              <div class="col-md-3 col-sm-6">
                <div class="service-item">
                  <span class="fa-stack fa-4x">
                    <!-- <i class="fa fa-circle fa-stack-2x"></i> -->
                    <i class="fa fa-users"></i>
                  </span>
                  <h4>
                    <strong>SNS</strong>
                  </h4>
                  <p>Social Networking Service</p>
                  <a href="" class="btn btn-light">바로가기</a>
                </div>
              </div>
              <div class="col-md-3 col-sm-6">
                <div class="service-item">
                  <span class="fa-stack fa-4x">
                    <!-- <i class="fa fa-circle fa-stack-2x"></i> -->
                    <i class="fa fa-cutlery"></i>
                  </span>
                  <h4>
                    <strong>메뉴 소개</strong>
                  </h4>
                  <p>메뉴메뉴메뉴메뉴</p>
                  <a href="" class="btn btn-light">바로가기</a>
                </div>
              </div>
            </div>
            <!-- /.row (nested) -->
          </div>
          <!-- /.col-lg-10 -->
        </div>
        <!-- /.row -->
      </div>
      <!-- /.container -->
    </section>

    <!-- Callout -->
    <aside class="callout">
      <div class="text-vertical-center">
        <h1></h1>
      </div>
    </aside>

    <!-- Portfolio -->
    <section id="portfolio" class="portfolio">
      <div class="container">
        <div class="row">
          <div class="col-lg-10 mx-auto text-center">
            <h2>스크린 샷</h2>
            <hr class="small">
            <div class="row">
              <div class="col-md-6">
                <div class="portfolio-item">
                  <a href="">
                    <img class="img-portfolio img-fluid" src="resources/main3/img/portfolio-1.jpg">
                  </a>
                </div>
              </div>
              <div class="col-md-6">
                <div class="portfolio-item">
                  <a href="">
                    <img class="img-portfolio img-fluid" src="resources/main3/img/portfolio-2.jpg">
                  </a>
                </div>
              </div>
              <div class="col-md-6">
                <div class="portfolio-item">
                  <a href="#">
                    <img class="img-portfolio img-fluid" src="resources/main3/img/portfolio-3.jpg">
                  </a>
                </div>
              </div>
              <div class="col-md-6">
                <div class="portfolio-item">
                  <a href="">
                    <img class="img-portfolio img-fluid" src="resources/main3/img/portfolio-4.jpg">
                  </a>
                </div>
              </div>
            </div>
            <!-- /.row (nested) -->
            <a href="" class="btn btn-dark">어쩌구 저쩌구</a>
          </div>
          <!-- /.col-lg-10 -->
        </div>
        <!-- /.row -->
      </div>
      <!-- /.container -->
    </section>

   <!--  
    <aside class="call-to-action bg-primary text-white">
      <div class="container text-center">
        <h3>The buttons below are impossible to resist.</h3>
        <a href="" class="btn btn-lg btn-light">Click Me!</a>
        <a href="" class="btn btn-lg btn-dark">Look at Me!</a>
      </div>
    </aside> -->

    <!-- Map -->
    <div class="col-lg-10 mx-auto text-center">
    <h2>오시는 길</h2>
    <hr class="small">
    <section id="map" class="map" width="100%" height="100%" frameborder="0" scrolling="no" marginheight="0" marginwidth="0">
  
      <!-- <iframe width="100%" height="100%" frameborder="0" scrolling="no" marginheight="0" marginwidth="0" src="https://maps.google.com/maps?f=q&amp;source=s_q&amp;hl=en&amp;geocode=&amp;q=Twitter,+Inc.,+Market+Street,+San+Francisco,+CA&amp;aq=0&amp;oq=twitter&amp;sll=28.659344,-81.187888&amp;sspn=0.128789,0.264187&amp;ie=UTF8&amp;hq=Twitter,+Inc.,+Market+Street,+San+Francisco,+CA&amp;t=m&amp;z=15&amp;iwloc=A&amp;output=embed"></iframe> -->
      <br/>
      <!-- <small>
        <a href="https://maps.google.com/maps?f=q&amp;source=embed&amp;hl=en&amp;geocode=&amp;q=Twitter,+Inc.,+Market+Street,+San+Francisco,+CA&amp;aq=0&amp;oq=twitter&amp;sll=28.659344,-81.187888&amp;sspn=0.128789,0.264187&amp;ie=UTF8&amp;hq=Twitter,+Inc.,+Market+Street,+San+Francisco,+CA&amp;t=m&amp;z=15&amp;iwloc=A"></a>
      </small> -->
    </section>
   </div>
  
  
    <!-- Footer -->
    <footer>
      <div class="container">
        <div class="row">
          <div class="col-lg-10 mx-auto text-center">
            <h4>
              <strong>FoodToLuck</strong>
            </h4>
            <p>한국정보기술연구원
              <br>최종 프로젝트</p>
            <ul class="list-unstyled">
              <li>
                <i class="fa fa-phone fa-fw"></i>
                (123) 456-7890</li>
              <li>
                <i class="fa fa-envelope-o fa-fw"></i>
                <a href="mailto:name@example.com">sew921229@naver.com</a>
              </li>
            </ul>
            <br>
            <ul class="list-inline">
              <li class="list-inline-item">
                <a href="www.facebook.com">
                  <i class="fa fa-facebook fa-fw fa-3x"></i>
                </a>
              </li>
              <li class="list-inline-item">
                <a href="www.twitter.com">
                  <i class="fa fa-twitter fa-fw fa-3x"></i>
                </a>
              </li>
              <li class="list-inline-item">
                <a href="www.google.com">
                  <i class="fa fa-dribbble fa-fw fa-3x"></i>
                </a>
              </li>
            </ul>
            <hr class="small">
            <p class="text-muted">Copyright &copy; FoodToLuck 2017</p>
          </div>
        </div>
      </div>
      <a id="to-top" href="top" class="btn btn-dark btn-lg js-scroll-trigger">
        <i class="fa fa-chevron-up fa-fw fa-1x"></i>
      </a>
    </footer>

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