package com.team4.shoppingmall.customer;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class CustomerService {
	
	@Autowired
	CustomerDAOInterface customerDAO;
	
	// 고객상세 
	public CustomerDTO selectById(String customerID) {
		return customerDAO.selectById(customerID);
	}
	
	// 고객목록
	public List<CustomerDTO> selectAll() {
		return customerDAO.selectAll();
	}
	
	// 고객등록
	public int customerInsert(CustomerDTO customer) {
		return customerDAO.customerInsert(customer);
	}
	
	// 고객수정
	public int customerUpdate(CustomerDTO customer) {
		return customerDAO.customerUpdate(customer);
	}

	public Long TotalMoneyAmount() {		
		return customerDAO.TotalMoneyAmount();
	}
}