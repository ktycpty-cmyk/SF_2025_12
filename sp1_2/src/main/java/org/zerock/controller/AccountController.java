package org.zerock.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.zerock.dto.AccountDTO;
import org.zerock.service.AccountService;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;

@Controller
@Log4j2
@RequestMapping("/account")
@RequiredArgsConstructor
public class AccountController {

	private final AccountService accountService;

	@GetMapping("/login")
	public void loginGET() {
		log.info("-----------loginGET-------------");
	}

	@GetMapping("/join")
	public void joinGET() {
		log.info("-----------joinGET-------------");
	}

	@PostMapping("/join")
	public String joinPOST(AccountDTO accountDTO, org.springframework.web.servlet.mvc.support.RedirectAttributes rttr) {
		log.info("-----------joinPOST-------------");
		log.info(accountDTO);

		// 중복 체크
		if (accountService.get(accountDTO.getUid()) != null) {
			rttr.addAttribute("error", "duplicate");
			return "redirect:/account/join";
		}

		accountService.register(accountDTO);

		return "redirect:/account/login";
	}
}
