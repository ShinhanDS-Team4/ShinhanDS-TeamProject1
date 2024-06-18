package com.team4.shoppingmall.customer;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class CustomerService {
	
	@Autowired
	CustomerDAOInterface customerDAO;
	
	// °í°´»ó¼¼ 
	public CustomerDTO selectById(Integer rental_code) {
		return customerDAO.selectById(rental_code);
	}
	
	// °í°´¸ñ·Ï 
	public List<CustomerDTO> selectAll() {
		return customerDAO.selectAll();
	}
	
	// °í°´µî·Ï 
	public int customerInsert(CustomerDTO customer) {
		return customerDAO.customerInsert(customer);
	}
	
	// °í°´¼öÁ¤ 
	public int customerUpdate(Integer rental_code) {
		return customerDAO.customerUpdate(rental_code);
	}

}