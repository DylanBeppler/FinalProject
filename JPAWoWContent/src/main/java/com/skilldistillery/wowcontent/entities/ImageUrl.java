package com.skilldistillery.wowcontent.entities;

import java.time.LocalDateTime;
import java.util.Objects;



import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;

@Entity
@Table(name = "image_url")
public class ImageUrl {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	private String url;
	private String caption;
	@Column(name = "created_date")
	private LocalDateTime createdDate;
	@Column(name = "update_date")
	private LocalDateTime updateDate;
	private boolean enabled;
//	@ManyToOne
//	@JoinColumn(name = "content_id")
//	private Content content;
	
	public ImageUrl() {
		super();
	}

//	public ImageUrl(int id, String url, String caption, LocalDateTime createdDate, LocalDateTime updateDate,
//			boolean enabled, Content content) {
//		super();
//		this.id = id;
//		this.url = url;
//		this.caption = caption;
//		this.createdDate = createdDate;
//		this.updateDate = updateDate;
//		this.enabled = enabled;
//		this.content = content;
//	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public String getCaption() {
		return caption;
	}

	public void setCaption(String caption) {
		this.caption = caption;
	}

	public LocalDateTime getCreatedDate() {
		return createdDate;
	}

	public void setCreatedDate(LocalDateTime createdDate) {
		this.createdDate = createdDate;
	}

	public LocalDateTime getUpdateDate() {
		return updateDate;
	}

	public void setUpdateDate(LocalDateTime updateDate) {
		this.updateDate = updateDate;
	}

	public boolean isEnabled() {
		return enabled;
	}

	public void setEnabled(boolean enabled) {
		this.enabled = enabled;
	}

//	public Content getContent() {
//		return content;
//	}
//
//	public void setContent(Content content) {
//		this.content = content;
//	}

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
		ImageUrl other = (ImageUrl) obj;
		return id == other.id;
	}

//	@Override
//	public String toString() {
//		return "imageUrl [id=" + id + ", url=" + url + ", caption=" + caption + ", createdDate=" + createdDate
//				+ ", updateDate=" + updateDate + ", enabled=" + enabled + ", content=" + content + "]";
//	}

}
