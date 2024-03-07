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
import com.skilldistillery.wowcontent.entities.ContentComment;
import com.skilldistillery.wowcontent.services.CommentService;
import com.skilldistillery.wowcontent.services.ContentService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@CrossOrigin({"*", "http://localhost/"})
@RequestMapping("api")
@RestController
public class CommentController {
	
	@Autowired
	CommentService commService;
	
	@Autowired
	ContentService contentService;
	
	@GetMapping("comments")
	public List<ContentComment> index() {
		return commService.index();
	}
	
	@GetMapping("comments/my_comments")
	public List<ContentComment> getAllCommentsByUsername(Principal principal) {
		return commService.showAllUserComments(principal.getName());
	}
	
	@GetMapping("content/{contentId}/comments")
	public List <ContentComment> showCommentByContentId(@PathVariable("contentId") int contentId, HttpServletResponse resp) {
		Content content = contentService.showContentById(contentId);
		List <ContentComment> contentComment  = commService.showCommentsByContentId(content.getId());
		if (contentComment != null) {
			return contentComment;
		}
		resp.setStatus(404);
		return null;
	}
	
	@PostMapping("content/{contentId}/comments")
	public ContentComment createComment(Principal principal, @RequestBody ContentComment contentComment, @PathVariable("contentId") int contentId, HttpServletRequest req, HttpServletResponse resp) {
		try {
			contentComment = commService.create(principal.getName(), contentComment, contentId);
			if (contentComment != null) {
				resp.setStatus(201);
				resp.setHeader("Location", req.getRequestURL().append("/").append(contentComment.getId()).toString());
			}
		} catch (Exception e) {
			resp.setStatus(400);
			e.printStackTrace();
			contentComment = null;
		}
		return contentComment;
	}
	
	@PutMapping("content/{contentId}/comments/{commentId}")
	public ContentComment updateComment(Principal principal, @RequestBody ContentComment contentComment, @PathVariable("contentId") int contentId, @PathVariable("commentId") int commentId, HttpServletResponse resp) {
		try {
			contentComment = commService.update(principal.getName(), contentId, commentId, contentComment);
			if (contentComment != null) {
				resp.setStatus(201);
			}
		} catch (Exception e) {
			resp.setStatus(400);
			e.printStackTrace();
			contentComment = null;
		}
		return contentComment;
	}	
	@DeleteMapping("content/{contentId}/comments/{commentId}")
	public void destroy(Principal principal, @PathVariable("contentId") int contentId, @PathVariable("commentId") int commentId, HttpServletResponse resp) {
		try {
			boolean success = commService.destroy(principal.getName(), contentId, commentId);
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
