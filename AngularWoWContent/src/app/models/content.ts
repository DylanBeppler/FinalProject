import { ContentCategory } from "./content-category";
import { User } from "./user";

export class Content {
  id: number;
  name: string;
  description: string;
  imageUrl: string;
  enabled: boolean;
  createdDate: string;
  lastUpdate: string | null;
  contentCategory: ContentCategory;
  user: User;

  constructor(
    id: number = 0,
    name: string = '',
    description: string = '',
    imageUrl: string = '',
    enabled: boolean = false,
    createdDate: string = '',
    lastUpdate: string = '',
    contentCategory: ContentCategory = new ContentCategory(),
    user: User = new User()
  ) {
    this.id = id;
    this.name = name;
    this.description = description;
    this.imageUrl = imageUrl;
    this.enabled = enabled;
    this.createdDate = createdDate;
    this.lastUpdate = lastUpdate;
    this.contentCategory = contentCategory;
    this.user = user;
  }
}
