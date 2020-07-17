import { Injectable } from '@angular/core';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { IWork, Work } from '../shared/models/work';
import { IUser } from '../shared/models/user';

@Injectable({
  providedIn: 'root'
})
export class WorkService {
  baseUrl = 'https://localhost:5001/api/';
  headers: HttpHeaders;
  id: number;
  constructor(private http: HttpClient) {
    this.id = +localStorage.getItem('id');
   }

  getWorks(sort: string) {
    const headers = new  HttpHeaders().set('Authorization', 'Bearer ' + localStorage.getItem('token'));
    return this.http.get<IWork[]>(this.baseUrl + 'works' + '/' + sort + '?id=' + this.id, {headers});
  }

  getAssignedWorks(personId: number) {
    const headers = new  HttpHeaders().set('Authorization', 'Bearer ' + localStorage.getItem('token'));
    return this.http.get<IWork[]>(this.baseUrl + 'works' + '/getAssignedWork?id=' + this.id + '&personId=' + personId, {headers});
  }

  addWork(work: Work) {
    const  headers = new  HttpHeaders().set('Authorization', 'Bearer ' + localStorage.getItem('token'));
    if (work.id === 0) {
    console.log(work);
    return this.http.post(this.baseUrl + 'works/add', work, {headers});
    } else {
    console.log(work);
    return this.http.post(this.baseUrl + 'works/update', work, {headers});
    }

  }

  getWork(id: number) {
    const  headers = new  HttpHeaders().set('Authorization', 'Bearer ' + localStorage.getItem('token'));
    return this.http.get<IWork>(this.baseUrl + 'works/' + id, {headers});
  }

  deleteWork(id: number) {
    const  headers = new  HttpHeaders().set('Authorization', 'Bearer ' + localStorage.getItem('token'));
    return this.http.delete(this.baseUrl + 'works/delete/' + id, {headers});
  }

  doneWork(id: number) {
    const  headers = new  HttpHeaders().set('Authorization', 'Bearer ' + localStorage.getItem('token'));
    return this.http.get<any>(this.baseUrl + 'works/done/?id=' + id, {headers});
  }

  getUserByEmail(email: string) {
    return this.http.get<IUser>(this.baseUrl + 'user/getUser?email=' + email);
  }

  assignWork(id: number, personid: number) {
    const headers = new  HttpHeaders().set('Authorization', 'Bearer ' + localStorage.getItem('token'));
    return this.http.get<any>(this.baseUrl + 'works' + '/assign' + '?id=' + id + '&personid=' + personid, {headers});
  }

  backAssignWork(id: number) {
    const headers = new  HttpHeaders().set('Authorization', 'Bearer ' + localStorage.getItem('token'));
    return this.http.get<any>(this.baseUrl + 'works' + '/backAssign' + '?id=' + id , {headers});
  }

}
