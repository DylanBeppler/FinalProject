import { Content } from "./content";

export class Comment {
  id: number;
  message: string;
  enabled: boolean;
  description: string;
  imageUrl: string;
  commentDate: string;
  updatedDate: string;
  content: Content;
  replyToId: number;

  constructor(
    id: number = 0,
    message: string = '',
    description: string = '',
    imageUrl: string = '',
    commentDate: string = '',
    enabled: boolean = true,
    updatedDate: string = '',
    content: Content = new Content(),
    replyToId: number = 0
  ) {
    this.id = id;
    this.message = message;
    this.description = description;
    this.imageUrl = imageUrl;
    this.commentDate = commentDate;
    this.enabled = enabled;
    this.updatedDate = updatedDate;
    this.content = content;
    this.replyToId = replyToId;
  }
}
