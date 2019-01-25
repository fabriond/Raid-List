import 'package:flutter/material.dart';
import 'package:raid_list/models/user.dart';
import 'package:raid_list/widgets/form/buttons.dart';
import 'package:raid_list/widgets/form/fields.dart';

class LoginScreen extends StatelessWidget {

  final _formKey = GlobalKey<FormState>();
  final loginInfo = User();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[400],
        appBar: AppBar(
          title: Text('Raid Groups'),
        ),
        body: Padding(
          padding: EdgeInsets.only(left: 80.0, right: 80.0),
          child: Center(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  //logo
                  SizedBox(height: 96.0),
                  DefaultField('username', (value) => loginInfo.username = value),
                  SizedBox(height: 8.0),
                  PasswordField((value) => loginInfo.password = value),
                  SizedBox(height: 8.0),
                  LoginButton(_formKey, loginInfo),
                  CreateAccountButton()
                ],
              ),
            ),
          )
        )
      )
    );
  }
}