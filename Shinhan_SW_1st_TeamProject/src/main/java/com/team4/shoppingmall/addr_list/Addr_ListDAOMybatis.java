package com.team4.shoppingmall.addr_list;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class Addr_ListDAOMybatis implements Addr_ListDAOInterface{
	
	@Autowired
	SqlSession sqlSession;
	
	String namespace = "com.saren.addr_list.";
	
	@Override
	public List<Addr_ListDTO> selectAll(){
		return sqlSession.selectOne(namespace+"selectAll");
	};
	
	//나의 배송지 목록 조회
	@Override
	public List<Map<String,Object>> selectByMember_Id(String member_id) {
		return sqlSession.selectList(namespace+"selectByMember_Id", member_id);
	}
	
	@Override
	public int addressInsert(Addr_ListDTO addr_list) {
		return sqlSession.insert(namespace+"addressInsert", addr_list);
	};
	
	@Override
	public int addressDelete(int addr_num) {
		return sqlSession.delete(namespace+"addressDelete", addr_num);
	};
	
	@Override
	public int addressUpdate(Addr_ListDTO addr_list) {
		return sqlSession.update(namespace+"addressUpdate", addr_list);
	}

	// 기존 is_master_addr 값을 N으로 업데이트
	public int updateMasterAddrToN() {
		return sqlSession.update(namespace+"updateMasterAddrToN");
	};
	//나의 주소 개수 
	public int countAddresses(String member_id){
		return sqlSession.selectOne(namespace+"countAddresses", member_id);
	};
	
}
