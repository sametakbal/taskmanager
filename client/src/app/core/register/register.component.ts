import { Component, OnInit } from '@angular/core';
import { User } from 'src/app/shared/models/user';
import { NgForm } from '@angular/forms';
import { AuthService } from '../auth.service';
import { Router } from '@angular/router';
import { TranslationWidth } from '@angular/common';

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
    if (this.auth.loggedIn()) {
    this.router.navigate(['/work']);
    }
  }

  register() {
    if(this.passConfirm === this.user.password){
        this.auth.register(this.user).subscribe( (response) => {
          alert('Register succesfull, you can login');
          console.log(response);
        }, error => {
          alert(error.error[0].description);
        });
      }else {
        alert('Passwords are not equal!');
      }
  }

}
