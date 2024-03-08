import { Component } from '@angular/core';
import { Router, RouterLink } from '@angular/router';
import { AuthService } from '../../services/auth.service';
import { NgbModal, NgbModule } from '@ng-bootstrap/ng-bootstrap';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { LogoutComponent } from '../logout/logout.component';
import { LoginComponent } from '../login/login.component';
import { RegisterComponent } from '../register/register.component';

import {
  MatDialog,
  MatDialogRef,
  MatDialogActions,
  MatDialogClose,
  MatDialogTitle,
  MatDialogContent,
} from '@angular/material/dialog';
import {MatButtonModule} from '@angular/material/button';


@Component({
  selector: 'app-navigation',
  standalone: true,
  imports: [
    MatButtonModule,
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
  constructor(private authService: AuthService, private router: Router, private modalService: NgbModal, public dialog: MatDialog) {

  }

  openRegisterDialog(enterAnimationDuration: string, exitAnimationDuration: string): void {
    this.dialog.open(RegisterComponent, {
      width: '250px',
      enterAnimationDuration,
      exitAnimationDuration,
    });
  }

  openLoginDialog(enterAnimationDuration: string, exitAnimationDuration: string): void {
    this.dialog.open(LoginComponent, {
      width: '250px',
      enterAnimationDuration,
      exitAnimationDuration,
    });
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




@Component({
  selector: 'app-navigation-dialog',
  standalone: true,
  imports: [MatButtonModule, MatDialogActions, MatDialogClose, MatDialogTitle, MatDialogContent],
  templateUrl: './navigation-dialog.component.html',

})
export class NavigationDialogComponent {
  constructor(public dialogRef: MatDialogRef<NavigationDialogComponent>) {}
}

