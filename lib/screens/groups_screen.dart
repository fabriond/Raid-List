import 'package:flutter/material.dart';
import 'package:raid_list/widgets/group_list.dart';
import 'package:raid_list/models/group.dart';
import 'package:raid_list/widgets/group_form.dart';
import 'package:raid_list/widgets/group_search.dart';
import 'package:raid_list/models/user.dart';
import 'package:raid_list/widgets/form/buttons.dart';

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
        endDrawer: Drawer(
          child: ListView(
            children: <Widget>[
              ListTile(
                title: Text('Profile'),
                onTap: () {
                  //build User class as widget and return it
                },
              ),
              ListTile(
                title: Text('Join Group (Requires group key)'),
                onTap: () {
                  Navigator.pop(context);
                  showDialog(
                    context: context, 
                    builder: (context) {
                      return GroupSearch(user);
                    }
                  );
                },
              ),
              ListTile(
                title: Text('Create Group'),
                onTap: () {
                  Navigator.pop(context);
                  showDialog(
                    context: context, 
                    builder: (context) {
                      return GroupForm(user, group: Group());
                    }
                  );
                },
              ),
              ListTile(
                title: Text('Logout'),
                onTap: () {
                  //maybe do a countdown onTap and logout onLongPress
                  //to make sure the user intends to logout
                  User.logout(context);
                },
              )
            ],
          ),
        ),
      )
    );
  }
}