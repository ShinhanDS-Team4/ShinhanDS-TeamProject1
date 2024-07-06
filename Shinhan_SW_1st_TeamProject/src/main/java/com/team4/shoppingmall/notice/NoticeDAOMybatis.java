package com.team4.shoppingmall.notice;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class NoticeDAOMybatis implements NoticeDAOInterface {

	@Autowired
	SqlSession sqlSession;
	
	String namespace = "com.saren.notice.";
	
	@Override
	public NoticeDTO selectById(Integer not_id) {
		return sqlSession.selectOne(namespace+"selectById", not_id);
	}

	@Override
	public List<NoticeDTO> selectAll() {
		return sqlSession.selectList(namespace+"selectAll");
	}

	@Override
	public int noticeInsert(NoticeDTO notice) {
		return sqlSession.insert(namespace+"noticeInsert", notice);
	}

	@Override
	public int noticeUpdate(NoticeDTO notice) {
		return sqlSession.update(namespace+"noticeUpdate", notice);
	}

	@Override
	public int noticeDelete(Integer not_id) {
		return sqlSession.delete(namespace+"noticeDelete", not_id);
	}
	@Override
	public List<NoticeDTO> noticeBysearch(String search_title) {
		return sqlSession.selectList(namespace+"noticeBysearch", search_title);
	}
}
