package com.team4.shoppingmall.addr_list;

import java.util.List;

public interface Addr_ListDAOInterface {
		
	public List<Addr_ListDTO> selectAll();

	//public Addr_ListDTO selectByAddr_Num(int addr_num);
	
	public List<Addr_ListDTO> selectByMember_Id(String member_id);
	
	
	public int addressInsert(Addr_ListDTO addr_list);
	
	public int addressUpdate(Addr_ListDTO addr_list);

	public int addressDelete(int addr_num);
	
	
	
}
