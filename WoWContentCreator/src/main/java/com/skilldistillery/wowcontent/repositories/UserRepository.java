package com.skilldistillery.wowcontent.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.wowcontent.entities.User;

public interface UserRepository extends JpaRepository<User, Integer> {

	User findByUsername(String username);
	
}
