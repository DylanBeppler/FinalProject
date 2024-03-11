import { Pipe, PipeTransform } from '@angular/core';
import { Content } from '../models/content';

@Pipe({
  name: 'voteSort',
  standalone: true,
})
export class VoteSortPipe implements PipeTransform {
  transform(arr: Content[]): Content[] {
    for (let i = 0; i < arr.length && i <=9; i++) {
      let indexMin = i;
      let minCount = -99999;
      for (let j = i + 1; j < arr.length; j++) {
        let jCount = 0;
        for (let vote of arr[j].contentVotes) {
          if (vote.upvoted) {
            jCount++;
          } else {
            jCount--;
          }
        }

        if (jCount > minCount) {
          indexMin = j;
          minCount = jCount;
        }
      }

      if (indexMin !== i) {
        let lesser = arr[indexMin];
        arr[indexMin] = arr[i];
        arr[i] = lesser;
      }
    }

    return arr.slice(0, 10);
  }
}
