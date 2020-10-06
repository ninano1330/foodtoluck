<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="resources/css/style.css">
<title>FoodToLuck</title>
<script src="resources/jquery-3.2.1.min.js"></script>
<script type="text/javascript">
function writebtn(){
	location.href="<%=request.getContextPath()%>/boardwrite.action"
};
function list(page){
    location.href="<%=request.getContextPath()%>/boardform.action?curPage="+page+"&searchOption-${map.searchOption}"+"&keyword=${map.keyword}";
};

/* $(function(){
    $('body').contents().eq(0).each(function(){
        if(this.nodeName.toString()=='#text' && this.data.trim().charCodeAt(0)==8203){
            $(this).remove();
        }
    });
});
 */


/* https://bootsnipp.com/snippets/featured/panel-table-with-filters-per-column */
$(document).ready(function(){
    $('.filterable .btn-filter').click(function(){
        var $panel = $(this).parents('.filterable'),
        $filters = $panel.find('.filters input'),
        $tbody = $panel.find('.table tbody');
        if ($filters.prop('disabled') == true) {
            $filters.prop('disabled', false);
            $filters.first().focus();
        } else {
            $filters.val('').prop('disabled', true);
            $tbody.find('.no-result').remove();
            $tbody.find('tr').show();
        }
    });

    $('.filterable .filters input').keyup(function(e){
        /* Ignore tab key */
        var code = e.keyCode || e.which;
        if (code == '9') return;
        /* Useful DOM data and selectors */
        var $input = $(this),
        inputContent = $input.val().toLowerCase(),
        $panel = $input.parents('.filterable'),
        column = $panel.find('.filters th').index($input.parents('th')),
        $table = $panel.find('.table'),
        $rows = $table.find('tbody tr');
        /* Dirtiest filter function ever ;) */
        var $filteredRows = $rows.filter(function(){
            var value = $(this).find('td').eq(column).text().toLowerCase();
            return value.indexOf(inputContent) === -1;
        });
        /* Clean previous no-result if exist */
        $table.find('tbody .no-result').remove();
        /* Show all rows, hide filtered ones (never do that outside of a demo ! xD) */
        $rows.show();
        $filteredRows.hide();
        /* Prepend no-result row if all rows are filtered */
        if ($filteredRows.length === $rows.length) {
            $table.find('tbody').prepend($('<tr class="no-result text-center"><td colspan="'+ $table.find('.filters th').length +'">No result found</td></tr>'));
        }
    });
});
</script>
<style>
.filterable {
    margin-top: 15px;
}
.filterable .panel-heading .pull-right {
    margin-top: -20px;
}
.filterable .filters input[disabled] {
    background-color: transparent;
    border: none;
    cursor: auto;
    box-shadow: none;
    padding: 0;
    height: auto;
}
.filterable .filters input[disabled]::-webkit-input-placeholder {
    color: #333;
}
.filterable .filters input[disabled]::-moz-placeholder {
    color: #333;
}
.filterable .filters input[disabled]:-ms-input-placeholder {
    color: #333;
}
</style>
<title>FoodToLuck</title>
</head>
<body>
<jsp:include page="../framemode/FT_header.jsp"/>
	<h1 class="text-center" style="font: bold;font-family: cursive;">자유게시판</h1>
	<br>
	<div class="container">
    <div class="row">
        <div class="panel panel-primary filterable">
            <div class="panel-heading">
                <h3 class="panel-title">자유게시판</h3>
                <div class="pull-right">
                    <button class="btn btn-default btn-xs btn-filter"><span class="glyphicon glyphicon-filter"></span> Filter</button>
                </div>
            </div>
            <table class="table">
                <thead>
                    <tr class="filters">
                        <th><input type="text" class="form-control" placeholder="글번호" disabled></th>
                        <th><input type="text" class="form-control" placeholder="제목" disabled></th>
                        <th><input type="text" class="form-control" placeholder="작성자" disabled></th>
                        <th><input type="text" class="form-control" placeholder="날짜" disabled></th>
                    </tr>
  				
                </thead>
                <tbody>
                    <c:forEach var="row" items="${map.boardlist}">
      				  <tr>
            			<td>${row.board_no }</td>
           				 <td><a href="<%=request.getContextPath()%>/boardview.action?board_no=${row.board_no}"> <!-- 고침 -->
<!--            				 &curPage=${map.boardPager.curPage}&searchOption=${map.searchOption}&keyword=${map.keyword}"> -->
							${row.board_title} 
           				 </a></td>
           				 <td>${row.member_id }</td>
           				 <td>${row.board_date }</td>
      				  </tr>    
        			</c:forEach>
                </tbody>
            </table>
        </div>
        <div class="text-center">
			<div class="w3-bar">
				<table>
					<tr>
			            <td colspan="5">
			                <!-- **이전페이지 블록으로 이동 : 현재 페이지 블럭이 1보다 크면 [이전]하이퍼링크를 화면에 출력 -->
			                <c:if test="${map.boardPager.curBlock > 1}">
			                    <a href="javascript:list('${map.boardPager.prevPage}')" class="w3-button">[이전]</a>
			                </c:if>
	                
	                <!-- **하나의 블럭에서 반복문 수행 시작페이지부터 끝페이지까지 -->
			                <c:forEach var="num" begin="${map.boardPager.blockBegin}" end="${map.boardPager.blockEnd}">
			                    <!-- **현재페이지이면 하이퍼링크 제거 -->
			                    <c:choose>
			                        <c:when test="${num == map.boardPager.curPage}">
			                            <span style="color: red" class="w3-button">${num}</span>&nbsp;
			                        </c:when>
			                        <c:otherwise>
			                            <a href="javascript:list('${num}')" class="w3-button">${num}</a>&nbsp;
			                        </c:otherwise>
	                   			</c:choose>
	               			</c:forEach>
	                
			                <!-- **다음페이지 블록으로 이동 : 현재 페이지 블럭이 전체 페이지 블럭보다 작거나 같으면 [다음]하이퍼링크를 화면에 출력 -->
			                <c:if test="${map.boardPager.curBlock <= map.boardPager.totBlock}">
			                    <a href="javascript:list('${map.boardPager.nextPage}')" class="w3-button">[다음]</a>
			                </c:if>
	            		</td>
	        		</tr>
				</table>
			</div>
		</div>
		<div style="text-align: right">
		<c:if test="${sessionScope.sessionId.member_id != null }">
			<button class="w3-btn w3-round w3-border w3-padding-small" onclick=writebtn() id="write">글쓰기</button>
		</c:if>
		
		</div><br>
		<div class ="top-margin" style="text-align: right">
			<form  name="form1" method="post" action="<%=request.getContextPath()%>/boardform.action" class="form-inline">
		  		<div class="form-group">
			  		<select name="searchOption" style="height:33px">
						<option value="all"  <c:out value="${map.searchOption == 'all'?'selected':''}"/> >전체</option>
						<option value="member_id" <c:out value="${map.searchOption == 'member_id'?'selected':''}"/> >이름</option>
    				    <option value="board_content" <c:out value="${map.searchOption == 'board_content'?'selected':''}"/> >내용</option>
         				<option value="board_title" <c:out value="${map.searchOption == 'board_title'?'selected':''}"/> >제목</option>
					</select>
		    		<input type="text" class="form-control" style="width:290px" name="keyword" value="${map.keyword}" placeholder="Search">
		    		<input class="w3-btn w3-round w3-border w3-padding-small" type="submit" value="조회">
		  		</div>
			</form>
		</div>
    </div>
</div>
</body>
</html>
