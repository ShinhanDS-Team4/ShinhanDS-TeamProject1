package com.team4.shoppingmall.category;

import java.util.List;

public interface CategoryDAOInterface {
	
	//상품의 카테고리명 조회
	public CategoryDTO productCategoryByProdId(String prod_id);
	
	public CategoryDTO selectById(Integer category_id);
	
	public List<CategoryDTO> selectByParentId(Integer parent_category_id);
	
	public List<CategoryDTO> selectAll();
	
//	public List<MemberDTO> selectByCondition();
	
	public int categoryInsert(CategoryDTO category);
	
	public int categoryUpdate(CategoryDTO category);
	
	public int categoryDelete(Integer category_id);

	public List<CategoryDTO> categoryListBydepth(CategoryDTO category);

	public List<CategoryDTO> firstDepthCategoryList();
}