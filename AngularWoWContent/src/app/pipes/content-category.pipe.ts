import { Pipe, PipeTransform } from '@angular/core';
import { Content } from '../models/content';

@Pipe({
  name: 'contentCategory',
  standalone: true
})
export class ContentCategoryPipe implements PipeTransform {

  transform(content: Content[], categoryStr: string): Content[] {
    const results: Content[] = [];
    for (const cont of content) {
      if (cont.contentCategory.name) {
        if (cont.contentCategory.name === categoryStr) {
          results.push(cont);
        } else if (categoryStr === "all") {
          return content;
        }
      }
    }

    return results;
  }

}
