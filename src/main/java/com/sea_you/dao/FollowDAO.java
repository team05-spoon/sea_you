package com.sea_you.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.sea_you.dto.MemberDTO;

@Mapper
public interface FollowDAO {

	public void follow(@Param("follower_no") int followerNo, @Param("following_no") int followingNo);
	public void unfollow(@Param("follower_no") int followerNo, @Param("following_no") int followingNo);
    public int checkFollow(@Param("follower_no") int followerNo, @Param("following_no") int followingNo);
    public int getFollowerCount(int m_no);
    public int getFollowingCount(int m_no);
    public List<MemberDTO> getFollowerList(int m_no);
    public List<MemberDTO> getFollowingList(int m_no);
}
