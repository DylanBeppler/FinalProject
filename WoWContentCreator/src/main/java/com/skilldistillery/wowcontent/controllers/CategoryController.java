package com.skilldistillery.wowcontent.controllers;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.wowcontent.entities.ContentCategory;
import com.skilldistillery.wowcontent.services.CategoryService;

@CrossOrigin({"*", "http://localhost/"})
@RequestMapping("api")
@RestController
public class CategoryController {
	
	@Autowired
	CategoryService categoryService;
	
	@GetMapping("categories")
	public List<ContentCategory> index() {
		return categoryService.index();
	}

}
