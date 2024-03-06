package com.skilldistillery.wowcontent.services;

import java.util.List;

import com.skilldistillery.wowcontent.entities.Content;


public interface ContentService {
	
	public List <Content> index(); 
	
	public List <Content> showAllUserContent(String userName);
	
	public Content showContentById(int contentId);
	
    public Content create(String userName, Content content);

    public Content update(String userName, int contentId, Content content);

    public boolean destroy(String userName, int contentId);
	
	
}
