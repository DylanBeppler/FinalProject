import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { Content } from '../../models/content';
import { ContentService } from '../../services/content.service';
import { ContentCategory } from '../../models/content-category';
import { ContentCategoryService } from '../../services/content-category.service';
import { CommentService } from '../../services/comment.service';

@Component({
  selector: 'app-content',
  standalone: true,
  imports: [CommonModule, FormsModule],
  templateUrl: './content.component.html',
  styleUrls: ['./content.component.css'],
})
export class ContentComponent implements OnInit {
  editComment: Comment | null = null;
  newComment: Comment = new Comment();
  selectedComment: Comment | null = null;
  allComments: Comment[] = [];

  editContent: Content | null = null;
  newContent: Content = new Content();
  selectedContent: Content | null = null;
  allContent: Content[] = [];
  allContentCategories: ContentCategory[] = [];

  constructor(
    private commentService: CommentService,
    private contentService: ContentService,
    private contentCategoryService: ContentCategoryService,
    private activateRoute: ActivatedRoute,
    private router: Router
  ) {}

  ngOnInit(): void {
    this.reload();
    this.activateRoute.paramMap.subscribe({
      next: (params) => {
        let contentIdStr = params.get('contentId');
        if (contentIdStr) {
          let contentId = parseInt(contentIdStr);
          if (isNaN(contentId)) {
            this.router.navigateByUrl('contentId');
          } else {
            this.getContent(contentId);
          }
        }
      },
      error: (kaboom) => {
        console.error('Error retreiving content');
        console.error(kaboom);
      },
    });
  }

  reload(): void {
    this.contentService.index().subscribe({
      next: (content) => {
        this.allContent = content;
      },
      error: (problem) => {
        console.error('ContentComponent.reload(): error loading all content: ');
        console.error(problem);
      },
    });
    this.contentCategoryService.index().subscribe({
      next: (contentCategories) => {
        this.allContentCategories = contentCategories;
      },
      error: (problem) => {
        console.error(
          'ContentComponent.reload(): error loading all content categories: '
        );
        console.error(problem);
      },
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

  displayContent(content: Content) {
    this.selectedContent = content;
  }

  displayComment(comment: Comment) {
    this.selectedComment = comment;
  }

  displayTableContent() {
    this.selectedContent = null;
  }

  displayTableComment() {
    this.selectedComment = null;
  }

  setEditContent() {
    this.editContent = Object.assign({}, this.selectedContent);
  }

  setEditComment() {
    this.editComment = Object.assign({}, this.selectedComment);
  }

  getContent(contentId: number) {
    this.contentService.show(contentId).subscribe({
      next: (content) => {
        (this.selectedContent = content), this.reload();
      },
      error: () => {
        this.router.navigateByUrl('contentNotFound');
      },
    });
  }

  createContent(newContent: Content) {
    this.contentService.create(newContent).subscribe({
      next: (newContent) => {
        this.newContent = new Content();
        this.reload();
      },
      error: () => {},
    });
  }

  updateContent(content: Content, goToDetail = true) {
    this.contentService.update(content).subscribe({
      next: (content) => {
        this.editContent = null;
        if (goToDetail) {
          this.selectedContent = content;
        }
        this.reload();
      },
      error: (kaboom: any) => {
        console.error('Error updating Todo');
        console.error(kaboom);
      },
    });
  }

  deleteContent(contentId: number) {
    this.contentService.destroy(contentId).subscribe({
      next: () => {
        this.reload();
      },
      error: () => {},
    });
  }
  getCommentsByContentId(contentId: number, commentId: number) {
    this.commentService.commentsByContentId(contentId).subscribe({
      next: (comment) => {
        (this.allComments = comment), this.reload();
      },
      error: () => {
        this.router.navigateByUrl('contentNotFound');
      },
    });
  }

  getCommentByCommentId(contentId: number, commentId: number) {
    this.commentService.commentByCommentId(contentId, commentId).subscribe({
      next: (comment) => {
        (this.selectedComment = comment), this.reload();
      },
      error: () => {
        this.router.navigateByUrl('contentNotFound');
      },
    });
  }

  getUserComments() {
    this.commentService.userComments().subscribe({
      next: (comment) => {
        (this.selectedComment = comment), this.reload();
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
        this.reload();
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
        this.reload();
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
        this.reload();
      },
      error: () => {},
    });
  }
}
