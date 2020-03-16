package org.hello.controller;

import java.util.List;
import java.util.Map;
import java.util.Objects;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.hello.domain.NoticeVO;
import org.hello.service.NoticeService;
import org.hello.validator.NoticeValidator;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.method.annotation.MethodArgumentTypeMismatchException;
import org.springframework.web.servlet.NoHandlerFoundException;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
public class NoticeController {

	@Inject
	private NoticeService service;

	@Inject
	private NoticeValidator noticeValidator;
	// print in console
	public static final Logger logger = Logger.getLogger(NoticeController.class.getName());

	/**
	 * 관리자
	 *
	 */

	@RequestMapping(value = "/notice/mList.do", method = RequestMethod.GET)
	public String managerList(@RequestParam(value = "page", required = false) Integer page, HttpServletRequest request,
			Model model,RedirectAttributes rttr) throws Exception {

		logger.info("관리자 목록 페이지");

		// max number of posts shown in a page
		int total = 10;
		int pageInUrl = page == null || page < 1 ? 1: page;
		// this is the list logic per page. if path in the address is 1 (which means it
		// is equal to homepage), then lets set the pageid to 0 so it will start on the
		// top most/ latest record.
		// if not, then get the pageid in the url path and compute to get the next
		// starting index of the next page. offset is 0

		if (page == null) {
			page = 0;
		} else {
			if (page <= 1) {
				page = 0;
			} else {
				page = (page - 1) * total;
			}
		}

		// search function
		String keyword =Objects.toString(request.getParameter("keyword"), "").trim();

		// value object
		NoticeVO vo = new NoticeVO();
		vo.setKeyword(noticeValidator.escape(keyword));

		vo.setManagerYn("Y");
		// vo.setPageid(0);//get certain page start

		List<NoticeVO> listAll = service.list(vo); // list all
		vo.setPageid(page);// get certain page start
		vo.setByPage("Y");
		List<NoticeVO> searchList = service.list(vo);
		// List<NoticeVO> searchListByPage = service.searchListByPage(vo);

		model.addAttribute("keyword", keyword);
		model.addAttribute("notice", searchList);
		model.addAttribute("listCount", pagination(listAll, total));
		model.addAttribute("totalRows", listAll.size());
		model.addAttribute("currentPage", page);
		model.addAttribute("page", pageInUrl);
		
		if(!keyword.equals("")) {
			model.addAttribute("queryString", "&page="+pageInUrl+"&keyword="+keyword);
			model.addAttribute("urlParam", "&keyword="+keyword);
		}else {
			model.addAttribute("queryString", "&page="+pageInUrl);
		}
		
		
		return "notice/listMgr";
	}

	// another list function but using POST - this is only called when using delete
	// selected posts (through checkbox)
	// 사용자 page has no delete selected so this is not needed in user page
	@RequestMapping(value ="/notice/mList.do", method = RequestMethod.POST)
	public String managerListPost(HttpServletRequest request, Model model,RedirectAttributes rttr) throws Exception {

		logger.info("관리자 목록 페이지");

		// max number of posts shown in a page
		int total = 10;
		int pageInUrl = Integer.parseInt(request.getParameter("page"));

		int page = pageInUrl;
		if (page <= 1) {
			page = 0;
		} else {
			page = (page - 1) * total;
		}
		
		// delete selected section only for POST
		int size = 0;
		if (request.getParameter("listLength") != null) {
			size = Integer.parseInt(request.getParameter("listLength"));
		}

		int id = 0;

		for (int i = 0; i < size; i++) {
			if (request.getParameter("no_" + i) != null) {
				id = Integer.parseInt(request.getParameter("no_" + i));
			}

			if (id > 0) {
				service.delete(id);

			}

		}
		/////////////

		// search function
		String keyword = Objects.toString(request.getParameter("keyword"), "").trim();

		if(pageInUrl > 0) 
			rttr.addAttribute("page", pageInUrl);
		
		if(!keyword.equals("")) {

			rttr.addAttribute("keyword", keyword);
		}
		
		return "redirect:/notice/mList.do";
	}

	@RequestMapping(value = "/notice/write.do", method = RequestMethod.GET)
	public String write() throws Exception {
		logger.info("/notice/write 입니다. GET방식");
		return "notice/form";
	}

	@RequestMapping(value = { "/notice/write.do", "board/notice/write.do" }, method = RequestMethod.POST)
	public String writePost(NoticeVO notice, RedirectAttributes rttr) throws Exception {
		logger.info("/notice/write POST방식 입니다.");
		logger.info(notice.toString());

		// server side validation
		Map<String, String> errors = noticeValidator.validate(notice);
		if (errors.isEmpty()) {
			service.insert(notice);
			rttr.addFlashAttribute("msg", "성공");
		} else {
			rttr.addFlashAttribute("msg", "ERROR");
		}

		return "redirect:/notice/mList.do";
	}

	@RequestMapping(value = { "/notice/edit.do", "board/notice/edit.do" }, method = RequestMethod.POST)
	public String editPost(HttpServletRequest request,NoticeVO notice, RedirectAttributes rttr) throws Exception {
		logger.info("/notice/edit POST방식 입니다.");
		logger.info(notice.toString());
		if (notice.getNo() > 0) {
			// server side validation
			Map<String, String> errors = noticeValidator.validate(notice);
			if (errors.isEmpty()) {
				service.update(notice);
				rttr.addFlashAttribute("msg", "성공");
			} else {
				rttr.addFlashAttribute("msg", "ERROR");
			}

		} else {
			rttr.addFlashAttribute("msg", "Fail");
		}

		String keyword = Objects.toString(request.getParameter("keyword"), "").trim();
		int pageInUrl = Integer.parseInt(request.getParameter("page"));

		if(pageInUrl > 0) 
			rttr.addAttribute("page", pageInUrl);
		
		if(!keyword.equals("")) {

			rttr.addAttribute("keyword", keyword);
		}
		
		
		
		
		return "redirect:/notice/mList.do";
	}

	@RequestMapping(value = "/notice/edit.do", method = RequestMethod.GET)
	public String edit(@RequestParam("no") int no, @RequestParam(value = "page", required = false) Integer page,
			 @RequestParam(value = "keyword", required = false) String keyword, Model model) throws Exception {

		logger.info("글 번호" + no + "번의 수정 페이지");

		model.addAttribute("notice", service.select(no));
		
		keyword =Objects.toString(keyword, "").trim();
		page = page == null ? 1 : page;

		model.addAttribute("page", page);
		model.addAttribute("keyword", keyword);
		return "notice/form";
	}

	@RequestMapping(value = "/notice/mDetail.do", method = RequestMethod.GET)
	public String managerDetail(@RequestParam("no") int no, @RequestParam(value = "page", required = false) Integer page,
			 @RequestParam(value = "keyword", required = false) String keyword, Model model, NoticeVO notice) throws Exception {

		logger.info("글 번호" + no + "번의 상세내용 페이지");

		model.addAttribute("notice", service.select(no));
		int pageInUrl = page == null || page < 1 ? 1: page;
		model.addAttribute("page", pageInUrl);
		keyword =  Objects.toString(keyword, "").trim();
		if(!keyword.equals("")) {
			model.addAttribute("queryString", "&page="+pageInUrl+"&keyword="+keyword);
			model.addAttribute("urlParam", "&keyword="+keyword);
		}else {
			model.addAttribute("queryString", "&page="+pageInUrl);
		}
		return "notice/detailMgr";
	}

	@RequestMapping(value = "/notice/delete.do", method = RequestMethod.GET)
	public String delete(@RequestParam("no") int no, @RequestParam(value = "page", required = false) Integer page,
			 @RequestParam(value = "keyword", required = false) String keyword, RedirectAttributes rttr) throws Exception {

		logger.info("글 번호" + no + "번의 삭제");

		service.delete(no);

		rttr.addFlashAttribute("msg", "삭제");
		int pageInUrl =  page == null || page < 1 ? 1: page;

//		/String keyword =Objects.toString(keyword, "").trim();
		if(pageInUrl > 0) 
			rttr.addAttribute("page", pageInUrl);
		
		keyword =  Objects.toString(keyword, "").trim();
		if(!keyword.equals("")) 
			rttr.addAttribute("keyword", Objects.toString(keyword, "").trim());
			//model.addAttribute("urlParam", "&keyword="+keyword);
		
		
		return "redirect:/notice/mList.do";
	}

	/**
	 * 사용자
	 *
	 */
	@RequestMapping(value = { "/notice/list.do" }, method = RequestMethod.GET)
	public String list(@RequestParam(value = "page", required = false) Integer page, HttpServletRequest request,
			Model model) throws Exception {

		logger.info("사용자 목록 페이지");

		// max number of posts shown in a page
		int total = 10;
		int pageInUrl = page == null || page < 1 ? 1: page;

		if (page == null) {
			page = 0;
		} else {
			if (page == 1 || page < 1) {
				page = 0;
			} else {
				page = (page - 1) * total;
			}
		}

		// search function
		String keyword = Objects.toString(request.getParameter("keyword"), "").trim();

		// value object
		NoticeVO vo = new NoticeVO();
		vo.setKeyword(noticeValidator.escape(keyword));
		vo.setPageid(0);

		List<NoticeVO> listAll = service.list(vo); // list all
		vo.setPageid(page);// get certain page start
		vo.setByPage("Y");
		List<NoticeVO> searchList = service.list(vo);
		// List<NoticeVO> searchListByPage = service.searchListByPage(vo);

		model.addAttribute("keyword", keyword);
		model.addAttribute("notice", searchList);
		model.addAttribute("listCount", pagination(listAll, total));
		model.addAttribute("totalRows", listAll.size());
		model.addAttribute("currentPage", page);
		model.addAttribute("page", pageInUrl);
		
		if(!keyword.equals("")) {
			model.addAttribute("queryString", "&page="+pageInUrl+"&keyword="+keyword);
			model.addAttribute("urlParam", "&keyword="+keyword);
		}else {
			model.addAttribute("queryString", "&page="+pageInUrl);
		}
		return "notice/list";
	}

	@RequestMapping(value = "/notice/detail.do", method = RequestMethod.GET)
	public String detail(@RequestParam("no") int no, Model model, NoticeVO notice) throws Exception {

		logger.info("글 번호" + no + "번의 상세내용 페이지");

		service.updateCount(notice);

		model.addAttribute("notice", service.select(no));
		return "notice/detail";
	}

	/**
	 * 공통
	 *
	 */
	// returns the number of pages
	public Integer pagination(List<NoticeVO> list, int total) throws Exception {
		Integer listSize = list.size();
		int pages = listSize / total;
		// get remainder of list size and max total posts. if greater than 1, then add
		// another page
		if (listSize < total) {
			return 1;
		} else {
			if ((listSize % total) >= 1)
				return pages + 1;
			else {
				return (int) Math.ceil(pages);
			}

		}

	}
	
	@RequestMapping(value = "/notice/error.do", method = RequestMethod.GET)
	public String error(Model model, NoticeVO notice) throws Exception {

		return "notice/error";
	}

	// handles the exception
	@ExceptionHandler(MethodArgumentTypeMismatchException.class)
	public String handleTypeMismatch(MethodArgumentTypeMismatchException ex) {
		String name = ex.getName();
		String type = ex.getRequiredType().getSimpleName();
		Object value = ex.getValue();
		String message = String.format("'%s' should be a valid '%s' and '%s' isn't", name, type, value);

		System.out.println(message);
		// Do the graceful handling
		return "redirect:/notice/error.do";
	}
	
}
