import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:raid_list/models/user.dart';
import 'package:raid_list/models/raid.dart';
import 'package:raid_list/models/group.dart';
import 'package:raid_list/widgets/raid/raid_form.dart';
import 'package:raid_list/widgets/raid/raid_list.dart';
import 'package:raid_list/controllers/group_controller.dart';
import 'package:raid_list/widgets/dialogs/confirm_dialog.dart';
import 'package:raid_list/widgets/user/member_list.dart';

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
                    SizedBox(height: 5),
                    FlatButton.icon(
                      label: Text('Copy Group Invite Key'),
                      icon: Icon(Icons.content_copy),
                      onPressed: () {
                        Clipboard.setData(ClipboardData(text: group.id));
                      },
                      color: Theme.of(context).highlightColor
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
                        child: MemberList(user, group: group)
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
                      GroupController.removeMember(group, user);
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