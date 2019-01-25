import 'package:flutter/material.dart';
import 'package:raid_list/widgets/group_list.dart';
import 'package:raid_list/screens/group_edit_screen.dart';
import 'package:raid_list/models/user.dart';

class GroupsScreen extends StatelessWidget {

  final User user;

  GroupsScreen(this.user);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Raid Groups'),
        ),
        body: Center(
          child: GroupList(user),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.push(
            context, 
            MaterialPageRoute(builder: (context) => GroupEditScreen(user))
          ),
          tooltip: 'Create Group',
          child: Icon(Icons.add),
        ),
      )
    );
  }
}