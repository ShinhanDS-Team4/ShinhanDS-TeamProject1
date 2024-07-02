package com.team4.shoppingmall.customer;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class CustomerService {
	
	@Autowired
	CustomerDAOInterface customerDAO;
	
	// 占쏙옙占쏙옙 
	public CustomerDTO selectById(String customerID) {
		return customerDAO.selectById(customerID);
	}
	
	// 占쏙옙占쏙옙占� 
	public List<CustomerDTO> selectAll() {
		return customerDAO.selectAll();
	}
	
	// 占쏙옙占쏙옙占� 
	public int customerInsert(CustomerDTO customer) {
		return customerDAO.customerInsert(customer);
	}
	
	// 占쏙옙占쏙옙占쏙옙 
	public int customerUpdate(CustomerDTO customer) {
		return customerDAO.customerUpdate(customer);
	}

	public Long TotalMoneyAmount() {		
		return customerDAO.TotalMoneyAmount();
	}
}