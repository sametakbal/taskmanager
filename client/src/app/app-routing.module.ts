import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { WorkComponent } from './work/work.component';
import { WorkCreateComponent } from './work/work-create/work-create.component';


const routes: Routes = [
  {path: '', component: WorkComponent},
  {path: 'work-create', component: WorkCreateComponent},
  {path: 'work-create/:id', component: WorkCreateComponent},
  {path: '**', redirectTo: '' , pathMatch: 'full'}
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
