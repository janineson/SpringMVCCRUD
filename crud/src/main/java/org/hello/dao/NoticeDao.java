package org.hello.dao;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.hello.domain.NoticeVO;
import org.springframework.stereotype.Repository;

@Repository
public class NoticeDao {
	@Inject
    private SqlSession sqlSession;
    
    private static String namespace = "org.hello.mapper.Notice";
 
    public void insert(NoticeVO vo) throws Exception {
        sqlSession.insert(namespace+".insert", vo);	 
    }
    
    public List<NoticeVO> list(NoticeVO vo) throws Exception {
    	List<NoticeVO> list = sqlSession.selectList(namespace+".list", vo);
        return list;
    }
    
    public NoticeVO select(Integer b_no) throws Exception {
    	NoticeVO data = (NoticeVO) sqlSession.selectOne(namespace+".select", b_no);
        return data;
        
    }
 
    public void delete(Integer b_no) throws Exception {
        sqlSession.delete(namespace+".delete", b_no);
 
    }
 
    public void update(NoticeVO vo) throws Exception {
        sqlSession.update(namespace+".update", vo);
 
    }
 
    public void updateCount(NoticeVO vo) throws Exception {
        sqlSession.update(namespace+".updateCount", vo);
 
    }
}
