<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<div class="card-header">즐겨찾기 목록</div>
					<div class="card-body">
					<div id="">
	    				<h3>
		    				<div id="isEmpty"></div>
		    			</h3>
		    		</div>
		    		<Br>
						<ul>
							<c:forEach items="${favoriteFoodtruck}" var="foodtruck">
							<div class="truck_list">											
								<li>
								<a href="timelines?truck_code=${foodtruck.truck_code }">
								<img src="${foodtruck.truck_image }" width=300px height=200px /><br>
									${foodtruck.truck_name }<br>
									<c:forEach items="${foodlist }" var="foodlist">
			                              <c:if test="${foodlist.truck_code == foodtruck.truck_code}">
			                                 ${foodlist.foodtype_name }
			                              </c:if>
			                        </c:forEach><br>
									${foodtruck.truck_intro }<br>	
									${foodtruck.truck_like }<Br>
									${foodtruck.address_full }<Br>
								</a>
								<input type="hidden" class="truck_code" value="${foodtruck.truck_code }">
								<input id="${foodtruck.truck_code }" class="truck_modify_btn" type="button" value="수정">&nbsp;
								<input id="${foodtruck.truck_code }" class="truck_delete_btn" type="button" value="삭제">
								
								</li>
								<br><br>
							</div>		
							</c:forEach>
						</ul>						
						<Br>
							
					
					</div>
</body>
</html>