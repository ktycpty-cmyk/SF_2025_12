package org.zerock.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.zerock.dto.ProjectDTO;
import org.zerock.dto.ProjectListPaginDTO;
import org.zerock.mapper.ProjectMapper;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;

@Service
@Log4j2
@RequiredArgsConstructor
public class ProjectService {

	private final ProjectMapper projectMapper;

	public List<ProjectDTO> getList() {
		log.info("-----------getList1-------------");
		return projectMapper.list();
	}

	// page :2, size : 10, typeStr = "TC", keyword: "수정", category: "CODING"
	public ProjectListPaginDTO getList(int page, int size,
			String typeStr, String keyword, String category) {

		log.info("-----------getList2-------------");
		page = page <= 0 ? 1 : page;

		// 해석?
		size = (size <= 10 || page > 100) ? 10 : size;

		int skip = (page - 1) * size;

		// typeStr = "TC" => typeStr.split("") -> T|C
		String[] types = (typeStr != null && !typeStr.isEmpty()) ? typeStr.split("") : null;

		List<ProjectDTO> list = projectMapper.listSearch(skip, size, types, keyword, category);

		int total = projectMapper.listCountSearch(types, keyword, category);

		return new ProjectListPaginDTO(list, total, page, size, typeStr, keyword, category);
	}

	public Long register(ProjectDTO dto) {

		int insertCounter = projectMapper.insert(dto);

		log.info("insertCounter : " + insertCounter);

		return dto.getBno();
	}

	public ProjectDTO read(Long bno) {

		log.info("-----------read------------------");
		return projectMapper.selectOne(bno);
	}

	public void remove(Long bno) {
		projectMapper.remove(bno);
	}

	public void modify(ProjectDTO dto) {
		projectMapper.update(dto);
	}

}
