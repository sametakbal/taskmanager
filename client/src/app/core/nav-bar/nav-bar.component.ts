import { Component, OnInit } from '@angular/core';
import { AuthService } from '../auth.service';
import { Router } from '@angular/router';

@Component({
  selector: 'app-nav-bar',
  templateUrl: './nav-bar.component.html',
  styleUrls: ['./nav-bar.component.scss']
})
export class NavBarComponent implements OnInit {
  model: any = {};
  constructor(private auth: AuthService, private router: Router) { }

  ngOnInit(): void {
  }

  login() {
    this.auth.login(this.model).subscribe(next => {
      window.location.reload();
      console.log('success');
    }, error => {
      alert('wrong password or username');
      console.log('error');
    });
  }

  loggedIn() {
    return this.auth.loggedIn();
  }

  logout() {
    localStorage.removeItem('token');
    localStorage.removeItem('id');
    this.router.navigate(['/']);
    console.log('logout');
  }
}
