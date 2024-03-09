package com.skilldistillery.wowcontent.controllers;

import java.security.Principal;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.wowcontent.entities.Content;
import com.skilldistillery.wowcontent.entities.ContentVote;
import com.skilldistillery.wowcontent.services.ContentService;
import com.skilldistillery.wowcontent.services.ContentVoteService;

import jakarta.servlet.http.HttpServletResponse;


@CrossOrigin({"*", "http://localhost/"})
@RequestMapping("api")
@RestController
public class ContentVoteController {
@Autowired 
private ContentVoteService voteService;
@Autowired
private ContentService contentService;

	@GetMapping("content/{content_id}/votes")
	public List <ContentVote> showVotesByContentId(@PathVariable("contentId") int contentId, HttpServletResponse resp) {
		Content content = contentService.showContentById(contentId);
		List <ContentVote> contentVote = 
	}
	
	
	 @PostMapping("{contentId}/votes")
	    public ResponseEntity<ContentVote> create(@PathVariable int contentId, @RequestBody ContentVote vote, String username) {
	        ContentVote createdVote = voteService.create(username, contentId, vote);
	        if (createdVote != null) {
	            return ResponseEntity.status(HttpStatus.CREATED).body(createdVote);
	        }
	        return ResponseEntity.badRequest().build();
	    }
	
	
}
