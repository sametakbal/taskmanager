import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { WorkComponent } from './work/work.component';
import { WorkCreateComponent } from './work/work-create/work-create.component';
import { RegisterComponent } from './core/register/register.component';
import { AssignedWorksComponent } from './assigned-works/assigned-works.component';
import { BusyUserComponent } from './assigned-works/busy-user/busy-user/busy-user.component';


const routes: Routes = [
  {path: '', component: RegisterComponent},
  {path: 'work', component: WorkComponent},
  {path: 'work-create', component: WorkCreateComponent},
  {path: 'work-create/:id', component: WorkCreateComponent},
  {path: 'assigned-works', component: AssignedWorksComponent},
  {path: 'assigned-works/:id', component: BusyUserComponent},
  {path: '**', redirectTo: '' , pathMatch: 'full'}
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
