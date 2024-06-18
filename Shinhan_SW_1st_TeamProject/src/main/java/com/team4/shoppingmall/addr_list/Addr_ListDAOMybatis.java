package com.team4.shoppingmall.addr_list;

import java.util.List;

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
	
	@Override
	public List<Addr_ListDTO> selectByMember_Id(String member_id) {
		return sqlSession.selectOne(namespace+"selectByMember_Id", member_id);
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

	
	
}
