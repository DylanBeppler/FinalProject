import { Component } from '@angular/core';
import { Router, RouterLink } from '@angular/router';
import { AuthService } from '../../services/auth.service';
import { NgbModule } from '@ng-bootstrap/ng-bootstrap';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { LogoutComponent } from '../logout/logout.component';

@Component({
  selector: 'app-navigation',
  standalone: true,
  imports: [

    NgbModule,
    CommonModule,
    FormsModule,
    RouterLink,
    LogoutComponent

  ],
  templateUrl: './navigation.component.html',
  styleUrl: './navigation.component.css'
})
export class NavigationComponent {

  public isLoggedIn = false;
  public isCollapsed = true;
  constructor(private authService: AuthService, private router: Router) {
    this.isLoggedIn = this.authService.checkLogin();
  }

  toggleCollapse(): void {
    this.isCollapsed = !this.isCollapsed;
  }

  logout(): void {
    this.authService.logout();
    this.router.navigateByUrl('/');
  }


}
