import { DatePipe } from '@angular/common';
import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable, catchError, throwError } from 'rxjs';
import { environment } from '../../environments/environment';
import { AuthService } from './auth.service';
import { Content } from '../models/content';

@Injectable({
  providedIn: 'root',
})
export class ContentService {
  private url = environment.baseUrl + 'api/content';

  constructor(
    private http: HttpClient,
    private datePipe: DatePipe,
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

  index(): Observable<Content[]> {
    return this.http.get<Content[]>(this.url, this.getHttpOptions()).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () =>
            new Error(
              'ContentService.index(): error retrieving all content: ' + err
            )
        );
      })
    );
  }

  show(contentId: number): Observable<Content> {
    return this.http
      .get<Content>(this.url + '/' + contentId, this.getHttpOptions())
      .pipe(
        catchError((err: any) => {
          console.log(err);
          return throwError(
            () =>
              new Error(
                'ContentService.index(): error retrieving content by id: ' + err
              )
          );
        })
      );
  }

  create(content: Content): Observable<Content> {
    return this.http
      .post<Content>(this.url, content, this.getHttpOptions())
      .pipe(
        catchError((err: any) => {
          console.log(err);
          return throwError(
            () =>
              new Error(
                'ContentService.create(): error creating content: ' + err
              )
          );
        })
      );
  }

  update(editContent: Content): Observable<Content> {
    return this.http
      .put<Content>(
        this.url + '/' + editContent.id,
        editContent,
        this.getHttpOptions()
      )
      .pipe(
        catchError((err: any) => {
          console.log(err);
          return throwError(
            () => new Error('ConentService.update(): error updating content: ' + err)
          );
        })
      );
  }

  destroy(contentId: number): Observable<void> {
    return this.http
      .delete<void>(`${this.url}/${contentId}`, this.getHttpOptions())
      .pipe(
        catchError((err: any) => {
          console.log(err);
          return throwError(
            () => new Error('ContentService.delete(): error deleting content by id: ' + err)
          );
        })
      );
  }
}
