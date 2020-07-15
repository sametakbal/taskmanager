import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { IWork, Work } from '../shared/models/work';

@Injectable({
  providedIn: 'root'
})
export class WorkService {
  baseUrl = 'https://localhost:5001/api/';

  constructor(private http: HttpClient) { }

  getWorks(sort: string) {
    return this.http.get<IWork[]>(this.baseUrl + 'works' + '/' + sort);
  }

  addWork(work: Work) {
    if (work.id === 0) {
     return this.http.post(this.baseUrl + 'works/add', work);
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
