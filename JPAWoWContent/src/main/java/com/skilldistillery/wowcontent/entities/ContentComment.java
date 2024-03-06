package com.skilldistillery.wowcontent.entities;

import java.time.LocalDateTime;
import java.util.Objects;

import com.fasterxml.jackson.annotation.JsonIgnore;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;

@Entity
@Table(name = "content_comment")
public class ContentComment {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	
	@Column(name = "comment_date")
	private LocalDateTime commentDate;
	
	private String message;

	@ManyToOne
	@JoinColumn(name = "user_id")
	@JsonIgnore
	private User user;

	@ManyToOne
    @JoinColumn(name = "content_id")
	@JsonIgnore
	private Content content;
	
	@Column(name = "reply_to_id")
	private int replyToId;
	
	private boolean enabled;
	
	@Column(name = "image_url")
	private String imageUrl;
	
	@Column(name = "updated_date")
	private LocalDateTime updatedDate;

	public ContentComment() {
		super();
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public LocalDateTime getCommentDate() {
		return commentDate;
	}

	public void setCommentDate(LocalDateTime commentDate) {
		this.commentDate = commentDate;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public int getReplyToId() {
		return replyToId;
	}

	public void setReplyToId(int replyToId) {
		this.replyToId = replyToId;
	}

	public boolean isEnabled() {
		return enabled;
	}

	public void setEnabled(boolean enabled) {
		this.enabled = enabled;
	}

	public String getImageUrl() {
		return imageUrl;
	}

	public void setImageUrl(String imageUrl) {
		this.imageUrl = imageUrl;
	}

	public LocalDateTime getUpdatedDate() {
		return updatedDate;
	}

	public void setUpdatedDate(LocalDateTime updatedDate) {
		this.updatedDate = updatedDate;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public Content getContent() {
		return content;
	}

	public void setContent(Content content) {
		this.content = content;
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
		ContentComment other = (ContentComment) obj;
		return id == other.id;
	}

	@Override
	public String toString() {
		return "contentComment [id=" + id + ", commentDate=" + commentDate + ", message=" + message + ", user=" + user
				+ ", content=" + content + ", replyTo=" + replyToId + ", enabled=" + enabled + ", imageUrl=" + imageUrl
				+ ", updatedDate=" + updatedDate + "]";
	}

}