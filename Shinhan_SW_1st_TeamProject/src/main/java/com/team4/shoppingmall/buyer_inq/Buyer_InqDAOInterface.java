package com.team4.shoppingmall.buyer_inq;

import java.sql.Date;
import java.util.List;

import org.apache.ibatis.annotations.Param;

public interface Buyer_InqDAOInterface {
	
	public Buyer_InqDTO selectByInqId(Integer buyer_inq_id);
	
	public Buyer_InqDetailDTO selectByInqIdFORseller(Integer buyer_inq_id);
	
	public List<Buyer_InqDTO> selectByMemberId(String member_id);

	public List<Buyer_InqDTO> selectAll();
	
//	public List<MemberDTO> selectByCondition();
	
	public List<Buyer_InqDTO> selectInqList(String member_id);
	
	public int buyer_inqInsert(Buyer_InqDTO buyer_inq);
	
	public int buyer_inqUpdate(Buyer_InqDTO buyer_inq);
	
	public int buyer_inqDelete(Integer buyer_inq_id);
}
