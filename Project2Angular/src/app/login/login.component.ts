import {Component, OnInit} from '@angular/core';
import {User, UserService} from '../user.service';
import {Router} from '@angular/router';


@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.css']
})

export class LoginComponent implements OnInit{

    username: string;
    password: string;

  login(): void {
    this.userService.loginUser(this.user).subscribe(
      response => {
        console.log(this.username, this.password);
        console.log(response);
        this.user.username = this.username;
        this.user.password = this.password;
        console.log(this.username, this.password);
        console.log(this.username, this.password);
        console.log(this.user.username!=null);
        if (this.user.username!=null) {this.router.navigate(['/past-recs']);}    
      },
      (err: any) => console.log(`Error: $(err)`)
    );

  }


  constructor(public userService: UserService,
              public user: User,
              public router: Router) { }

  ngOnInit() {
  }


}
