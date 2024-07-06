package com.team4.shoppingmall.admin_inq;

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
}
