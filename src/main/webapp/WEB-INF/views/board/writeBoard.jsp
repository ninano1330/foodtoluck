<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="../framemode/FT_header.jsp">
	<jsp:param value="board/viewBoard" name="parent"/>
</jsp:include>
  <meta charset="UTF-8">
  <title>자유게시판 작성화면</title>
  <link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.css" rel="stylesheet">
  <script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.4/jquery.js"></script> 
  <script src="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.js"></script> 
  <link href="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.1/summernote.css" rel="stylesheet">
  <script src="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.1/summernote.js"></script>
  <script type="text/javascript">
  </script>
<script type="text/javascript">
    $(document).ready(function() {
      $('#summernote').summernote({
        height: 300,
        minHeight: null,
        maxHeight: null,
        focus: true,
        callbacks: {
          onImageUpload: function(files, editor, welEditable) {
            for (var i = files.length - 1; i >= 0; i--) {
              sendFile(files[i], this);
            }
          }
        },
      });
    });
    
    function sendFile(file, el) {
      var form_data = new FormData();
      form_data.append('file', file);
      $.ajax({
        data: form_data,
        type: "POST",
        url: 'boardfile.action',
        cache: false,
        contentType: false,
        enctype: 'multipart/form-data',
        processData: false,
        success: function(url) {
            $(el).summernote('editor.insertImage', url);
            $('#imageBoard > ul').append('<li><img src="'+url+'" width="480" height="auto"/></li>');
          }
      });
    }
</script>
</head>

<body>
<!-- <div style="text-align: right" class="top-align right-margin top-margin">
		<button class="w3-btn w3-round w3-border w3-padding-small">회원가입</button>
		<button class="w3-btn w3-round w3-border w3-padding-small">로그인</button>
</div> -->

	<!-- Search bar -->
<!-- 	<div class="w3-margin">
		<form class="form-inline" action="/">
	  		<div class="form-group" style="text-align: right">
	  			<button type="submit" class="btn btn-default">메인화면</button>
	  		</div>
		</form>
	</div> -->
	<br/><br/><br/><br/>
	<h1 align="center">자유게시판 작성</h1>
	<br/><br/><br/><br/>
	<div class="center-block" style="width:50%">
	<div class="panel panel-default">
	<div class="panal-heading">자유게시판 작성<br/></div>
	<div class="panel-body">
<section>
 <form id="postForm" action="boardinsert.action" method="GET" enctype="multipart/form-data" >
	제목<input name="board_title" id="board_title" size="50" placeholder="제목을 입력해주세요"><br><br>
	<input type="hidden" name="member_id" id="member_id" value="${sessionScope.sessionId.member_id }" size="80" placeholder="이름을 입력해주세요" readonly="readonly" >
    <!-- summernote와 관련된 영역 -->
    <textarea id="summernote" name="board_content" ></textarea>
    <!-- 버튼과 관련된 영역 -->
    <div align="center">
   <input type="submit" class="btn btn-default" value="작성">
   <input type="button" class="btn btn-default" onclick="history.back()" value="취소">
    </div>
</form>
</section>
  </div>
  </div>
  </div>
</body>
</html>