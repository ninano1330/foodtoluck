package kitri.project.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import kitri.project.vo.BookmarkVO;
import kitri.project.vo.MemberMenuVO;
import kitri.project.vo.MemberVO;
import kitri.project.vo.OwnerVO;

@Component
public class MemberDAO {

	@Autowired
	SqlSession session;

	public MemberVO login(MemberVO memberVO) {
		// sqlmapper namespase.id
		return session.selectOne("login.select_login", memberVO);
	}

	// test4 : insert : resultType 필요 없는 sql
	public int insertMember(MemberVO vo) {
		return session.insert("Member.insertMember", vo);
	}

	public int insertOwner(OwnerVO vo) {
		return session.insert("Member.insertOwner", vo);
	}

	public int updateMember(MemberVO vo) {
		return session.update("Member.updateMember", vo);
	}

	public MemberVO pwCheck(String member_id) {
		return session.selectOne("Member.pwCheck", member_id);
	}

	public int pwChange(MemberVO vo) {
		return session.update("Member.pwChange", vo);
	}

	public int insertBookmark(BookmarkVO vo) {
		return session.insert("Member.insertBookmark", vo);
	}

	public int deleteBookmark(BookmarkVO vo) {
		return session.delete("Member.deleteBookmark", vo);
	}

	public int addMemberMenu(MemberMenuVO vo) {
		return session.insert("Member.insertMemberMenu", vo);
	}

	public int deleteMemberMenu(MemberMenuVO vo) {
		return session.delete("Member.deleteMemberMenu", vo);
	}

	public List<MemberMenuVO> selectMemberMenu(String userId) {
		return session.selectList("Member.selectMemberMenu", userId);
	}

	public MemberVO selectMember(String member_id) {
		return session.selectOne("Member.selectMember",member_id);
	}
}
