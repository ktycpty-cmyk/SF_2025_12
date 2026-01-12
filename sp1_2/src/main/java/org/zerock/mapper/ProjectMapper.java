package org.zerock.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.zerock.dto.ProjectDTO;

public interface ProjectMapper {

	int insert(ProjectDTO dto);

	ProjectDTO selectOne(Long bno);

	int remove(Long bno);

	int update(ProjectDTO dto);

	List<ProjectDTO> list();

	List<ProjectDTO> list2(@Param("skip") int skip, @Param("count") int count);

	int listCount();

	/*
	 * T, C, W
	 * types : TCW -> T|C|W
	 * keyword : 스프링 검색
	 */
	List<ProjectDTO> listSearch(@Param("skip") int skip,
			@Param("count") int count,
			@Param("types") String[] types,
			@Param("keyword") String keyword,
			@Param("category") String category);

	int listCountSearch(
			@Param("types") String[] types,
			@Param("keyword") String keyword,
			@Param("category") String category);
}
