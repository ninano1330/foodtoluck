package kitri.project.service;

import java.io.File;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.multipart.MultipartFile;

import kitri.project.dao.TimeLineDAO;
import kitri.project.vo.TimeLineCommentVO;
import kitri.project.vo.TimeLineVO;

@Service
public class TimeLineServiceImpl implements TimeLineService {
	
	@Autowired
	TimeLineDAO timeLineDAO;

	@Override
	public String getOwnerId(int truck_code) {

		return timeLineDAO.getOwnerId(truck_code);
	}

	@Override
	public int getMaxRownum(int truck_code) {

		return timeLineDAO.getMaxRownum(truck_code);
	}

	@Override
	public List<TimeLineVO> getTimeLine(Map<String, Integer> trcdmxrn) {

		return timeLineDAO.getTimeLine(trcdmxrn);
	}

	@Override
	public List<TimeLineVO> getTimeLineComment(Map<String, Integer> tlparam) {

		return timeLineDAO.getTimeLineComment(tlparam);
	}
	
	
    // 범용 고유 식별자 Universal Unique IDentifier(파일명 중복 안되도록)
    private String uploadFile(String originalName, byte[] fileData) throws Exception{
    	
    	
    	/*String[] sA = originalName.split("[.](?=[a-z]*$)"); 

    	System.out.println(sA.length); 

    	for(int i=0;i<sA.length;i++)
    	{ 
    		System.out.println(i + " : " + sA[i]); 
    	} */
    	
    	
    	//이건 org.apache.commons.io.FilenameUtils 를 디펜던시에 추가하면 쓸 수 있다. 확장자 체크하기 쉬움.
    	//String extension = getExtension(originalName);
    	
        // uuid 생성(Universal Unique IDentifier, 범용 고유 식별자)
        UUID uuid = UUID.randomUUID();
        // 랜덤생성+파일이름 저장
        String savedName = uuid.toString()+"_"+originalName;
        //String path = 
    	//"G:\\workspace_spring\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\FoodToLuck\\resources\\img\\timelineImages";
        //String path = "C:\\eclipse\\workspace_spring\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\FoodToLuck\\resources\\img\\timelineImages";
//        String path = "G:\\workspace_spring\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\FoodToLuck\\resources\\img\\timelineImages";
        String path= "D:\\javaIDE\\spring\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp1\\wtpwebapps\\FoodToLuck3\\resources\\img\\timelineImages";
        File target = new File(path, savedName);
        // 임시디렉토리에 저장된 업로드된 파일을 지정된 디렉토리로 복사
        // FileCopyUtils.copy(바이트배열, 파일객체)
        FileCopyUtils.copy(fileData, target);
        return savedName;
    }
	
	
    //타임라인 저장 입력 작성
	@Override
	public void setTimeline(TimeLineVO vo) throws Exception{
		System.out.println("Impl - truck_code = "+vo.getTruck_code());
		System.out.println("Impl - member_id = "+vo.getMember_id());
		System.out.println("Impl - timeline_content = "+vo.getTimeline_content());
		
		if(!vo.getTimeline_image_file().isEmpty()){
			
			MultipartFile mf = vo.getTimeline_image_file();
			String orinalName = mf.getOriginalFilename();
			
			//새로 저장된 이미지명 = uuid_원본이미지명
			String savedImgName = uploadFile(orinalName, mf.getBytes());

			System.out.println("Impl - timeline_image 파일명 = "+savedImgName);
			
			vo.setTimeline_image("resources\\img\\timelineImages\\"+savedImgName);
			
		}else{
			
			vo.setTimeline_image("No_image");
		}
		
		timeLineDAO.setTimeline(vo);
	}
	
	

//타임라인 수정
	//모달창에 기존내용 뿌려주기
	@Override
	public TimeLineVO mdfTimelineModal(TimeLineVO vo) {

		return timeLineDAO.mdfTimelineModal(vo);
	}
	//수정한거 파일은 서버에 저장하고 나머지는 DB에 저장 후 다시 들고 오기
	@Override
	public TimeLineVO mdfTimeline(TimeLineVO vo) throws Exception {
		
		String result = timeLineDAO.checkMember(vo.getMember_id());
		System.out.println("Impl mdfTimeline - result = "+result);
		TimeLineVO ro = new TimeLineVO();
		
		if(result.equals("") || result.equals(null)){
			System.out.println("Impl checkMember - result = "+result);
			ro.setTimeline_no(-1);//작성자와 접속자 다름 - 수정X
			return ro;
			
		}else if(result.equals(vo.getMember_id())){//작성자 접속자 일치하면
			
			System.out.println("작성자 == 접속자");
			
			if(!vo.getTimeline_image_file().isEmpty()){//이미지 파일도 업로드 했으면
				
				System.out.println("이미지파일 올렸네");
				
				MultipartFile mf = vo.getTimeline_image_file();
				String orinalName = mf.getOriginalFilename();
				
				//새로 저장된 이미지명 = uuid_원본이미지명
				String savedImgName = uploadFile(orinalName, mf.getBytes());
				
				System.out.println("Impl mdfTimeline - timeline_image 파일명(파일 있으면) = "+savedImgName);
				
				vo.setTimeline_image("resources\\img\\timelineImages\\"+savedImgName);
				
			}else{
				System.out.println("Impl - 이미지 안올렸네");
				//수정할 때 따로 다른 이미지 업로드를 하지 않았으면 기존의 이미지명으로 ㅇㅇ
				String existingImageName = timeLineDAO.mdfGetTimeline(vo).getTimeline_image();
				vo.setTimeline_image(existingImageName);
				System.out.println("Impl - 이미지명에 뭐가 들어갔나 = "+vo);
			}
			
			int result2 = timeLineDAO.mdfSetTimeline(vo);
			
			System.out.println("impl mdfSetTimeline result2(update결과) = "+result2);
			if(result2 == 0){
				System.out.println("Impl mdfSetTimeline - 알수없는 오류");
				ro.setTimeline_no(-2);//업뎃 실패(알수없는 오류)
				return ro;
			}else{//정상적으로 수정되면 수정된vo db에서 가져오기
				
				ro = timeLineDAO.mdfGetTimeline(vo);
				System.out.println("impl mdfGetTimeline 수정 완료된 타임라인  = "+ro);
				return ro;
			}
		}
		return ro;
	}

	
	
	//댓글 대댓글 입력
	@Override
	public TimeLineCommentVO inputComment(TimeLineCommentVO vo) {
		//TimeLineCommentVO co = new TimeLineCommentVO();
		System.out.println(vo);
		
		String checkResult = timeLineDAO.checkMember(vo.getMember_id());
		
		if(checkResult.equals("") || checkResult.equals(null)){
			vo.setTcomment_no(-1);//작성자 접속자 불일치용
			return vo;
		}else{//작성자 접속자 일치하면
			
			
			int result_tc_no = timeLineDAO.inputComment(vo);
			
			System.out.println("Impn inputComment 6, result_tc_no = "+result_tc_no);
			
			if(result_tc_no != 0){
				vo = timeLineDAO.getComment(result_tc_no);
				return vo;
			}else{
				vo.setTcomment_no(-2);// 알수없는 오류
				return vo;
			}
		}
	}

	@Override
	public TimeLineCommentVO getCommentContent(TimeLineCommentVO vo) {

		return timeLineDAO.getCommentContent(vo);
	}

	@Override
	public TimeLineCommentVO mdfCommentAj(TimeLineCommentVO vo) {
		
		System.out.println("Impl mdfCommentAj 수정 전 vo = "+vo);

		String checkResult = timeLineDAO.checkMember(vo.getMember_id());
		
		if(checkResult.equals("") || checkResult.equals(null)){
			
			vo.setTcomment_no(-1);//작성자 접속자 불일치용
			return vo;
			
		}else{//작성자 접속자 일치하면
			
			vo.setTcomment_content("(수정됨) "+vo.getTcomment_content());
			int result_tc_no = timeLineDAO.mdfCommentAj(vo);
			System.out.println("Impn mdfCommentAj , result_tc_no = "+result_tc_no);
			
			if(result_tc_no != 0){//정상 수정됬다면 다시 들고 보내기
				
				vo = timeLineDAO.getComment(vo.getTcomment_no());
				System.out.println("Impl mdfCommentAj 수정 후 vo = "+vo);
				return vo;
			}else{

				vo.setTcomment_no(-2);// 알수없는 오류
				return vo;
			}
		}
	}

	@Override
	public int delTimeline(TimeLineCommentVO vo) {

		String checkResult = timeLineDAO.checkMember(vo.getMember_id());
		
		if(checkResult.equals("") || checkResult.equals(null)){
			
			return -1;//작성자 접속자 불일치용
			
		}else{//작성자 접속자 일치하면
			
			int result = timeLineDAO.delTimeline(vo);
			System.out.println("Impl delTimeline 실행 결과 = "+result);
			if(result > 0){//정상 삭제됬다면 1
				
				//타임라인 삭제시 댓글들은 show=n 로 update할 것.(트럭코드, 타임라인번호) 로 싹 다 업데이트
				timeLineDAO.delComment(vo);
				
				return 1;
			}else{
				return -2;// 알수없는 오류
			}
		}
	}

	@Override
	public int delComment(TimeLineCommentVO vo) {

		String checkResult = timeLineDAO.checkMember(vo.getMember_id());
		
		if(checkResult.equals("") || checkResult.equals(null)){
			
			return -1;//작성자 접속자 불일치용
			
		}else{//작성자 접속자 일치하면
			
			//아 무한루프에서 빠져나오질 못하네
			TimeLineCommentVO uo = new TimeLineCommentVO(); //상위 댓글 vo
			TimeLineCommentVO po = vo; //현재 댓글 vo
			int result = 0;
			
			//하위댓글이 존재하나
				//하위댓글 존재하면
					//del=y 로 업데이트       (show=y 그대로)
				//하위댓글 존재하지 않으면
					//del=y, show=n 으로 업데이트 (화면에 보여줄 필요 없으므로)
					//while(vo.getDepth > 1) 상위 댓글이 존재한다면 계속 체크
						//상위댓글 존재하면 
							//상위댓글이 삭제표시가 아니라면 if(del == 'n')
								//break;
							//상위댓글이 삭제표시되었다면 if(del == 'y')
								// 아 여기서 막히네 밑에 다돌아야 할거 아냐
						//상위댓글 없으면 break;
				
			//1. 하위댓글 없나?
			if(timeLineDAO.existLowerComment(po)==0){
				
				//하위댓글없으면 완전삭제
				timeLineDAO.delComment(po);
				
				
				//여기서 무한 검사
			
				while(true){
					//상위댓글이 존재하는지 검사
					if(po.getTrecomment_no() != 0){
						
						uo = timeLineDAO.getComment(po.getTrecomment_no());
						
						System.out.println("uo = "+uo);
						
						//상위댓글 존재하고
						if(uo != null){
							
							//상위댓글 del==1이고 (상위댓글이 하위댓글때문에 삭제되지 못하고 삭제표시만 했던 경우)
							if(uo.getDel().equals("y")){
								
								//하위댓글 없으면 삭제
								if(timeLineDAO.existLowerComment(uo)==0){
									
									//삭제(상위댓글이 하위댓글때문에 삭제되지 못하고 삭제표시만 했던 경우)
									timeLineDAO.delComment(uo);
									
									//여기까지 if문을 탔다면 while문 계속 돌게 만든다.
									po = uo;
									System.out.println("po(=uo) = "+po);

									//아직 하위댓글이 남아있으면 그대로 냅둬
								}else if(timeLineDAO.existLowerComment(uo)!=0){
									result = 0;
									break;
								}
								
								//상위댓글이 삭제(update)된 상태가 아니면 그냥 패스
							}else if(uo.getDel().equals("n")){
								result = 0;
								break;
							}
							
							
						}else{
							break;
						}
					}else{
						break;
					}
				}
				
				result = 0;
			}else{
				result = timeLineDAO.upDelComment(vo);
			}
			
			return result;
		}
	}

	@Override
	public int getMaxTimeLineNo(int truck_code) {

		return timeLineDAO.getMaxTimeLineNo(truck_code);
	}
}
