package org.zerock.controller;

import java.util.Map;

import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.zerock.dto.ReplyDTO;
import org.zerock.dto.ReplyListPaginDTO;
import org.zerock.service.ReplyService;
import org.zerock.service.exception.ReplyException;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;

@RestController
@RequiredArgsConstructor
@Log4j2
@RequestMapping("/replies")
public class ReplyController {

	private final ReplyService replyService;

	@ExceptionHandler(ReplyException.class)
	public ResponseEntity<String> handleReplyError(ReplyException ex) {

		log.error(ex.getMessage());

		return ResponseEntity.status(ex.getCode()).body(ex.getMsg());

	}

	@PostMapping("")
	public ResponseEntity<Map<String, Integer>> add(@RequestBody ReplyDTO replyDTO) {

		log.info("---------------add-----------------");
		log.info(replyDTO);

		replyService.add(replyDTO);

		return ResponseEntity.ok(Map.of("result", replyDTO.getRno()));
	}

	@GetMapping("/{bno}/list")
	public ResponseEntity<ReplyListPaginDTO> listOfBoard(
			@PathVariable("bno") Long bno,
			@RequestParam(name = "page", defaultValue = "1") int page,
			@RequestParam(name = "size", defaultValue = "10") int size) {

		ReplyListPaginDTO listOfBoard = replyService.listOfBoard(bno, page, size);

		log.info(listOfBoard);

		return ResponseEntity.ok(listOfBoard);

	}

	@GetMapping("/{rno}")
	public ResponseEntity<ReplyDTO> read(@PathVariable("rno") int rno) {

		return ResponseEntity.ok(replyService.getOne(rno));
	}

	@PreAuthorize("principal.username == #replyer or hasRole('ROLE_ADMIN')")
	@DeleteMapping("/{rno}")
	public ResponseEntity<Map<String, String>> delete(@PathVariable("rno") int rno,
			@RequestParam("replyer") String replyer) {

		log.info("delete rno : " + rno);

		replyService.remove(rno);

		return ResponseEntity.ok(Map.of("result", "deleted"));
	}

	@PreAuthorize("principal.username == #replyDTO.replyer or hasRole('ROLE_ADMIN')")
	@PutMapping("/{rno}")
	public ResponseEntity<Map<String, String>> modify(@PathVariable("rno") int rno,
			@RequestBody ReplyDTO replyDTO) {

		log.info("rno : " + rno);
		log.info("replyDTO : " + replyDTO);

		replyService.modify(replyDTO);

		return ResponseEntity.ok(Map.of("result", "modified"));
	}

}
