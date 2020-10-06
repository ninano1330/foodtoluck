package kitri.project.service;

import java.util.List;
import java.util.Map;

import kitri.project.vo.TimeLineCommentVO;
import kitri.project.vo.TimeLineVO;

public interface TimeLineService {

	String getOwnerId(int truck_code);

	int getMaxRownum(int truck_code);

	List<TimeLineVO> getTimeLine(Map<String, Integer> trcdmxrn);

	List<TimeLineVO> getTimeLineComment(Map<String, Integer> tlparam);

	void setTimeline(TimeLineVO vo) throws Exception;

	TimeLineVO mdfTimeline(TimeLineVO vo) throws Exception;

	TimeLineVO mdfTimelineModal(TimeLineVO vo);

	TimeLineCommentVO inputComment(TimeLineCommentVO vo);

	TimeLineCommentVO getCommentContent(TimeLineCommentVO vo);

	TimeLineCommentVO mdfCommentAj(TimeLineCommentVO vo);

	int delTimeline(TimeLineCommentVO vo);

	int delComment(TimeLineCommentVO vo);

	int getMaxTimeLineNo(int truck_code);

}
