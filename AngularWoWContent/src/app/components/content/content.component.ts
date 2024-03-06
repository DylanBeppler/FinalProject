import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { Content } from '../../models/content';
import { ContentService } from '../../services/content.service';

@Component({
  selector: 'app-content',
  standalone: true,
  imports: [CommonModule, FormsModule],
  templateUrl: './content.component.html',
  styleUrls: ['./content.component.css'],
})
export class ContentComponent implements OnInit {

  ngOnInit(): void {
    this.reload();
    this.activateRoute.paramMap.subscribe({
      next: (params) => {
        let contentIdStr = params.get('contentId');
        if (contentIdStr) {
          let contentId = parseInt(contentIdStr);
          if (isNaN(contentId)) {
            this.router.navigateByUrl('contentId');
          } else {
            this.getContent(contentId);
          }
        }
      },
      error: (kaboom) => {
        console.error('Error retreiving content');
        console.error(kaboom);
      },
    });
  }

  constructor(
    private contentService: ContentService,
    private activateRoute: ActivatedRoute,
    private router: Router
  ) {}

  reload(): void {
    this.contentService.index().subscribe({
      next: (content) => {
        this.allContent = content;
      },
      error: (problem) => {
        console.error('ContentComponent.reload(): error loading all content: ');
        console.error(problem);
      },
    });
  }

  editContent: Content | null = null;
  newContent: Content = new Content();
  selected: Content | null = null;
  allContent: Content[] = [];

  displayContent(content: Content) {
    this.selected = content;
  }

  displayTable() {
    this.selected = null;
  }

  setEditContent() {
    this.editContent = Object.assign({}, this.selected);
  }

  getContent(contentId: number) {
    this.contentService.show(contentId).subscribe({
      next: (content) => {
        (this.selected = content), this.reload();
      },
      error: () => {
        this.router.navigateByUrl('contentNotFound');
      },
    });
  }

  addContent(newContent: Content) {
    this.contentService.create(newContent).subscribe({
      next: (newContent) => {
        this.newContent = new Content();
        this.reload();
      },
      error: () => {},
    });
  }

  updateContent(content: Content, goToDetail = true) {
    console.log(content);
    this.contentService.update(content).subscribe({
      next: (content) => {
        this.editContent = null;
        if (goToDetail) {
          this.selected = content;
        }
        this.reload();
      },
      error: (kaboom: any) => {
        console.error('Error updating Todo');
        console.error(kaboom);
      },
    });
  }

  deleteContent(contentId: number) {
    this.contentService.destroy(contentId).subscribe({
      next: () => {
        this.reload();
      },
      error: () => {},
    });
  }
}
