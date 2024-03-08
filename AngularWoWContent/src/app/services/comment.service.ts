import { DatePipe } from '@angular/common';
import { Comment } from '../models/comment';
import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable, catchError, throwError } from 'rxjs';
import { environment } from '../../environments/environment';
import { AuthService } from './auth.service';

@Injectable({
  providedIn: 'root',
})
export class CommentService {
  private urlComment = environment.baseUrl + 'api/comments';
  private urlContent = environment.baseUrl + 'api/content';

  constructor(
    private http: HttpClient,
    private auth: AuthService
  ) {}

  getHttpOptions() {
    let options = {
      headers: {
        Authorization: 'Basic ' + this.auth.getCredentials(),
        'X-Requested-With': 'XMLHttpRequest',
      },
    };
    return options;
  }

  index(): Observable<Comment[]> {
    return this.http
      .get<Comment[]>(this.urlComment, this.getHttpOptions())
      .pipe(
        catchError((err: any) => {
          console.log(err);
          return throwError(
            () =>
              new Error(
                'CommentService.index(): error retrieving all comment: ' + err
              )
          );
        })
      );
  }

  userComments(): Observable<Comment> {
    return this.http
      .get<Comment>(this.urlContent + '/my_comments', this.getHttpOptions())
      .pipe(
        catchError((err: any) => {
          console.log(err);
          return throwError(
            () =>
              new Error(
                'CommentService.userComments(): error retrieving user comments: ' +
                  err
              )
          );
        })
      );
  }

  commentsByContentId(contentId: number): Observable<Comment[]> {
    return this.http
      .get<Comment[]>(
        this.urlContent + '/' + contentId + '/comments',
        this.getHttpOptions()
      )
      .pipe(
        catchError((err: any) => {
          console.log(err);
          return throwError(
            () =>
              new Error(
                'ContentService.commentsByContentId(): error retrieving content comments: ' +
                  err
              )
          );
        })
      );
  }

  commentByCommentId(
    contentId: number,
    commentId: number
  ): Observable<Comment> {
    return this.http
      .get<Comment>(
        this.urlContent + '/' + contentId + '/comments/' + commentId,
        this.getHttpOptions()
      )
      .pipe(
        catchError((err: any) => {
          console.log(err);
          return throwError(
            () =>
              new Error(
                'CommentService.commentByCommentId(): error retrieving comment by id: ' +
                  err
              )
          );
        })
      );
  }

  create(contentId: number, comment: Comment): Observable<Comment> {
    return this.http
      .post<Comment>(
        this.urlContent + '/' + contentId + '/comment',
        comment,
        this.getHttpOptions()
      )
      .pipe(
        catchError((err: any) => {
          console.log(err);
          return throwError(
            () =>
              new Error(
                'CommentService.create(): error creating comment: ' + err
              )
          );
        })
      );
  }

  update(
    contentId: number,
    commentId: number,
    editComment: Comment
  ): Observable<Comment> {
    // if (editComment) {
    //   editComment.updatedDate = this.datePipe.transform(Date.now(), 'shortDate'); //  7/23/23
    // } else {
    //   editComment.updatedDate = '';
    // }
    return this.http
      .put<Comment>(
        this.urlContent + '/' + contentId + '/comment' + commentId,
        editComment,
        this.getHttpOptions()
      )
      .pipe(
        catchError((err: any) => {
          console.log(err);
          return throwError(
            () =>
              new Error(
                'ComentService.update(): error updating comment: ' + err
              )
          );
        })
      );
  }

  destroy(contentId: number, commentId: number): Observable<void> {
    return this.http
      .delete<void>(
        `${this.urlContent}/${contentId}/comments/${commentId}`,
        this.getHttpOptions()
      )
      .pipe(
        catchError((err: any) => {
          console.log(err);
          return throwError(
            () =>
              new Error(
                'CommentService.delete(): error deleting comment by id: ' + err
              )
          );
        })
      );
  }
}
