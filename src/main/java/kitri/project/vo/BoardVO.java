package kitri.project.vo;

import org.springframework.stereotype.Component;

@Component
public class BoardVO {
	public int board_no;
	public String member_id;
	public String board_title;
	public String board_content;
	public String board_date;
	public String board_image;
	
	public BoardVO(){}

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

	public String getBoard_title() {
		return board_title;
	}

	public void setBoard_title(String board_title) {
		this.board_title = board_title;
	}

	public String getBoard_content() {
		return board_content;
	}

	public void setBoard_content(String board_content) {
		this.board_content = board_content;
	}

	public String getBoard_date() {
		return board_date;
	}

	public void setBoard_date(String board_date) {
		this.board_date = board_date;
	}

	public String getBoard_image() {
		return board_image;
	}

	public void setBoard_image(String board_image) {
		this.board_image = board_image;
	}

	@Override
	public String toString() {
		return "BoardVO [board_no=" + board_no + ", member_id=" + member_id + ", board_title=" + board_title
				+ ", board_content=" + board_content + ", board_date=" + board_date + ", board_image=" + board_image
				+ "]";
	};
	
	
	

}
