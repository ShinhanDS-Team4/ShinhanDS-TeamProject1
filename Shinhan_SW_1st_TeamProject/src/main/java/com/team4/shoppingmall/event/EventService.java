package com.team4.shoppingmall.event;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class EventService {
	
	@Autowired
	EventDAOInterface eventDAO;
	
	public EventDTO selectById(Integer event_id) {
		return eventDAO.selectById(event_id);
	}
	
	public List<EventDTO> selectAll() {
		return eventDAO.selectAll();
	}
	
	public int eventInsert(EventDTO event) {
		return eventDAO.eventInsert(event);
	}
	
	public int eventUpdate(EventDTO event) {
		return eventDAO.eventUpdate(event);
	}
	
	public int eventDelete(Integer event_id) {
		return eventDAO.eventDelete(event_id);
	}

	public List<EventDTO> selectBySearch(String search_Event) {		
		return eventDAO.selectBySearch(search_Event);
	}
}