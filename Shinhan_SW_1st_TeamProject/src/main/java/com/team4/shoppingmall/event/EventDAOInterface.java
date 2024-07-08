package com.team4.shoppingmall.event;

import java.util.List;

public interface EventDAOInterface {
	
	public EventDTO selectById(Integer event_id);
	
	public List<EventDTO> selectAll();
	
//	public List<MemberDTO> selectByCondition();
	
	public int eventInsert(EventDTO event);
	
	public int eventUpdate(EventDTO event);
	
	public int eventDelete(Integer event_id);

	public EventDTO selectFirst();
}
