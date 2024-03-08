import { Component } from '@angular/core';
import { AuthService } from '../../services/auth.service';
import { Router } from '@angular/router';
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
import { FormsModule } from '@angular/forms';

@Component({
  selector: 'app-logout',
  standalone: true,
  imports: [FormsModule, RegisterComponent, MatButtonModule, MatDialogActions, MatDialogClose, MatDialogTitle, MatDialogContent],
  templateUrl: './logout.component.html',
  styleUrl: './logout.component.css'
})
export class LogoutComponent {

constructor(
  private auth: AuthService,
  private route: Router,
  public dialogRef: MatDialogRef<RegisterComponent>
) {}

  logout() {
    console.log('logging out')
    this.auth.logout();
    this.route.navigateByUrl('/home')
  }


}
