import { CommonModule } from '@angular/common';
import { Component } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { Router, RouterLink } from '@angular/router';
import { AuthService } from '../../services/auth.service';
import { ContentComponent } from '../content/content.component';
import { ContentCategoryService } from '../../services/content-category.service';
import { ContentCategory } from '../../models/content-category';

@Component({
  selector: 'app-home',
  standalone: true,
  imports: [
  CommonModule,
  FormsModule,
    RouterLink
],
  templateUrl: './home.component.html',
  styleUrl: './home.component.css'
})
export class HomeComponent {
  allContentCategories: ContentCategory[] = [];

 ngOnInit(): void {
  this.contentCategoryService.index().subscribe({
    next: (contentCategories) => {
      this.allContentCategories = contentCategories;
    },
    error: (problem) => {
      console.error('ContentComponent.reload(): error loading all content categories: ');
      console.error(problem);
    },
  });

 }


  constructor(
  private contentCategoryService: ContentCategoryService
) {}


}


