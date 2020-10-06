package kitri.project.service;

import java.awt.image.BufferedImage;
import java.io.File;
import java.util.List;

import javax.imageio.ImageIO;

import org.imgscalr.Scalr;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import kitri.project.dao.MemberDAO;
import kitri.project.util.MediaUtils;
import kitri.project.vo.BookmarkVO;
import kitri.project.vo.MemberMenuVO;
import kitri.project.vo.MemberVO;
import kitri.project.vo.OwnerVO;

@Service("memberService")
public class MemberServiceImpl implements MemberService {

	@Autowired
	MemberDAO dao;

	@Override
	public int insertMember(MemberVO vo) {
		return dao.insertMember(vo);
	}

	@Override
	public int insertOwner(OwnerVO vo) {
		return dao.insertOwner(vo);
	}

	@Override
	public String imageUpload(MemberVO vo) throws Exception {
		MultipartFile multipartfile = vo.getImage_file();

		String filename = multipartfile.getOriginalFilename();
		// if(filename==null)
		String savedName = vo.getMember_id() + "_profilePhoto" + filename;
		if (filename == null || filename.equals("")) {
			return "resources/img/userImage/default.png";
		} else {
			// 업로드할 디렉토리(날짜별 폴더) 생성
			String uploadPath = "D:\\javaIDE\\spring\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp1\\wtpwebapps\\FoodToLuck3\\resources\\img\\userImage";

			// 파일 경로(기존의 업로드경로+날짜별경로), 파일명을 받아 파일 객체 생성

			File file = new File(uploadPath, savedName);

			if (file.exists() == true) { // 같은이름 파일 존재하면 삭제
				file.delete();
			}

			multipartfile.transferTo(file);

			// 썸네일을 생성하기 위한 파일의 확장자 검사
			// 파일명이 aaa.bbb.ccc.jpg일 경우 마지막 마침표를 찾기 위해
			String formatName = filename.substring(filename.lastIndexOf(".") + 1);
			String uploadedFileName = null;
			// 이미지 파일은 썸네일 사용
			if (MediaUtils.getMediaType(formatName) != null) {
				// 썸네일 생성
				uploadedFileName = makeThumbnail(uploadPath, savedName);
				// 나머지는 아이콘
			} else {
				// 아이콘 생성
				uploadedFileName = makeIcon(uploadPath, savedName);
			}
			return "resources/img/userImage/" + savedName;
		}
	}

	// 썸네일 생성
	private static String makeThumbnail(String uploadPath, String fileName) throws Exception {
		// 이미지를 읽기 위한 버퍼
		BufferedImage sourceImg = ImageIO.read(new File(uploadPath, fileName));
		// 100픽셀 단위의 썸네일 생성
		BufferedImage destImg = Scalr.resize(sourceImg, Scalr.Method.AUTOMATIC, Scalr.Mode.FIT_TO_HEIGHT, 100);
		// 썸네일의 이름을 생성(원본파일명에 's_'를 붙임)
		String thumbnailName = uploadPath + File.separator + "s_" + fileName;
		File newFile = new File(thumbnailName);
		String formatName = fileName.substring(fileName.lastIndexOf(".") + 1);
		// 썸네일 생성
		ImageIO.write(destImg, formatName.toUpperCase(), newFile);
		// 썸네일의 이름을 리턴함
		return thumbnailName.substring(uploadPath.length()).replace(File.separatorChar, '/');
	}

	// 아이콘 생성
	private static String makeIcon(String uploadPath, String fileName) throws Exception {
		// 아이콘의 이름
		String iconName = uploadPath + File.separator + fileName;
		// 아이콘 이름을 리턴
		// File.separatorChar : 디렉토리 구분자
		// 윈도우 \ , 유닉스(리눅스) /
		return iconName.substring(uploadPath.length()).replace(File.separatorChar, '/');
	}

	@Override
	public int updateMember(MemberVO vo) {
		return dao.updateMember(vo);
	}

	@Override
	public MemberVO pwCheck(String member_id) {
		return dao.pwCheck(member_id);
	}

	@Override
	public int pwChange(MemberVO vo) {
		return dao.pwChange(vo);
	}

	@Override
	public int insertBookmark(BookmarkVO vo) {
		return dao.insertBookmark(vo);
	}

	@Override
	public int deleteBookmark(BookmarkVO vo) {
		return dao.deleteBookmark(vo);
	}

	@Override
	public int addMemberMenu(MemberMenuVO vo) {
		return dao.addMemberMenu(vo);
	}

	@Override
	public int deleteMemberMenu(MemberMenuVO vo) {
		return dao.deleteMemberMenu(vo);
	}

	@Override
	public List<MemberMenuVO> selectMemberMenu(String userId) {
		return dao.selectMemberMenu(userId);
	}

	@Override
	public MemberVO selectMember(String member_id) {
		return dao.selectMember(member_id);
	}

}
