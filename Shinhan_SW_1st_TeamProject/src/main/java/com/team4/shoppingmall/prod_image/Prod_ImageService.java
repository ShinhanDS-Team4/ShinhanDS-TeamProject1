package com.team4.shoppingmall.prod_image;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class Prod_ImageService {
	
	@Autowired
	Prod_ImageDAOInterface prod_imageDAO;
	
	public Prod_ImageDTO selectByImageId(Integer img_id) {
		return prod_imageDAO.selectByImageId(img_id);
	}

	public Prod_ImageDTO selectByProdId(Integer prod_id) {
		return prod_imageDAO.selectByProdId(prod_id);
	}
	
	public List<Prod_ImageDTO> selectAll() {
		return prod_imageDAO.selectAll();
	}
	
	public int prod_imageInsert(Prod_ImageDTO prod_image) {
		return prod_imageDAO.prod_imageInsert(prod_image);
	}
	
	public int prod_imageUpdate(Prod_ImageDTO prod_image) {
		return prod_imageDAO.prod_imageUpdate(prod_image);
	}
	
	public int prod_imageDelete(Integer img_id) {
		return prod_imageDAO.prod_imageDelete(img_id);
	}
}