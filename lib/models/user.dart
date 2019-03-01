import 'package:flutter/material.dart';
import 'package:password/password.dart';
import 'package:raid_list/screens/login_screen.dart';
import 'package:raid_list/screens/groups_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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

  static Future<bool> login(BuildContext context, User loginInfo) async {
    final ref = Firestore.instance.collection('users');
    final document = await ref.document(loginInfo.username).get();
    if(!document.exists){
      //if there's no user with such name in the database
      Scaffold.of(context).showSnackBar(SnackBar(content: Text('Invalid username')));
      return false;
    } else {
      final user = User.fromMap(document.data);
      if(!Password.verify(loginInfo.password, user.password)){
        //if the password is incorrect
        Scaffold.of(context).showSnackBar(SnackBar(content: Text('Incorrect password')));
        return false;
      } else{
        //login success
        Navigator.pushReplacement(
          context, 
          MaterialPageRoute(builder: (context) => GroupsScreen(user))
        );
        return true;
      }
    }
  }

  static void logout(BuildContext context){
    Navigator.of(context).popUntil((route) => route.isFirst);
    Navigator.pushReplacement(
      context, 
      MaterialPageRoute(builder: (context) => LoginScreen())
    );
  }
}