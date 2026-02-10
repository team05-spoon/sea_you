package com.sea_you.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.sea_you.dto.MemberDTO;

@Mapper
public interface MemberDAO {

	public List<MemberDTO> listDao();
	public List<MemberDTO> mlistDao();
	public MemberDTO viewDao(int m_no);
	public int writeDao(MemberDTO dto);
	public int deleteDao(int m_no);
	public int deletememberDao(String m_nick);
	public int updateDao(MemberDTO dto);
	public MemberDTO findByMnick(String m_nick);
	public MemberDTO findByMno(int m_no);
	int getFollowerCount(int m_no);
	public List<java.util.Map<String, Object>> getTopFollowers();
	public int checkNick(String m_nick);
}
