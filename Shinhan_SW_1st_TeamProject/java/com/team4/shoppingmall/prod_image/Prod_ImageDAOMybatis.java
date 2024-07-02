package com.team4.shoppingmall.prod_image;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class Prod_ImageDAOMybatis implements Prod_ImageDAOInterface {

	@Autowired
	SqlSession sqlSession;
	
	String namespace = "com.saren.prod_image.";
	
	@Override
	public Prod_ImageDTO selectByImageId(String img_id) {
		return sqlSession.selectOne(namespace+"selectByImageId", img_id);
	}

	@Override
	public Prod_ImageDTO selectByProdId(String prod_id) {
		return sqlSession.selectOne(namespace+"selectByProdId", prod_id);
	}
	
	@Override
	public List<Prod_ImageDTO> findAllImgsByProdID(String prod_id) {
		return sqlSession.selectList(namespace+"findAllImgsByProdID",prod_id);
	}

	@Override
	public List<Prod_ImageDTO> selectAll() {
		return sqlSession.selectList(namespace+"selectAll");
	}

	@Override
	public int prod_imageInsert(Prod_ImageDTO prod_image) {
		return sqlSession.insert(namespace+"prod_imageInsert", prod_image);
	}

	@Override
	public int prod_imageUpdate(Prod_ImageDTO prod_image) {
		return sqlSession.update(namespace+"prod_imageUpdate", prod_image);
	}

	@Override
	public int prod_imageDelete(String img_id) {
		return sqlSession.delete(namespace+"prod_imageDelete", img_id);
	}

	
}
