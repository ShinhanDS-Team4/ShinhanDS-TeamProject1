package com.team4.shoppingmall.event;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class EventDAOMybatis implements EventDAOInterface {

	@Autowired
	SqlSession sqlSession;
	
	String namespace = "com.saren.event.";
	
	@Override
	public EventDTO selectById(Integer event_id) {
		return sqlSession.selectOne(namespace+"selectById", event_id);
	}

	@Override
	public List<EventDTO> selectAll() {
		return sqlSession.selectList(namespace+"selectAll");
	}

	@Override
	public int eventInsert(EventDTO event) {
		return sqlSession.insert(namespace+"eventInsert", event);
	}

	@Override
	public int eventUpdate(EventDTO event) {
		return sqlSession.update(namespace+"eventUpdate", event);
	}

	@Override
	public int eventDelete(Integer event_id) {
		return sqlSession.delete(namespace+"eventDelete", event_id);
	}

	@Override
	public EventDTO selectFirst() {
		return sqlSession.selectOne(namespace+"selectFirst");
	}
}
