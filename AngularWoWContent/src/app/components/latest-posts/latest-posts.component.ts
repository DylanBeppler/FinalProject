import { VoteService } from './../../services/vote.service';
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
import { FormsModule } from '@angular/forms';
import { ContentCommentPipe } from "../../pipes/content-comment.pipe";
import { Vote } from '../../models/vote';
import { EditCommentComponent } from '../edit-comment/edit-comment.component';


import {
  MatDialog,
  MatDialogRef,
  MatDialogActions,
  MatDialogClose,
  MatDialogTitle,
  MatDialogContent,
} from '@angular/material/dialog';
import { MatButtonModule } from '@angular/material/button';


@Component({
    selector: 'app-latest-posts',
    standalone: true,
    templateUrl: './latest-posts.component.html',
    styleUrl: './latest-posts.component.css',
    imports: [
      CommonModule,
      ContentCategoryPipe,
      FormsModule,
      ContentCommentPipe,
      MatButtonModule,
      MatDialogActions,
      MatDialogClose,
      MatDialogTitle,
      MatDialogContent
    ]
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

  allContentVotes: Vote[] = [];
  newVote: Vote = new Vote();


  constructor(private contentService: ContentService,private commentService: CommentService, private auth: AuthService,  private router: Router, private voteService: VoteService, public dialog: MatDialog) {}

  ngOnInit(): void {
    this.loadLatestContent();
    this.setLoggedInUser();
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

  deleteContent(contentId: number) {
    this.contentService.destroy(contentId).subscribe({
      next: () => {
        this.loadLatestContent();
      },
      error: () => {},
    });
  }


  loadLatestContent(): void {
    this.setLoggedInUser();
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
      this.loadLatestContent();
    });
  }



  updateVote(contentId: number, upvoted: boolean) {
    this.voteService.updatingVote(contentId, upvoted).subscribe({
      next: (vote) => {
        this.loadLatestContent();
        if (this.selectedContent) {
          this.contentService.show(contentId).subscribe(
            (content: Content) => {
              this.selectedContent = content;
            },
            (error) => {
              console.error('Error fetching content:', error);
              // Handle error as needed, e.g., redirect to an error page
            }
          );
        }
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



