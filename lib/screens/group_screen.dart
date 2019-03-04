import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:raid_list/models/user.dart';
import 'package:raid_list/models/raid.dart';
import 'package:raid_list/models/group.dart';
import 'package:raid_list/widgets/raid/raid_form.dart';
import 'package:raid_list/widgets/raid/raid_list.dart';
import 'package:raid_list/widgets/dialogs/confirm_dialog.dart';

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
                title: Center(child: Text(group.name, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),)),
                subtitle: Column(
                  children: <Widget>[
                    Center(child: Text(group.description)),
                    FlatButton.icon(
                      label: Text('Copy Group Invite Key'),
                      icon: Icon(Icons.content_copy),
                      onPressed: () {
                        Clipboard.setData(ClipboardData(text: group.id));
                      },
                      color: Colors.grey[100],
                    ),
                  ],
                ),
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
              ),
              ListTile(
                title: Text('Leave Group'),
                onTap: (){
                  Navigator.pop(context);
                  showDialog(
                    context: context,
                    builder: (context) => ConfirmDialog('Leave Group?', () {
                      group.removeMember(user);
                      user.leaveGroup(group);
                      Navigator.pop(context);
                    })
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