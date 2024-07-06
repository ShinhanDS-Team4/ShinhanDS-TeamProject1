package com.team4.shoppingmall.notice;

import java.util.List;

public interface NoticeDAOInterface {
	
	public NoticeDTO selectById(Integer not_id);
	
	public List<NoticeDTO> selectAll();
	
//	public List<MemberDTO> selectByCondition();
	
	public int noticeInsert(NoticeDTO notice);
	
	public int noticeUpdate(NoticeDTO notice);
	
	public int noticeDelete(Integer not_id);

	public List<NoticeDTO> noticeBysearch(String search_title);
}
