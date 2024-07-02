package com.team4.shoppingmall.customer;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class CustomerService {
	
	@Autowired
	CustomerDAOInterface customerDAO;
	
	// ���� 
	public CustomerDTO selectById(String member_id) {
		return customerDAO.selectById(member_id);
	}
	
	// ����� 
	public List<CustomerDTO> selectAll() {
		return customerDAO.selectAll();
	}
	
	// ����� 
	public int customerInsert(CustomerDTO customer) {
		return customerDAO.customerInsert(customer);
	}
	
	// ������ 
	public int customerUpdate(Integer rental_code) {
		return customerDAO.customerUpdate(rental_code);
	}

	public Long TotalMoneyAmount() {		
		return customerDAO.TotalMoneyAmount();
	}
}