package kitri.project.vo;

public class MemberMenuVO {

	int menu_no;
	String member_id;
	
	
	public MemberMenuVO() {
	}
	public MemberMenuVO(int menu_no, String member_id) {
		this.menu_no = menu_no;
		this.member_id = member_id;
	}
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
	@Override
	public String toString() {
		return "MemberMenuVO [menu_no=" + menu_no + ", member_id=" + member_id + "]\n";
	}
	
	
}
