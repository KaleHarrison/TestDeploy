import { Injectable, Input } from '@angular/core';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Observable } from 'rxjs';


const httpOptions = {
  headers: new HttpHeaders({
    'Content-Type': 'application/json',
    'Authorization': 'my-auth-token'
  })
};

@Injectable({
  providedIn: 'root',
})

@Injectable()
export class UserService {

  constructor(private http: HttpClient) { }
  //private baseUrl: string = 'http://localhost:8080/Project2/rest/';
  private baseUrl: string = 'http://54.145.242.129:8080/Project2/rest/'

  loginUser(userAttempt: User): Observable<User> {
    return this.http.post<User>(this.baseUrl + "user", userAttempt);
  }

  registerUser(userAttempt: User): Observable<User> {
    //http://54.145.242.129:8080/Project2/rest/user/register
    return this.http.put<User>(this.baseUrl + "user/register", userAttempt);
  }

}

@Injectable()
export class User {
  username: string;
  password: string;
  firstName: string;
  lastName: string;
  email: string;
}

