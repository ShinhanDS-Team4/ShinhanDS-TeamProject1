package com.team4.shoppingmall.addr_list;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class Addr_ListService {
	
	@Autowired
	Addr_ListDAOInterface addr_ListDAOMybatis;
	
	
	public List<Addr_ListDTO> selectAll() {
		return addr_ListDAOMybatis.selectAll();
	}
	
	public List<Addr_ListDTO> selectByMember_Id(String member_id) {
		return addr_ListDAOMybatis.selectByMember_Id(member_id);
	}
	
	public List<Map<String,Object>> selectByMember_Id2(String member_id) {
		return addr_ListDAOMybatis.selectByMember_Id2(member_id);
	}

	@Transactional
	public int addressInsert(Addr_ListDTO addr_list) {
		
		// 湲곗〈 is_master_addr 媛믪쓣 N�쑝濡� �뾽�뜲�씠�듃
		int updateToNresult = addr_ListDAOMybatis.updateMasterAddrToN();
		
        // �깉濡쒖슫 二쇱냼 �궫�엯
        int result = addr_ListDAOMybatis.addressInsert(addr_list);

        return result;
	}
	
	public int addressUpdate(Addr_ListDTO addr_list) {
		return addr_ListDAOMybatis.addressUpdate(addr_list);
	}

	public int addressDelete(int addr_num) {
		return addr_ListDAOMybatis.addressDelete(addr_num);
	}

	//�굹�쓽 二쇱냼 媛쒖닔 
	public int countAddresses(String member_id) {
		return addr_ListDAOMybatis.countAddresses(member_id);
	}
	
	//二쇱냼id�뿉 �빐�떦�븯�뒗 二쇱냼瑜� ���몴'Y'濡� �꽕�젙
	@Transactional
	public int updateMasterAddrToY(int addr_num) {
		
		// 湲곗〈 is_master_addr 媛믪쓣 N�쑝濡� �뾽�뜲�씠�듃
		int updateToNresult = addr_ListDAOMybatis.updateMasterAddrToN();
				
		//���몴 二쇱냼'Y'濡� �뾽�뜲�씠�듃
		int result = addr_ListDAOMybatis.updateMasterAddrToY(addr_num);
	
			
		return result;
	}
	
	public Addr_ListDTO findMasterAddr(String member_id) {
		return addr_ListDAOMybatis.findMasterAddr(member_id);
	}
}
