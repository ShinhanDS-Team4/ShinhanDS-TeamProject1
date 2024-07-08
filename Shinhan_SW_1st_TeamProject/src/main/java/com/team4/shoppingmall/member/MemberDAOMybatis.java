package com.team4.shoppingmall.member;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class MemberDAOMybatis implements MemberDAOInterface {

	@Autowired
	SqlSession sqlSession;
	
	String namespace = "com.saren.member.";
	
	//구매자 회원 정보 수정
	public int myInfoUpdate(MemberDTO member) {
		return sqlSession.update(namespace+"myInfoUpdate", member);
	}
	
	//로그인 회원 정보 수정용 비밀번호 체크
	public MemberDTO memberCheckByPw(MemberDTO member) {
		return sqlSession.selectOne(namespace+"memberCheckByPw", member);
	}
	
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
	

	@Override
	public List<MemberDTO> selectByCondition() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<MemberDTO> selectBySeller() {
		return sqlSession.selectList(namespace+"selectBySeller");
	}

	@Override
	public List<MemberDTO> selectByCustomer() {
		return sqlSession.selectList(namespace+"selectByCustomer");
	}
	
	@Override
	public List<MemberDTO> selectBySeller_authority() {
		return sqlSession.selectList(namespace+"selectBySeller_authority");
	}
	
	@Override
	public MemberDTO selectBySeller_info(String member_id) {
		return sqlSession.selectOne(namespace+"selectBySeller_info", member_id);
	}
	
	@Override	
	public List<MemberDTO> searchMembers(String searchType, String keyword)	{
		Map<String, Object> search = new HashMap<>();
		search.put("searchType", searchType);
		search.put("keyword", keyword);
        return sqlSession.selectList(namespace + "searchMembers", search);
    }
	
	public int seller_Monthly_IncreaseRate() {
		return sqlSession.selectOne(namespace+"seller_Monthly_IncreaseRate");
	}
  

	public int customer_Monthly_IncreaseRate() {
		return sqlSession.selectOne(namespace+"customer_Monthly_IncreaseRate");
	}
	
    @Override
    public Double sellerMonthlyIncreaseRate() {
        Double seller_monthly_increase_rate = sqlSession.selectOne("sellerMonthlyIncreaseRate");
        return seller_monthly_increase_rate != null ? seller_monthly_increase_rate : 0.0;
    }
    
    @Override
    public Double customerMonthlyIncreaseRate() {
    	Double customer_monthly_increase_rate = sqlSession.selectOne("customerMonthlyIncreaseRate");
    	return customer_monthly_increase_rate != null ? customer_monthly_increase_rate : 0.0;
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
	
	@Override 
	public MemberDTO memberCheckByPw2(MemberDTO member)  {
		return sqlSession.selectOne(namespace+"memberCheckByPw2", member);
	}
 
	public int seller_authority_access_deny(String member_id, String seller_authority) {
		Map<String, Object> upset = new HashMap<>();
		upset.put("member_id", member_id);
		upset.put("seller_authority", seller_authority);        
		return sqlSession.update(namespace+"seller_authority_access_deny", upset);
	}
		
	@Override
	public List<MemberCustomerDTO> selectByAllCustomer() {
		return sqlSession.selectList(namespace+"selectByAllCustomer");
	}

	@Override
	public List<MemberCustomerDTO> searchByCustomer(String searchCustomer) {
		return sqlSession.selectList(namespace+"searchByCustomer", searchCustomer);
	}
	
	@Override
	public MemberCustomerDTO customerByInfo(String member_id) {
		return sqlSession.selectOne(namespace+"customerByInfo", member_id);
	}
	
	@Override
	public List<MemberDTO> selectBySeller_access(String searchSeller) {
		return sqlSession.selectList(namespace+"selectBySeller_access", searchSeller);
	}

}
 
