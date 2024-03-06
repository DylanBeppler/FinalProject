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

class ContentCategoryTest {
	private static EntityManagerFactory emf;
	private EntityManager em;
	private ContentCategory contentCategory;

	
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
		contentCategory = em.find(ContentCategory.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		contentCategory = null;
	}

	@Test
	void test_User_Has_Username() {
		assertNotNull(contentCategory);
		assertEquals("Quest", contentCategory.getName());
		
	}
	
//	@Test
//	void test_User_Has_Quests() {
//		assertNotNull(user);
//		assertTrue(user.getQuests().size() > 0);	
//	}
}
