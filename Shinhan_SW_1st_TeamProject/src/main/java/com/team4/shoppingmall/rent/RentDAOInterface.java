package com.team4.shoppingmall.rent;

import java.util.List;
import java.util.Map;

import com.team4.shoppingmall.rent_prod_stock.RentProdStockDTO;

public interface RentDAOInterface {
	
	//�뿩��� �ִ� ��ǰ�� �뿩ID ã��
	
	// �뿩��
	public RentDTO selectById(Integer rental_code);
	
	// �뿩���
	public List<RentDTO> selectAll();
	
	// �뿩�ϱ� 
	public int rentInsert(RentDTO rent);
	
	// �뿩���� ����
	public int rentUpdate(Integer rental_code);

	// rentlist.jsp�� ����� �뿩��ǰ ������(�귣���, ��ǰ��, �ɼ�, �뿩����, �̹���URL)
	public List<RentSelectDTO> selectById2(int rental_code);

	// rentlist.jsp����, �󼼻�ǰ �ɼ� ��½�, ��� �ɼ� ��������
	public List<RentProdStockDTO> selectOptions();

	// rentlist.jsp����, ���
	public int cancelRent(int rentalCode);

	// rentlist.jsp����, �ݳ�
	public int returnRent(int rentalCode);
	
}
