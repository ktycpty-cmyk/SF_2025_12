package org.zerock.mapper;

import java.util.List;

import org.zerock.dto.SimpleDTO;

public interface SimpleMapper {
	
	void insert(SimpleDTO dto);
	
	List<SimpleDTO> getList();
	
	SimpleDTO simpleById(int id);
	
	void update(SimpleDTO dto);
	
	void delete(int id);

}
