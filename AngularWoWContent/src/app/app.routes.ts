import { ContentComponent } from './components/content/content.component';
import { Routes } from '@angular/router';
import { NotFoundComponent } from './components/not-found/not-found.component';

export const routes: Routes = [
  { path: '', pathMatch: 'full', redirectTo: 'home' },
  { path: 'content', component: ContentComponent },
  { path: '**', component: NotFoundComponent },
];
