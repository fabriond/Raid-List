import 'package:flutter/material.dart';
import 'package:raid_list/widgets/user_form.dart';

class UserEditScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[400],
        appBar: AppBar(
          title: Text('Create User'),
        ),
        body: Padding(
          padding: EdgeInsets.only(left: 80.0, right:80.0),
          child: Center(
            child: SingleChildScrollView(child: UserForm())
          )
        )
      )
    );
  }
}