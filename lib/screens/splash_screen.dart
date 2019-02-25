import 'package:flutter/material.dart';
import 'package:raid_list/screens/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:raid_list/models/user.dart';

class SplashScreen extends StatelessWidget{
  
  Future<LoginScreen> autoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    final loginInfo = User();
    loginInfo.username = prefs.getString('username');
    loginInfo.password = prefs.getString('password');
    return LoginScreen(loginInfo);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FutureBuilder(
        initialData: CircularProgressIndicator(),
        future: autoLogin(),
        builder: (context, snapshot) => snapshot.data,
      )
    );
  }
}