package com.skilldistillery.wowcontent.entities;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Objects;

import org.hibernate.annotations.CreationTimestamp;

import com.fasterxml.jackson.annotation.JsonIgnore;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;

@Entity
public class User {

	public User() {
	}

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;

	private String username;
	private String password;
	private String email;
	private boolean enabled;
	private String role;
	private String battletag;

	@Column(name = "about_me")
	private String aboutMe;

	@Column(name = "avatar_url")
	private String avatarUrl;

	@CreationTimestamp
	@Column(name = "last_updated")
	private LocalDateTime lastUpdated;

	@CreationTimestamp
	@Column(name = "join_date")
	private LocalDateTime joinDate;

	@JsonIgnore
	@OneToMany(mappedBy = "user")
	private List<Content> userContent;

	@JsonIgnore
	@OneToMany(mappedBy = "user")
	private List<ContentComment> userComments;

	@JsonIgnore
	@OneToMany(mappedBy = "user")
	private List<ContentVote> contentVotes;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public boolean isEnabled() {
		return enabled;
	}

	public void setEnabled(boolean enabled) {
		this.enabled = enabled;
	}

	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}

	public String getAboutMe() {
		return aboutMe;
	}

	public void setAboutMe(String aboutMe) {
		this.aboutMe = aboutMe;
	}

	public String getAvatarUrl() {
		return avatarUrl;
	}

	public void setAvatarUrl(String avatarUrl) {
		this.avatarUrl = avatarUrl;
	}

	public LocalDateTime getLastUpdated() {
		return lastUpdated;
	}

	public void setLastUpdated(LocalDateTime lastUpdated) {
		this.lastUpdated = lastUpdated;
	}

	public LocalDateTime getJoinDate() {
		return joinDate;
	}

	public void setJoinDate(LocalDateTime joinDate) {
		this.joinDate = joinDate;
	}

	public String getBattletag() {
		return battletag;
	}

	public void setBattletag(String battletag) {
		this.battletag = battletag;
	}

	public List<Content> getUserContent() {
		return userContent;
	}

	public void setUserContent(List<Content> userContent) {
		this.userContent = userContent;
	}

	public List<ContentComment> getUserComments() {
		return userComments;
	}

	public void setUserComments(List<ContentComment> userComments) {
		this.userComments = userComments;
	}

	public List<ContentVote> getContentVotes() {
		return contentVotes;
	}

	public void setContentVotes(List<ContentVote> contentVotes) {
		this.contentVotes = contentVotes;
	}

	@Override
	public int hashCode() {
		return Objects.hash(id);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		User other = (User) obj;
		return id == other.id;
	}

	@Override
	public String toString() {
		return "User [id=" + id + ", username=" + username + ", password=" + password + ", email=" + email
				+ ", enabled=" + enabled + ", role=" + role + ", battletag=" + battletag + ", aboutMe=" + aboutMe
				+ ", avatarUrl=" + avatarUrl + ", lastUpdated=" + lastUpdated + ", joinDate=" + joinDate + "]";
	}

}
