package com.team4.shoppingmall.notice;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/notice")
public class NoticeController {
	
	@Autowired
	NoticeService noticeService;
	
	@GetMapping("/notices")
	public String listNotices(@RequestParam(value = "query", required = false) String query,
			@RequestParam(value = "page", defaultValue = "1") int page, Model model) {

		List<NoticeDTO> notices = noticeService.selectAll();
		int itemsPerPage = 10;
		List<NoticeDTO> filteredNotices;

		if (query != null && !query.trim().isEmpty()) {
			
			filteredNotices = notices.stream().filter(notice -> notice.getNot_title().contains(query))
					.collect(Collectors.toList());
		} else {
			filteredNotices = new ArrayList<>(notices);
		}

		int totalPages = (int) Math.ceil((double) filteredNotices.size() / itemsPerPage);
		int start = (page - 1) * itemsPerPage;
		int end = Math.min(start + itemsPerPage, filteredNotices.size());
		List<NoticeDTO> pageNotices = filteredNotices.subList(start, end);

		model.addAttribute("notices", pageNotices);
		model.addAttribute("totalPages", totalPages);
		model.addAttribute("currentPage", page);
		model.addAttribute("query", query);

		return "board/notice";
	}
	
}