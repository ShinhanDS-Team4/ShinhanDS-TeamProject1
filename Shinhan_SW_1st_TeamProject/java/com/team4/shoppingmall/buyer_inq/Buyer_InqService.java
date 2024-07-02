package com.team4.shoppingmall.buyer_inq;

import java.sql.Date;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class Buyer_InqService {
	
	@Autowired
	Buyer_InqDAOInterface buyer_inqDAO;
	

	//�긽�뭹 ID�쓽 �쟾泥� 臾몄쓽 紐⑸줉 議고쉶
	public List<Buyer_InqDTO> selectByProdId(String prod_id){
		return buyer_inqDAO.selectByProdId(prod_id);
	};

	
	public Buyer_InqDTO selectByInqId(Integer buyer_inq_id) {
		return buyer_inqDAO.selectByInqId(buyer_inq_id);
	}
	
	public Buyer_InqDetailDTO selectByInqIdFORseller(Integer buyer_inq_id){
		System.out.println("selectByInqIdFORseller Service 쩌철횉횪");
		return buyer_inqDAO.selectByInqIdFORseller(buyer_inq_id);
	}
	
	public List<Buyer_InqDTO> selectByMemberId(String member_id) {
		return buyer_inqDAO.selectByMemberId(member_id);
	}
	
	public List<Buyer_InqDTO> selectAll() {
		return buyer_inqDAO.selectAll();
	}
	

	//insert ���엯 �닔�젙
	public int buyer_inqInsert(Map<String,String> buyer_inq_map) {
		return buyer_inqDAO.buyer_inqInsert(buyer_inq_map);
	}

	public List<Buyer_InqDTO> selectInqList(String member_id){
		return buyer_inqDAO.selectInqList(member_id);
	}
	

	
	public int buyer_inqUpdate(Buyer_InqDTO buyer_inq) {
		return buyer_inqDAO.buyer_inqUpdate(buyer_inq);
	}
	
	public int buyer_inqDelete(Integer buyer_inq_id) {
		return buyer_inqDAO.buyer_inqDelete(buyer_inq_id);
	}
}