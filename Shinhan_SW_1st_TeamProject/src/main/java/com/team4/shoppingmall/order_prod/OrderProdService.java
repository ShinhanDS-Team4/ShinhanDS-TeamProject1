package com.team4.shoppingmall.order_prod;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.team4.shoppingmall.order_detail.Order_DetailDAOInterface;
import com.team4.shoppingmall.order_detail.Order_DetailDTO;
import com.team4.shoppingmall.prod.ProductNewVO;
import com.team4.shoppingmall.seller_prod_stock.Seller_Prod_StockDAOInterface;
import com.team4.shoppingmall.seller_prod_stock.Seller_Prod_StockDAOMybatis;
import com.team4.shoppingmall.seller_prod_stock.Seller_Prod_StockDTO;
import com.team4.shoppingmall.seller_prod_stockTest.Seller_Prod_StockTestDAOInterface;
import com.team4.shoppingmall.seller_prod_stockTest.Seller_Prod_StockTestDTO;

@Service
public class OrderProdService {

	@Autowired
	OrderProdDAOInterface orderprodDAO;

	@Autowired
	Order_DetailDAOInterface orderDetailDAO;
	
	@Autowired
	Seller_Prod_StockTestDAOInterface seller_Prod_StockTestDAO; //Test����
	
	// �ֹ���
	public OrderProdDTO selectById(Integer order_id) {
		return orderprodDAO.selectById(order_id);
	}

	// �ֹ����
	public List<OrderProdDTO> selectAll() {
		return orderprodDAO.selectAll();
	}


	// �ֹ�����, �ֹ��� ����, ��� ������Ʈ
	@Transactional
	public int orderprodInsert(ProductNewVO prodVO, int total_price, String member_id) {
		
		OrderProdDTO order = new OrderProdDTO();
		
		order.setMember_id(member_id);
		order.setTotal_price(total_price);
		
		//1.�ֹ� ���� 
		int result = orderprodDAO.orderprodInsert(order);
		
		//2.�ֹ��� ���� 
		
		//생성된 주문id 시퀀스 번호 찾기 
		int order_id = orderprodDAO.sequenceOrderId(); //null
		//Integer orderId = order.getOrder_id(); // insert�� orderId���� �����´�

		Order_DetailDTO orderDetailDTO = new Order_DetailDTO();
		
		int productPrice = Integer.parseInt(prodVO.getProductPrice()); //��ǰ ����
		
		orderDetailDTO.setOrder_num(prodVO.getOrder_num());
		orderDetailDTO.setOrder_product_price(productPrice);
		orderDetailDTO.setOrder_id(order_id);
		orderDetailDTO.setS_stock_id(prodVO.getS_stock_id());
		
		result = orderDetailDAO.orderDetailInsert(orderDetailDTO);
		
		//3.���� ������Ʈ
		seller_Prod_StockTestDAO.sellProdStockUpdate(prodVO);
		
		return result;
	}
	// �ֹ�����
	public int orderprodUpdate(OrderProdDTO orderprod) {
		return orderprodDAO.orderprodUpdate(orderprod);
	}
	
	// orderlist.jsp�� ����� ��ǰ��, �귣��, �ɼ�, ��ǰ����, �̹���URL
	public Map<String, Object> selectById2(int order_id) {
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