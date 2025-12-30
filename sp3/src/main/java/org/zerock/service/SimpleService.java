package org.zerock.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.zerock.dto.SimpleDTO;
import org.zerock.mapper.SimpleMapper;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class SimpleService {
	
	private final SimpleMapper mapper;
	
	public List<SimpleDTO> getList(){
		return mapper.getList();
	}
	
	public SimpleDTO simpleByID(int id) {
		return mapper.simpleById(id);
	}
	
	public void update(SimpleDTO dto) {
		mapper.update(dto);
	}
	
	public void insert(SimpleDTO dto) {
		mapper.insert(dto);
	}
	
	public void delete(int id) {
		mapper.delete(id);
	}

}
