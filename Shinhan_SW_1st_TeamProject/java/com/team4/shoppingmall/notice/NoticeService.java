package com.team4.shoppingmall.notice;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class NoticeService {
	
	@Autowired
	NoticeDAOInterface noticeDAO;
	
	public NoticeDTO selectById(Integer not_id) {
		return noticeDAO.selectById(not_id);
	}
	
	public List<NoticeDTO> selectAll() {
		return noticeDAO.selectAll();
	}
	
	public int noticeInsert(NoticeDTO notice) {
		return noticeDAO.noticeInsert(notice);
	}
	
	public int noticeUpdate(NoticeDTO notice) {
		return noticeDAO.noticeUpdate(notice);
	}
	
	public int noticeDelete(Integer not_id) {
		return noticeDAO.noticeDelete(not_id);
	}
}