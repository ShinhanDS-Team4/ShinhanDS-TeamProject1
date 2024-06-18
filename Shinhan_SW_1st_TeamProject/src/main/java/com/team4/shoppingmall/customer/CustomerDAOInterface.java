package com.team4.shoppingmall.customer;

import java.util.List;

public interface CustomerDAOInterface {
	
	// °í°´»ó¼¼
	public CustomerDTO selectById(Integer rental_code);
	
	// °í°´¸ñ·Ï
	public List<CustomerDTO> selectAll();
	
	// °í°´µî·Ï
	public int customerInsert(CustomerDTO customer);
	
	// °í°´¼öÁ¤
	public int customerUpdate(Integer rental_code);
	
}
