package com.team4.shoppingmall.admin_inq;

import java.sql.Date;
import java.util.List;

public interface Admin_InqDAOInterface {
	
	public Admin_InqDTO selectByInqId(Integer admin_inq_id);
	
	public List<Admin_InqDTO> selectByMemberId(String member_id);

	public List<Admin_InqDTO> selectAll();
	
//	public List<MemberDTO> selectByCondition();
	
	public int admin_inqInsert(Admin_InqDTO admin_inq);
	
	public int admin_inqUpdate(Admin_InqDTO admin_inq);
	
	public int admin_inqDelete(Integer admin_inq_id);

	public Integer findMaxAdminInqId();
	
	public List<Admin_InqDTO> selectBySellerAll();
	public List<Admin_InqDTO> selectByCustomerAll();
	
	public List<Admin_InqDTO> searchFaq(String searchQuery, String boardType);

	public int admin_reply_delete(Integer admin_inq_id);

	public int admin_replyUpdate(Admin_InqDTO reply_update);
}
