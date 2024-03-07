import { ContentCategory } from "./content-category";

export class Content {
  id: number;
  name: string;
  description: string;
  imageUrl: string;
  enabled: boolean;
  createdDate: string;
  updateDate: string | null;
  contentCategory: ContentCategory;

  constructor(
    id: number = 0,
    name: string = '',
    description: string = '',
    imageUrl: string = '',
    enabled: boolean = false,
    createdDate: string = '',
    updateDate: string = '',
    contentCategory: ContentCategory = new ContentCategory()
  ) {
    this.id = id;
    this.name = name;
    this.description = description;
    this.imageUrl = imageUrl;
    this.enabled = enabled;
    this.createdDate = createdDate;
    this.updateDate = updateDate;
    this.contentCategory = contentCategory;

  }
}
