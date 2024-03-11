import { ContentComponent } from './../content/content.component';
import { CommonModule } from '@angular/common';
import { Component } from '@angular/core';
import { Content } from '../../models/content';
import { ContentCategory } from '../../models/content-category';
import { ContentService } from '../../services/content.service';
import { CommentService } from '../../services/comment.service';
import { ContentCategoryPipe } from "../../pipes/content-category.pipe";
import { User } from '../../models/user';
import { AuthService } from '../../services/auth.service';
import { Router } from '@angular/router';
import { Comment } from './../../models/comment';

@Component({
    selector: 'app-latest-posts',
    standalone: true,
    templateUrl: './latest-posts.component.html',
    styleUrl: './latest-posts.component.css',
    imports: [CommonModule, ContentCategoryPipe]
})
export class LatestPostsComponent {
  selectedContent: Content | null = null;
  latestContents: Content[] = [];
  editContent: Content | null = null;

  loggedInUser: User | null = null;

  editComment: Comment | null = null;
  newComment: Comment = new Comment();
  selectedComment: Comment | null = null;
  allComments: Comment[] = [];

  constructor(private contentService: ContentService,private commentService: CommentService, private auth: AuthService,  private router: Router) {}

  ngOnInit(): void {
    this.loadLatestContent();
  }

  isLoggedIn(): boolean {
    return this.auth.checkLogin();
  }

  deleteContent(contentId: number) {
    this.contentService.destroy(contentId).subscribe({
      next: () => {
        this.loadLatestContent();
      },
      error: () => {},
    });
  }


  loadLatestContent(): void {
    this.contentService.index().subscribe({
      next: (contents) => {
        this.latestContents = contents.sort((a, b) =>
        {
          return new Date(b.createdDate).getTime() - new Date(a.createdDate).getTime();
        })
        .slice(0, 10);

      },
      error: (err) => {
        console.error('Error fetching latest content', err);
      }
    });
    this.commentService.index().subscribe({
      next: (allComments) => {
        this.allComments = allComments;
      },
      error: (problem) => {
        console.error(
          'ContentComponent.reload(): error loading all comments: '
        );
        console.error(problem);
      },
    });

  }

  setEditComment(comment: Comment) {
    this.editComment = Object.assign({}, comment);
  console.log(this.editComment);
  }

  getCommentsByContentId(contentId: number) {
    this.commentService.commentsByContentId(contentId).subscribe({
      next: (comment) => {
        (this.allComments = comment), this.loadLatestContent();
      },
      error: () => {
        this.router.navigateByUrl('contentNotFound');
      },
    });
  }

  getCommentByCommentId(contentId: number, commentId: number) {
    this.commentService.commentByCommentId(contentId, commentId).subscribe({
      next: (comment) => {
        (this.selectedComment = comment), this.loadLatestContent();
      },
      error: () => {
        this.router.navigateByUrl('contentNotFound');
      },
    });
  }

  getUserComments() {
    this.commentService.userComments().subscribe({
      next: (comment) => {
        (this.selectedComment = comment), this.loadLatestContent();
      },
      error: () => {
        this.router.navigateByUrl('contentNotFound');
      },
    });
  }

  addComment(contentId: number, newComment: Comment) {
    this.commentService.create(contentId, newComment).subscribe({
      next: (newComment) => {
        this.newComment = new Comment();
        this.loadLatestContent();
      },
      error: () => {},
    });
  }

  updateComment(
    contentId: number,
    commentId: number,
    comment: Comment,
    goToDetail = true
  ) {
    this.commentService.update(contentId, commentId, comment).subscribe({
      next: (comment) => {
        this.editContent = null;
        if (goToDetail) {
          this.selectedComment = comment;
        }
        this.loadLatestContent();
      },
      error: (kaboom: any) => {
        console.error('Error updating comment');
        console.error(kaboom);
      },
    });
  }

  deleteComment(contentId: number, commentId: number) {
    this.commentService.destroy(contentId, commentId).subscribe({
      next: () => {
        this.loadLatestContent();
      },
      error: () => {},
    });
  }


}



