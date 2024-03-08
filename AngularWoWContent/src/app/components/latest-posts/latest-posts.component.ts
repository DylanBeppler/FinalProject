import { ContentComponent } from './../content/content.component';
import { CommonModule } from '@angular/common';
import { Component } from '@angular/core';
import { Content } from '../../models/content';
import { ContentCategory } from '../../models/content-category';
import { ContentService } from '../../services/content.service';
import { CommentService } from '../../services/comment.service';

@Component({
  selector: 'app-latest-posts',
  standalone: true,
  imports: [CommonModule],
  templateUrl: './latest-posts.component.html',
  styleUrl: './latest-posts.component.css'
})
export class LatestPostsComponent {

  latestContents: Content[] = [];

  constructor(private contentService: ContentService) {}

  ngOnInit(): void {
    this.loadLatestContent();
  }

  loadLatestContent(): void {
    this.contentService.index().subscribe({
      next: (contents) => {
        this.latestContents = contents;
      },
      error: (err) => {
        console.error('Error fetching latest content', err);
      }
    });
  }
}



