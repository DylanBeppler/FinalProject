package com.skilldistillery.wowcontent.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.wowcontent.entities.ContentVote;

public interface ContentVoteRepository extends JpaRepository<ContentVote, Integer> {
	ContentVote findByUser_UsernameAndContent_Id(String username, int contentId);
}
