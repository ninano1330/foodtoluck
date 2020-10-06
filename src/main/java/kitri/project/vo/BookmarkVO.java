package kitri.project.vo;

public class BookmarkVO {
	String member_id;
	int truck_code;
	String bookmark_date;
	
	public BookmarkVO(){}
	public BookmarkVO(String member_id, int truck_code) {
		super();
		this.member_id = member_id;
		this.truck_code = truck_code;
	}
	public String getMember_id() {
		return member_id;
	}
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
	public int getTruck_code() {
		return truck_code;
	}
	public void setTruck_code(int truck_code) {
		this.truck_code = truck_code;
	}
	public String getBookmark_date() {
		return bookmark_date;
	}
	public void setBookmark_date(String bookmark_date) {
		this.bookmark_date = bookmark_date;
	}
	
	
}
