package com.skilldistillery.wowcontent.services;

import java.util.List;

import com.skilldistillery.wowcontent.entities.Content;
import com.skilldistillery.wowcontent.entities.ContentComment;


public interface CommentService {
	
	public List <ContentComment> index(); 
	public List <ContentComment> showAllUserComments(String userName);
	public List <ContentComment> showCommentsByContentId(int contentId);
    public ContentComment create(String userName, ContentComment contentComment, int contentId);
    public ContentComment update(String userName, int contentId, int commentId, ContentComment contentComment);
    public boolean destroy(String userName, int commentId);
	
	
}
