package com.skilldistillery.wowcontent.entities;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;

import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

class ContentVoteTest {
	private static EntityManagerFactory emf;
	private EntityManager em;
	private ContentVote contentVote;

	
	@BeforeAll
	static void setUpBeforeClass() throws Exception {
		emf = Persistence.createEntityManagerFactory("JPAWoWContent");
	}

	@AfterAll
	static void tearDownAfterClass() throws Exception {
		emf.close();
	}

	@BeforeEach
	void setUp() throws Exception {
		em = emf.createEntityManager();
		contentVote = em.find(ContentVote.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		contentVote = null;
	}
	
	@Test
	void test_ContentVote_has_User() {
		User user = contentVote.getUser();
		assertNotNull(user);
		assertEquals("blake", user.getUsername());
	}
	@Test
	void test_ContentVote_has_Content() {
		Content content = contentVote.getContent();
		assertNotNull(content);
		assertEquals("mount", content.getName());
		assertEquals("mount description", content.getDescription());
	}

}
