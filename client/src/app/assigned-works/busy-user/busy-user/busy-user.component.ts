import { Component, OnInit } from '@angular/core';
import { Router, ActivatedRoute } from '@angular/router';
import { WorkService } from 'src/app/work/work.service';
import { IWork } from 'src/app/shared/models/work';
import { User } from 'src/app/shared/models/user';
import { UserService } from '../../user.service';

@Component({
  selector: 'app-busy-user',
  templateUrl: './busy-user.component.html',
  styleUrls: ['./busy-user.component.scss']
})
export class BusyUserComponent implements OnInit {
  works: IWork[];
  user: User;
  id: number;
  constructor(private workService: WorkService, private router: Router, private activateRoute: ActivatedRoute,
              private userService: UserService) { }

  ngOnInit(): void {
    this.id = +this.activateRoute.snapshot.paramMap.get('id');
    if (this.id === 0) {
      this.router.navigate(['/works']);
    } else {
      this.getUser();
      this.getWorks();
    }
  }

  getWorks() {
    this.workService.getAssignedWorks(this.id).subscribe( res => {
      this.works = res;
    }, error => {
      alert(error);
    });
  }
  getUser() {
    this.userService.getUser(this.id).subscribe(res => {
      this.user = res;
    }, error => {
      alert(error);
    });
  }

  backAssign(id: number) {
    this.workService.backAssignWork(id).subscribe(res => {
      console.log(res);
      this.getWorks();
    }, error => {
      alert(error);
    });
  }

}
