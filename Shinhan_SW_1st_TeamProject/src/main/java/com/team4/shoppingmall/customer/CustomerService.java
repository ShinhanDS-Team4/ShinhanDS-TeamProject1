package com.team4.shoppingmall.customer;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class CustomerService {
	
	@Autowired
	CustomerDAOInterface customerDAO;
	
	// 고객상세
	public CustomerDTO selectById(Integer rental_code) {
		return customerDAO.selectById(rental_code);
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
	public int customerUpdate(Integer rental_code) {
		return customerDAO.customerUpdate(rental_code);
	}

	public Long TotalMoneyAmount() {		
		return customerDAO.TotalMoneyAmount();
	}
}