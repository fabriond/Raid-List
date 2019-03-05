import 'package:flutter/material.dart';
import 'package:raid_list/screens/splash_screen.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Raid List',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        primaryColor: Colors.blue,                //Used because dark theme has black as default primaryColor
        accentColor: Colors.lightBlueAccent[400], //Used because dark theme has green as default accentColor
        textSelectionHandleColor: Colors.blueAccent,
        
        buttonTheme: ButtonThemeData(
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.lightBlue,  //Positive button (any)
            backgroundColor: Colors.blueGrey, //Cancel button
            errorColor: Colors.redAccent      //Delete button
          )
        ),
        
        brightness: Brightness.dark,
      ),
      home: SplashScreen(),     
    );
  }
}
