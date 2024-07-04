package com.team4.shoppingmall.category;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class CategoryService {
	
	@Autowired
	CategoryDAOInterface categoryDAO;
	
	//�긽�뭹�쓽 移댄뀒怨좊━紐� 議고쉶
	public CategoryDTO productCategoryByProdId(String prod_id) {
		return categoryDAO.productCategoryByProdId(prod_id);
	};
	public CategoryDTO selectById(Integer category_id) {
		return categoryDAO.selectById(category_id);
	}

	public List<CategoryDTO> selectByParentId(Integer parent_category_id) {
		return categoryDAO.selectByParentId(parent_category_id);
	}
	
	public List<CategoryDTO> selectAll() {
		return categoryDAO.selectAll();
	}
	
	public int categoryInsert(CategoryDTO category) {
		return categoryDAO.categoryInsert(category);
	}
	
	public int categoryUpdate(CategoryDTO category) {
		return categoryDAO.categoryUpdate(category);
	}
	
	public int categoryDelete(Integer category_id) {
		return categoryDAO.categoryDelete(category_id);
	}
	
	public List<CategoryDTO> firstDepthCategoryList() {
		return categoryDAO.firstDepthCategoryList();
	}
	
	public List<CategoryDTO> categoryListBydepth(CategoryDTO category){
		return categoryDAO.categoryListBydepth(category);
	}
}