/*
 * import java.util.List;
 * 
 * import org.apache.ibatis.session.SqlSession; import
 * org.springframework.beans.factory.annotation.Autowired; import
 * org.springframework.stereotype.Repository;
 * 
 * @Repository public class AdminDAOMybatis implements AdminDAOInterface {
 * 
 * @Autowired SqlSession sqlSession;
 * 
 * String namespace = "com.saren.admin.";
 * 
 * @Override public AdminDTO selectById(admin_id) { return
 * sqlSession.selectOne(namespace+"selectById", admin_id); }
 * 
 * @Override public List<AdminDTO> selectAll() { return
 * sqlSession.selectList(namespace+"selectAll"); }
 * 
 * @Override public int ?Insert(AdminDTO ?) { return
 * sqlSession.insert(namespace+"?Insert", ?); }
 * 
 * @Override public int ?Update(AdminDTO ?) { return
 * sqlSession.update(namespace+"?Update", ?); }
 * 
 * @Override public int ?Delete(?) { return
 * sqlSession.delete(namespace+"?Delete", ?); } }
 */
