package com.team4.shoppingmall.member;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class MemberDAOMybatis implements MemberDAOInterface {

	@Autowired
	SqlSession sqlSession;
	
	String namespace = "com.saren.member.";
	
	@Override
	public MemberDTO selectById(String member_id) {
		return sqlSession.selectOne(namespace+"selectById", member_id);
	}
	
	@Override
	public MemberDTO findId(String member_name, String phone) {
		return sqlSession.selectOne(namespace+"findId", phone);
	}

	@Override
	public List<MemberDTO> selectAll() {
		return sqlSession.selectList(namespace+"selectAll");
	}

	@Override
	public int memberInsert(MemberDTO member) {
		return sqlSession.insert(namespace+"memberInsert", member);
	}

	@Override
	public int memberUpdate(MemberDTO member) {
		return sqlSession.update(namespace+"memberUpdate", member);
	}

	@Override
	public int memberDelete(String member_id) {
		return sqlSession.delete(namespace+"memberDelete", member_id);
	}
	
	public MemberDTO loginChk(String member_id) {
		MemberDTO member = sqlSession.selectOne(namespace+"loginChk", member_id);
		return member;
	}

	@Override
	public int updatePassword(MemberDTO member) {
		return sqlSession.update(namespace+"memberUpdatePassword", member);
	}

	@Override
	public int memberUpdateAccess(MemberDTO member) {
		return sqlSession.update(namespace+"memberUpdateAccess", member);
	}
}
