package com.team4.shoppingmall.customer;

import java.util.List;

public interface CustomerDAOInterface {
	
	// 占쏙옙占쏙옙
	public CustomerDTO selectById(String customerID);
	
	// 占쏙옙占쏙옙占�
	public List<CustomerDTO> selectAll();
	
	// 占쏙옙占쏙옙占�
	public int customerInsert(CustomerDTO customer);
	
	// 占쏙옙占쏙옙占쏙옙
	public int customerUpdate(CustomerDTO customer);

	public Long TotalMoneyAmount();
	
}
