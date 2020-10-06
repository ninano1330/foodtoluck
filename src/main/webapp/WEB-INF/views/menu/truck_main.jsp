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
  <link rel="stylesheet" type="text/css" href="resources/css/starability-all.min.css"/>

<title>FoodToLuck</title>
<script src="resources/jquery-3.2.1.min.js"></script>
<script type="text/javascript">
</script>
<body>
	<!-- 상단 로그인 메뉴 -->
	<div style="text-align: right" class="top-align right-margin top-margin">
		<button class="w3-btn w3-round w3-border w3-padding-small">회원가입</button>
		<button class="w3-btn w3-round w3-border w3-padding-small">로그인</button>
	</div>
		
	<!-- Search bar -->
	<div class="w3-margin">
		<form class="form-inline">
	  		<div class="form-group">
	    		<input type="text" class="form-control" style="width:290px" placeholder="Search">
	  		</div>
	  		<button type="submit" class="btn btn-default">&nbsp;&nbsp;검색&nbsp;&nbsp;</button>
		</form>
		
		<br/>
			<!-- 메인창 -->
			<div class="row">
				<!-- 왼쪽 -->
	    		<div class="col-xs-6 col-sm-4">
	    			<div style="width:290px">
		    			<img src="resources/img/owner_img.JPG"/>
						<br/><br/>
						<p class="bg-success">트럭 사장님 한줄 코멘트</p>
	    			</div>
	    			<button type="button" id="truck_menu" class="btn btn-default" style="width:290px">MENU</button>
	    			<br/><br/>
	    			<img src="resources/img/owner_map_img.JPG"/>
	    		</div>
	    		  	
		    	<!-- Optional: clear the XS cols if their content doesn't match in height -->
		    	<div class="clearfix visible-xs-block"></div>
		    	<!-- 오른쪽 -->
		    	<div class="col-xs-6 col-sm-4">여기다가 채팅창 추가 가능</div>
			</div>
		</div>

</body>
</html>