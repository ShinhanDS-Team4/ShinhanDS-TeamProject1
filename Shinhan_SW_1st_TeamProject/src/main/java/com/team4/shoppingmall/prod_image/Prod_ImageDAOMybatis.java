package com.team4.shoppingmall.prod_image;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class Prod_ImageDAOMybatis implements Prod_ImageDAOInterface {

	@Autowired
	SqlSession sqlSession;
	
	String namespace = "com.saren.prod_image.";
	
	//메인 이미지 조회
	public List<Map<String,Object>> prodMainImgInfoByProdId(String prod_id){
		return sqlSession.selectList(namespace+"prodMainImgInfoByProdId", prod_id);
	};
	//서브 이미지 조회
	public List<Map<String,Object>> prodSubImgInfoByProdId(String prod_id){
		return sqlSession.selectList(namespace+"prodSubImgInfoByProdId", prod_id);
	};
	
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
	public List<String> findAllImgFileNameByProdID(String prod_id) {
		return sqlSession.selectList(namespace+"findAllImgFileNameByProdID", prod_id);
	}
	
	@Override
	public List<String> findMainImgFileNameByProdID(Prod_ImageDTO prod_image) {
		return sqlSession.selectList(namespace+"findMainImgFileNameByProdID", prod_image);
	}
	
	@Override
	public List<String> findDescImgFileNameByProdID(Prod_ImageDTO prod_image) {
		return sqlSession.selectList(namespace+"findDescImgFileNameByProdID", prod_image);
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
