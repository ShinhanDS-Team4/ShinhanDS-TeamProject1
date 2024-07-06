package com.team4.shoppingmall.prod_image;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class Prod_ImageService {
	
	@Autowired
	Prod_ImageDAOInterface prod_imageDAO;
	
	//메인 이미지 조회
	public List<Map<String,Object>> prodMainImgInfoByProdId(String prod_id){
		return prod_imageDAO.prodMainImgInfoByProdId(prod_id);
	};
	//서브 이미지 조회
	public List<Map<String,Object>> prodSubImgInfoByProdId(String prod_id){
		return prod_imageDAO.prodSubImgInfoByProdId(prod_id);
	};
	
	public Prod_ImageDTO selectByImageId(String img_id) {
		return prod_imageDAO.selectByImageId(img_id);
	}

	public Prod_ImageDTO selectByProdId(String prod_id) {
		return prod_imageDAO.selectByProdId(prod_id);
	}
	
	public List<Prod_ImageDTO> findAllImgsByProdID(String prod_id){
		return prod_imageDAO.findAllImgsByProdID(prod_id);
	}
	
	public List<String> findMainImgFileNameByProdID(Prod_ImageDTO prod_image){
		return prod_imageDAO.findMainImgFileNameByProdID(prod_image);
	}
	public List<String> findDescImgFileNameByProdID(Prod_ImageDTO prod_image){
		return prod_imageDAO.findDescImgFileNameByProdID(prod_image);
	}
	public List<String> findAllImgFileNameByProdID(String prod_id){
		return prod_imageDAO.findAllImgFileNameByProdID(prod_id);
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
	
	public int prod_imageDelete(String img_id) {
		return prod_imageDAO.prod_imageDelete(img_id);
	}
}