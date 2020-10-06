<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@include file="mainFrame.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
<title>FoodToLuck 회원가입</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<meta name="Title" content="Food To Everywhere - 푸드트럭!" />
<meta name="Keywords" content="해당섹션 설명" />
<meta name="Description" content="" />

<link rel="shortcut icon" href="resources/img/foodtoluck.JPG" />
<script type="text/javascript" src="resources/js/util/envUtils.js?v=10"></script>
<link href="resources/css/member_new.css?v=10"
	rel="stylesheet" type="text/css" />
<script type="text/javascript" src="resources/js/jquery-3.2.1.min.js"></script>
<script type="text/javascript"
	src="resources/js/library/underscore-1.8.3.min.js"></script>
<script type="text/javascript" src="resources/js/util/envUtils.js"></script>
<script type="text/javascript" src="resources/js/util/dataUtils.js"></script>
<script type="text/javascript" src="resources/js/util/logUtils.js"></script>
<script type="text/javascript"
	src="resources/js/util/navigationUtils.js"></script>
<script type="text/javascript" src="resources/js/service/netService.js"></script>
<script type="text/javascript"
	src="resources/js/DanawaMemberValidation.js"></script>
<script type="text/javascript"
	src="resources/js/application/model/join/joinStep.js"></script>
<script src='https://www.google.com/recaptcha/api.js'></script>
<style>
.g-recaptcha{
	margin-left: 28%;
	margin-right: auto;
}
</style>
<script type="text/javascript">
			$(document).ready(function() {
				var memberJoinStep = new DanawaMemberJoinStep();
					memberJoinStep.initialize();
					
				var memberValidation = new DanawaMemberValidation();
				var validatonTagetId = {
						tagetFome : "danawa-member-joinStep-form-id",
						member : {
							id:"danawa-member-joinStep-member-id",
							password : "danawa-member-joinStep-member-password",
							passwordConfirm :"danawa-member-joinStep-member-passwordConfim", 
							name : "danawa-member-joinStep-member-name",
							nickname : "danawa-member-joinStep-member-nickname",
							email : {
								emailFirst :"danawa-member-joinStep-member-email-emailFirst",
								emailSecond :"danawa-member-joinStep-member-email-emailSecond"
							}
						},
						message : {
							id:"danawa-member-joinStep-message-id",
							password : "danawa-member-joinStep-message-password",
							passwordConfirm : "danawa-member-joinStep-message-passwordConfirm",
							name : "danawa-member-joinStep-message-name",
							nickname : "danawa-member-joinStep-message-nickname", 
							email :"danawa-member-joinStep-message-email"
						}
				};
				memberValidation.initialize(validatonTagetId);
			
			//var modalLayer = $("#modalLayer");
			var modalLayer = $("#layer_pop_byemail");
			var modalLink = $(".modalLink");
			
			var emailFirst = $('#danawa-member-joinStep-member-email-emailFirst');
			var emailSecond = $('#danawa-member-joinStep-member-email-emailSecond');
			var emailCode = $('#email_code');
			
			var loadingHtml = '<div id="loading" style="z-index: 1005;position: absolute; top:69%;left:50%; text-align:center;"> ';
		    loadingHtml += '<div class="loading_box"><img src="<c:url value="resources/img/load-root.gif"/>"  /></div></div>';
			 
			modalLink.click(function(){
			    modalLayer.fadeIn();
			    $('body').fadeTo( "fast", 0.4 ).append(loadingHtml);
			    doAjax(emailFirst.val()+'@'+emailSecond.val());
			    //alert(emailFirst.val()+'@'+emailSecond.val());
			    
			    $(this).blur();
			    $("#email_code").focus(); 
			    return false;
			});
			
			$('.btn_basic_type01').click(function(){
				$("#email_layer_sub_title").html("잠시만 기다려주세요.");
				$('body').fadeTo( "fast", 0.4 ).append(loadingHtml);
				emailCode.val("");
			    doAjax(emailFirst.val()+'@'+emailSecond.val());
			})
			 
			  
			$(".btn_layer_close").click(function(){
				$("#email_layer_sub_title").html("잠시만 기다려주세요.");
			    modalLayer.fadeOut();
			    modalLink.focus();
			  });  
			
			$('.btn_basic_type04').on('click', function(){
				doAjax2(emailCode.val());		
			});	
				
	});//end document.ready
				
			
			function doAjax(email){
				$.ajax({
					type:"post",
					url:"<%=request.getContextPath()%>/sendMail/auth",
					data: {"email":email },
					success:function(result){
						$('body').fadeTo( "slow", 1 ).find('#loading').remove();
						if(result==true){
							console.log(result);
							$("#email_layer_sub_title").html("인증번호가 발송되었습니다.<br>이메일로 전달받은 인증번호를 입력해주세요.");
						}else{
							$("#email_layer_sub_title").html("발송이 실패하였습니다. 다시 시도해주세요.");
						}
						
					}

				});//$.ajax			
			}
	
			function doAjax2(emailCode){
				$.ajax({
					type:"post",
					url:"<%=request.getContextPath()%>/sendMail/auth2",
					data: {"emailCode":emailCode },
					success:function(result){
						if(emailCode==''){
							alert('인증번호를 입력해주세요');
						}else if(result==true){
							alert("인증 완료");
							$('.email_certi_noti p').html("인증완료");
							$('.email_certi_noti p').css("color","blue");
							$("#layer_pop_byemail").fadeOut();
							
							$(".modalLink").hide();
							$(".slct_email_tail").hide();
							
							$('#danawa-member-joinStep-member-email-emailFirst').attr("readonly",true);
							$('#danawa-member-joinStep-member-email-emailSecond').attr("readonly",true);
							
							//확인변수 생성
						}else if(result==false){
							alert("인증번호가 틀립니다");
						}
					}

				});//$.ajax			
			}
			function chkCaptcha() {
			    if (typeof(grecaptcha) != 'undefined') {
			       if (grecaptcha.getResponse() == "") {
			           alert("스팸방지코드를 확인해 주세요.");
			           return false;
			       }
			    }
			    else {
			         return false;
			    }
			}
		</script>
		

</head>
<body>
	<form name="frm_Info" method="post" id="danawa-member-joinStep-form-id">
		<!-- 회원타입 : G - 개인, D - 사업자 -->
		<input type="hidden" name="hdnMemberType"
			id="danawa-member-joinStep-memberType" value="G" /> 
		<input type="hidden" id="danawa-member-joinStep-hidden-email"
			name="memberEmail" /> <input type="hidden" name="url" value="" />

		<div id="dnw_wrap" class="join_wrap join_certi_wrap">
			<!-- join_wrap 클래스추가 -->
			<!-- join_member-->
			<div class="join_member">
				<!-- join_member 클래스추가 -->
				<!-- guide_header -->
				<div id="danawa-member-joinStep-danawaLogo" class="guide_header">
					<h1>
						<a href="main">FoodToLuck.com</a>
					</h1>
					<h2 class="tit_join_top tit_join_member">회원가입</h2>
				</div>
				<!-- //guide_header -->
				<!-- join_container -->
				<div class="join_container">
					<!-- join_tab -->
					<div class="join_top_area">
						<ul class="join_tap">
							<li class="tab_li tap_member_join"
								id="danawa-member-joinStep-tap-member">
								<h3 id="danawa-member-joinStep-tap-member-on" class="on">
									<a href="javascript:;" title="개인 회원"><span>개인 회원</span></a>
								</h3>
								<!-- 활성화시 on클래스 추가 -->
							</li>
							<li class="tab_li tab_company_join"
								id="danawa-member-joinStep-tap-company">
								<h3 id="danawa-member-joinStep-tap-company-on">
									<a href="#" onclick="return false;" title="사업자 회원"><span>트럭운영자</span></a>
								</h3>
							</li>
						</ul>
						<div class="sns_login_wrap" id="danawa-member-joinStep-snsLogin">
							<dl>
								<dt>
									소셜 계정으로 이동<span class="ico"></span>
								</dt>
								<dd>
									<a href="/sns/login?type=NAVER&redirectUrl=" target="_blank"><img
										src="resources/img/bnr_naver_ico.jpg"
										alt="네이버 로그인" /></a>
								</dd>
								<dd>
									<a href="/sns/login?type=KAKAO&redirectUrl=" target="_blank"><img
										src="resources/img/bnr_kakao_ico.jpg"
										alt="카카오 로그인" /></a>
								</dd>
								<dd>
									<a href="/sns/login?type=FACEBOOK&redirectUrl=" target="_blank"><img
										src="resources/img/bnr_facebook_ico.jpg"
										alt="페이스북 로그인" /></a>
								</dd>
								<dd id="danawa-member-joinStep-snsLogin-daum">
									<a href="/sns/login?type=DAUM&redirectUrl=" target="_blank"><img
										src="resources/img/bnr_daum_ico.jpg"
										alt="다음 로그인" /></a>
								</dd>
							</dl>
						</div>
					</div>
					<!--// join_tab -->
					<!-- join_contents -->
					<!--1702 personal 클래스 추가 join_contents -->
					<div class="join_contents personal">
						<div class="join_title_area">
							<h4 class="tit_h4">약관 동의</h4>
							<div class="checkbox_wrap">
								<!-- 웹접근성을 위해 input의 id값과 label의 for값을 동일하게 해주세요.-->
								<!-- 1702 라벨 클릭 시 클래스 on 추가  -->
								<label for="danawa-member-joinStep-checkBox-agree-all"
									class="lb_chk_box" title="회원가입 약관에 모두 동의합니다. 필수 입력 항목"><strong>
										회원가입 약관에 모두 동의합니다.</strong></label>
								<!--1702 웹접근성 포커스 (Tab키) 이동 시 클래스 focus 추가 탭키 이동 관련 개발 필요 -->
								<input class="input_check focus" type="checkbox"
									id="danawa-member-joinStep-checkBox-agree-all" title="[체크박스]" />
							</div>
						</div>
						<!-- join_box -->
						<div class="join_box join_agree_box">
							<div class="agree_con agree_con1">
								<h5 class="tit_h5">
									<!-- 1702 라벨 클릭 시 클래스 on 추가 -->
									<label for="danawa-member-joinStep-checkBox-agree-service"
										class="lb_chk_box" title="서비스 이용 약관 필수 입력 항목"> <strong>서비스
											이용 약관</strong> <span> (필수)</span> <span class="blind">FoodToLuck 서비스
											이용 약관에 동의합니다.</span>
									</label>
									<!--1702 약관보기 클릭 시 클래스 on 과 내용닫기 텍스트 변경 -->
									<span class="btn_view ico on">
										<button type="button"
											id="danawa-member-joinStep-guide-button-service"
											title="약관보기 버튼 누르면 상세 내용이 열립니다">약관보기 ▼</button>
									</span>
									<!--1702 웹접근성 포커스 (Tab키) 이동 시 클래스 focus 추가 탭키 이동 관련 개발 필요 -->
									<input class="input_check" type="checkbox"
										id="danawa-member-joinStep-checkBox-agree-service"
										title="[체크박스]" />
								</h5>
								<div class="agree_textarea_wrap">
									<textarea readonly="readonly" class="textarea_member"
										id="danawa-member-joinStep-guide-textDesc-service" cols=""
										rows="" style="display: none;" title="서비스 이용 약관 안내 내용"></textarea>
									<!-- 이용약관 설정 -->
									<textarea readonly="readonly" class="textarea_member"
										id="danawa-member-joinStep-member-agreement" cols="" rows=""
										style="display: none;" title="개인회원 서비스 이용 약관 안내 내용">
											
제 1장 총칙

제 1 조 (목 적)

이 약관은 ㈜FoodToLuck (전자상거래 사업자)가 운영하는 인터넷 서비스 "FoodToLuck" (www.FoodToLuck.com) 및 FoodToLuck 관련 제반 서비스 사이트(접속 가능한 유,무선 단말기의 종류와는 상관없이 이용 가능한 '회사' 가 제공하는 모든 "서비스" 를 의미하며, 이하 '사이트'라 함)에서 제공하는 상품 및 가격정보 등 상품에 대한 정보 제공 및 광고서비스를 이용함에 있어 '회사' 와 이용자의 권리와 의무 및 책임사항 등을 규정함을 그 목적으로 합니다.

제 2 조 (정의)

① 본사의 규칙을 따라야합니다. 본사가 정의입니다.

<부칙> 본 개정약관은 2016년 5월 25일부터 시행합니다.
    
										</textarea>
									<textarea readonly="readonly" class="textarea_member"
										id="danawa-member-joinStep-company-agreement" cols="" rows=""
										style="display: none;" title="사업자회원 서비스 이용 약관 안내 내용">
											
제 1장 총칙

제 1 조 (목적)

트럭 잘 운영하시길 부탁드립니다.

<부칙> 본 개정약관은 2012년 02월 27일부터 시행합니다.
										</textarea>
								</div>
							</div>
							<div class="agree_con agree_con2">
								<h5 class="tit_h5">
									<!-- 1702 라벨 클릭 시 클래스 on 추가 -->
									<label for="danawa-member-joinStep-checkBox-agree-privacy"
										class="lb_chk_box" title="개인정보 수집 및 이용 안내 필수 입력 항목"> <strong>개인정보
											수집 및 이용 안내</strong> <span> (필수)</span>
									</label>
									<!--1702 약관보기 클릭 시 클래스 on 과 내용닫기 텍스트 변경 -->
									<span class="btn_view ico">
										<button type="button"
											id="danawa-member-joinStep-guide-button-privacy"
											title="약관보기 버튼 누르면 상세 내용이 열립니다">약관보기 ▼</button>
									</span>
									<!--1702 웹접근성 포커스 (Tab키) 이동 시 클래스 focus 추가 탭키 이동 관련 개발 필요 -->
									<input class="input_check" type="checkbox"
										id="danawa-member-joinStep-checkBox-agree-privacy"
										title="[체크박스]" />
								</h5>
								<div class="agree_textarea_wrap">
									<textarea readonly="readonly" class="textarea_member"
										id="danawa-member-joinStep-guide-textDesc-privacy" cols=""
										rows="" style="display: none;" title="개인정보 수집 및 이용 안내 내용">
											
1. 수집하는 개인정보의 항목 및 수집방법

저희가 알아서 관리하겠습니다.
										</textarea>
								</div>
							</div>
							<div class="agree_con agree_con3">
								<h5 class="tit_h5">
									<!-- 1702 라벨 클릭 시 클래스 on 추가 -->
									<label for="danawa-member-joinStep-checkBox-agree-age"
										class="lb_chk_box" title="만 14세 이상 확인 필수 입력 항목"> <strong>만
											14세 이상 확인</strong> <span> (필수)</span> <span class="txt_grey">
											FoodToLuck은 만 14세 이상부터 회원가입이 가능합니다.</span>
									</label>
									<!--1702 웹접근성 포커스 (Tab키) 이동 시 클래스 focus 추가 탭키 이동 관련 개발 필요 -->
									<input class="input_check" type="checkbox"
										id="danawa-member-joinStep-checkBox-agree-age" title="[체크박스]" />
								</h5>
								<!-- 웹접근성을 위해 textarea의 id값과 label의 for값을 동일하게 해주세요.-->
							</div>
							<div class="agree_con agree_con4">
								<h5 class="tit_h5">
									<!-- 1702 라벨 클릭 시 클래스 on 추가 -->
									<label for="danawa-member-joinStep-checkBox-agree-mailing"
										class="lb_chk_box" title="메일 수신 여부 항목"> <strong>메일
											수신 여부</strong> <span class="txt_blue"> (선택)</span>
									</label>
									<!--1702 약관보기 클릭 시 클래스 on 과 내용닫기 텍스트 변경 -->
									<span class="btn_view ico">
										<button type="button"
											id="danawa-member-joinStep-guide-button-mailing"
											title="약관보기 버튼 누르면 상세 내용이 열립니다">약관보기 ▼</button>
									</span>
									<!--1702 웹접근성 포커스 (Tab키) 이동 시 클래스 focus 추가 탭키 이동 관련 개발 필요 -->
									<input class="input_check" type="checkbox"
										id="danawa-member-joinStep-checkBox-agree-mailing"
										name="useMailing" value="Y" title="[체크박스]" />
								</h5>
								<!-- 웹접근성을 위해 textarea의 id값과 label의 for값을 동일하게 해주세요.-->

								<div class="agree_textarea_wrap">
									<div class="mail_r_tbl"
										id="danawa-member-joinStep-guide-textDesc-mailing"
										style="display: none;">
										<p class="tit_p">고객님께서는 동의를 거부할 수 있으며, 동의하지 않아도 가입이 가능합니다.</p>
										<table summary="메일수신여부 수집방침 테이블로 이용목적, 수집항목, 보유기간 정보 안내">
											<caption class="blind">메일수신여부 수집방침</caption>
											<colgroup>
												<col style="width: 132px" />
												<col style="width: 131px" />
												<col />
											</colgroup>
											<thead>
												<tr>
													<th scope="col">이용목적</th>
													<th scope="col">수집항목</th>
													<th scope="col">보유기간</th>
												</tr>
											</thead>
											<tbody>
												<tr>
													<td>할인혜택, 소식 및 이벤트 당첨 알림 서비스제공</td>
													<td style="text-align: center;">이메일 주소</td>
													<td>회원탈퇴 또는 개인정보 유효기간 도래시까지 보관<br />(단, 관계 법령에 따라
														고객님의 개인정보를 보존해야 하는 경우, 회사는 해당 법령에서 정한 기간동안 보관합니다.)
													</td>
												</tr>
											</tbody>
										</table>
									</div>
								</div>
							</div>
						</div>
						<!--// join_box -->
						<div class="join_title_area">
							<h4 class="tit_con">정보 입력</h4>
							
						</div>
						<!-- join_box -->
						<div class="join_box join_input_box">
							<!-- 20160128 btn_inpt_error -->
							<!-- <a href="/pwdRule" target="_blank" class="btn_inpt_error"
								title="입력한 내용이 자꾸 초기화 되시나요? 내용 새 창이 열립니다.">입력한 내용이 자꾸 초기화
								되시나요?</a> -->
							<div class="join_input_area">
								<dl class="contents_row">
									<dt>
										<label for="danawa-member-joinStep-member-email-emailFirst"
											class="input_title" title="이메일 필수 입력 항목">이메일</label>
									</dt>
									<dd class="email_certi_row">
										<div class="email_certi_noti">
											<p>- 가입 완료를 위한 이메일 인증이 진행되니 정확한 이메일 주소를 입력해주시기 바랍니다.</p>
										</div>
										<span class="input_wrap email_certi1">
										<input
											type="text"
											id="danawa-member-joinStep-member-email-emailFirst"
											name = "member_emailFirst"
											title="이메일 앞자리 입력창" class="" /></span> <span class="email_at">@</span>
										<span class="input_wrap email_certi2">
										<input
											type="text"
											id="danawa-member-joinStep-member-email-emailSecond"
											name = "member_emailSecond"
											title="이메일 뒷자리 입력창" class="" /></span> <select
											id="danawa-member-joinStep-selectBox-email"
											title="이메일 뒷자리 선택" class="slct_email_tail">
											<option value="">직접입력</option>
											<option value="naver.com">naver.com</option>
											<option value="hanmail.net">hanmail.net</option>
											<option value="nate.com">nate.com</option>
											<option value="gmail.com">gmail.com</option>
											<option value="hotmail.com">hotmail.com</option>
											<option value="lycos.co.kr">lycos.co.kr</option>
											<option value="empal.com">empal.com</option>
											<option value="dreamwiz.com">dreamwiz.com</option>
											<option value="korea.com">korea.com</option>
										</select> 
										<a href="#layer_pop_byemail" class="modalLink">인증 </a>
										<span class="input_alert_txt"
											id="danawa-member-joinStep-message-email"></span>
									</dd>
								</dl>
			
			
			<div class="layer_identify open" id="layer_pop_byemail">
			<h4>이메일 인증</h4>
			<button type="button" class="btn_layer_close">
				<span>닫기</span>
			</button>
			<p class="txt" id="email_layer_sub_title"
				>잠시만 기다려주세요.
			</p>
			<input type="hidden" name="mail_confirm_complete" value="n"
				id="mail_confirm_complete">
			<table class="tbl_fieldset">
				<caption></caption>
				<colgroup>
					<col style="width: 130px;">
					<col>
				</colgroup>
				<tbody>
					<tr>
						<th>인증번호</th>
						<td><input type="text" id="email_code" name="email_code"
							value="" class="sri_input" style="width: 96px;" />
							<button id="btn_basic_type04" type="button" class="btn_basic_type04">확인</button>
							<span class="expiredin" id="confirm_remain_mail_time_area"
							name="confirm_remain_mail_time_area">남은시간 (<span
								id="confirm_mail_remain_time">2:36</span>)
						</span></td>
					</tr>
				</tbody>
			</table>
			<div class="txt alert_txt">
				<p class="alert_column warning_txt" id="email_confirm_msg"
					style="display: none;">인증번호를 입력해주세요.</p>
			</div>
			<div class="bottom_btn_wrap">
				<button type="button" class="btn_basic_type01"
					onclick="sendCodeAction();">인증번호 재발송</button>
				<button type="button" class="btn_basic_type05"
					onclick="changeConfirmCell('mail')">인증완료</button>
			</div>
		</div> 
								<dl class="contents_row">
									<!-- 웹접근성을 위해 input의 id값과 label의 for값을 동일하게 해주세요.-->
									<dt>
										<label for="danawa-member-joinStep-member-id"
											class="input_title" title="아이디 필수 입력 항목">아이디</label>
									</dt>
									<dd>
										<span class="input_wrap"><input type="text"
											id="danawa-member-joinStep-member-id" name="memberId"
											title="아이디 입력창" /></span> <span class="input_alert_txt"
											id="danawa-member-joinStep-message-id"></span>
									</dd>
								</dl>
								<dl class="contents_row">
									<dt>
										<label for="danawa-member-joinStep-member-password"
											class="input_title" title="비밀번호 필수 입력 항목">비밀번호</label>
									</dt>
									<dd>
										<span class="input_wrap"><input type="password"
											id="danawa-member-joinStep-member-password" name="memberPwd"
											title="비밀번호 입력창" /></span> <span class="input_alert_txt"
											id="danawa-member-joinStep-message-password"></span>
									</dd>
								</dl>
								<dl class="contents_row">
									<dt>
										<label for="danawa-member-joinStep-member-passwordConfim"
											class="input_title" title="비밀번호 확인 필수 입력 항목">비밀번호확인</label>
									</dt>
									<dd>
										<span class="input_wrap"><input type="password"
											id="danawa-member-joinStep-member-passwordConfim"
											name="memberPwdConfirm" title="비밀번호 확인 입력창" /></span> <span
											class="input_alert_txt"
											id="danawa-member-joinStep-message-passwordConfirm"></span>
									</dd>
								</dl>	
								<dl class="contents_row">
									<dt>
										<label for="danawa-member-joinStep-member-nickname"
											class="input_title" title="닉네임 필수 입력 항목">닉네임</label>
									</dt>
									<dd>
										<span class="input_wrap"><input type="text"
											id="danawa-member-joinStep-member-nickname"
											name="memberNickname" title="닉네임 입력창" /></span> 
											<span class="input_alert_txt"
											id="danawa-member-joinStep-message-nickname"></span>
									</dd>
								</dl>															
								<dl class="contents_row">
									<dt>
										<label for="danawa-member-joinStep-member-name"
											class="input_title" title="이름 필수 입력 항목">핸드폰</label>
									</dt>
									<dd>
									
									<span class="input_wrap">
											<input type="tel" id="danawa-member-joinStep-member-name" name="memberName"></input></span>
											<span class="input_alert_txt"
											id="danawa-member-joinStep-message-name"></span>
									</dd>
								</dl>
								<dl class="contents_row">
									<dt>
										<label for=""
											class="input_title" title="이름 필수 입력 항목">성별</label>
									</dt>
									<dd>
										
											<input type="radio" name="member_gender" value="M" title="성별 입력창" checked/>남자  
											<input type="radio" name="member_gender" value="F" title="성별 입력창" />여자 
											
									</dd>
								</dl>

								<!-- 사업자 정보 입력 -->
								<div id="danawa-member-joinStep-company-self" style="display: none;">
									<dl class="contents_row">
										<dt>
											<label for="joinLicense1" class="input_title"
												title="사업자 등록 번호 필수 입력 항목">사업자등록번호</label>
										</dt>
										<dd>
											<span class="input_wrap input_num_wrap"><input
												type="text" id="danawa-member-joinStep-company-license-1"
												name="joinLicense1" title="사업자등록번호 앞자리 입력창" /></span> - <span
												class="input_wrap input_num_wrap"><input type="text"
												id="danawa-member-joinStep-company-license-2"
												name="joinLicense2" title="사업자등록번호 중간자리 입력창" /></span> - <span
												class="input_wrap input_num_wrap"><input type="text"
												id="danawa-member-joinStep-company-license-3"
												name="joinLicense3" title="사업자등록번호 끝자리 입력창" /></span>
										</dd>
									</dl>
								</div>
								<!-- //사업자 정보 입력 -->													
						        <div class="g-recaptcha" data-sitekey="6LdIaDYUAAAAAPgqG22XOSRUr7nfce_kfNmOrv7v"></div>
								<div class="bottom_btn_area">
									<a href="javascript:;" id="danawa-member-joinStep-memberJoin"
										onclick="return false;" class="btn_join_sty1"
										title="확인 버튼 누르면 회원가입이 완료됩니다.">확인</a>
								</div>
								
							</div>
						</div>
						<!--// join_box -->
					</div>
					<!--// join_contents -->
				</div>
				<!--// join_container -->

				<!-- footer_type1 -->
				<div class="footer_type1">
					<div class="dnw_service_wrap">
						<p class="tit">
							<span class="blue_txt">FoodToLuck 서비스 이용</span>을 환영합니다.
						</p>
					</div>
					<address>
						Copyright&copy; <strong>FoodToLuck</strong> Co., Ltd. All Rights
						Reserved.
					</address>
				</div>
				<!--// footer_type1 -->
			</div>
			<!--// join_member -->
		</div>
	</form>

	<script src="resources/js/logger_Insight_WebAnalytics.js"></script>

</body>
</html>