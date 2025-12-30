package org.zerock.service;

import static org.junit.jupiter.api.Assertions.*;

import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringExtension;
import org.zerock.dto.MemberDTO;


import lombok.extern.log4j.Log4j2;



@ExtendWith(SpringExtension.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j2
class MemberServiceTests {
	
	@Autowired
	private MemberService memberService;
	@Test
	void testList() {
		memberService.getList()
		.forEach(member-> log.info(member));
	}
	
	@Test
	void testInsert() {
		MemberDTO dto = MemberDTO.builder()
				.name("작가")
				.email("rsc@naver.com")
				.password("1234")
				.build();
		
		memberService.insert(dto);
		
		assertNotNull(dto.getMno());
	}
	
	@Test
	void testMemberById() {
		MemberDTO dto = memberService.memberById(1);
		
		log.info(dto);
	}
	
	@Test
	void testUpdate() {
		MemberDTO dto = MemberDTO.builder()
				.name("청자")
				.password("2222")
				.email("react@test.com")
				.mno(1)
				.build();
		
		memberService.update(dto);
		log.info(memberService.memberById(1));
	}
	
	@Test
	void testDelete() {
		memberService.delete(4);
	}
	

}
