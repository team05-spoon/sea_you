package com.sea_you.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.sea_you.dto.MessageDTO;

@Mapper
public interface MessageDAO {

	public int writeDao(MessageDTO dto);
	public List<MessageDTO> listDao(int m_no);
	public List<MessageDTO> sendlistDao(int m_no);
	public MessageDTO viewDao(int ms_no);
    public int updateDao(@Param("m_no") int m_no, @Param("ms_no") int ms_no);
    public int deleteDao(@Param("ms_no") int ms_no, @Param("type") String type);
    public Integer getMnoById(@Param("nick") String nick);
    public int getUnreadCount(@Param("m_no") int m_no);
	
}

