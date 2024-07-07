package com.team4.shoppingmall.addr_list;

import java.util.List;
import java.util.Map;

public interface Addr_ListDAOInterface {
		
	public List<Addr_ListDTO> selectAll();

	//public Addr_ListDTO selectByAddr_Num(int addr_num);
	
	public List<Addr_ListDTO> selectByMember_Id(String member_id);
	
	//�굹�쓽 諛곗넚 紐⑸줉 寃��깋
	public List<Map<String,Object>> selectByMember_Id2(String member_id);
	
	
	public int addressInsert(Addr_ListDTO addr_list);
	
	public int addressUpdate(Addr_ListDTO addr_list);

	public int addressDelete(int addr_num);

	// 湲곗〈 is_master_addr 媛믪쓣 N�쑝濡� �뾽�뜲�씠�듃
	public int updateMasterAddrToN();
	//�굹�쓽 二쇱냼 媛쒖닔 
	public int countAddresses(String member_id);
	
	//二쇱냼id�뿉 �빐�떦�븯�뒗 二쇱냼瑜� ���몴'Y'濡� �꽕�젙
	public int updateMasterAddrToY(int addr_num);

	public Addr_ListDTO findMasterAddr(String member_id);
	
}
