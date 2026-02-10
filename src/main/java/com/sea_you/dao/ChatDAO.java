package com.sea_you.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.sea_you.dto.ChatDTO;

@Mapper
public interface ChatDAO {

	public List<ChatDTO> listDao();
	public int writeDao(ChatDTO dto);
}
