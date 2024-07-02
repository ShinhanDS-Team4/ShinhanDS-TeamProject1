package com.team4.shoppingmall.order_prod;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class OrderProdService {

	@Autowired
	OrderProdDAOInterface orderprodDAO;

	// �ֹ���
	public OrderProdDTO selectById(Integer order_id) {
		return orderprodDAO.selectById(order_id);
	}

	// �ֹ����
	public List<OrderProdDTO> selectAll() {
		return orderprodDAO.selectAll();
	}

	// �ֹ�����
	public int orderprodInsert(OrderProdDTO orderprod) {
		return orderprodDAO.orderprodInsert(orderprod);
	}

	// �ֹ�����
	public int orderprodUpdate(OrderProdDTO orderprod) {
		return orderprodDAO.orderprodUpdate(orderprod);
	}
	
	// orderlist.jsp�� ����� ��ǰ��, �귣��, �ɼ�, ��ǰ����, �̹���URL
	public List<OrderProdDetailDTO> selectById2(int order_id) {
        return orderprodDAO.selectById2(order_id);
    }

	// orderlist.jsp����, �󼼻�ǰ �ɼ� ��½�, ��� �ɼ� ��������
	public Object selectOptions() { 
        return orderprodDAO.selectOptions();
	}

	// orderlist.jsp����, �ֹ����
	public int orderCancel(int orderId) {
		return orderprodDAO.orderCancel(orderId);
	}

	// orderlist.jsp����, ȯ��
	public int orderRefund(int orderId) {
		return orderprodDAO.orderRefund(orderId);
	}

}