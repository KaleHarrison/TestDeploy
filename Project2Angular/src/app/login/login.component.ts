import {Component, OnInit} from '@angular/core';
import {User, UserAttempt, UserService} from '../user.service';
import {Router} from '@angular/router';


@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.css']
})
export class LoginComponent implements OnInit{

  user: User = {
    id: null,
    email: null,
    username: null,
    password: null,
    firstname: null,
    lastname: null
  };

  userAttempt: UserAttempt = {
    username: null,
    password: null
  };



  login(): User {
    this.userService.loginUser(this.userAttempt).subscribe(
      response => {
        console.log(this.userAttempt);
        // @ts-ignore
        this.user = response;
        console.log(response);

        console.log(this.user)
      },
      (err: any) => console.log(`Error: $(err)`)
    );
    return this.user;
   // if (this.user.id>-1) {this.router.navigate(['/past-recs']);}
  }

  constructor(private userService: UserService,
              private router: Router) { }

  ngOnInit() {
    // this.userService.getUser().subscribe(
    //   //success
    //   data => this.user = data,
    //   //failure
    //   err => console.log(`Error: ${err}`))

    // this.userService.loginUser(this.user).subscribe(
    //   data => this.user = data,
    //   err => console.log(`Error: $(err)`)
    // )
  }


}