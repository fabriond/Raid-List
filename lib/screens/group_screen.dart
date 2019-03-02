import 'package:flutter/material.dart';
import 'package:raid_list/models/user.dart';
import 'package:raid_list/models/raid.dart';
import 'package:raid_list/models/group.dart';
import 'package:raid_list/widgets/raid_form.dart';
import 'package:raid_list/widgets/raid_list.dart';

class GroupScreen extends StatelessWidget{
  
  final User user;
  final Group group;

  GroupScreen(this.user, this.group);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text(group.name)),
        body: RaidList(user, group),
        endDrawer: Drawer(
          child: ListView(
            children: <Widget>[
              ListTile(
                title: Center(child: Text(group.name)),
                subtitle: Center(child: Text(group.description)),
              ),
              ListTile(
                title: Text('View Members'),
                onTap: () {
                  Navigator.pop(context);
                  showDialog(
                    context: context, 
                    builder: (context) {
                      return Dialog(
                        child: ListView(
                          children: group.members.map((m) => ListTile(title: Text(m))).toList()
                        )
                      );
                    }
                  );
                },
              ),
              ListTile(
                title: Text('Create Raid'),
                onTap: (){
                  Navigator.pop(context);
                  showDialog(
                    context: context, 
                    builder: (context) {
                      return RaidForm(user, group, raid: Raid());
                    }
                  );
                },
              )
            ],
          )
        ),
      )
    );
  }
}