package com.team4.shoppingmall.buyer_inq;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class Buyer_InqService {
	
	@Autowired
	Buyer_InqDAOInterface buyer_inqDAO;
	
	public Buyer_InqDTO selectByInqId(Integer buyer_inq_id) {
		return buyer_inqDAO.selectByInqId(buyer_inq_id);
	}
	
	public List<Buyer_InqDTO> selectByMemberId(String member_id) {
		return buyer_inqDAO.selectByMemberId(member_id);
	}
	
	public List<Buyer_InqDTO> selectAll() {
		return buyer_inqDAO.selectAll();
	}
	
	public int buyer_inqInsert(Buyer_InqDTO buyer_inq) {
		return buyer_inqDAO.buyer_inqInsert(buyer_inq);
	}
	
	public int buyer_inqUpdate(Buyer_InqDTO buyer_inq) {
		return buyer_inqDAO.buyer_inqUpdate(buyer_inq);
	}
	
	public int buyer_inqDelete(Integer buyer_inq_id) {
		return buyer_inqDAO.buyer_inqDelete(buyer_inq_id);
	}
}