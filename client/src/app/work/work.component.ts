import { Component, OnInit } from '@angular/core';
import { IWork } from '../shared/models/work';
import { WorkService } from './work.service';
import { Router } from '@angular/router';
import { AuthService } from '../core/auth.service';

@Component({
  selector: 'app-work',
  templateUrl: './work.component.html',
  styleUrls: ['./work.component.scss']
})
export class WorkComponent implements OnInit {
  works: IWork[];
  sort = '';
  sortOptions = [
    {name: 'This week', value: ''},
    {name: 'This Month', value: 'getMonth'},
    {name: 'This Year', value: 'getYear'}
  ];
  constructor(private workService: WorkService, private router: Router, private auth: AuthService) { }

  ngOnInit(): void {
    if (!this.auth.loggedIn()){
      this.router.navigate(['/']);
      }
    this.getWorks();
  }

  getWorks() {
    this.workService.getWorks(this.sort).subscribe(response => {
      this.works = response;
    }, error => {
      console.log(error);
    });
  }

  onSortSelected(val: string) {
    this.sort = val;
    console.log(this.sort);
    this.getWorks();
  }

  deleteWork(id: number) {
    this.workService.deleteWork(id).subscribe(res => {
      alert(res);
      this.getWorks();
    });
  }
}
