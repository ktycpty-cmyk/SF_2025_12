package org.zerock.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.zerock.dto.SimpleDTO;
import org.zerock.service.SimpleService;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;

@Controller
@RequestMapping("/simple")
@Log4j2
@RequiredArgsConstructor
public class SimpleController {
	
	private final SimpleService service;
	
	@GetMapping("/list")
	public void list(Model model) {
		List<SimpleDTO> simpleList = service.getList();
		
		model.addAttribute("simpleList",simpleList);
	}
	
	@GetMapping("/register")
	public void registerGet() {
		log.info("register get");
	}
	
	@PostMapping("/register")
	public String registerPost(SimpleDTO dto) {
		service.insert(dto);
		return "redirect:/simple/list";
	}
	
	@GetMapping("/read/{id}")
	public String read(@PathVariable("id") int id, Model model) {
		
		SimpleDTO simple = service.simpleByID(id);
		model.addAttribute("simple",simple);
		
		return "/simple/read";
	}
	
	@PostMapping("/modify")
	public String modifyPost(SimpleDTO dto) {
		service.update(dto);
		return "redirect:/simple/list";
	}
	
	@PostMapping("/delete")
	public String deletePost(@RequestParam("id") int id) {
		service.delete(id);
		return "redirect:/simple/list";
	}
	

}
