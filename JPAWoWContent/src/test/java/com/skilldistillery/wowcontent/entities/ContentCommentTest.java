package com.skilldistillery.wowcontent.entities;

import static org.junit.jupiter.api.Assertions.*;

import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

class ContentCommentTest {
	private static EntityManagerFactory emf;
	private EntityManager em;
	private ContentComment contentComment;

	
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
		contentComment = em.find(ContentComment.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		contentComment = null;
	}

	@Test
	void test_ContentComment_Has_basic_mappings() {
		assertNotNull(contentComment);
		assertEquals("test", contentComment.getMessage());
		
	}
	
	@Test
	void test_ContentComment_has_User() {
		User user = contentComment.getUser();
		assertNotNull(user);
		assertEquals("blake", user.getUsername());
	}
	
	@Test
	void test_ContentComment_has_Content() {
		Content content = contentComment.getContent();
		assertNotNull(content);
		assertEquals("mount", content.getName());
	}
	
}
