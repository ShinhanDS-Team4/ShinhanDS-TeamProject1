package com.team4.shoppingmall.prod_image;

import java.util.List;

public interface Prod_ImageDAOInterface {
	
	public Prod_ImageDTO selectByImageId(Integer img_id);

	public Prod_ImageDTO selectByProdId(Integer prod_id);
	
	public List<Prod_ImageDTO> selectAll();
	
	public int prod_imageInsert(Prod_ImageDTO prod_image);
	
	public int prod_imageUpdate(Prod_ImageDTO prod_image);
	
	public int prod_imageDelete(Integer img_id);
}
