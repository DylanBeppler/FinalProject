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

class ImageUrlTest {
	private static EntityManagerFactory emf;
	private EntityManager em;
	private ImageUrl imageUrl;

	
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
		imageUrl = em.find(ImageUrl.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		imageUrl = null;
	}

	@Test
	void test_ImageUrl_Has_ImageUrlname() {
		assertNotNull(imageUrl);
		assertEquals("caption", imageUrl.getCaption());
		
	}
	
	@Test
	void test_ImageUrl_Has_Content() {
		Content content = imageUrl.getContent();
		assertNotNull(content);
		assertTrue(content.getName().equals("mount"));	
	}
	
}
