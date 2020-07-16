import { Injectable } from '@angular/core';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { IWork, Work } from '../shared/models/work';

@Injectable({
  providedIn: 'root'
})
export class WorkService {
  baseUrl = 'https://localhost:5001/api/';
  headers: HttpHeaders;
  constructor(private http: HttpClient) {
   }

  getWorks(sort: string) {
    const headers = new  HttpHeaders().set('Authorization', 'Bearer ' + localStorage.getItem('token'));
    return this.http.get<IWork[]>(this.baseUrl + 'works' + '/' + sort, {headers});
  }

  addWork(work: Work) {
    const  headers = new  HttpHeaders().set('Authorization', 'Bearer ' + localStorage.getItem('token'));
    if (work.id === 0) {
     return this.http.post(this.baseUrl + 'works/add', work, {headers});
    } else {
     return this.http.post(this.baseUrl + 'works/update', work);
    }

  }

  getWork(id: number) {
    return this.http.get<IWork>(this.baseUrl + 'works/' + id);
  }

  deleteWork(id: number) {
    return this.http.delete(this.baseUrl + 'works/delete/' + id);
  }

}
