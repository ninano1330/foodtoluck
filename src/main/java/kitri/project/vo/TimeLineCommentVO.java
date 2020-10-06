package kitri.project.vo;

//타임라인 댓글
public class TimeLineCommentVO {
	
	int truck_code;
	int timeline_no;
	int tcomment_no;
	int trecomment_no;
	int depth;
	String tcomment_content;
	String tcomment_date;
	String member_id;
	String member_nickname;
	String member_image = "resources/img/userImage/default.png";
	String del;
	
	
	public TimeLineCommentVO() {
		super();
	}
	public TimeLineCommentVO(int truck_code, int timeline_no, int tcomment_no, int trecomment_no, int depth,
			String tcomment_content, String tcomment_date, String member_id, String member_nickname,
			String member_image, String del) {
		super();
		this.truck_code = truck_code;
		this.timeline_no = timeline_no;
		this.tcomment_no = tcomment_no;
		this.trecomment_no = trecomment_no;
		this.depth = depth;
		this.tcomment_content = tcomment_content;
		this.tcomment_date = tcomment_date;
		this.member_id = member_id;
		this.member_nickname = member_nickname;
		this.member_image = member_image;
		this.del = del;
	}
	
	
	public int getTruck_code() {
		return truck_code;
	}
	public void setTruck_code(int truck_code) {
		this.truck_code = truck_code;
	}
	public int getTimeline_no() {
		return timeline_no;
	}
	public void setTimeline_no(int timeline_no) {
		this.timeline_no = timeline_no;
	}
	public int getTcomment_no() {
		return tcomment_no;
	}
	public void setTcomment_no(int tcomment_no) {
		this.tcomment_no = tcomment_no;
	}
	public int getTrecomment_no() {
		return trecomment_no;
	}
	public void setTrecomment_no(int trecomment_no) {
		this.trecomment_no = trecomment_no;
	}
	public int getDepth() {
		return depth;
	}
	public void setDepth(int depth) {
		this.depth = depth;
	}
	public String getTcomment_content() {
		return tcomment_content;
	}
	public void setTcomment_content(String tcomment_content) {
		this.tcomment_content = tcomment_content;
	}
	public String getTcomment_date() {
		return tcomment_date;
	}
	public void setTcomment_date(String tcomment_date) {
		this.tcomment_date = tcomment_date;
	}
	public String getMember_id() {
		return member_id;
	}
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
	public String getMember_nickname() {
		return member_nickname;
	}
	public void setMember_nickname(String member_nickname) {
		this.member_nickname = member_nickname;
	}
	public String getMember_image() {
		return member_image;
	}
	public void setMember_image(String member_image) {
		this.member_image = member_image;
	}
	public String getDel() {
		return del;
	}
	public void setDel(String del) {
		this.del = del;
	}
	
	
	@Override
	public String toString() {
		return "TimeLineCommentVO [truck_code=" + truck_code + ", timeline_no=" + timeline_no + ", tcomment_no="
				+ tcomment_no + ", trecomment_no=" + trecomment_no + ", depth=" + depth + ", tcomment_content="
				+ tcomment_content + ", tcomment_date=" + tcomment_date + ", member_id=" + member_id
				+ ", member_nickname=" + member_nickname + ", member_image=" + member_image + ", del=" + del + "]";
	}
}