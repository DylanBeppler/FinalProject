import { Content } from "./content";
import { User } from "./user";

export class Vote {
  id: number;
  upvoted: boolean;
  voteDate: string;
  content: Content;
  user: User;

  constructor(
    id: number = 0,
    voteDate: string = '',
    upvoted: boolean = false,
    content: Content = new Content(),
    user: User = new User()
  ) {
    this.id = id;
    this.upvoted = upvoted;
    this.voteDate = voteDate;
    this.content = content;
    this.user = user;
  }
}

