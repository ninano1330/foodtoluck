<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>타임라인</title>
<link href="resources/css/timeline/bootstrap.3.3.7.css" rel="stylesheet">
<link href="resources/css/font-awesome.min.css" rel="stylesheet">
<link href="resources/css/timeline.css" rel="stylesheet">
<script src="resources/js/bootstrap.3.3.7.js"></script>
<script src="resources/jquery-3.2.1.min.js"></script>
<script type="text/javascript">

$(document).ready(function() {
//     $('#mdfTimelineModal').modal('show');
});
</script>

<script type="text/javascript">
//로그인 사용자 구분 용
//session.setAttribute("sessionId",vo)
// var owner_id = '<c:out value="${sessionScope.ownerId}"/>';
var owner_id = "${sessionScope.ownerId}";
console.log("현재 트럭의 사장 아이디 = "+owner_id);
//var owner_id = 'food111';
// var login_vo = '<c:out value="${sessionScope.sessionId}"/>';
var login_vo = "${sessionScope.sessionId}";
console.log("현재 로그인한 사용자의 VO = "+login_vo);
//var grade = login_vo.member_code;  // 일반사용자:u  사장:o  관리자:a
//var grade = "u";  // 일반사용자:u  사장:o  관리자:a
//var login_id = login_vo.member_id;
// var login_id = '<c:out value="${sessionScope.sessionId.member_id}"/>';
var login_id = "${sessionScope.sessionId.member_id}";
//var login_id = 'food111';
console.log("현재 로그인 사용자="+login_id);
//컨텍스트 경로
// var MyContextPath = '<c:out value="${pageContext.request.contextPath}"/>';
var MyContextPath ="${pageContext.request.contextPath}";
//트럭코드
// var truck_code = '<c:out value="${truck_code}"/>'; 
var truck_code = "${truck_code}"; 
//최신글번호 (페이징용)
// var maxRownum = '<c:out value="${maxRownum}"/>';
var maxRownum = "${maxRownum}";


//이건 아직 미구현 - 더보기 클릭 전에 새 타임라인을 누군가 등록했다면 추가분 만큼 위에 새 타임라인 보여주기위해
var since_no = 0;
//불러올 타임라인 갯수가 10개 미만이면 더보기 버튼 제거할 용도
var countList = '<c:out value="${countList}"/>';
//대댓글 깊이 저장용 변수
var reComment_depth = 0;

// -----------------------------------------------------------------------------------------------------------------------

//타임라인과 댓글관련 함수를 각기 구분하기 쉽게.
//timelineFNC
var timelineFNC = {
		
		//timelineFNC.checkImage(this)
		checkImage	:	function(that, id){
			console.log("this↓");
			console.log(that);
			console.log("$(that)↓");
			console.log($(that));
			
		 	/* var target = $('#'+imageTag);
			console.log("target[0]↓");
			console.log(target[0]);  
			console.log("target↓");
			console.log(target); */
			// ====== 확장자 체크  ===============================
	    	if($(that).val() != null && $(that).val() != ""){
	    		var extension = $(that).val().split(".").pop().toLowerCase();
	    		var extArray = ["gif", "jpg", "jpeg", "png"];
	    		
	    		//변수값과 배열내부의 값들을 비교해서 없으면 -1 리턴하는 jquery함수
	    		if($.inArray(extension, extArray) == -1){
	    			alert("이미지 파일만 업로드 할 수 있습니다.");
	    			$(that).val("");
	    			return;
	    		}
	    		
	    	} //확장자 체크 end
	    	
    		//======= 용량 체크 부분 ==========================
    		var fileSize = 0;
    		var maxSize = 3*1024*1024; //5mb 제한
    		var maxSizeString = "5MB";
    		var browser = navigator.appName;
    	
    		switch (browser) {
			case "Microsoft Internet Explorer" :
				var ao = new ActiveXObject("Scripting.FileSystemObject");
				fileSize = ao.getFile(that.value).size;
				break;
			default :
				fileSize = that.files[0].size;
				break;
			}
    		
    		alert("파일 사이즈 = "+fileSize+", "+maxSizeString+" 이내로 업로드 가능합니다.");
    		
    		if(fileSize > maxSize){
    			
    			alert("이미지파일 크기는 5MB 까지 업로드할 수 있습니다.");
    			$(that).val("");
    			return;
    		}//용량체크 end
    		
    		//아래 이미지 미리보기 호출
    		this.previewImage(that, id);
    		
		}, // 확장자, 용량체크 end
		

		
		//타임라인 작성 시 이미지 미리보기
		previewImage	:	function(timeline_image_file, id){
						
						if (timeline_image_file.files && timeline_image_file.files[0]) {
							var fileReader = new FileReader();
							
							fileReader.onload = function (e) {
								$(id).attr('src', e.target.result);
							}
							
							fileReader.readAsDataURL(timeline_image_file.files[0]);
						}
		},
		
		//--------------------------------------------------
		//타임라인입력란 보이기 / 감추기
		writetimelineToggle	:	function() {
			$('.writetimelineToggle').toggle();
		},
		
		//타임라인 불러올 ajax
		getTimeline		:	function(trcd, mxrn){
			$.ajax({
				
				async: true,
				type	:	"post",
				url		:	MyContextPath+"/getTimeline",
				data	:	{"truck_code" : trcd, "maxRownum" : mxrn},
				success	:	function(resultmap){
								//맵 안에 타임라인 list와 댓글list가 담겨있음
						console.log(resultmap);
						console.log(resultmap.TLlist);
						console.log(resultmap.TClist);
						
						var timelinebox = "";
						var tl = resultmap.TLlist;
						var tc = resultmap.TClist;
							
						//타임라인
						for (var i = 0; i < tl.length; i++) {
					 			 
					 		var mdfAndDelBtn = "";
					 		var mymy = "";
					 		var owner = "";
					 		var existImage = ""

					 		//(작성자 == 접속자)  수정/삭제 버튼 표시   +  내 글 표시
					 		if(tl[i].member_id == login_id){
					 			mdfAndDelBtn = 
						 			"<div class='col-xs-1 col-md-1 timeline_menu'>"
										+"<div class='dropdown'>"
											+"<button type='button' class='dropdown-toggle' id='menu1' data-toggle='dropdown'>"	
												+"<i class='fa fa-bars'></i>"
											+"</button>"
											+"<ul class='dropdown-menu dropdown-menu-right ddbtn' role='menu' aria-labelledby='menu1'>"
												+"<li role='presentation'>"
													+"<a class='mdfTimeline' role='menuitem' tabindex='-1' onclick='timelineFNC.mdfTimelineModal("+ tl[i].timeline_no +")'>"
														+"<i class='fa fa-pencil-square-o fa-fw'></i>수정"
													+"</a>"
												+"</li>"
												+"<li role='presentation'>"
													+"<a class='delTimeline' role='menuitem' tabindex='-1' onclick='timelineFNC.delTimeline("+ tl[i].timeline_no +")'><i class='fa fa-trash fa-fw'></i>삭제</a>"
												+"</li>"
											+"</ul>"
										+"</div>"
									+"</div>";
									
								mymy = " mymy";
					 		}		
					 		
					 		if(tl[i].member_id == owner_id){
					 			owner = " owner";
					 		}
					 			 
					 		if(tl[i].timeline_image != "no_image"){
					 			existImage = 
										"<img id='timeline_image"+ tl[i].timeline_no +"' class='timeline_image' alt='' src='"+ tl[i].timeline_image +"'>";
					 		}
					 		
					 		var inputCommentForm1 = "";
					 		if(login_id != "" && login_id != null && login_id != undefined){
					 			inputCommentForm1 = 
					 				"<div class='row form-inline'>"
										+"<div class='col-xs-9 col-md-9 form-group row'>"
											//+"<label class='sr-only'>writeComment</label>"
											+"<input id='tcomment_input_t"+ tl[i].timeline_no +"' type='text' class='form-control writeComment' placeholder='Write Comment Here'>"  //tcomment_input, timeline_no, trecomment_no, depth
										+"</div>"
										//고침
// 										+"<button class='col-xs-3 col-md-3 btn btn-default writeCommentBtn' onclick='commentFNC.inputComment(\"tcomment_input_t"+ tl[i].timeline_no +"\", \""+ tl[i].timeline_no +"\", 0, 1)'>"
										+"<button class='col-xs-3 col-md-3 btn btn-default writeCommentBtn' onclick='commentFNC.inputComment2(\"tcomment_input_t"+ tl[i].timeline_no +"\", \""+ tl[i].timeline_no +"\", 1)'>"
											+"<i class='fa fa-commenting fa-fw' aria-hidden='true'></i>"
											+"&nbsp; Confirm"
										+"</button>"
									+"</div>";
					 		}
					 	
					 			 
							var	timelinebox =
								"<div class='row timelinebox' id='timelinebox"+ tl[i].timeline_no +"'>"
									+"<div class='col-md-12 col-xs-12'>"
										+"<div class='row timeline_header'>"
											+"<div class='col-xs-2 col-md-2'>"
												+"<img class='profile-img img-circle center-block' alt='프로필짤' src='"+ tl[i].member_image +"'>"
											+"</div>"
											+"<div class='col-xs-9 col-md-9 memberbox'>"
												+"<div class='row'>"
													+"<div class='col-xs-6 col-md-6 member_nickname"+ owner +"'>"+ tl[i].member_nickname +"</div>"
													+"<div class='col-xs-6 col-md-6 member_id"+ mymy +"'>"+ tl[i].member_id +"</div>"
												+"</div>"
												+"<div class='row'>"
													+"<div class='col-md-12 timeline_date' id='timeline_date"+ tl[i].timeline_no +"'>"+ tl[i].timeline_date +"</div>"
												+"</div>"
											+"</div>"
											+ mdfAndDelBtn
										+"</div>" //end row timeline_header 
		 								+"<div class='row timeline_image_div'>"
											//+ existImage
											+"<img id='timeline_image"+ tl[i].timeline_no +"' class='timeline_image' alt='' src='"+ tl[i].timeline_image +"'>"
										+"</div>" 
										+"<div class='row timeline_content' id='timeline_content"+ tl[i].timeline_no +"'>"
											+ tl[i].timeline_content
										+"</div>"
										
										+ inputCommentForm1
										/* +"<div class='row form-inline'>"
											+"<div class='col-xs-9 col-md-9 form-group row'>"
												//+"<label class='sr-only'>writeComment</label>"
												+"<input id='tcomment_input_t"+ tl[i].timeline_no +"' type='text' class='form-control writeComment' placeholder='Write Comment Here'>"  //tcomment_input, timeline_no, trecomment_no, depth
											+"</div>"
											+"<button class='col-xs-3 col-md-3 btn btn-default writeCommentBtn' onclick='commentFNC.inputComment(\"tcomment_input_t"+ tl[i].timeline_no +"\", \""+ tl[i].timeline_no +"\", 0, 1)'>"
												+"<i class='fa fa-commenting fa-fw' aria-hidden='true'></i>"
												+"&nbsp; Confirm"
											+"</button>"
										+"</div>" */
										+"<div class='col-md-12 commentlist' id='commentlist"+ tl[i].timeline_no +"'>"
										+"</div>"
									+"</div>" //end col  
								+"</div>"; // 타임라인 빡쓰 닫는 태그
								
								
							if(i == tl.length-1 && mxrn-10>0)
								timelinebox	+=
								"<div class='row morebtncenter'>"
									+"<div>&nbsp;</div>"
										+"<button id='morebtn' class='btn btn-lg morebtn'>더 보기</button>"
									+"<div>&nbsp;</div>"
								+"</div>";
							
							$('.timelinelist').append(timelinebox);
						}
						
						//댓글 반복문
						for (var i = 0; i < tc.length; i++) {
							console.log(i+"번째 vo = "+tc[i]);
							//대댓글이면 옆으로 들여쓰기 margin-left: ~~px
							var rereply = "";
							var inputCommentForm2 = "";
							var mdfAndDelBtn = "";
							var mymy = "";
							var owner = "";
							
							if(tc[i].member_id == owner_id){
								owner = " owner";
							}
							
							
							if(tc[i].depth != 1){
								//css 클래스 추가
								rereply = " rereply"
							}
							
							if(login_id != "" && login_id != null && login_id != undefined){
								inputCommentForm2 = 
									"<div id='commentInputBox"+ tc[i].tcomment_no +"' class='row form-inline drop_menu'>"
										+"<div class='col-xs-9 col-md-9 form-group'>"
											//+"<label class='sr-only'>writeComment</label>"
											+"<input id='tcomment_input"+ tc[i].tcomment_no +"' type='text' class='form-control writeComment' placeholder='Write Comment Here' style='width:100%;'>"
										+"</div>"
										+"<button class='col-xs-3 col-md-3 btn btn-default writeCommentBtn'type='button' onclick='commentFNC.inputComment(\"tcomment_input"+ tc[i].tcomment_no +"\", \""+ tc[i].timeline_no +"\", \""+ tc[i].tcomment_no +"\", \""+ (tc[i].depth+1) +"\")'>"
											+"<i class='fa fa-commenting' aria-hidden='true'></i>"
											+"&nbsp; comment"
										+"</button>"
									+"</div>";
							}
							

							// id 같으면 수정/삭제 보이기 + 내 꺼 표시
							if(login_id == tc[i].member_id){
								mdfAndDelBtn =
									"<div class='dropdown alal'>"
										+"<i class='fa fa-bars dropdown-toggle' id='menu1' data-toggle='dropdown'></i>"
										+"<ul class='dropdown-menu dropdown-menu-right ddbtn' role='menu' aria-labelledby='menu1'>"
											+"<li role='presentation'>"
												+"<a class='mdfcmt' role='menuitem' tabindex='-1' onclick='commentFNC.mdfCommentModal("+ tc[i].tcomment_no +")'>"
													+"<i class='fa fa-pencil-square-o fa-fw'></i>"
													+"수정"
												+"</a>"
											+"</li>"
											+"<li role='presentation'>"
												+"<a class='delcmt' role='menuitem' tabindex='-1' onclick='commentFNC.delComment("+ tc[i].timeline_no +", "+ tc[i].tcomment_no +", "+ tc[i].trecomment_no +", "+ tc[i].depth +")'>"
													+"<i class='fa fa-trash fa-fw'></i>"
													+"삭제"
												+"</a>"
											+"</li>"
										+"</ul>"
									+"</div>";
									
								mymy = " mymy";
							} // id 같으면 수정/삭제 보이기
							
							var	commentbox = 
								"<div class='row'>"
								+"<div class='col-xs-12 col-md-12 commentbox_wrap' id='commentbox_wrap"+ tc[i].tcomment_no +"'>"
								
									+"<div class='row commentbox"+ rereply +"' id='commentbox"+ tc[i].tcomment_no +"'>"
										
										+"<div class='col-xs-12 col-md-12'>"
											+"<div class='row commentrow'>"
												
												+"<div class='col-xs-2 col-md-2'>"
													+"<div class='row'>"
														+"<img class='profile-img img-circle center-block' alt='프로필짤' src='"+ tc[i].member_image +"'>"
													+"</div>"
													+"<div class='row'>"
														+"&nbsp;"
													+"</div>"
												+"</div>"
												+"<div class='col-md10 col-xs-10 comment_ body'>"
													+"<div class='row comment_header'>"
														+"<div class='col-xs-11 col-md-11 memberbox'>"
															+"<div class='row'>"
																+"<div class='col-xs-6 col-md-6 member_nickname"+owner+"'>"+ tc[i].member_nickname +"</div>"
																+"<div class='col-xs-6 col-md-6 member_id"+ mymy +"'>"+ tc[i].member_id +"</div>"
															+"</div>"
															+"<div class='row'>"
																+"<div class='col-xs-12 col-md-12 tcomment_date' id='tcomment_date"+ tc[i].tcomment_no +"'>"+ tc[i].tcomment_date +"</div>"
															+"</div>"
														+"</div>"
														+"<div class='col-xs-1 col-md-1 comment_menu'>"//<!-- Dropdown menu -->
															+ mdfAndDelBtn
														+"</div>"// end Dropdown menu
													+"</div>" // end comment header
													
													+"<div class='row comment_contnent'>"// commment content 
														+"<div class='col-xs-12 col-md-12'>"
															+"<div class='row'>"
																+"<div class='col-xs-11 col-md-11 tcomment_content' id='tcomment_content"+ tc[i].tcomment_no +"'>"
																	+ tc[i].tcomment_content
																+"</div>"		
																+"<div class='col-xs-1 col-md-1 alal'>"
																	+"<i class='fa fa-commenting fa-fw' onclick='commentFNC.commentInputBox(\"commentInputBox"+ tc[i].tcomment_no +"\")'></i>"
																+"</div>"
															+"</div>"
															// 여기가 대댓글 달리는 장소였었지.... 
														+"</div>"
													+"</div>"// end commment content 
												+"</div>"// end comment_ body
										
											+"</div>"
											
											+inputCommentForm2
										
											/* +"<div id='commentInputBox"+ tc[i].tcomment_no +"' class='row form-inline drop_menu'>"
												+"<div class='col-xs-9 col-md-9 form-group'>"
													//+"<label class='sr-only'>writeComment</label>"
													+"<input id='tcomment_input"+ tc[i].tcomment_no +"' type='text' class='form-control writeComment' placeholder='Write Comment Here' style='width:100%;'>"
												+"</div>"
												+"<button class='col-xs-3 col-md-3 btn btn-default writeCommentBtn'type='button' onclick='commentFNC.inputComment(\"tcomment_input"+ tc[i].tcomment_no +"\", \""+ tc[i].timeline_no +"\", \""+ tc[i].tcomment_no +"\", \""+ (tc[i].depth+1) +"\")'>"
													+"<i class='fa fa-commenting' aria-hidden='true'></i>"
													+"&nbsp; comment"
												+"</button>"
											+"</div>" */
									
										+"</div>"
										
									+"</div>"; // end commentbox (row)
									
								var target = "";
								if(tc[i].depth == 1){
									target = "#commentlist"+ tc[i].timeline_no;
									$(target).prepend(commentbox);
								}else{
									target = "#commentbox_wrap"+ tc[i].trecomment_no;
									$(target).append(commentbox);
								}
								
						}// end 댓글 for 
				},//success end
				error	:	function(e){  
		            alert("getTimeline(ajax 타임라인 불러오기) 실패! = "+e.responseText);  
		        } //error end	
			}); //ajax end
			
			
			maxRownum = mxrn-10;
			
			if(maxRownum <= 0){
				//버튼 제거
				$('#morebtn').remove();
			}
			
		}, //getTimeline end
		
		
		//--------------------------------------------------
		//타임라인 수정
		mdfTimelineModal	:	function(t_no){
			
			$.ajax({
				//async: true,		
				type	:	"post",
				url		:	MyContextPath+"/mdfTimelineModal",
				data	:	{"truck_code" : truck_code, "timeline_no" : t_no},
				success	:	function(vo){
								console.log("타임라인 수정용 모달창 불러오기")
								console.log(vo);
								$('#mdfTimelineNo').val(t_no);
								$('#mdfTimelineContent').text(vo.timeline_content);
								$('#mdfTimelineImageSrc').attr('src', ""+vo.timeline_image);
								$("#mdfTimelineModal").modal("show");					
								console.log($('#mdfTimelineModal'));
				},//success end
				error	:	function(e){
					alert("mdfTimeline(ajax 타임라인 수정 전 내용 불러오기) 실패! = "+e.responseText);  
				}//error end
			}); //ajax end
		},//function mdfTimelineModal end

		//--------------------------------------------------
		//mdfTimelineModal에 이어서 저장버튼 누르면 실행
		//mdfTimelineAjax
		mdfTimelineAj	:	function(){

				var nullCheckTcmt = $('#mdfTimelineContent').val();
				if(nullCheckTcmt == "" || nullCheckTcmt == null || nullCheckTcmt == undefined){
					alert("내용을 입력하세요!");
					return;
				}
	
				var formData = new FormData($('#mdfForm')[0]);
				console.log(formData.get("truck_code"));
				console.log(formData.get("timeline_no"));
				console.log(formData.get("timeline_content"));
				console.log(formData.get("timeline_image_file"));

				$.ajax({
					//async: true,		 
					url		:	MyContextPath+"/mdfTimeline",
					data	:	formData,
					processData: false,
				    contentType: false,
					type	:	"POST",
					success	:	function(vo){
									console.log(vo);
									//로그인사용자와 작성자가 일치하지 않으면
									if(vo.timeline_no == -1){
										alert("해당글은 작성자만 수정할 수 있습니다.");
									}else if(vo.timeline_no == -2){
										alert("수정에 실패!!");
									}else{
										
										$('#timeline_content'+vo.timeline_no).text(vo.timeline_content);
										$('#timeline_date'+vo.timeline_no).text(vo.timeline_date);
										if(vo.timeline_image != "no_image"){
											$('#timeline_image'+vo.timeline_no).attr("src", vo.timeline_image);
										}else{
											$('#timeline_image'+vo.timeline_no).attr("src", "");
										}
										
										$('#mdfTimelineModal').modal('hide');
									}// else end
					},//success end
					error	:	function(request,status,error){
			            alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			            console.log("실패!");
			            console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
					}//error end
				});//ajax end 
			},//function mdfTimeline end
			
		//--------------------------------------------------
			
		//타임라인 삭제
		delTimeline		:	function(tl_no){
			
				if(!confirm("삭제하시겄소?")){
					return;
				}
		
				$.ajax({
					//async: true,		 
					type	:	"POST",
					url		:	MyContextPath+"/delTimeline",
					data	:	{
						
						"truck_code"	: truck_code,
						"timeline_no"	: tl_no,
						"member_id"		: login_id
					},
					success	:	function(result){
										console.log("result↓");
										console.log(result);
										if(result == -1){
											alert("해당글 작성자만 삭제할 수 있습니다.");
										}else if(result == -2){
											alert("오류 발생!");
										}else{
											 location.reload();
										}
										
										//maxRounum 꼬이니까 그냥 정상삭제되면 redirect 로 새로고침하는게 낫다싶음. 오류나면 redirect대신 alert만 띄우기로.
										/* else{
											alert("성공적으로 삭제했습니다.");
											$('#timelinebox'+tl_no).remove();
										}//else end */
						
					},//success end
					error	:	function(request,status,error){
			            alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			            console.log("실패!");
			            console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
					}//error end
				});//ajax end 
		} //delTimeline end
			
};//timelineFNC end




//-----------------------------------------------------------------------------------------------------------------------




var commentFNC = {
		//코멘트 입력창 토글하기
		commentInputBox : function(target){
			$('#'+target).toggle();
		},
		
		//댓글 대댓글 작성용 -- 
		//화면에 뿌릴 댓글버튼은 타임라인댓글버튼이면 depth=1, 댓글의 대댓글버튼이면 tc[i].depth + 1 하면 다음 댓글 달릴때 알아서 깊이 입력되니 ㅇㅋ
		//				function(tcomment_content, timeline_no, trecomment_no, depth){
		inputComment : function(tc_content, tl_no, trc_no, dpth){
			
			var tc = $("#"+tc_content).val();
			if(tc == "" || tc == null || tc == undefined){
				alert("내용을 입력하세요!");
				return;
			}
			
			//alert("댓글 인풋창 타겟용 id 변수="+tc_content +", 타임라인번호"+ tl_no +", 상위댓글번호"+ trc_no +", 깊이"+ dpth);
			//alert("트럭코드 = "+truck_code+" , login_id = "+login_id);
			//alert("댓글 입력한 내용 = "+tc);
			//alert(document.getElementById(tc_content));

			$.ajax({
				//async: true,
				type	:	"POST",
				url		:	MyContextPath+"/inputComment1",
				data	:	{
						"tcomment_content" : tc,
						"timeline_no"	   : tl_no, 
						"trecomment_no"    : trc_no, //타임라인 댓글이면 0
						"depth"			   : dpth,
						"truck_code"	   : truck_code, //이건 전역변수이므로 그냥 갖다 써
						"member_id"		   : login_id //컨트롤러에서  db아이디와 비교하기로
				},
				success	:	function(vo){
								
								console.log("댓글 입력 후 vo 는 ↓");
								console.log(vo);
								
							var rereply = "";
							if(vo.depth != 1){
								//css 클래스 추가
								rereply = " rereply"
							}
							var owner = ""
							if(owner_id == vo.member_id){
								owner = " owner";								
							}
		
							// id 같으면 수정/삭제 보이기
							var	mdfAndDelBtn =
									"<div class='dropdown alal'>"
										+"<i class='fa fa-bars dropdown-toggle' id='menu1' data-toggle='dropdown'></i>"
										+"<ul class='dropdown-menu dropdown-menu-right ddbtn' role='menu' aria-labelledby='menu1'>"
											+"<li role='presentation'>"
												+"<a class='mdfcmt' role='menuitem' tabindex='-1' onclick='commentFNC.mdfCommentModal("+ vo.tcomment_no +")'>"
													+"<i class='fa fa-pencil-square-o fa-fw'></i>"
													+"수정"
												+"</a>"
											+"</li>"
											+"<li role='presentation'>"
												+"<a class='delcmt' role='menuitem' tabindex='-1' onclick='commentFNC.delComment("+ vo.timeline_no +", "+ vo.tcomment_no +", "+ vo.trecomment_no +", "+ vo.depth +")'>"
													+"<i class='fa fa-trash fa-fw'></i>"
													+"삭제"
												+"</a>"
											+"</li>"
										+"</ul>"
									+"</div>";
				

							var	commentbox = 
								
								"<div class='row'>"
								+"<div class='col-xs-12 col-md-12 commentbox_wrap' id='commentbox_wrap"+ vo.tcomment_no +"'>"
								+"<div class='row commentbox"+ rereply +"' id='commentbox"+ vo.tcomment_no +"'>"
									+"<div class='col-xs-12 col-md-12'>"
										+"<div class='row commentrow'>"
											+"<div class='col-xs-2 col-md-2'>"
												+"<div class='row'>"
													+"<img class='profile-img img-circle center-block' alt='프로필짤' src='"+ vo.member_image +"'>"
												+"</div>"
												+"<div class='row'>"
													+"&nbsp;"
												+"</div>"
											+"</div>"
											+"<div class='col-md10 col-xs-10 comment_ body'>"
												+"<div class='row comment_header'>"
													+"<div class='col-xs-11 col-md-11 memberbox'>"
														+"<div class='row'>"
															+"<div class='col-xs-6 col-md-6 member_nickname"+owner+"'>"+ vo.member_nickname +"</div>"
															+"<div class='col-xs-6 col-md-6 member_id mymy'>"+ vo.member_id +"</div>"
														+"</div>"
														+"<div class='row'>"
															+"<div class='col-xs-12 col-md-12 tcomment_date' id='tcomment_date"+ vo.tcomment_no +"'>"+ vo.tcomment_date +"</div>"
														+"</div>"
													+"</div>"
													+"<div class='col-xs-1 col-md-1 comment_menu'>"//<!-- Dropdown menu -->
														+ mdfAndDelBtn
													+"</div>"// end Dropdown menu
												+"</div>" // end comment header
												
												+"<div class='row comment_contnent'>"// commment content 
													+"<div class='col-xs-12 col-md-12'>"
														+"<div class='row'>"
															+"<div class='col-xs-11 col-md-11 tcomment_content' id='tcomment_content"+ vo.tcomment_no +"'>"
																+ vo.tcomment_content
															+"</div>"		
															+"<div class='col-xs-1 col-md-1 alal'>"
																+"<i class='fa fa-commenting fa-fw' onclick='commentFNC.commentInputBox(\"commentInputBox"+ vo.tcomment_no +"\")'></i>"
															+"</div>"
														+"</div>"
														// 여기가 대댓글 달리는 장소였었지.... 
													+"</div>"
												+"</div>"// end commment content 
											+"</div>"// end comment_ body
										+"</div>"
									
										+"<div id='commentInputBox"+ vo.tcomment_no +"' class='row form-inline drop_menu'>"
											+"<div class='col-xs-9 col-md-9 form-group'>"
												//+"<label class='sr-only'>writeComment</label>"
												+"<input id='tcomment_input"+ vo.tcomment_no +"' type='text' class='form-control writeComment' placeholder='Write Comment Here' style='width:100%;'>"
											+"</div>"
											+"<button class='col-xs-3 col-md-3 btn btn-default writeCommentBtn' type='button' onclick='commentFNC.inputComment(\"tcomment_input"+ vo.tcomment_no +"\", \""+ vo.timeline_no +"\", \""+ vo.tcomment_no +"\", \""+ (vo.depth+1) +"\")'>"
												+"<i class='fa fa-commenting' aria-hidden='true'></i>"
												+"&nbsp; comment"
											+"</button>"
										+"</div>"
										
									+"</div>"
								+"</div>" // end commentbox
									+"</div>" // end commentbox_wrap  -- 여기에 append할거
								+"</div>"; // end row
							
								 var target = "";
								if(vo.depth == 1){
									target = "#commentlist"+vo.timeline_no;
									$(target).prepend(commentbox);
								}else{
									target = "#commentbox_wrap"+vo.trecomment_no;
									$(target).append(commentbox);
									$('#commentInputBox'+vo.trecomment_no).hide();//대댓글 입력후 입력창 닫기(토글임)
								}
					
						//alert("성공!");
						
						$("#"+tc_content).val(""); // 입력 성공 후 댓글입력칸 비우기
						
				},//success end
				error	:	function(request,status,error){
		            console.log("실패!");
// 		            console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
				}//error end : 
			});//ajax end
		},// inputComment end		
		
inputComment2 : function(tc_content, tl_no, dpth){
			
			var tc = $("#"+tc_content).val();
			if(tc == "" || tc == null || tc == undefined){
				alert("내용을 입력하세요!");
				return;
			}
			
			//alert("댓글 인풋창 타겟용 id 변수="+tc_content +", 타임라인번호"+ tl_no +", 상위댓글번호"+ trc_no +", 깊이"+ dpth);
			//alert("트럭코드 = "+truck_code+" , login_id = "+login_id);
			//alert("댓글 입력한 내용 = "+tc);
			//alert(document.getElementById(tc_content));

			$.ajax({
				//async: true,
				type	:	"POST",
				url		:	MyContextPath+"/inputComment1",
				data	:	{
						"tcomment_content" : tc,
						"timeline_no"	   : tl_no, 
// 						"trecomment_no"    : trc_no, //타임라인 댓글이면 0
						"depth"			   : dpth,
						"truck_code"	   : truck_code, //이건 전역변수이므로 그냥 갖다 써
						"member_id"		   : login_id //컨트롤러에서  db아이디와 비교하기로
				},
				success	:	function(vo){
								
								console.log("댓글 입력 후 vo 는 ↓");
								console.log(vo);
								
							var rereply = "";
							if(vo.depth != 1){
								//css 클래스 추가
								rereply = " rereply"
							}
							var owner = ""
							if(owner_id == vo.member_id){
								owner = " owner";								
							}
		
							// id 같으면 수정/삭제 보이기
							var	mdfAndDelBtn =
									"<div class='dropdown alal'>"
										+"<i class='fa fa-bars dropdown-toggle' id='menu1' data-toggle='dropdown'></i>"
										+"<ul class='dropdown-menu dropdown-menu-right ddbtn' role='menu' aria-labelledby='menu1'>"
											+"<li role='presentation'>"
												+"<a class='mdfcmt' role='menuitem' tabindex='-1' onclick='commentFNC.mdfCommentModal("+ vo.tcomment_no +")'>"
													+"<i class='fa fa-pencil-square-o fa-fw'></i>"
													+"수정"
												+"</a>"
											+"</li>"
											+"<li role='presentation'>"
												+"<a class='delcmt' role='menuitem' tabindex='-1' onclick='commentFNC.delComment("+ vo.timeline_no +", "+ vo.tcomment_no +", "+ vo.trecomment_no +", "+ vo.depth +")'>"
													+"<i class='fa fa-trash fa-fw'></i>"
													+"삭제"
												+"</a>"
											+"</li>"
										+"</ul>"
									+"</div>";
				

							var	commentbox = 
								
								"<div class='row'>"
								+"<div class='col-xs-12 col-md-12 commentbox_wrap' id='commentbox_wrap"+ vo.tcomment_no +"'>"
								+"<div class='row commentbox"+ rereply +"' id='commentbox"+ vo.tcomment_no +"'>"
									+"<div class='col-xs-12 col-md-12'>"
										+"<div class='row commentrow'>"
											+"<div class='col-xs-2 col-md-2'>"
												+"<div class='row'>"
													+"<img class='profile-img img-circle center-block' alt='프로필짤' src='"+ vo.member_image +"'>"
												+"</div>"
												+"<div class='row'>"
													+"&nbsp;"
												+"</div>"
											+"</div>"
											+"<div class='col-md10 col-xs-10 comment_ body'>"
												+"<div class='row comment_header'>"
													+"<div class='col-xs-11 col-md-11 memberbox'>"
														+"<div class='row'>"
															+"<div class='col-xs-6 col-md-6 member_nickname"+owner+"'>"+ vo.member_nickname +"</div>"
															+"<div class='col-xs-6 col-md-6 member_id mymy'>"+ vo.member_id +"</div>"
														+"</div>"
														+"<div class='row'>"
															+"<div class='col-xs-12 col-md-12 tcomment_date' id='tcomment_date"+ vo.tcomment_no +"'>"+ vo.tcomment_date +"</div>"
														+"</div>"
													+"</div>"
													+"<div class='col-xs-1 col-md-1 comment_menu'>"//<!-- Dropdown menu -->
														+ mdfAndDelBtn
													+"</div>"// end Dropdown menu
												+"</div>" // end comment header
												
												+"<div class='row comment_contnent'>"// commment content 
													+"<div class='col-xs-12 col-md-12'>"
														+"<div class='row'>"
															+"<div class='col-xs-11 col-md-11 tcomment_content' id='tcomment_content"+ vo.tcomment_no +"'>"
																+ vo.tcomment_content
															+"</div>"		
															+"<div class='col-xs-1 col-md-1 alal'>"
																+"<i class='fa fa-commenting fa-fw' onclick='commentFNC.commentInputBox(\"commentInputBox"+ vo.tcomment_no +"\")'></i>"
															+"</div>"
														+"</div>"
														// 여기가 대댓글 달리는 장소였었지.... 
													+"</div>"
												+"</div>"// end commment content 
											+"</div>"// end comment_ body
										+"</div>"
									
										+"<div id='commentInputBox"+ vo.tcomment_no +"' class='row form-inline drop_menu'>"
											+"<div class='col-xs-9 col-md-9 form-group'>"
												//+"<label class='sr-only'>writeComment</label>"
												+"<input id='tcomment_input"+ vo.tcomment_no +"' type='text' class='form-control writeComment' placeholder='Write Comment Here' style='width:100%;'>"
											+"</div>"
											+"<button class='col-xs-3 col-md-3 btn btn-default writeCommentBtn' type='button' onclick='commentFNC.inputComment(\"tcomment_input"+ vo.tcomment_no +"\", \""+ vo.timeline_no +"\", \""+ vo.tcomment_no +"\", \""+ (vo.depth+1) +"\")'>"
												+"<i class='fa fa-commenting' aria-hidden='true'></i>"
												+"&nbsp; comment"
											+"</button>"
										+"</div>"
										
									+"</div>"
								+"</div>" // end commentbox
									+"</div>" // end commentbox_wrap  -- 여기에 append할거
								+"</div>"; // end row
							
								 var target = "";
								if(vo.depth == 1){
									target = "#commentlist"+vo.timeline_no;
									$(target).prepend(commentbox);
								}else{
									target = "#commentbox_wrap"+vo.trecomment_no;
									$(target).append(commentbox);
									$('#commentInputBox'+vo.trecomment_no).hide();//대댓글 입력후 입력창 닫기(토글임)
								}
					
						//alert("성공!");
						
						$("#"+tc_content).val(""); // 입력 성공 후 댓글입력칸 비우기
						
				},//success end
				error	:	function(request,status,error){
		            console.log("실패!");
// 		            console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
				}//error end : 
			});//ajax end
		},// inputComment end
		
		
		//댓글 수정용 - 모달창에 내용 쏴주고 모달창 열기
		mdfCommentModal		:	function(tc_no) {
			//alert("댓글번호는 "+tc_no);
			$.ajax({
					type	:	"post",
					url		:	MyContextPath+"/mdfCommentModal",
					data	:	{"truck_code" : "${truck_code}", "tcomment_no" : tc_no},
					success	:	function(vo){
									console.log("댓글 수정용 모달창 불러오기")
									console.log(vo);
									$('#mdfCommentTcno').val(vo.tcomment_no);
									$('#mdfCommentContent').text(vo.tcomment_content);
									$('#mdfCommentModal').modal('show');
					},//success end
					error	:	function(e){
						alert("mdfCommentModal(ajax 댓글 수정 전 내용 불러오기) 실패! = "+e.responseText);  
					} //error end
			}); //ajax end
		},//mdfCommentModal end
		
		
		//댓글 대댓글 수정 - 모달창 저장버튼 클릭시 작동
		mdfCommentAj	:	function(){
			
				var nullCheckTcmt = $('#mdfCommentContent').val();
				if(nullCheckTcmt == "" || nullCheckTcmt == null || nullCheckTcmt == undefined){
					alert("내용을 입력하세요!");
					return;
				}
				var formParam = $('#mdfCommentForm').serialize();
				console.log("formParam ↓");
				console.log(formParam);
				
				//저장을 누르면 모달창을 닫고
				//ajax를 타서 여차저차 후 db에 저장한 후 저장된 내용을 다시 불러와 원래의 댓글자리에 쏴준다. 끗

				$.ajax({
						type	:	"post",
						url		:	MyContextPath+"/mdfCommentAj",
						data	:	formParam,
						success	:	function(vo){
										console.log("댓글 수정 클릭 후 ↓ ")
										console.log(vo);
										
										if(vo.tcomment_no == -1){ //작성자 접속자 불일치
											alert("해당글은 작성자만 수정할 수 있습니다.");
										}else if(vo.tcomment_no == -2){ //알수없는 오류 허헣
											alert("수정에 실패!!");
										}else{//수정 성공!
											$('#tcomment_content'+vo.tcomment_no).text(vo.tcomment_content);
											$('#tcomment_date'+vo.tcomment_no).text(vo.tcomment_date);
										}
										
										//모달창 닫기
										$('#mdfCommentModal').modal('hide');
										
						},//success end
						error	:	function(e){
							alert("mdfCommentAj(ajax 댓글 수정 전 내용 불러오기) 실패! = "+e.responseText);  
						} //error end				
				});//ajax end
			},//mdfComment function end
			
			
			//댓글 삭제    (트럭코드, 타임라인번호, 댓글번호, 상위댓글번호, 작성자, 깊이)
				//전역(트럭코드, 접속자) (타임라인번호, 댓글번호, 상위번호, 깊이)
			//commentFNC.delComment(tl_no, tc_no, tre_no, dpth)
			delComment	:	function(tl_no, tc_no, tre_no, dpth){

						if(!confirm("삭제하시겄소?")){
							return;
						}		
				
						$.ajax({
								type	:	"post",
								url		:	MyContextPath+"/delComment",
								data	:	{
											"truck_code"	:	truck_code,
											"timeline_no"	:	tl_no,
											"tcomment_no"	:	tc_no,
											"trecomment_no"	:	tre_no,
											"depth"			:	dpth,
											"member_id"		:	login_id
								},
								success	:	function(result){

											console.log("result↓");
											console.log(result);
											if(result == -1){
												alert("해당댓글은 작성자만 삭제할 수 있습니다.");
											}else if(result == -2){
												alert("오류 발생!");
											}else{
												 location.reload();
											}
								},//success end
								error	:	function(request,status,error){
						            console.log("실패!");
						            console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
								}//error end : 
						}); //ajax end
			}//delComment end
		
}// commentFNC end

//top 버튼 동작 구현부분
// When the user scrolls down 20px from the top of the document, show the button
window.onscroll = function() {scrollFunction()};

function scrollFunction() {
    if (document.body.scrollTop > 20 || document.documentElement.scrollTop > 20) {
        document.getElementById("topbtn").style.display = "block";
    } else {
        document.getElementById("topbtn").style.display = "none";
    }
}

// When the user clicks on the button, scroll to the top of the document
function topFunction() {
    document.body.scrollTop = 0; // For Chrome, Safari and Opera 
    document.documentElement.scrollTop = 0; // For IE and Firefox
}



//-----------------------------------------------------------------------------------------------------------------------
//DOCUMENT READY ========================================================================================================
	
$(document).ready(function() {

	alert(maxRownum);
//-----------------------------------------------------------------------------------------------------------------------
	if(maxRownum>0){ //타임라인 존재하면 불러오기
		timelineFNC.getTimeline(truck_code, maxRownum);
	}
	
	$("body").on('click', '#morebtn', function(){
		timelineFNC.getTimeline(truck_code, maxRownum);
		$('#morebtn').remove();
	});
//-----------------------------------------------------------------------------------------------------------------------

	  
//-----------------------------------------------------------------------------------------------------------------------
	//써머노트 안쓰고 이미지 미리보기할 때
	/* $("#timeline_image_file").on('change', function(){
		timelineFNC.previewImage(this, "#previewImage");
	}); */
	
//-----------------------------------------------------------------------------------------------------------------------

	//jQuery로 CSS높이 맞추기-------------------
	var maxHeight = -1;
	
	$('.features').each(function() {
	  maxHeight = maxHeight > $(this).height() ? maxHeight : $(this).height();
	});
	
	$('.features').each(function() {
	  $(this).height(maxHeight);
	});
	//end jQuery로 CSS높이 맞추기----------------
//-----------------------------------------------------------------------------------------------------------------------

//타임라인 작성시 내용 null 체크용
 	$("#inputCommentBtn").on('click', function(){
 		
		var checkNull = $("#inputTimeline_content").val();	
		if(checkNull == "" || checkNull == null || checkNull == undefined){
			alert("내용을 입력하세요!");
			return;
		}else{
			$("#inputTimelineForm").submit();
		}
	});

	

}); // DOCUMENT READY end =====================================================================================================
</script>
</head>
<body>
<div class='timelinelist'>
		<!-- 로그인 사용자만 -->
			<c:if test="${sessionScope.sessionId != '' && sessionScope.sessionId != null}">
			
				<!-- write timeline -->
				<div class='row writetimeline'>
					<button class='row btn btn-default writetimelineBtn' onclick="timelineFNC.writetimelineToggle()"><i class="fa fa-newspaper-o fa-lg" aria-hidden="true"></i>&nbsp;&nbsp;&nbsp;Write TimeLine!</button>
					<!-- SummerNote Place -->
					<div class='row writetimelineToggle' hidden="true">
						<form id='inputTimelineForm' class='row form-inline' action="setTimeline" method="post" enctype="multipart/form-data">
							<div class='row'>
								<div class='col-xs-12 col-md-12 form-group'>
									<label class='sr-only'>uploadImage</label>	
									<!-- 혹시라도 써머노트 쓸거면 아래처럼 -->
									<!-- <input type="text" class='summernote' id='summernoteSubmit' name='contextResult'> -->
									<input type="file" id='timeline_image_file' name='timeline_image_file' placeholder="이미지파일 크기는 5MB 까지 업로드할 수 있습니다." onchange="timelineFNC.checkImage(this, '#previewImage')">
									<img alt="" src="" id='previewImage' class='timeline_image'>
								</div>
							</div>
							<div class='row'>
								<div class='col-xs-12 col-md-12 form-group'>
									<label class='sr-only'>writeTimeline</label>
									<input type="hidden" name="truck_code" value="${truck_code}">	
									<textarea id='inputTimeline_content' name='timeline_content' class='form-control writeComment' placeholder='Write Timeline Here'></textarea>
								</div>
							</div>
							<div class='row'>
								<button id='inputCommentBtn' class='col-xs-12 col-md-12 btn btn-default writeCommentBtn' type="button">
									<i class='fa fa-commenting fa-fw' aria-hidden='true'></i>
									&nbsp; Confirm
								</button>
							</div>
						</form>
					</div>
					</div>
				</div>
				<!-- end write timeline -->
			</c:if>
			<br>
			
			<button onclick="topFunction()" id="topbtn" title="Go to top">Top</button>
		
		
		
		<!-- 여기서부터 붙여넣기함 -->
		<!-- 로그인 사용자만 -->
		<c:if test="${sessionScope.sessionId != '' && sessionScope.sessionId != null}">
			<!-- ===========================타임라인 수정 용 모달 창 띄우기 ========================================================================== -->
			<!-- <button class="btn btn-default" id="mdfbutton">글 수정</button> -->
			<div class="modal fade" id="mdfTimelineModal" >
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
							<h4 class="modal-title">타임라인 수정하기</h4>
							<form id='mdfForm' action='/foodtoluck/mdfTimeline' method="post" enctype="multipart/form-data">
								<div class="modal-body">
									<input type="hidden" id='mdfTruck_code' name='truck_code' value="${truck_code}">
									<input type="hidden" id='mdfTimelineNo' name='timeline_no'>
									<input type="file" name="timeline_image_file" id="mdfTimelineImageInput" onchange='timelineFNC.checkImage(this, "#mdfTimelineImageSrc")'>
									<img alt="이전 이미지" src="" class='timeline_image' id='mdfTimelineImageSrc'>
									<textarea name="timeline_content" class='writeComment' id="mdfTimelineContent" rows="5" cols="50"></textarea>
								</div>
								<div class="modal-footer">
									<button type="button" id="mdfTimelineAjax" class="btn btn-default" onclick="timelineFNC.mdfTimelineAj()">저장</button>
									<button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
			<!-- ======================  end 타임라인 수정 용 모달 창 띄우기 ========================================================================== -->
			
			<!-- ====================== 댓글, 대댓글 수정용 모달창 ================================================================================= -->
			<div class="modal fade" id="mdfCommentModal" >
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
							<h4 class="modal-title">댓글 수정하기</h4>
						</div>
						<form id='mdfCommentForm'>
							<div class="modal-body">
								<input type="hidden" id='mdfCommentMemid' name='member_id' value=<c:out value="${sessionScope.sessionId.member_id}"/>>
								<input type="hidden" id='mdfCommentTrcd' name='truck_code' value="${truck_code}">
								<input type="hidden" id='mdfCommentTcno' name='tcomment_no'>
								<textarea id="mdfCommentContent" class='writeComment' name="tcomment_content" rows="5" cols="50"></textarea>
							</div>
							<div class="modal-footer">
								<button type="button" id="mdfCommentInput" class="btn btn-default" onclick="commentFNC.mdfCommentAj()">저장</button>
								<button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
							</div>
						</form>
					</div>
				</div>
			</div>
			<!-- ======================  end 댓글, 대댓글 수정용 모달창 ============================================================================= -->
		
		</c:if>
</body>
</html>