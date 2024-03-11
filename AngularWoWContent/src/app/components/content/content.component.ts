import { Comment } from './../../models/comment';
import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { ActivatedRoute, ParamMap, Router } from '@angular/router';
import { Content } from '../../models/content';
import { ContentService } from '../../services/content.service';
import { ContentCategory } from '../../models/content-category';
import { ContentCategoryService } from '../../services/content-category.service';
import { CommentService } from '../../services/comment.service';
import { ContentCategoryPipe } from '../../pipes/content-category.pipe';
import { AuthService } from '../../services/auth.service';
import { User } from '../../models/user';

import {
  MatDialog,
  MatDialogRef,
  MatDialogActions,
  MatDialogClose,
  MatDialogTitle,
  MatDialogContent,
} from '@angular/material/dialog';
import { MatButtonModule } from '@angular/material/button';
import { CommentComponent } from '../comment/comment.component';
import { NavigationDialogComponent } from '../navigation/navigation.component';
import { EditCommentComponent } from '../edit-comment/edit-comment.component';
import { VoteService } from '../../services/vote.service';
import { Vote } from '../../models/vote';
import { ContentCommentPipe } from '../../pipes/content-comment.pipe';

@Component({
  selector: 'app-content',
  standalone: true,
  imports: [
    CommonModule,
    FormsModule,
    ContentCategoryPipe,
    ContentCommentPipe,
    MatButtonModule,
    MatDialogActions,
    MatDialogClose,
    MatDialogTitle,
    MatDialogContent,
  ],
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
  categoryName: string = '';

  loggedInUser: User | null = null;

  allContentVotes: Vote[] = [];
  newVote: Vote = new Vote();

  constructor(
    private commentService: CommentService,
    private contentService: ContentService,
    private contentCategoryService: ContentCategoryService,
    private voteService: VoteService,
    private activateRoute: ActivatedRoute,
    private router: Router,
    private activatedRoute: ActivatedRoute,
    private auth: AuthService,
    public dialog: MatDialog
  ) {}

  ngOnInit(): void {
    this.reload();
    this.setLoggedInUser();
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
    this.activatedRoute.paramMap.subscribe({
      next: (params: ParamMap) => {
        let contentCategoryParam = params.get('name');
        if (contentCategoryParam) {
          this.categoryName = contentCategoryParam;
        }
      },
    });
  }

  isLoggedIn(): boolean {
    return this.auth.checkLogin();
  }

  setLoggedInUser(): void {
    if (this.isLoggedIn()) {
      this.auth.getLoggedInUser().subscribe({
        next: (user) => {
          this.loggedInUser = user;
        },
        error: (problem) => {
          console.error(
            'ContentComponent.setLoggedInUser(): error setting logged in user: '
          );
          console.error(problem);
        },
      });
    }
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
    this.voteService.index().subscribe({
      next: (allVotes) => {
        this.allContentVotes = allVotes;
      },
      error: (problem) => {
        console.error(
          'ContentComponent.reload(): error loading all votes: '
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

  setEditComment(comment: Comment) {
    this.editComment = Object.assign({}, comment);
    console.log(this.editComment);
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
        console.error('Error updating Content');
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
  getCommentsByContentId(contentId: number) {
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
        this.editComment = null;
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

  openCommentDialog(
    enterAnimationDuration: string,
    exitAnimationDuration: string
  ): void {
    let dialogRef = this.dialog.open(EditCommentComponent, {
      data: {
        editComment: this.editComment,
        selectedContent: this.selectedContent,
      },
      width: '250px',
      enterAnimationDuration,
      exitAnimationDuration,
    });
    dialogRef.afterClosed().subscribe((result) => {
      this.editComment = null;
      this.reload();
    });
  }

  getContentVotes(contentId: number) {
    this.voteService.allVotes(contentId).subscribe({
      next: (votes) => {
        (this.allContentVotes = votes), this.reload();
      },
      error: () => {
        this.router.navigateByUrl('contentNotFound');
      },
    });
  }

  addVote(contentId: number, newVote: Vote) {
    this.voteService.creatingVote(contentId, newVote).subscribe({
      next: (newVote) => {
        this.newVote = new Vote();
        this.reload();
      },
      error: (error) => {
        console.error('Error creating vote');
        console.error(error);
      },
    });
  }

  updateVote(contentId: number, upvoted: boolean) {
    this.voteService.updatingVote(contentId, upvoted).subscribe({
      next: (vote) => {
        this.reload();
      },
      error: (kaboom: any) => {
        console.error('Error updating vote');
        console.error(kaboom);
      },
    });
  }

  getTotalVotes(votes: Vote[]) {
    let num = 0;
    for (let vote of votes) {
      if (vote.upvoted !== null && vote.upvoted === false) {
        num -= 1;
      } else if (vote.upvoted !== null && vote.upvoted === true) {
        num += 1;
      }
    }
    return num;
  }

}
