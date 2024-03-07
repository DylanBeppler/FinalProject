package com.skilldistillery.wowcontent.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.wowcontent.entities.Content;
import com.skilldistillery.wowcontent.entities.ContentCategory;

public interface CategoryRepository extends JpaRepository <ContentCategory, Integer> {
	
	List<ContentCategory>findAll();
	
}
