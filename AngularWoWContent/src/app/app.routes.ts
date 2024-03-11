import { Component } from '@angular/core';
import { ContentComponent } from './components/content/content.component';
import { Routes } from '@angular/router';
import { NotFoundComponent } from './components/not-found/not-found.component';
import { LoginComponent } from './components/login/login.component';
import { LogoutComponent } from './components/logout/logout.component';
import { RegisterComponent } from './components/register/register.component';
import { NavigationComponent } from './components/navigation/navigation.component';
import { HomeComponent } from './components/home/home.component';
import { LatestPostsComponent } from './components/latest-posts/latest-posts.component';
import { ToppostsComponent } from './components/topposts/topposts.component';

export const routes: Routes = [
  { path: '', pathMatch: 'full', redirectTo: 'home' },
  { path: 'home', component: HomeComponent },
  { path: 'content', component: ContentComponent },
  { path: 'navigation', component: NavigationComponent },
  { path: 'register', component: RegisterComponent },
  { path: 'login', component: LoginComponent },
  { path: 'logout', component: LogoutComponent },
  { path: 'content/:name', component: ContentComponent },
  {path: 'latest', component: LatestPostsComponent},
  {path: 'top', component: ToppostsComponent},
  { path: '**', component: NotFoundComponent }


];
