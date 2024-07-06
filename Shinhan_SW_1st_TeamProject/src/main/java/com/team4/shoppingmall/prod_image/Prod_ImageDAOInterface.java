package com.team4.shoppingmall.prod_image;

import java.util.List;
import java.util.Map;

public interface Prod_ImageDAOInterface {
	//메인 이미지 조회
	public List<Map<String,Object>> prodMainImgInfoByProdId(String prod_id);
	//서브 이미지 조회
	public List<Map<String,Object>> prodSubImgInfoByProdId(String prod_id);
	
	public Prod_ImageDTO selectByImageId(String img_id);

	public Prod_ImageDTO selectByProdId(String prod_id);
	
	public List<Prod_ImageDTO> findAllImgsByProdID(String prod_id);
	
	public List<Prod_ImageDTO> selectAll();
	
	public int prod_imageInsert(Prod_ImageDTO prod_image);
	
	public int prod_imageUpdate(Prod_ImageDTO prod_image);
	
	public int prod_imageDelete(String img_id);

	public List<String> findAllImgFileNameByProdID(String prod_id);

	public List<String> findMainImgFileNameByProdID(Prod_ImageDTO prod_image);

	public List<String> findDescImgFileNameByProdID(Prod_ImageDTO prod_image);

	
}
