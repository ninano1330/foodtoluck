<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="../framemode/FT_header.jsp">
	<jsp:param value="notic/writeNotice" name="parent"/>
</jsp:include>
  <meta charset="UTF-8">
  <title>공지게시판 작성화면</title>
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
        url: 'file.action',
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

<br/><br/><br/><br/>
<h1 align="center">공지게시판 작성</h1>
<br/><br/><br/><br/>
<div class="center-block" style="width:50%">
	<div class="panel panel-default">
		<div class="panal-heading">
			공지 게시글 작성<br/>
		</div>
		<div class="panel-body">
			<section>
				<form id="postForm" action="insert.action" method="GET" enctype="multipart/form-data" >
					<div>
						<label class="item" for="subject">제목</label>
						<input name="notice_title" id="notice_title" size="55" placeholder="제목을 입력해주세요">
					</div>
					<br>
					<div>
						<input type="hidden" name="admin_id" id="admin_id" value="${sessionScope.sessionId.member_id }" size="80" >
						<!-- summernote와 관련된 영역 -->
						<textarea id="summernote" name="notice_content" ></textarea>
					</div>
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