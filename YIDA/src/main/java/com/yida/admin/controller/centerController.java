package com.yida.admin.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class centerController {

	@GetMapping("/index.do")
	public String toIndex() {
		return "admin/index.jsp";
	}
}
