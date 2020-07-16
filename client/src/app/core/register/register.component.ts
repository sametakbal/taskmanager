import { Component, OnInit } from '@angular/core';
import { User } from 'src/app/shared/models/user';
import { NgForm } from '@angular/forms';
import { AuthService } from '../auth.service';
import { Router } from '@angular/router';

@Component({
  selector: 'app-register',
  templateUrl: './register.component.html',
  styleUrls: ['./register.component.scss']
})
export class RegisterComponent implements OnInit {
  user = new User();
  passConfirm: string;
  constructor(private auth: AuthService, private router: Router) {
   }

  ngOnInit(): void {
    if (this.auth.loggedIn()){
    this.router.navigate(['/work']);
    }
  }

  register() {
    if (this.passConfirm === this.user.password) {
        this.auth.register(this.user).subscribe( (response) => {
          console.log(response);
        }, error => {
          console.log(error);
        });
    } else {
      alert('Password not equal');
    }
  }

}