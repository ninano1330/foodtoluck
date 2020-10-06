package kitri.project.vo;

public class ReplyVO {
	
	private int bcomment_no;
	private String bcomment_content;
	private String bcomment_date;
	private int board_no;
	private String member_id;
	
	public int getBcomment_no() {
		return bcomment_no;
	}
	public void setBcomment_no(int bcomment_no) {
		this.bcomment_no = bcomment_no;
	}
	public String getBcomment_content() {
		return bcomment_content;
	}
	public void setBcomment_content(String bcomment_content) {
		this.bcomment_content = bcomment_content;
	}
	public String getBcomment_date() {
		return bcomment_date;
	}
	public void setBcomment_date(String bcomment_date) {
		this.bcomment_date = bcomment_date;
	}
	public int getBoard_no() {
		return board_no;
	}
	public void setBoard_no(int board_no) {
		this.board_no = board_no;
	}
	public String getMember_id() {
		return member_id;
	}
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
	
	@Override
	public String toString() {
		return "ReplyVO [bcomment_no=" + bcomment_no + ", bcomment_content=" + bcomment_content + ", bcomment_date="
				+ bcomment_date + ", board_no=" + board_no + ", member_id=" + member_id + "]";
	}
	
	
	
	
}
