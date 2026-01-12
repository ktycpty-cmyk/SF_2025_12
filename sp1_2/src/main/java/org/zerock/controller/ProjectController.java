package org.zerock.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.dto.ProjectDTO;
import org.zerock.dto.ProjectListPaginDTO;
import org.zerock.service.ProjectService;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;

@Controller
@Log4j2
@RequestMapping("/project")
@RequiredArgsConstructor
public class ProjectController {

	// 생성자 주입(DI) , @RequiredArgsConstructor 의해서
	private final ProjectService projectService;

	@Autowired
	private ProjectService service;

	/*
	 * //localhost:8080/board/ex1 -> /WEB-INF/ views / board / ex1.jsp
	 * 
	 * @GetMapping("/ex1")
	 * void ex1() {
	 * 
	 * }
	 */

	// localhost:8080/board/list
	// -> /WEB-INF/ views / board / list.jsp
	@GetMapping("/dashboard")
	public void dashboard() {
		log.info("Project Dashboard...");
	}

	@GetMapping("/list")
	public void list(
			@RequestParam(name = "page", defaultValue = "1") int page,
			@RequestParam(name = "size", defaultValue = "10") int size,
			@RequestParam(name = "types", required = false) String types,
			@RequestParam(name = "keyword", required = false) String keyword,
			@RequestParam(name = "category", defaultValue = "CODING") String category,
			Model model, Authentication authentication) {

		log.info("---------------------------------------");
		ProjectListPaginDTO list = projectService.getList(page, size, types, keyword, category);

		model.addAttribute("dto", list);

	}

	// 등록 화면
	@PreAuthorize("isAuthenticated()")
	@GetMapping("/register")
	public void register() {
		log.info("board register");
	}

	// 등록 처리
	@PostMapping("/register")
	public String registerPost(Authentication authentication, ProjectDTO dto, RedirectAttributes rttr) {

		// 게시글 등록하면 등록된 번호를 반환
		Long bno = projectService.register(dto);

		rttr.addFlashAttribute("result", bno);
		rttr.addAttribute("category", dto.getCategory());

		return "redirect:/project/list";
	}

	// 단건 조회 localhost:8080/board/read/12
	// db에서 1번 데이타 보여주세요
	// -> /WEB-INF/ views / board / read.jsp
	@PreAuthorize("isAuthenticated()")
	@GetMapping("/read/{bno}")
	public String read(@PathVariable("bno") Long bno,
			@RequestParam(name = "page", defaultValue = "1") int page,
			@RequestParam(name = "size", defaultValue = "10") int size,
			@RequestParam(name = "types", required = false) String types,
			@RequestParam(name = "keyword", required = false) String keyword,
			@RequestParam(name = "category", defaultValue = "CODING") String category,
			Model model) {

		ProjectDTO dto = projectService.read(bno);

		model.addAttribute("project", dto);
		model.addAttribute("page", page);
		model.addAttribute("size", size);
		model.addAttribute("types", types);
		model.addAttribute("keyword", keyword);
		model.addAttribute("category", category);

		return "/project/read";

	}

	/*
	 * 수정 폼
	 * localhost:8080/board/modify/1
	 */
	@GetMapping("/modify/{bno}")
	public String modifyGet(@PathVariable("bno") Long bno,
			@RequestParam(name = "page", defaultValue = "1") int page,
			@RequestParam(name = "size", defaultValue = "10") int size,
			@RequestParam(name = "types", required = false) String types,
			@RequestParam(name = "keyword", required = false) String keyword,
			@RequestParam(name = "category", defaultValue = "CODING") String category,
			Model model) {

		ProjectDTO dto = projectService.read(bno);
		model.addAttribute("project", dto);
		model.addAttribute("page", page);
		model.addAttribute("size", size);
		model.addAttribute("types", types);
		model.addAttribute("keyword", keyword);
		model.addAttribute("category", category);

		return "project/modify";
	}

	@PreAuthorize("principal.username == #dto.writer or hasRole('ROLE_ADMIN')")
	@PostMapping("/modify")
	public String modifyPost(@ModelAttribute ProjectDTO dto, RedirectAttributes rttr) {

		projectService.modify(dto);

		rttr.addAttribute("category", dto.getCategory());

		return "redirect:/project/read/" + dto.getBno();
	}

	/*
	 * 삭제
	 * localhost:8080/board/remove
	 */
	@PreAuthorize("principal.username == #writer or hasRole('ROLE_ADMIN')")
	@PostMapping("/remove")
	public String remove(@RequestParam("bno") Long bno,
			@RequestParam("writer") String writer,
			@RequestParam("category") String category,
			RedirectAttributes rttr) {

		projectService.remove(bno);

		rttr.addFlashAttribute("result", bno);
		rttr.addAttribute("category", category);

		return "redirect:/project/list";
	}
}
