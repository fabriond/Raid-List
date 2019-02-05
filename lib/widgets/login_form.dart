import 'package:flutter/material.dart';
import 'package:raid_list/models/user.dart';
import 'package:raid_list/widgets/form/buttons.dart';
import 'package:raid_list/widgets/form/fields.dart';

class LoginForm extends StatelessWidget {

  static final _formKey = GlobalKey<FormState>();
  final loginInfo = User();
  final usernameFocus = FocusNode();
  final passwordFocus = FocusNode();

  Widget rememberMe(BuildContext context){
    bool state = false;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text("Remember me"),
        SizedBox(width: 20),
        Switch(
          value: state,
          activeColor: Colors.blueAccent,
          onChanged: (bool active){
            //make do
          }
        )
      ]
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
          DefaultField('username', (value) => loginInfo.username = value, usernameFocus, nextFocus: passwordFocus),
          SizedBox(height: 8.0),
          PasswordField((value) => loginInfo.password = value, passwordFocus),
          SizedBox(height: 8.0),
          rememberMe(context),
          SizedBox(height: 8.0),
          LoginButton(_formKey, loginInfo),
          CreateAccountButton()
        ],
      ),
    );
  }

}