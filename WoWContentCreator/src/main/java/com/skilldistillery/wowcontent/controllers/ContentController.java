package com.skilldistillery.wowcontent.controllers;

import java.security.Principal;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.wowcontent.entities.Content;
import com.skilldistillery.wowcontent.services.ContentService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@CrossOrigin({"*", "http://localhost/"})
@RequestMapping("api")
@RestController
public class ContentController {
	
	@Autowired
	ContentService contentService;
	
	@GetMapping("content")
	public List<Content> index() {
		return contentService.index();
	}
	
	@GetMapping("content/my_content")
	public List<Content> getAllContentByUsername(Principal principal) {
		return contentService.showAllUserContent(principal.getName());
	}
	
	@GetMapping("content/{contentId}")
	public Content showContentById(@PathVariable("contentId") int contentId, HttpServletResponse resp) {
		Content content = contentService.showContentById(contentId);
		if (content != null) {
			return content;
		}
		resp.setStatus(404);
		return null;
	}
	
	@PostMapping("content")
	public Content createContent(Principal principal, @RequestBody Content content, HttpServletRequest req, HttpServletResponse resp) {
		try {
			content = contentService.create(principal.getName(), content);
			if (content != null) {
				resp.setStatus(201);
				resp.setHeader("Location", req.getRequestURL().append("/").append(content.getId()).toString());
			}
		} catch (Exception e) {
			resp.setStatus(400);
			e.printStackTrace();
			content = null;
		}
		return content;
	}
	
	@PutMapping("content/{contentId}")
	public Content updateContent(Principal principal, @RequestBody Content content, @PathVariable("contentId") int contentId, HttpServletResponse resp) {
		try {
			content = contentService.update(principal.getName(), contentId, content);
			if (content != null) {
				resp.setStatus(201);
			}
		} catch (Exception e) {
			resp.setStatus(400);
			e.printStackTrace();
			content = null;
		}
		return content;
	}
	
	@DeleteMapping("content/{contentId}")
	public void destroy(Principal principal, @PathVariable("contentId") int contentId, HttpServletResponse resp) {
		try {
			boolean success = contentService.destroy(principal.getName(), contentId);
			if (success) {
				resp.setStatus(204);
			} else {
				resp.setStatus(404);
			}
		} catch (Exception e) {
			resp.setStatus(400);
			e.printStackTrace();
		}
	}
	

}
