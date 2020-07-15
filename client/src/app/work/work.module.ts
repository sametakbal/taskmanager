import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { WorkComponent } from './work.component';
import { WorkDetailsComponent } from './work-details/work-details.component';
import { RouterModule } from '@angular/router';
import { WorkCreateComponent } from './work-create/work-create.component';
import { FormsModule } from '@angular/forms';



@NgModule({
  declarations: [WorkComponent, WorkDetailsComponent, WorkDetailsComponent, WorkCreateComponent],
  imports: [
    CommonModule,
    RouterModule,
    FormsModule
  ],
  exports: [WorkComponent]
})
export class WorkModule { }
