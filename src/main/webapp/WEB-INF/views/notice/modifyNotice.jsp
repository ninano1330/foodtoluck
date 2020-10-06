<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="../framemode/FT_header.jsp">
	<jsp:param value="notice/modifyNotice" name="parent"/>
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
<link rel="stylesheet" href="http://cdnjs.cloudflare.com/ajax/libs/jquery.bootstrapvalidator/0.5.2/css/bootstrapValidator.min.css"/>
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




<script type="text/javascript" src="http://cdnjs.cloudflare.com/ajax/libs/jquery.bootstrapvalidator/0.5.2/js/bootstrapValidator.min.js"></script>

	<br><br><br><br><br><br>
	<h1 class="text-center" style="font: bold;font-family: cursive;">공지게시판</h1>
	<br><br><br><br><br><br>
<section>
<div class="container">
	<div class="row">
		<form role="form" id="contact-form" class="contact-form" action="update.action" onsubmit="return postForm()" method="GET">
                    <div class="row">
                		<div class="col-md-6">
                		
                  		<div class="form-group">
                  			<input type="hidden" class="form-control" autocomplete="off"  name="notice_no" id="notice_no"  value="${read.notice_no }" size="80">
                            <input class="form-control" autocomplete="off"   name="notice_title" id="notice_title"  value="${read.notice_title }" size="80" placeholder="제목을 입력해주세요">
                  		</div>
                  	</div>
                    	<div class="col-md-6">
                  		<div class="form-group">
                            <input class="form-control" autocomplete="off" name="admin_id" id="admin_id" value="${read.admin_id }" placeholder="작성자id" readonly="readonly" >
                  		</div>
                  	</div>
                  	</div>
                  	<textarea id="summernote" name="notice_content" >${read.notice_content }</textarea>
                    </div>
                    <div class="row">
                    <div class="col-md-12">
                 <div style="text-align : right;">
                  	<button type="submit" class="btn btn-default">작성</button>
                  	<input type="button" class="btn btn-default " onclick="history.back()" value="취소">
                  	</div>
                  </div>
                  </div>
           </form>
	</div>
</div>
</section>
  
  </div>
</body>
</html>