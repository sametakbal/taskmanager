import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { IWork, Work } from 'src/app/shared/models/work';
import { WorkService } from '../work.service';
import { AuthService } from 'src/app/core/auth.service';
import { IUser } from 'src/app/shared/models/user';

@Component({
  selector: 'app-work-create',
  templateUrl: './work-create.component.html',
  styleUrls: ['./work-create.component.scss']
})
export class WorkCreateComponent implements OnInit {
  work = new Work();
  user: IUser;
  search: string;
  submitted = false;
  id: number;
  result: boolean;

  constructor(private workService: WorkService, private activateRoute: ActivatedRoute,
              private router: Router, private auth: AuthService) { }

  ngOnInit(): void {
    if (!this.auth.loggedIn()) {
      this.router.navigate(['/']);
      }
    this.id = +this.activateRoute.snapshot.paramMap.get('id');
    if ( this.id !== 0) {
      this.getWork();
      this.result = false;
    } else {
      this.work.id = 0;
      this.work.ownerId = +localStorage.getItem('id');
    }
  }

  getWork() {
    this.workService.getWork(this.id).subscribe(res => {
      this.work = res;
      this.work.goalTime = this.work.goalTime.substring(0, 10);
      console.log(this.work.id);
    });
  }

  onSearch(term: string) {
    this.workService.getUserByEmail(term.search.toString()).subscribe(res => {
      this.user = res;
      this.result = false;
      console.log(res);
    },error => {
      alert('User Not found');
      this.result = true;
    }
    );
  }
  assignWork() {
    this.workService.assignWork(this.id , this.user.id).subscribe( res => {
      console.log(res);
      alert('Assigned');
    });
  }
  onSubmit(model: Work) {
    this.workService.addWork(model)
    .subscribe((result) => {
      console.log(result);
      this.router.navigate(['/']);
    });
  }
}
