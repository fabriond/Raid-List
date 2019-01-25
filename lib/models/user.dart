class User {
  String username;
  String password;

  User({this.username, this.password});

  factory User.fromMap(Map<String, dynamic> user){
    return User(username: user['username'], password: user['password']);
  }

  Map<String, dynamic> toMap(){
    final map = Map<String, dynamic>();
    map.putIfAbsent('username', () => username);
    map.putIfAbsent('password', () => password);
    return map;
  }
}