package org.zerock.mapper;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.IntStream;

import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringExtension;
import org.zerock.dto.ProjectDTO;

import lombok.extern.log4j.Log4j2;

@ExtendWith(SpringExtension.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j2
public class ProjectMapperTests {

	@Autowired
	private ProjectMapper projectMapper;
	
	@Test
	public void testInsert() {
		
//		BoardDTO dto = new BoardDTO();
//		dto.setTitle("title");
//		dto.setContent("content");
//		dto.setWriter("user00");
		
		ProjectDTO dto = ProjectDTO.builder()
				.title("test2")
				.content("Spring Legacy Test")
				.writer("tester")				
				.build();
		
		int insertCount = projectMapper.insert(dto);
		log.info("-----------------------------");
		log.info("insertCount : " + insertCount);
		
		log.info("BNO : " + dto.getBno());
	}
	
	@Test
	public void testSelectOne() {
		ProjectDTO projectDTO = projectMapper.selectOne(1L);
		 
		 log.info("projectDTO : " + projectDTO);
	}
	
	@Test
	public void testDelete() {
		int result = projectMapper.remove(1L);
		
		log.info("result : " + result);
	}
	
	@Test
	public void testUpdate() {
		ProjectDTO dto = ProjectDTO.builder()
				.title("new test")
				.content("new Spring Legacy Test")
				.delFlag(false)
				.bno(1L)
				.build();
		
		int result = projectMapper.update(dto);
		log.info("result : " + result);
	}
	
	@Test
	public void testSelect() {
		
		//List<BoardDTO> list = boardMapper.list();		
		//for(BoardDTO dto : list)
		//	log.info(dto);
		
		
		projectMapper.list().forEach(dto->log.info(dto));
		
	}
	/*
	@Test
	public void testPagining() {
	
		int page =3;
		
		//계산
		int skip = (page - 1) * 10;
		int count = 10;
		
		projectMapper.list2(skip, count)
			.forEach(board-> log.info(board));
	}
	*/
	@Test
	public void testPagNums() {
		
//		IntStream.rangeClosed(1, 5).boxed().forEach(i -> log.info(i));
		List<Integer> list = IntStream.rangeClosed(1, 5).boxed().toList();
		log.info(list);
	}
	/*
	@Test
	public void testSearch() {
		int page= 2;
		
		int skip = (page -1) * 10;
		int count = 15;
		
		String[] types = new String[] {"T","C"};
		
//		List<String> types = new ArrayList<String>();
//		types.add("T");
//		types.add("C");		
		
		String keyword = "test";
		
		projectMapper.listSearch(skip, count, types, keyword);
	}
	*/
	
	/*
	@Test
	public void testCount() {
		
		
		String[] types = new String[] {"T","C"};				
		
		String keyword = "수정";
		
		int result = projectMapper.listCountSearch(types, keyword);
		log.info("전체 갯수 : " + result);
	}
	*/
}
