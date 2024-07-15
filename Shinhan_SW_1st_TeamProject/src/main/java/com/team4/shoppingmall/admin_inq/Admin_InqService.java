package com.team4.shoppingmall.admin_inq;

import java.sql.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class Admin_InqService {
	
	@Autowired
	Admin_InqDAOInterface admin_inqDAO;
	
	public Admin_InqDTO selectByInqId(Integer admin_inq_id) {
		return admin_inqDAO.selectByInqId(admin_inq_id);
	}

	public List<Admin_InqDTO> selectByMemberId(String member_id) {
		return admin_inqDAO.selectByMemberId(member_id);
	}
	
	public List<Admin_InqDTO> selectAll() {
		return admin_inqDAO.selectAll();
	}
	
	public Integer findMaxAdminInqId() {
		return admin_inqDAO.findMaxAdminInqId();
	}
	
	public int admin_inqInsert(Admin_InqDTO admin_inq) {
		return admin_inqDAO.admin_inqInsert(admin_inq);
	}
	
	public int admin_inqUpdate(Admin_InqDTO admin_inq) {
		return admin_inqDAO.admin_inqUpdate(admin_inq);
	}
	
	public int admin_inqDelete(Integer admin_inq_id) {
		return admin_inqDAO.admin_inqDelete(admin_inq_id);
	}

	public List<Admin_InqDTO> selectBySellerAll() {
		return admin_inqDAO.selectBySellerAll();
	}

	public List<Admin_InqDTO> selectByCustomerAll() {
		return admin_inqDAO.selectByCustomerAll();
	}

	public List<Admin_InqDTO> searchFaq(String searchQuery, String boardType) {
		return admin_inqDAO.searchFaq(searchQuery, boardType);
	}

	public int admin_reply_delete(Integer admin_inq_id) {
		return admin_inqDAO.admin_reply_delete(admin_inq_id);
	}

	public int admin_replyUpdate(Admin_InqDTO reply_update) {		
		return admin_inqDAO.admin_replyUpdate(reply_update);
	}


}