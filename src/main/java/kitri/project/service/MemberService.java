package kitri.project.service;

import java.util.List;

import kitri.project.vo.BookmarkVO;
import kitri.project.vo.MemberMenuVO;
import kitri.project.vo.MemberVO;
import kitri.project.vo.OwnerVO;

public interface MemberService {
	public MemberVO selectMember(String member_id);
	
	public int insertMember(MemberVO vo);
	
	public int insertOwner(OwnerVO vo);
	
	public int updateMember(MemberVO vo);
	
	public MemberVO pwCheck(String member_id);
	
	public int pwChange(MemberVO vo);
	
	public String imageUpload(MemberVO vo) throws Exception;
	//public MemberVO findAccount(String email);
	//public void updateInfo(String member_pw, String string, String password);
	public int addMemberMenu(MemberMenuVO vo);
	public int insertBookmark(BookmarkVO vo);
	public int deleteBookmark(BookmarkVO vo);
	public int deleteMemberMenu(MemberMenuVO vo);

	public List<MemberMenuVO> selectMemberMenu(String userId);
}
