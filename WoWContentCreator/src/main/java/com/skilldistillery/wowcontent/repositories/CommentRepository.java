package com.skilldistillery.wowcontent.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.wowcontent.entities.Content;
import com.skilldistillery.wowcontent.entities.ContentCategory;
import com.skilldistillery.wowcontent.entities.ContentComment;

public interface CommentRepository extends JpaRepository <ContentComment, Integer> {
	
	List<ContentComment>findAll();
	List<ContentComment>findByUser_Username(String username);
	ContentComment findByUser_UsernameAndId(String username, int commentId);
	boolean existsByUser_UsernameAndId(String username, int commentId);
	
}
