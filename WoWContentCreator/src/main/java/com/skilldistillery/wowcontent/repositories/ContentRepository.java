package com.skilldistillery.wowcontent.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.wowcontent.entities.Content;

public interface ContentRepository extends JpaRepository <Content, Integer> {
	List<Content>findByUser_Username(String username);
	Content findByUser_UsernameAndId(String username, int contentId);
	boolean existsByUser_UsernameAndId(String username, int contentId);
	
}
