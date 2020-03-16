package org.hello.service;

import java.util.List;

import javax.inject.Inject;

import org.hello.dao.NoticeDao;
import org.hello.domain.NoticeVO;
import org.springframework.stereotype.Service;

@Service
public class NoticeServiceImpl implements NoticeService {
	//inject is same as Autowired...
    @Inject
    private NoticeDao dao;
    
    
    @Override
    public void insert(NoticeVO vo) throws Exception {
        dao.insert(vo);
    }
 
    @Override
    public List<NoticeVO> list(NoticeVO vo) throws Exception {      
  	  return dao.list(vo);
    }

    @Override
    public NoticeVO select(Integer no) throws Exception {
        return dao.select(no);
    }
 
    @Override
    public void delete(Integer no) throws Exception {
        dao.delete(no);
    }
 
    @Override
    public void update(NoticeVO vo) throws Exception { 
        dao.update(vo);
    }
 
    @Override
    public void updateCount(NoticeVO vo) throws Exception {
        dao.updateCount(vo);
    }
}
