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

class UserTest {
	private static EntityManagerFactory emf;
	private EntityManager em;
	private User user;

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
		user = em.find(User.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		user = null;
	}

	@Test
	void test_User_Has_Username() {
		assertNotNull(user);
		assertEquals("blake", user.getUsername());

	}

	@Test
	void test_User_Has_Content() {
		assertNotNull(user);
		assertTrue(user.getUserContent().size() > 0);

	}

	@Test
	void test_User_Has_ContentVotes() {
		assertNotNull(user);
		assertTrue(user.getContentVotes().size() > 0);

	}
	
	@Test
	void test_User_has_ContentComments() {
		List<ContentComment> userComments = user.getUserComments();
		assertNotNull(userComments);
		assertTrue(userComments.size() > 0);
	}

}
