import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { IUser } from '../shared/models/user';

@Injectable({
  providedIn: 'root'
})
export class UserService {
  baseUrl = 'https://localhost:5001/api/user/';
  id: number;
  constructor(private http: HttpClient) {
    this.id = +localStorage.getItem('id');
  }

  getUsers() {
    return this.http.get<IUser[]>(this.baseUrl + 'getUsers' + '/' + '?id=' + this.id);
  }
}
