import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { WorkComponent } from './work.component';
import { RouterModule } from '@angular/router';
import { WorkCreateComponent } from './work-create/work-create.component';
import { FormsModule } from '@angular/forms';



@NgModule({
  declarations: [WorkComponent, WorkCreateComponent],
  imports: [
    CommonModule,
    RouterModule,
    FormsModule
  ],
  exports: [WorkComponent]
})
export class WorkModule { }
