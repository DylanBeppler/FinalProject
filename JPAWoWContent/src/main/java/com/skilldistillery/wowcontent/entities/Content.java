package com.skilldistillery.wowcontent.entities;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Objects;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;

@Entity
public class Content {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;

	private String name;
	private String description;
	private boolean enabled;

	@Column(name = "image_url")
	private String imageUrl;

	@Column(name = "created_date")
	private LocalDateTime createdDate;

	@Column(name = "last_update")
	private LocalDateTime lastUpdate;

	@OneToMany(mappedBy = "content")
	@Column(name = "content_vote")
	private List<ContentVote> contentVotes;

	@ManyToOne
	@JoinColumn(name = "user_id")
	private User user;

	@OneToMany(mappedBy = "content")
	private List<ContentComment> contentComments;

	@ManyToOne
	@JoinColumn(name = "content_category_id")
	private ContentCategory contentCategory;

	@OneToMany(mappedBy = "content")
	private List<ImageUrl> imageUrls;

	public Content() {

	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getImageUrl() {
		return imageUrl;
	}

	public void setImageUrl(String imageUrl) {
		this.imageUrl = imageUrl;
	}

	public LocalDateTime getCreatedDate() {
		return createdDate;
	}

	public void setCreatedDate(LocalDateTime createdDate) {
		this.createdDate = createdDate;
	}

	public LocalDateTime getLastUpdate() {
		return lastUpdate;
	}

	public void setLastUpdate(LocalDateTime lastUpdate) {
		this.lastUpdate = lastUpdate;
	}

	public boolean isEnabled() {
		return enabled;
	}

	public void setEnabled(boolean enabled) {
		this.enabled = enabled;
	}

	public List<ContentVote> getContentVotes() {
		return contentVotes;
	}

	public void setContentVotes(List<ContentVote> contentVote) {
		this.contentVotes = contentVote;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public ContentCategory getContentCategory() {
		return contentCategory;
	}

	public void setContentCategory(ContentCategory contentCategory) {
		this.contentCategory = contentCategory;
	}

	public List<ContentComment> getContentComments() {
		return contentComments;
	}

	public void setContentComments(List<ContentComment> contentComments) {
		this.contentComments = contentComments;
	}

	public List<ImageUrl> getImageUrls() {
		return imageUrls;
	}

	public void setImageUrls(List<ImageUrl> imageUrls) {
		this.imageUrls = imageUrls;
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
		Content other = (Content) obj;
		return id == other.id;
	}

}
