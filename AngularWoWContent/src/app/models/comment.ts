import { Content } from "./content";
import { User } from "./user";

export class Comment {
  id: number;
  message: string;
  enabled: boolean;
  imageUrl: string;
  commentDate: string | undefined;
  updatedDate: string | null | undefined;
  content: Content | undefined;
  user: User;
  replyToId: number | null;

  constructor(
    id: number = 0,
    message: string = '',
    description: string = '',
    imageUrl: string = '',
    commentDate: string = '',
    enabled: boolean = true,
    updatedDate: string = '',
    content: Content = new Content(),
    user: User = new User(),
    replyToId: number | null = null
  ) {
    this.id = id;
    this.message = message;
    this.imageUrl = imageUrl;
    this.commentDate = commentDate;
    this.enabled = enabled;
    this.updatedDate = updatedDate;
    this.content = content;
    this.replyToId = replyToId;
    this.user = user;
  }
}
