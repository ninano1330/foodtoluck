package kitri.project.vo;

import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

@Component
public class MemberVO {
	String member_id;
	String member_pw;
	String member_phone;
	String member_email;
	String member_gender;
	String member_nickname;
	String member_joindate;
	String member_code;
	
	String member_image = "resources/img/userImage/default.png";
	String member_thumbnail;
	
	MultipartFile image_file;
	
	public MemberVO(){}	
	public MemberVO(String member_id, String member_pw, String member_phone, String member_email, String member_gender,
			String membernick_name, String member_code, String member_image) {
		super();
		this.member_id = member_id;
		this.member_pw = member_pw;
		this.member_phone = member_phone;
		this.member_email = member_email;
		this.member_gender = member_gender;
		this.member_nickname = membernick_name;
		this.member_code = member_code;
		this.member_image = member_image;
	}

	
	public MemberVO(String member_id, String member_phone, String member_email, String member_gender,
			String member_nickname, String member_code, String member_image) {
		super();
		this.member_id = member_id;
		this.member_phone = member_phone;
		this.member_email = member_email;
		this.member_gender = member_gender;
		this.member_nickname = member_nickname;
		this.member_code = member_code;
		this.member_image = member_image;
	}
	public String getMember_image() {
		return member_image;
	}
	public void setMember_image(String member_image) {
		this.member_image = member_image;
	}
	
	public String getMember_id() {
		return member_id;
	}
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
	public String getMember_pw() {
		return member_pw;
	}
	public void setMember_pw(String member_pw) {
		this.member_pw = member_pw;
	}
	public String getMember_phone() {
		return member_phone;
	}
	public void setMember_phone(String member_phone) {
		this.member_phone = member_phone;
	}
	public String getMember_email() {
		return member_email;
	}
	public void setMember_email(String member_email) {
		this.member_email = member_email;
	}
	public String getMember_gender() {
		return member_gender;
	}
	public void setMember_gender(String member_gender) {
		this.member_gender = member_gender;
	}
	public String getMembernick_name() {
		return member_nickname;
	}
	public void setMembernick_name(String membernick_name) {
		this.member_nickname = membernick_name;
	}
	public String getMember_joindate() {
		return member_joindate;
	}
	public void setMember_joindate(String member_joindate) {
		this.member_joindate = member_joindate;
	}
	public String getMember_code() {
		return member_code;
	}
	public void setMember_code(String member_code) {
		this.member_code = member_code;
	}	
	public MultipartFile getImage_file() {
		return image_file;
	}
	public void setImage_file(MultipartFile image_file) {
		this.image_file = image_file;
	}
	
	public String getMember_thumbnail() {
		return member_thumbnail;
	}
	public void setMember_thumbnail(String member_thumbnail) {
		this.member_thumbnail = member_thumbnail;
	}
	@Override
	public String toString() {
		return "MemberVO [member_id=" + member_id + ", member_pw=" + member_pw + ", member_phone=" + member_phone
				+ ", member_email=" + member_email + ", member_gender=" + member_gender + ", membernick_name="
				+ member_nickname + ", member_joindate=" + member_joindate + ", member_code=" + member_code
				+ ", member_image=" + member_image + ", member_thumbnail=" + member_thumbnail + ", image_file="
				+ image_file + "]";
	}
	
	
}
