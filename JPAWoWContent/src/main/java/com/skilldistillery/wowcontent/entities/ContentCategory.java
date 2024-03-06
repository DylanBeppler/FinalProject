package com.skilldistillery.wowcontent.entities;

import java.util.List;
import java.util.Objects;

import com.fasterxml.jackson.annotation.JsonIgnore;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;

@Entity
@Table(name = "content_category")
public class ContentCategory {
	
	public ContentCategory() {}
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;

	private String name;
	private String description;
	
	@Column(name = "image_url")
	private String imageUrl;
//	
//	@JsonIgnore
//	@OneToMany(mappedBy = "ContentCategory")
//	private List<Content> content;

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

//	public List<Content> getContent() {
//		return content;
//	}
//
//	public void setContent(List<Content> content) {
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
		ContentCategory other = (ContentCategory) obj;
		return id == other.id;
	}

//	@Override
//	public String toString() {
//		return "ContentCategory [id=" + id + ", name=" + name + ", description=" + description + ", imageUrl="
//				+ imageUrl + ", content=" + content + "]";
//	}
	

}
