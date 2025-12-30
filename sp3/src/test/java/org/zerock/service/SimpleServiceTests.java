package org.zerock.service;

import static org.junit.jupiter.api.Assertions.*;

import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringExtension;

import org.zerock.dto.SimpleDTO;

import lombok.extern.log4j.Log4j2;



@ExtendWith(SpringExtension.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j2
class SimpleServiceTests {
	
	@Autowired
	private SimpleService simpleService;
	
	@Test
	void testList() {
		simpleService.getList()
		.forEach(todo-> log.info(todo));
		
	}
	
	@Test
	void testInsert() {
		SimpleDTO dto = SimpleDTO.builder()
				.title("피곤")
				.description("이불 밖은 위험해")
				.done(false)
				.build();
				
		
		simpleService.insert(dto);
		
		assertNotNull(dto.getId());
	}
	
	@Test
	void testMemberById() {
		SimpleDTO dto = simpleService.simpleByID(1);
		
		log.info(dto);
	}
	
	@Test
	void testUpdate() {
		SimpleDTO dto = SimpleDTO.builder()
				.title("만두전골")
				.description("먹고싶다")
				.done(false)
				.id(8)
				.build();
				
		
		simpleService.update(dto);
		log.info(simpleService.simpleByID(1));
	}
	
	@Test
	void testDelete() {
		simpleService.delete(4);
	}
	

}
