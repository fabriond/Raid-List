import 'package:flutter/material.dart';
import 'package:raid_list/widgets/group_form.dart';
import 'package:raid_list/models/user.dart';
import 'package:raid_list/models/group.dart';

class GroupEditScreen extends StatelessWidget {
  final Group group;
  final User user;

  GroupEditScreen(this.user, {this.group});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Raid Groups'),
        ),
        body: Padding(
          padding: EdgeInsets.only(left: 80.0, right:80.0),
          child: Center(
            child: SingleChildScrollView(child: GroupForm(user, group: this.group ?? Group()))
          )
        )
      )
    );
  }
}