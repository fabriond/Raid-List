import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:raid_list/models/user.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:raid_list/widgets/form/buttons.dart';
import 'package:raid_list/widgets/form/fields.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginForm extends StatefulWidget {

  static final _formKey = GlobalKey<FormState>();
  final User loginInfo = User();
  final usernameFocus = FocusNode();
  final passwordFocus = FocusNode();
  final recognizer = TapGestureRecognizer();
  
  void launchLogoURL() async {
    const url = 'http://www.freepik.com';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  
  LoginForm(){
    recognizer.onTap = launchLogoURL;
  }

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
  
  Widget rememberMe(BuildContext context){
    if(!remember) removeLoginInfo();
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Spacer(flex: 2),
        Text("Remember me"),
        Spacer(),
        Switch(
          value: remember,
          activeColor: Theme.of(context).buttonTheme.colorScheme.primary,
          onChanged: (bool value){
            setState(() => remember = value);
          }
        ),
        Spacer(flex: 2),
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
          Image.asset('assets/logo.png', height: 155, width: 143.7),
          RichText(
            text: TextSpan(
              text: 'Logo by Freepik', 
              style: TextStyle(color: Theme.of(context).hintColor),
              recognizer: widget.recognizer
            )
          ),
          SizedBox(height: 16.0),
          DefaultField('username', (value) => widget.loginInfo.username = value, widget.usernameFocus, nextFocus: widget.passwordFocus),
          SizedBox(height: 8.0),
          PasswordField((value) => widget.loginInfo.password = value, widget.passwordFocus),
          SizedBox(height: 8.0),
          rememberMe(context),
          LoginButton(LoginForm._formKey, widget.loginInfo, remember: remember),
          CreateAccountButton()
        ],
      ),
    );
  }

}