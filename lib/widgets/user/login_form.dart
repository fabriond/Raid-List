import 'package:flutter/material.dart';
import 'package:raid_list/models/user.dart';
import 'package:raid_list/widgets/form/buttons.dart';
import 'package:raid_list/widgets/form/fields.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginForm extends StatefulWidget {

  static final _formKey = GlobalKey<FormState>();
  final User loginInfo = User();
  final usernameFocus = FocusNode();
  final passwordFocus = FocusNode();

  @override
  State<StatefulWidget> createState() => LoginFormState();
}

class LoginFormState extends State<LoginForm>{
  
  bool remember = false;

  void removeLoginInfo() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('username');
    prefs.remove('password');
  }
  
  Widget rememberMe(){
    if(!remember) removeLoginInfo();
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text("Remember me"),
        SizedBox(width: 20),
        Switch(
          value: remember,
          activeColor: Colors.blueAccent,
          onChanged: (bool value){
            setState(() => remember = value);
          }
        )
      ]
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: LoginForm._formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          //logo
          DefaultField('username', (value) => widget.loginInfo.username = value, widget.usernameFocus, nextFocus: widget.passwordFocus),
          SizedBox(height: 8.0),
          PasswordField((value) => widget.loginInfo.password = value, widget.passwordFocus),
          SizedBox(height: 8.0),
          rememberMe(),
          SizedBox(height: 8.0),
          LoginButton(LoginForm._formKey, widget.loginInfo, remember: remember),
          CreateAccountButton()
        ],
      ),
    );
  }

}