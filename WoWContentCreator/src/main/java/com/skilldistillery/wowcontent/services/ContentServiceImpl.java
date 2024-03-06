package com.skilldistillery.wowcontent.services;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.wowcontent.entities.Content;
import com.skilldistillery.wowcontent.entities.User;
import com.skilldistillery.wowcontent.repositories.ContentRepository;
import com.skilldistillery.wowcontent.repositories.UserRepository;


@Service
public class ContentServiceImpl implements ContentService {
	@Autowired
	private ContentRepository contentRepo;
	@Autowired
	private UserRepository userRepo;
	
	
	@Override
	public List<Content> index() {
		return contentRepo.findAll();
	}

	@Override
	public List<Content> showAllUserContent(String userName) {
		return contentRepo.findByUser_Username(userName);
	}

	@Override
	public Content create(String userName, Content content) {
		User user = userRepo.findByUsername(userName);
		if (user != null) {
			content.setUser(user);
			return contentRepo.saveAndFlush(content);
		}
		return null;
	}

	@Override
	public Content update(String userName, int contentId, Content content) {
		Content managedContent = contentRepo.findByUser_UsernameAndId(userName, contentId);
		if(managedContent !=null) {
			managedContent.setContentCategory(content.getContentCategory());
			managedContent.setContentComments(content.getContentComments());
			managedContent.setContentVotes(content.getContentVotes());
			managedContent.setLastUpdate(LocalDateTime.now());
			managedContent.setDescription(content.getDescription());
			managedContent.setEnabled(content.isEnabled());
			managedContent.setImageUrl(content.getImageUrl());
			return contentRepo.saveAndFlush(managedContent);
		}
		return null;
	}

	@Override
	public boolean destroy(String userName, int contentId) {
		boolean isDeleted = false;
		if (contentRepo.existsByUser_UsernameAndId(userName, contentId)) {
			contentRepo.deleteById(contentId);
			isDeleted = true;
		}
		return isDeleted;
	}

	@Override
	public Content showContentById(int contentId) {
		Optional<Content>contentOpt = contentRepo.findById(contentId);
		if(contentOpt.isPresent()) {
			return contentOpt.get();
		}
		return null;
	}

}
