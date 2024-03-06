package com.skilldistillery.wowcontent.entities;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.util.List;

import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

class ContentTest {
	private static EntityManagerFactory emf;
	private EntityManager em;
	private Content content;

	
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
		content = em.find(Content.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		content = null;
	}

	@Test
	void test_Content_has_basic_mappings() {
		assertNotNull(content);
		assertEquals("mount", content.getName());
		assertEquals("mount description", content.getDescription());
	}
	
	@Test
	void test_Content_has_User() {
		User user = content.getUser();
		assertNotNull(user);
		assertEquals("blake", user.getUsername());
	}
	
	@Test
	void test_Content_has_ContentVotes() {
		List<ContentVote> contentVotes = content.getContentVotes();
		assertNotNull(contentVotes);
		assertTrue(contentVotes.size() > 0);
	}
	
	@Test
	void test_Content_has_ContentComments() {
		List<ContentComment> contentComments = content.getContentComments();
		assertNotNull(contentComments);
		assertTrue(contentComments.size() > 0);
	}
	
	@Test
	void test_Content_has_ContentCategory() {
		ContentCategory contentCategory = content.getContentCategory();
		assertNotNull(contentCategory);
		assertTrue(contentCategory.getName().equals("Quest"));
	}
	
	@Test
	void test_Content_has_ImageUrls() {
		List<ImageUrl> imageUrls = content.getImageUrls();
		assertNotNull(imageUrls);
		assertTrue(imageUrls.size() > 0);
	}
}
