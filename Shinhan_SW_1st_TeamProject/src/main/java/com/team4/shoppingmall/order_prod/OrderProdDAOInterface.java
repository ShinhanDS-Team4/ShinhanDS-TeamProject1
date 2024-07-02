package com.team4.shoppingmall.order_prod;

import java.util.List;
import java.util.Map;

import com.team4.shoppingmall.prod.ProductNewVO;
import com.team4.shoppingmall.prod_option.Prod_OptionDTO; 

public interface OrderProdDAOInterface {
	
	//ì£¼ë¬¸id ì‹œí€€ìŠ¤ ë²ˆí˜¸ ì°¾ê¸°
	public int sequenceOrderId();
	
	// ï¿½Ö¹ï¿½ï¿½ï¿½
	public OrderProdDTO selectById(Integer order_id);
	
	// ï¿½Ö¹ï¿½ï¿½ï¿½ï¿½
	public List<OrderProdDTO> selectAll();
	
	// ï¿½Ö¹ï¿½ï¿½ï¿½ï¿½ï¿½
	public int orderprodInsert(OrderProdDTO orderprod); 

	// ï¿½Ö¹ï¿½ï¿½ï¿½ï¿½ï¿½
	public int orderprodUpdate(OrderProdDTO orderprod);
	
	// orderlist.jspï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ï¿½ ï¿½Ç¸Å»ï¿½Ç° ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½(ï¿½ê·£ï¿½ï¿½ï¿½, ï¿½ï¿½Ç°ï¿½ï¿½, ï¿½É¼ï¿½, ï¿½ë¿©ï¿½ï¿½ï¿½ï¿½, ï¿½Ì¹ï¿½ï¿½ï¿½URL)
	public Map<String, Object> selectById2(int order_id);

	// orderlist.jspï¿½ï¿½ï¿½ï¿½, ï¿½ó¼¼»ï¿½Ç° ï¿½É¼ï¿½ ï¿½ï¿½Â½ï¿½, ï¿½ï¿½ï¿½ ï¿½É¼ï¿½ ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
	public List<Prod_OptionDTO> selectOptions();

	// orderlist.jsp¿¡¼­, ÁÖ¹®Ãë¼Ò
	public int orderCancel(int orderId);

	// orderlist.jsp¿¡¼­, ÁÖ¹®È¯ºÒ
	public int orderRefund(int orderId);

	
	
}
