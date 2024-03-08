import { Component } from '@angular/core';
import { Router } from '@angular/router';
import { User } from '../../models/user';
import { AuthService } from '../../services/auth.service';
import { FormsModule } from '@angular/forms';
import { RegisterComponent } from '../register/register.component';

import {
  MatDialog,
  MatDialogRef,
  MatDialogActions,
  MatDialogClose,
  MatDialogTitle,
  MatDialogContent,
} from '@angular/material/dialog';
import { MatButtonModule } from '@angular/material/button';

@Component({
  selector: 'app-login',
  standalone: true,
  imports: [FormsModule, RegisterComponent, MatButtonModule, MatDialogActions, MatDialogClose, MatDialogTitle, MatDialogContent ],
  templateUrl: './login.component.html',
  styleUrl: './login.component.css'
})
export class LoginComponent {

  constructor(private auth: AuthService, private router: Router, public dialogRef: MatDialogRef<LoginComponent>) {}

  loginUser: User = new User();

  login(user: User): void {
    console.log('Logging in user:');
    console.log(user);
    this.auth.login(user.username, user.password).subscribe({
      next: (loggedInUser) => {
        this.router.navigateByUrl('/home');
      },
      error: (problem) => {
        console.error('LoginComponent.login(): Error logging in user:');
        console.error(problem);
      },
    });
  }
}




