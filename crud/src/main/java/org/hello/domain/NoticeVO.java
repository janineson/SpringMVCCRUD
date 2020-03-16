package org.hello.domain;
 
import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.format.annotation.DateTimeFormat.ISO;
//Value Object
public class NoticeVO {
	 	private int no;
	    private String title;
	    private String contents;
	    private String author;
	    private Date crtDttm;
	    @DateTimeFormat(iso=ISO.DATE)
	    private Date postingDate;
	    private String stickyYn;
	    @DateTimeFormat(iso=ISO.DATE)
	    private Date stickyStrDate;
	    @DateTimeFormat(iso=ISO.DATE)
	    private Date stickyEndDate;
	    private int viewCount;
	    private String useYn;
	    private String delYn;
	    private Date modDttm;
	    private String modUser;
	    private String keyword;
	    private int pageid;
	    private String managerYn;
	    private String byPage;
	    
	    public NoticeVO(){};

		public int getNo() {
			return no;
		}

		public void setNo(int no) {
			this.no = no;
		}

		public String getTitle() {
			return title;
		}

		public void setTitle(String title) {
			this.title = title;
		}

		public String getContents() {
			return contents;
		}

		public void setContents(String contents) {
			this.contents = contents;
		}

		public String getAuthor() {
			return author;
		}

		public void setAuthor(String author) {
			this.author = author;
		}

		public Date getCrtDttm() {
			return crtDttm;
		}

		public void setCrtDttm(Date crtDttm) {
			this.crtDttm = crtDttm;
		}

		public Date getPostingDate() {
			return postingDate;
		}

		public void setPostingDate(Date postingDate) {
			this.postingDate = postingDate;
		}

		public String getStickyYn() {
			return stickyYn;
		}

		public void setStickyYn(String stickyYn) {
			this.stickyYn = stickyYn;
		}

		public Date getStickyStrDate() {
			return stickyStrDate;
		}

		public void setStickyStrDate(Date stickyStrDate) {
			this.stickyStrDate = stickyStrDate;
		}

		public Date getStickyEndDate() {
			return stickyEndDate;
		}

		public void setStickyEndDate(Date stickyEndDate) {
			this.stickyEndDate = stickyEndDate;
		}

		public int getViewCount() {
			return viewCount;
		}

		public void setViewCount(int viewCount) {
			this.viewCount = viewCount;
		}

		public String getUseYn() {
			return useYn;
		}

		public void setUseYn(String useYn) {
			this.useYn = useYn;
		}

		public String getDelYn() {
			return delYn;
		}

		public void setDelYn(String delYn) {
			this.delYn = delYn;
		}

		public Date getModDttm() {
			return modDttm;
		}

		public void setModDttm(Date modDttm) {
			this.modDttm = modDttm;
		}

		public String getModUser() {
			return modUser;
		}

		public void setModUser(String modUser) {
			this.modUser = modUser;
		}

		public String getKeyword() {
			return keyword;
		}

		public void setKeyword(String keyword) {
			this.keyword = keyword;
		}

		public int getPageid() {
			return pageid;
		}

		public void setPageid(int pageid) {
			this.pageid = pageid;
		}

		public String getManagerYn() {
			return managerYn;
		}

		public void setManagerYn(String managerYn) {
			this.managerYn = managerYn;
		}

		public String getByPage() {
			return byPage;
		}

		public void setByPage(String byPage) {
			this.byPage = byPage;
		};
	    
	  
}
