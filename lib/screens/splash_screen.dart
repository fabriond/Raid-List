import 'package:flutter/material.dart';
import 'package:raid_list/screens/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:raid_list/models/user.dart';
import 'package:raid_list/widgets/loading_icon.dart';

class SplashScreen extends StatelessWidget{
  
  void autoLogin(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final loginInfo = User();
    loginInfo.username = prefs.getString('username');
    loginInfo.password = prefs.getString('password');
    if(loginInfo.username != null && loginInfo.password != null){
      User.login(context, loginInfo);
    } else {
      Navigator.pushReplacement(
        context, 
        MaterialPageRoute(builder: (context) => LoginScreen())
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    autoLogin(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Raid List App'),
        ),
        body: LoadingIcon()
      )
    );
  }
}