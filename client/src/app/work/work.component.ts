import { Component, OnInit } from '@angular/core';
import { IWork } from '../shared/models/work';
import { WorkService } from './work.service';

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
  constructor(private workService: WorkService) { }

  ngOnInit(): void {
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
