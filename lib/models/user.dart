import 'package:flutter/material.dart';
import 'package:password/password.dart';
import 'package:raid_list/models/group.dart';
import 'package:raid_list/screens/login_screen.dart';
import 'package:raid_list/screens/groups_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:raid_list/controllers/user_controller.dart';

class User {
  String username;
  String password;
  List<String> groups;

  User({this.username, this.password, this.groups}){
    if(this.groups == null){
      this.groups = [];
    }
  }

  factory User.fromMap(Map<String, dynamic> user){
    return User(
      username: user['username'], 
      password: user['password'], 
      groups: List.from(user['groups'], growable: true)
    );
  }

  Map<String, dynamic> toMap(){
    final map = Map<String, dynamic>();
    map.putIfAbsent('username', () => username);
    map.putIfAbsent('password', () => password);
    map.putIfAbsent('groups', () => groups);
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

  bool addGroup(Group newGroup){
    if(!groups.contains(newGroup.id)){
      groups.add(newGroup.id);
      UserController.update(this);
      return true;
    }
    return false;
  }
}