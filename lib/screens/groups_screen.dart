import 'package:flutter/material.dart';
import 'package:raid_list/widgets/group_list.dart';
import 'package:raid_list/models/group.dart';
import 'package:raid_list/widgets/group_form.dart';
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
          onPressed: () => showDialog(
            context: context, 
            builder: (context) {
              return GroupForm(user, group: Group());
            }
          ),
          tooltip: 'Create Group',
          child: Icon(Icons.add),
        ),
      )
    );
  }
}