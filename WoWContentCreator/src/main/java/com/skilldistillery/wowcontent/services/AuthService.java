package com.skilldistillery.wowcontent.services;

import com.skilldistillery.wowcontent.entities.User;

public interface AuthService {

	public User register(User user);
	public User getUserByUsername(String username);
	
}
