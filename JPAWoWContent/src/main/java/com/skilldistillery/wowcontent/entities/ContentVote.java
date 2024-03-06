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
@Table(name = "content_vote")
public class ContentVote {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;

	private Boolean upvoted;

	@Column(name = "vote_date")
	private LocalDateTime voteDate;

	@ManyToOne
	@JoinColumn(name = "user_id")
	@JsonIgnore
	private User user;

	@ManyToOne
	@JoinColumn(name = "content_id")
	@JsonIgnore
	private Content content;

	public ContentVote() {
		super();
	}

	public Boolean getUpvoted() {
		return upvoted;
	}

	public void setUpvoted(Boolean upvoted) {
		this.upvoted = upvoted;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public LocalDateTime getVoteDate() {
		return voteDate;
	}

	public void setVoteDate(LocalDateTime voteDate) {
		this.voteDate = voteDate;
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
		ContentVote other = (ContentVote) obj;
		return id == other.id;
	}

	@Override
	public String toString() {
		return "ContentVote [id=" + id + ", upvoted=" + upvoted + ", vote_date=" + voteDate + ", user=" + user
				+ ", content=" + content + "]";
	}

}
