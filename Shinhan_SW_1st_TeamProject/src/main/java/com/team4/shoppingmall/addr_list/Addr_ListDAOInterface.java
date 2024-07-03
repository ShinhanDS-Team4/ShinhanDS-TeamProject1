package com.team4.shoppingmall.addr_list;

import java.util.List;
import java.util.Map;

public interface Addr_ListDAOInterface {
		
	public List<Addr_ListDTO> selectAll();

	//public Addr_ListDTO selectByAddr_Num(int addr_num);
	
	//나의 배송 목록 검색
	public List<Map<String,Object>> selectByMember_Id(String member_id);
	
	
	public int addressInsert(Addr_ListDTO addr_list);
	
	public int addressUpdate(Addr_ListDTO addr_list);

	public int addressDelete(int addr_num);

	// 기존 is_master_addr 값을 N으로 업데이트
	public int updateMasterAddrToN();
	//나의 주소 개수 
	public int countAddresses(String member_id);
	
	
	
}
