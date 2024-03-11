import { Pipe, PipeTransform } from '@angular/core';
import { Comment } from '../models/comment';

@Pipe({
  name: 'contentComment',
  standalone: true,
})
export class ContentCommentPipe implements PipeTransform {
  transform(comments: Comment[], contentId: number): Comment[] {
    const results: Comment[] = [];
    for (const comment of comments) {
      if (comment.content) {
        if (comment.content.id === contentId) {
          results.push(comment);
        }
      }

    }
    return results;
  }
}
