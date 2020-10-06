package kitri.project.vo;

public class ReviewFeedbackVO {
	private int menu_no = 0;
	private String member_id = "";
	private int menu_star = 0;
	private String review_content = "";
	private String review_date = "";
	private String feedback_date = "";
	private String feedback_content = "";
	private String owner_id = "";
	private String member_image = "resources/img/userImage/default.png";
	
	public int getMenu_no() {
		return menu_no;
	}
	public void setMenu_no(int menu_no) {
		this.menu_no = menu_no;
	}
	public String getMember_id() {
		return member_id;
	}
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
	public int getMenu_star() {
		return menu_star;
	}
	public void setMenu_star(int menu_star) {
		this.menu_star = menu_star;
	}
	public String getReview_content() {
		return review_content;
	}
	public void setReview_content(String review_content) {
		this.review_content = review_content;
	}
	public String getReview_date() {
		return review_date;
	}
	public void setReview_date(String review_date) {
		this.review_date = review_date;
	}
	public String getFeedback_date() {
		return feedback_date;
	}
	public void setFeedback_date(String feedback_date) {
		this.feedback_date = feedback_date;
	}
	public String getFeedback_content() {
		return feedback_content;
	}
	public void setFeedback_content(String feedback_content) {
		this.feedback_content = feedback_content;
	}
	public String getOwner_id() {
		return owner_id;
	}
	public void setOwner_id(String owner_id) {
		this.owner_id = owner_id;
	}
	
	public String getMember_image() {
		return member_image;
	}
	public void setMember_image(String member_image) {
		this.member_image = member_image;
	}
	
	@Override
	public String toString() {
		return "ReviewFeedbackVO \n[menu_no=" + menu_no + ", member_id=" + member_id + ", member_image = " + member_image + ", menu_star=" + menu_star
				+ ", review_content=" + review_content + ", review_date=" + review_date + ", feedback_date="
				+ feedback_date + ", feedback_content=" + feedback_content + ", owner_id=" + owner_id + "]";
	}
	
	
	
}
