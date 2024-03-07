import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { environment } from '../../environments/environment';
import { Observable, catchError, throwError } from 'rxjs';
import { ContentCategory } from '../models/content-category';
import { AuthService } from './auth.service';

@Injectable({
  providedIn: 'root'
})
export class ContentCategoryService {
  private url = environment.baseUrl + 'api/categories';

  constructor(private http: HttpClient, private auth: AuthService) { }

  getHttpOptions() {
    let options = {
      headers: {
        Authorization: 'Basic ' + this.auth.getCredentials(),
        'X-Requested-With': 'XMLHttpRequest',
      },
    };
    return options;
  }

  index(): Observable<ContentCategory[]> {
    return this.http.get<ContentCategory[]>(this.url).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () =>
            new Error(
              'ContentCategoryService.index(): error retrieving all content categories: ' + err
            )
        );
      })
    );
  }
}
