package kitri.project.service;

import java.awt.image.BufferedImage;
import java.io.File;
import java.util.List;
import java.util.UUID;

import javax.imageio.ImageIO;

import org.imgscalr.Scalr;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import kitri.project.dao.MenuDAO;
import kitri.project.util.MediaUtils;
import kitri.project.vo.FoodtruckVO;
import kitri.project.vo.MenuVO;

@Service("menuService")
public class MenuServiceImpl implements MenuService {

	@Autowired
	MenuDAO dao;

	public List<MenuVO> selectAllMenu(int truck_code) {
		return dao.selectAllMenu(truck_code);
	}

	@Override
	public String imageUpload(MenuVO vo) throws Exception {
		MultipartFile multipartfile = vo.getImage_file();
		UUID uuid = UUID.randomUUID();
		String filename = multipartfile.getOriginalFilename();
		String savedName = uuid.toString() + "_menuPhoto" + filename;
		if (filename == null || filename.equals("")) {
			return "resources/img/menuImage/menu_default.png";
		} else {
			// 업로드할 디렉토리(날짜별 폴더) 생성
			String uploadPath = "D:\\javaIDE\\spring\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp1\\wtpwebapps\\FoodToLuck3\\resources\\img\\menuImage";

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
			return "resources/img/menuImage/" + savedName;
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
	public int insertMenu(MenuVO vo) {
		return dao.insertMenu(vo);
	}

	@Override
	public int updateMenu(MenuVO vo) {
		return dao.updateMenu(vo);
	}

	@Override
	public int deleteMenu(int menu_no) {
		return dao.deleteMenu(menu_no);
	}

	@Override
	public int updateMenulike(int menu_no) {
		return dao.updateMenulike(menu_no);
	}

	@Override
	public int seleteMenulikeNumber(int menu_no) {
		return dao.seleteMenulikeNumber(menu_no);
	}

}
