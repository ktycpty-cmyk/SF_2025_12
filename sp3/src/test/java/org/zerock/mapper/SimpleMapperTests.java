package org.zerock.mapper;

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
class SimpleMapperTests {
	
	@Autowired
	private SimpleMapper simpleMapper;

	@Test
	void testInsert() {
		SimpleDTO dto = SimpleDTO.builder()
				.title("전골")
				.description("먹고 싶다")
				.done(false)
				.build();
		
		simpleMapper.insert(dto);
		
		assertNotNull(dto.getId());
	}
	
	@Test
	void testList() {
		simpleMapper.getList()
		.forEach(todo-> log.info(todo));
	}
	
	@Test
	void testSimpleById() {
		SimpleDTO dto = simpleMapper.simpleById(1);
		
		log.info(dto);
	}
	
	@Test
	void testUpdate() {
		SimpleDTO dto =SimpleDTO.builder()
				.title("사랑이")
				.description("발바닥 만지고 싶다")
				.done(false)
				.id(6)
				.build();
		simpleMapper.update(dto);
		log.info(simpleMapper.simpleById(6));
	}
	
	@Test
	void testDelete() {
		simpleMapper.delete(7);
	}

}
