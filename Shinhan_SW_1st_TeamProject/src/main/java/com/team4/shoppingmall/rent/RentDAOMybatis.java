package com.team4.shoppingmall.rent;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.team4.shoppingmall.rent_prod_stock.RentProdStockDTO;

@Repository
public class RentDAOMybatis implements RentDAOInterface {

	@Autowired
	SqlSession sqlSession;

	String namespace = "com.saren.rent.";
	

	//대여 신청 완료된 대여 상품 목록
	public List<Map<String,Object>> rentProductById(String member_id){
		return sqlSession.selectList(namespace+"rentProductById", member_id);
	};

	@Override
	public int searchRentId() {
		return sqlSession.selectOne(namespace+"searchRentId");
	}

	// 대여상세
	@Override
	public RentDTO selectById(Integer rental_code) {
		return sqlSession.selectOne(namespace+"selectById", rental_code);
	}

	// 대여목록
	@Override
	public List<RentDTO> selectAll() {
		return sqlSession.selectList(namespace + "selectAll");
	}

	// 대여하기
	@Override
	public int rentInsert(RentDTO rent) {
		return sqlSession.insert(namespace+"rentInsert", rent);
	} 

	// 대여상태 수정
	@Override
	public int rentUpdate(Integer rental_code) {
		return sqlSession.update(namespace+"rentUpdate", rental_code);
	} 


	// rentlist.jsp�� ����� ��ǰ��, �귣��, �ɼ�, ��ǰ����, �̹���URL
	@Override
	public List<RentSelectDTO> selectById2(int rental_code) {
		return sqlSession.selectList(namespace+"selectById2", rental_code); 
	}
	

	// rentlist.jsp����, �󼼻�ǰ �ɼ� ��½�, ��� �ɼ� ��������
	@Override
	public List<RentProdStockDTO> selectOptions() {
		return sqlSession.selectList(namespace+"selectOptions");  
    }

	// rentlist.jsp����, �뿩���
	@Override
	public int cancelRent(int rentalCode) {
		return sqlSession.update(namespace+"cancelRent", rentalCode);
	}
	
	// rentlist.jsp����, �ݳ�
	@Override
	public int returnRent(int rentalCode) {
		return sqlSession.update(namespace+"returnRent", rentalCode);
	}

	@Override
	public int updateRent(RentDTO rent) {
		return sqlSession.update(namespace+"updateRent", rent);
	}


}