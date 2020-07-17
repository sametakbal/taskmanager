import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { IUser, IBusyUser } from '../shared/models/user';
import { UserService } from './user.service';

@Component({
  selector: 'app-assigned-works',
  templateUrl: './assigned-works.component.html',
  styleUrls: ['./assigned-works.component.scss']
})
export class AssignedWorksComponent implements OnInit {
  users: IBusyUser[];

  constructor( private router: Router, private userService: UserService) { }

  ngOnInit(): void {
    this.getUsers();
  }

  getUsers() {
    this.userService.getUsers().subscribe( res => {
      this.users = res;
    }, error => {
      console.log(error);
    });
  }

}
