import { CommonModule } from '@angular/common';
import { Component, OnInit } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { CommentService } from '../../services/comment.service';
import { ActivatedRoute, Router } from '@angular/router';

@Component({
  selector: 'app-comment',
  standalone: true,
  imports: [CommonModule, FormsModule],
  templateUrl: './comment.component.html',
  styleUrl: './comment.component.css',
})
export class CommentComponent implements OnInit {
  allComments: Comment[] = [];
  selected: Comment | null = null;
  editComment: Comment | null = null;

  constructor(
    private commentService: CommentService,
    private activateRoute: ActivatedRoute,
    private router: Router
  ) {}

  ngOnInit(): void {
    this.reload();
    this.activateRoute.paramMap.subscribe({
      next: (params) => {
        let commentIdStr = params.get('commentId');
        if (commentIdStr) {
          let commentId = parseInt(commentIdStr);
          if (isNaN(commentId)) {
            this.router.navigateByUrl('commentId');
          } else {
            // this.getComment(commentId);
          }
        }
      },
      error: (kaboom) => {
        console.error('Error retreiving comment');
        console.error(kaboom);
      },
    });
  }

  reload(): void {
    this.commentService.index().subscribe({
      next: (comment) => {
        this.allComments = comment;
      },
      error: (problem) => {
        console.error(
          'CommentComponent.reload(): error loading all comments: '
        );
        console.error(problem);
      },
    });
  }

  displayComment(comment: Comment) {
    this.selected = comment;
  }

  displayTable() {
    this.selected = null;
  }

  setEditComment() {
    this.editComment = Object.assign({}, this.selected);
  }
}

