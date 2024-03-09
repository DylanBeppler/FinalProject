import { ContentCategory } from "./content-category";
import { User } from "./user";
import { Vote } from "./vote";

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
  votes: Vote[];

  constructor(
    id: number = 0,
    name: string = '',
    description: string = '',
    imageUrl: string = '',
    enabled: boolean = false,
    createdDate: string = '',
    lastUpdate: string = '',
    contentCategory: ContentCategory = new ContentCategory(),
    user: User = new User(),
    votes: Vote[] = []
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
    this.votes = votes;
  }
}
