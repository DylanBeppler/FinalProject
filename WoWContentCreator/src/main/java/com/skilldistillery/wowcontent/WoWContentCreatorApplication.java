package com.skilldistillery.wowcontent;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;

@SpringBootApplication
public class WoWContentCreatorApplication {

	public static void main(String[] args) {
		SpringApplication.run(WoWContentCreatorApplication.class, args);
	}

	@Bean
	PasswordEncoder configurePasswordEncoder() {
		return new BCryptPasswordEncoder();
	}

}
