package kitri.project.service;

import java.awt.image.BufferedImage;
import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.UUID;

import javax.imageio.ImageIO;

import org.imgscalr.Scalr;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import kitri.project.dao.FoodtruckDAO;
import kitri.project.util.MediaUtils;
import kitri.project.vo.FoodtruckVO;
import kitri.project.vo.Foodtruck_FoodTypeVO;

@Service("foodtruckService")
public class FoodtruckServiceImpl implements FoodtruckService {

	@Autowired
	FoodtruckDAO dao;
	
	@Override
	public List<FoodtruckVO> selectAllTruck(String ownerId) {
		// TODO Auto-generated method stub
		return dao.selectAllFoodtruck(ownerId);
	}

	@Override
	public int insertTruck(FoodtruckVO vo) {
		return dao.insertTruck(vo);
	}

	@Override
	public String imageUpload(FoodtruckVO vo) throws Exception {
		MultipartFile multipartfile = vo.getImage_file();
		
		// UUID 발급
		UUID uuid = UUID.randomUUID();
		// 저장할 파일명 = UUID + 원본이름
		String filename = multipartfile.getOriginalFilename();
		
		if(filename.equals("")|| filename ==null) {
			return "";
			
		}else {
			String savedName = uuid.toString() + "_truckPhoto"+filename;
			String uploadPath = "D:\\javaIDE\\spring\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp1\\wtpwebapps\\FoodToLuck3\\resources\\img\\truckImage";
			
			File file = new File(uploadPath,savedName); 
			
			if(file.exists() == true){	//같은이름 파일 존재하면 삭제
				file.delete();		
			}
	        
			multipartfile.transferTo(file);
			
			// 썸네일을 생성하기 위한 파일의 확장자 검사
	        // 파일명이 aaa.bbb.ccc.jpg일 경우 마지막 마침표를 찾기 위해
	        String formatName = filename.substring(filename.lastIndexOf(".")+1);
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
	        
	        return "resources/img/truckImage/"+savedName;
		}
		//int truck_code = dao.
		
		
        // 업로드할 디렉토리(날짜별 폴더) 생성 
		
//		String uploadPath = "G:\\workspace_spring\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\FoodToLuck\\resources\\img\\truckImage\\";
		
//		String uploadPath = "D:\\javaIDE\\spring\\FoodToLuck\\src\\main\\webapp\\resources\\img\\truckImage";

		// 파일 경로(기존의 업로드경로+날짜별경로), 파일명을 받아 파일 객체 생성
		
		 	  
        
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
	public int updateTruck(FoodtruckVO vo) {
		return dao.updateTruck(vo);		
	}

    @Override
	public int deleteTruck(int truck_code) {
		return dao.deleteTruck(truck_code);
	}

	@Override
	public int isFavorite(HashMap<String, Object> map) {
		return dao.isFavorite(map);
	}

	@Override
	public FoodtruckVO selectTruck(int truck_code) {
		return dao.selectFoodtruck(truck_code);
	}

	@Override
	public List<Foodtruck_FoodTypeVO> getThistruckFoodtype(int truck_code) {
		return dao.getThistruckFoodtype(truck_code);
	}

	@Override
	public List<FoodtruckVO> selectFavoriteFT(String userId) {
		return dao.selectFavoriteFT(userId);
	}

}
