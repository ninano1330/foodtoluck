<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="../framemode/FT_header.jsp">
	<jsp:param value="board/modifyBoard" name="parent"/>
</jsp:include>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style type="text/css">
.contact-form{ margin-top:15px;}
.contact-form .textarea{ min-height:220px; resize:none;}
.form-control{ box-shadow:none; border-color:#eee; height:49px;}
.form-control:focus{ box-shadow:none; border-color:#00b09c;}
.form-control-feedback{ line-height:50px;}
.main-btn{ background:#00b09c; border-color:#00b09c; color:#fff;}
.main-btn:hover{ background:#00a491;color:#fff;}
.form-control-feedback {
line-height: 50px;
top: 0px;
}
</style>
<link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.css" rel="stylesheet">
<script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.4/jquery.js"></script> 
<script src="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.js"></script> 
<link href="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.1/summernote.css" rel="stylesheet">
<script src="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.1/summernote.js"></script>
<script type="text/javascript">
</script>
<script>
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
  
  
  
  
  
  
  /* https://bootsnipp.com/snippets/featured/contact-us-form-with-validation */
  $('#contact-form').bootstrapValidator({
//    live: 'disabled',
    message: 'This value is not valid',
    feedbackIcons: {
        valid: 'glyphicon glyphicon-ok',
        invalid: 'glyphicon glyphicon-remove',
        validating: 'glyphicon glyphicon-refresh'
    },
    fields: {
        Name: {
            validators: {
                notEmpty: {
                    message: 'The Name is required and cannot be empty'
                }
            }
        },
        email: {
            validators: {
                notEmpty: {
                    message: 'The email address is required'
                },
                emailAddress: {
                    message: 'The email address is not valid'
                }
            }
        },
        Message: {
            validators: {
                notEmpty: {
                    message: 'The Message is required and cannot be empty'
                }
            }
        }
    }
});
  </script>
</head>

<body>
<link rel="stylesheet" href="http://cdnjs.cloudflare.com/ajax/libs/jquery.bootstrapvalidator/0.5.2/css/bootstrapValidator.min.css"/>
<script type="text/javascript" src="http://cdnjs.cloudflare.com/ajax/libs/jquery.bootstrapvalidator/0.5.2/js/bootstrapValidator.min.js"></script>
<div style="text-align: right" class="top-align right-margin top-margin">
		<button class="w3-btn w3-round w3-border w3-padding-small btn btn-default">회원가입</button>
		<button class="w3-btn w3-round w3-border w3-padding-small btn btn-default">로그인</button>
	</div>

	<!-- Search bar -->
<!-- 	<div class="w3-margin">
		<form class="form-inline" action="main.action">
	  		<div class="form-group" style="text-align:right;">
	  		</div>
	  		<button type="submit" class="btn btn-default">메인화면</button>
		</form>
	</div> -->
	<br><br><br><br><br><br>
	<h1 class="text-center" style="font: bold;font-family: cursive;">자유게시판</h1>
	<br><br><br><br><br><br>
<div class="container" style="height: 600px;">
	<div class="row">
		<form role="form" id="contact-form" class="contact-form" action="boardupdate.action" onsubmit="return postForm()" method="GET">
                    <div class="row">
                		<div class="col-md-6">
                		
                  		<div class="form-group">
                  			<input type="hidden" name="board_no" id="board_no" class="form-control" autocomplete="off"  value="${read.board_no }" size="80">
                            <input name="board_title" id="board_title" class="form-control" autocomplete="off"  value="${read.board_title }" size="80" placeholder="제목을 입력해주세요">
                  		</div>
                  	</div>
                    	<div class="col-md-6">
                  		<div class="form-group">
                            <input class="form-control" name="member_id" autocomplete="off" id="member_id" value="${read.member_id }" placeholder="작성자id" readonly="readonly" >
                  		</div>
                  	</div>
                  	</div>
                  	<textarea id="summernote" name="board_content" >${read.board_content }</textarea>
                    </div>
                    <div class="row">
                    <div class="col-md-12">
                 <div style="text-align:center;">
                  	<button type="submit" class="btn btn-default">작성</button>
                  	<input type="button" class="btn btn-default " onclick="history.back()" value="취소">
                 </div>
                  </div>
                  </div>
           </form>
	</div>
</div>
<%-- <section>
 <form id="postForm" action="boardupdate.action" onsubmit="return postForm()" method="GET">
	제목<input name="board_title" id="board_title"  value="${read.board_title }" size="80" placeholder="제목을 입력해주세요"><br>
	작성자:<input name="member_id" id="member_id" value=${read.member_id }>
    <!-- summernote와 관련된 영역 -->
    <textarea id="summernote" name="board_content" >${read.board_content }</textarea>

    <!-- 버튼과 관련된 영역 -->
    <div align="center">
   <input type="submit" class="button round blue" value="작성">
   <input type="button" onclick="history.back()" value="취소">
    </div>
</form>
</section> --%>
  
  </div>
</body>
</html>