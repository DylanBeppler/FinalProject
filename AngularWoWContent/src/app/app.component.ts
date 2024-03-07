import { Component } from '@angular/core';
import { RouterOutlet } from '@angular/router';
import { AuthService } from './services/auth.service';
import { HomeComponent } from "./components/home/home.component";
import { FormsModule } from '@angular/forms';
import { NavigationComponent } from './components/navigation/navigation.component';
import { ContentComponent } from './components/content/content.component';
import { LoginComponent } from './components/login/login.component';
import { LogoutComponent } from './components/logout/logout.component';
import { RegisterComponent } from './components/register/register.component';

@Component({
    selector: 'app-root',
    standalone: true,
    templateUrl: './app.component.html',
    styleUrl: './app.component.css',
    imports: [
      RouterOutlet,
       HomeComponent,
      FormsModule,
      NavigationComponent,
      ContentComponent,
      LoginComponent,
      LogoutComponent,
      RegisterComponent

    ]

})
export class AppComponent {
  constructor(
  ) {}

  // ngOnInit() {
  //   this.tempTestDeleteMeLater(); // DELETE LATER!!!
  // }

  // tempTestDeleteMeLater() {
  //   this.auth.login('zach','test').subscribe({ // change username to match DB
  //     next: (data) => {
  //       console.log('Logged in:');
  //       console.log(data);
  //     },
  //     error: (fail) => {
  //       console.error('Error authenticating:')
  //       console.error(fail);
  //     }
  //   });
  // }
}
