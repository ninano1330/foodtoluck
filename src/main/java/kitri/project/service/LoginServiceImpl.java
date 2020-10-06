package kitri.project.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kitri.project.dao.MemberDAO;
import kitri.project.vo.MemberVO;

@Service
public class LoginServiceImpl implements LoginService {

	@Autowired
	MemberDAO memberDAO;
	
	//로그인
	@Override
	public MemberVO login(MemberVO memberVO) {

		return memberDAO.login(memberVO);
	}

}
