import 'package:flutter/material.dart';
import 'package:raid_list/widgets/login_form.dart';
import 'package:raid_list/models/user.dart';

class LoginScreen extends StatelessWidget {

  final User loginInfo;

  LoginScreen(this.loginInfo);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[400],
        appBar: AppBar(
          title: Text('Raid List App'),
        ),
        body: Padding(
          padding: EdgeInsets.only(left: 80.0, right: 80.0),
          child: Center(
            child: SingleChildScrollView(child: LoginForm(loginInfo))
          )
        )
      )
    );
  }
}