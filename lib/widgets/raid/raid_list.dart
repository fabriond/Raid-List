import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:raid_list/widgets/raid/raid_form.dart';
import 'package:raid_list/models/user.dart';
import 'package:raid_list/models/group.dart';
import 'package:raid_list/models/raid.dart';
import 'package:raid_list/widgets/loading_icon.dart';
import 'package:raid_list/widgets/dialogs/confirm_dialog.dart';


class RaidList extends StatelessWidget {

  final User user;
  final Group group;

  RaidList(this.user, this.group);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('groups').document(group.id).collection('raids').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError)
          return Text('Error: ${snapshot.error}');
        switch (snapshot.connectionState) {
          case ConnectionState.waiting: return LoadingIcon();
          default:
            return ListView(
              children: snapshot.data.documents.map((DocumentSnapshot document) {
                final raid = Raid.fromMap(document.data);
                return ListTile(
                  title: Center(child: Text(raid.location)),
                  subtitle: Center(child: Text(raid.boss)),
                  trailing: IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      showDialog(
                        context: context, 
                        builder: (context) {
                          return RaidForm(user, group, raid: raid);
                        }
                      );
                    },
                  ),
                  onTap: () {
                    //TODO: maybe add a raid screen or just show members and info here
                    /*Navigator.push(
                      context, 
                      MaterialPageRoute(builder: (context) => )//TODO: add raid_screen.dart and call RaidScreen here
                    );*/
                  },
                  onLongPress: (){
                    if(!raid.members.contains(user.username)){
                      showDialog(
                        context: context,
                        builder: (context) => ConfirmDialog('Join raid?', () => raid.addMember(user))
                      );
                    } else {
                      showDialog(
                        context: context,
                        builder: (context) => ConfirmDialog('Leave raid?', () => raid.removeMember(user))
                      );
                    }
                  },
                );
              }).toList(),
            );
        }
      },
    );
  }
}