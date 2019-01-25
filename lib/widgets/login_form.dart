import 'package:flutter/material.dart';
import 'package:raid_list/models/user.dart';
import 'package:raid_list/widgets/form/buttons.dart';
import 'package:raid_list/widgets/form/fields.dart';

class LoginForm extends StatelessWidget {

  final _formKey = GlobalKey<FormState>();
  final loginInfo = User();

  Widget keepConnected(BuildContext context){
    bool state = false;
    return Switch(
      value: state,
      activeColor: Colors.blueAccent,
      onChanged: (bool active){
      
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          //logo
          DefaultField('username', false, (value) => loginInfo.username = value),
          SizedBox(height: 8.0),
          PasswordField((value) => loginInfo.password = value),
          SizedBox(height: 8.0),
          keepConnected(context),
          SizedBox(height: 8.0),
          LoginButton(_formKey, loginInfo),
          CreateAccountButton()
        ],
      ),
    );
  }

}