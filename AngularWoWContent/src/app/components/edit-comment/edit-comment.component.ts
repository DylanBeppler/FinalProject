import { CommonModule } from '@angular/common';
import { Component, Inject } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { MAT_DIALOG_DATA } from '@angular/material/dialog';
import { Comment } from './../../models/comment';
import { CommentService } from '../../services/comment.service';
import { Content } from '../../models/content';

@Component({
  selector: 'app-edit-comment',
  standalone: true,
  imports: [FormsModule, CommonModule],
  templateUrl: './edit-comment.component.html',
  styleUrl: './edit-comment.component.css'
})
export class EditCommentComponent {
  allComments: Comment[] = [];
  constructor(private commentService: CommentService, @Inject(MAT_DIALOG_DATA) public data: {editComment: Comment | null, selectedContent: Content}) { }


updateComment(
  contentId: number,
  commentId: number,
  comment: Comment,
  goToDetail = true
) {
  this.commentService.update(contentId, commentId, comment).subscribe({
    next: (comment) => {
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
    },
    error: (kaboom: any) => {
      console.error('Error updating comment');
      console.error(kaboom);
    },
  });
}

}

