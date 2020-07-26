class User {
  int id;
  String name;
  String surname;
  String email;
  String userName;
  String password;
  String token;

  User(
      {this.id = 0,
      this.name,
      this.surname,
      this.email,
      this.userName,
      this.password});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    surname = json['surname'];
    email = json['email'];
    userName = json['userName'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['surname'] = this.surname;
    data['email'] = this.email;
    data['userName'] = this.userName;
    data['password'] = this.password;
    return data;
  }
}
