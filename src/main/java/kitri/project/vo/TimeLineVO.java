package kitri.project.vo;

import org.springframework.web.multipart.MultipartFile;

//타임라인글
public class TimeLineVO {
	
	int truck_code;
	int timeline_no;
	String member_id;
	String member_nickname;
	String member_image = "resources/img/userImage/default.png";
	String timeline_image;
	String timeline_content;
	String timeline_date;
	String del;
	MultipartFile timeline_image_file;
	
	
	public TimeLineVO() {
		super();
	}


	public TimeLineVO(int truck_code, int timeline_no, String member_id, String member_nickname, String member_image,
			String timeline_image, String timeline_content, String timeline_date, String del,
			MultipartFile timeline_image_file) {
		super();
		this.truck_code = truck_code;
		this.timeline_no = timeline_no;
		this.member_id = member_id;
		this.member_nickname = member_nickname;
		this.member_image = member_image;
		this.timeline_image = timeline_image;
		this.timeline_content = timeline_content;
		this.timeline_date = timeline_date;
		this.del = del;
		this.timeline_image_file = timeline_image_file;
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
	public String getTimeline_image() {
		return timeline_image;
	}
	public void setTimeline_image(String timeline_image) {
		this.timeline_image = timeline_image;
	}
	public String getTimeline_content() {
		return timeline_content;
	}
	public void setTimeline_content(String timeline_content) {
		this.timeline_content = timeline_content;
	}
	public String getTimeline_date() {
		return timeline_date;
	}
	public void setTimeline_date(String timeline_date) {
		this.timeline_date = timeline_date;
	}
	public String getDel() {
		return del;
	}
	public void setDel(String del) {
		this.del = del;
	}
	public MultipartFile getTimeline_image_file() {
		return timeline_image_file;
	}
	public void setTimeline_image_file(MultipartFile timeline_image_file) {
		this.timeline_image_file = timeline_image_file;
	}

	
	@Override
	public String toString() {
		return "TimeLineVO [truck_code=" + truck_code + ", timeline_no=" + timeline_no + ", member_id=" + member_id
				+ ", member_nickname=" + member_nickname + ", member_image=" + member_image + ", timeline_image="
				+ timeline_image + ", timeline_content=" + timeline_content + ", timeline_date=" + timeline_date
				+ ", del=" + del + ", timeline_image_file=" + timeline_image_file + "]";
	}
}	