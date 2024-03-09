import { DatePipe } from '@angular/common';
import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable, catchError, throwError } from 'rxjs';
import { environment } from '../../environments/environment';
import { AuthService } from './auth.service';
import { Content } from '../models/content';
import { ContentService } from './content.service';
import { CommentService } from './comment.service';
import { Vote } from '../models/vote';

@Injectable({
  providedIn: 'root',
})
export class VoteService {
  private url = environment.baseUrl + 'api/content';

  constructor(
    private http: HttpClient,
    private datePipe: DatePipe,
    private auth: AuthService,
    private contentService: ContentService,
    private commentService: CommentService
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

  allVotes(contentId: number): Observable<Vote[]> {
    return this.http.get<Vote[]>(this.url + '/' + contentId + '/votes').pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () =>
            new Error(
              'VoteService.allVotes(): error retrieving all Votes: ' + err
            )
        );
      })
    );
  }

  showVoteByID(contentId: number, voteId: number): Observable<Vote> {
    return this.http
      .get<Vote>(
        this.url + '/' + contentId + '/votes/' + voteId,
        this.getHttpOptions()
      )
      .pipe(
        catchError((err: any) => {
          console.log(err);
          return throwError(
            () =>
              new Error(
                'VoteService.showVoteByID(): error retrieving vote by id: ' +
                  err
              )
          );
        })
      );
  }

  creatingVote(contentId: number, vote: Vote): Observable<Vote> {
    return this.http
      .post<Vote>(
        this.url + '/' + contentId + '/votes',
        vote,
        this.getHttpOptions()
      )
      .pipe(
        catchError((err: any) => {
          console.log(err);
          return throwError(
            () =>
              new Error(
                'VoteService.create(): error retrieving vote by id: ' + err
              )
          );
        })
      );
  }

  updatingVote(
    contentId: number,
    voteId: number,
    vote: Vote
  ): Observable<Vote> {
    return this.http
      .put<Vote>(
        this.url + '/' + contentId + '/votes/' + voteId,
        vote,
        this.getHttpOptions()
      )
      .pipe(
        catchError((err: any) => {
          console.log(err);
          return throwError(
            () =>
              new Error(
                'VoteService.updatingVote(): error updating vote: ' + err
              )
          );
        })
      );
  }

  // destroy(contentId: number): Observable<void> {
  //   return this.http
  //     .delete<void>(`${this.url}/${contentId}`, this.getHttpOptions())
  //     .pipe(
  //       catchError((err: any) => {
  //         console.log(err);
  //         return throwError(
  //           () =>
  //             new Error(
  //               'ContentService.delete(): error deleting content by id: ' + err
  //             )
  //         );
  //       })
  //     );
  // }
}
