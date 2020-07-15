import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { IWork, Work } from 'src/app/shared/models/work';
import { WorkService } from '../work.service';

@Component({
  selector: 'app-work-create',
  templateUrl: './work-create.component.html',
  styleUrls: ['./work-create.component.scss']
})
export class WorkCreateComponent implements OnInit {
  work = new Work();
  submitted = false;
  id: number;

  constructor(private workService: WorkService, private activateRoute: ActivatedRoute, private router: Router) { }

  ngOnInit(): void {
    this.id = +this.activateRoute.snapshot.paramMap.get('id');
    if ( this.id !== 0) {
      this.getWork();
    } else {
      this.work.id = 0;
    }
  }

  getWork() {
    this.workService.getWork(this.id).subscribe(res => {
      this.work = res;
      this.work.goalTime = this.work.goalTime.substring(0, 10);
      console.log(this.work.id);
    });
  }

  onSubmit(model: Work) {
    this.workService.addWork(model)
    .subscribe((result) => {
      console.log(result);
    });
    this.router.navigate(['/']);
  }

}
