package com.skilldistillery.wowcontent.services;

import java.util.List;

import com.skilldistillery.wowcontent.entities.ContentVote;

public interface ContentVoteService {
	List<ContentVote> index();
	ContentVote create(String username, int contentId, ContentVote vote);
	ContentVote update(String username, int contentId, int voteId, ContentVote vote);
}
