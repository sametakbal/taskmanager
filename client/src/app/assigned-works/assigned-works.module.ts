import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { AssignedWorksComponent } from './assigned-works.component';
import { BrowserModule } from '@angular/platform-browser';
import { RouterModule } from '@angular/router';



@NgModule({
  declarations: [AssignedWorksComponent],
  imports: [
    CommonModule,
    BrowserModule,
    RouterModule
  ],
  exports: [AssignedWorksComponent]
})
export class AssignedWorksModule { }
