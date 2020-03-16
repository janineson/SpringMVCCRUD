package org.hello.service;

import java.util.List;

import org.hello.domain.NoticeVO;

public interface NoticeService {
	
	 	public void insert(NoticeVO vo) throws Exception;
	    
	    public List<NoticeVO> list(NoticeVO vo) throws Exception;
	   
	    public NoticeVO select(Integer b_no) throws Exception;
	    
	    public void delete(Integer b_no) throws Exception;
	    
	    public void update(NoticeVO vo) throws Exception;
	    
	    public void updateCount(NoticeVO vo) throws Exception;

}
