package com.team4.shoppingmall.addr_list;

import java.util.List;
import java.util.Map;

public interface Addr_ListDAOInterface {
		
	public List<Addr_ListDTO> selectAll();

	//public Addr_ListDTO selectByAddr_Num(int addr_num);
	
	public List<Addr_ListDTO> selectByMember_Id(String member_id);
	
	//나의 배송 목록 검색
	public List<Map<String,Object>> selectByMember_Id2(String member_id);
	
	
	public int addressInsert(Addr_ListDTO addr_list);
	
	public int addressUpdate(Addr_ListDTO addr_list);

	public int addressDelete(int addr_num);

	// 기존 is_master_addr 값을 N으로 업데이트
	public int updateMasterAddrToN(String member_id);
	//나의 주소 개수 
	public int countAddresses(String member_id);
	
	//주소id에 해당하는 주소를 대표'Y'로 설정
	public int updateMasterAddrToY(int addr_num);

	public Addr_ListDTO findMasterAddr(String member_id);
	
}
