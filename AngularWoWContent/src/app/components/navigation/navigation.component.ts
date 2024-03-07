import { Component } from '@angular/core';
import { Router, RouterLink } from '@angular/router';
import { AuthService } from '../../services/auth.service';
import { NgbModal, NgbModule } from '@ng-bootstrap/ng-bootstrap';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { LogoutComponent } from '../logout/logout.component';
import { LoginComponent } from '../login/login.component';
import { RegisterComponent } from '../register/register.component';

@Component({
  selector: 'app-navigation',
  standalone: true,
  imports: [

    NgbModule,
    CommonModule,
    FormsModule,
    RouterLink,
    LogoutComponent,
    LoginComponent
  ],
  templateUrl: './navigation.component.html',
  styleUrl: './navigation.component.css'
})
export class NavigationComponent {


  public isCollapsed = true;
  constructor(private authService: AuthService, private router: Router, private modalService: NgbModal) {

  }

  openLoginModal() {
    this.modalService.open(LoginComponent);
  }

  openRegisterModal() {
    this.modalService.open(RegisterComponent);
  }

  toggleCollapse(): void {
    this.isCollapsed = !this.isCollapsed;
  }

  logout(): void {
    this.authService.logout();
    this.router.navigateByUrl('/');
  }

  isLoggedIn(): boolean {
  return this.authService.checkLogin();
}
}
