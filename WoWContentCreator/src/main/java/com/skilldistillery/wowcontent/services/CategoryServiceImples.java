package com.skilldistillery.wowcontent.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.wowcontent.entities.ContentCategory;
import com.skilldistillery.wowcontent.repositories.CategoryRepository;


@Service
public class CategoryServiceImples implements CategoryService {
	
	@Autowired
	private CategoryRepository categoryRepo;

	@Override
	public List<ContentCategory> index() {
		return categoryRepo.findAll();
	}

}
