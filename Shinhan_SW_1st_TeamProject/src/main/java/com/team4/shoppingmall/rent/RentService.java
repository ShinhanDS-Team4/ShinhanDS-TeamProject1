package com.team4.shoppingmall.rent;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.team4.shoppingmall.rent_prod_stock.RentProdStockDTO;

@Service
public class RentService {
	
	@Autowired
	RentDAOInterface rentDAO;
	
	// �뿩��
	public RentDTO selectById(Integer rental_code) {
		return rentDAO.selectById(rental_code);
	}

	// �뿩���
	public List<RentDTO> selectAll() {
		return rentDAO.selectAll();
	}

	// �뿩�ϱ�
	public int rentInsert(RentDTO rent) {
		return rentDAO.rentInsert(rent);
	}

	// �뿩���� ����
	public int rentUpdate(Integer rental_code) {
		return rentDAO.rentUpdate(rental_code);
	}

	// rentlist.jsp�� ����� �뿩��ǰ ������
	public List<RentSelectDTO> selectById2(int rental_code) { 
		return rentDAO.selectById2(rental_code);
	}

	// rentlist.jsp����, �󼼻�ǰ �ɼ� ��½�, ��� �ɼ� ��������
	public List<RentProdStockDTO> selectOptions() {
        return rentDAO.selectOptions();
	}

	// rentlist.jsp����, ���
	public int cancelRent(int rentalCode) {
        return rentDAO.cancelRent(rentalCode);
	}

	// rentlist.jsp����, �ݳ�
	public int returnRent(int rentalCode) {
        return rentDAO.returnRent(rentalCode);
	}

}