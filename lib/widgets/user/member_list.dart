import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:raid_list/controllers/group_controller.dart';
import 'package:raid_list/controllers/raid_controller.dart';
import 'package:raid_list/models/user.dart';
import 'package:raid_list/models/group.dart';
import 'package:raid_list/models/raid.dart';
import 'package:raid_list/widgets/loading_icon.dart';


class MemberList extends StatelessWidget {

  final User user;

  //This class either has a group or a raid, but never both
  final Group group;
  final Raid raid;

  MemberList(this.user, {this.group, this.raid});

  CollectionReference getRef(){
    if(group != null) return GroupController.membersRef(group.id);
    else if(raid != null) return RaidController.membersRef(raid);
    else return null;
  }

  Icon getIcon(bool isReady){
    if(group != null) return null;
    if(isReady) return Icon(Icons.check_circle, color: Colors.green);
    else return Icon(Icons.access_time, color: Colors.yellow[900]);
  }

  Widget getTileContent(DocumentSnapshot document){
    bool isReady;
    double boxWidth = 0.0;
    if(raid != null){
      isReady = document.data['isReady'];
      boxWidth = 5.0;
    }
    final content = Row(
      children: <Widget>[
        getIcon(isReady) ?? SizedBox(width: 0.0, height: 0.0),
        SizedBox(width: boxWidth),
        Text(document.documentID),
      ],
    );
    return content;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: getRef().snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError)
          return Text('Error: ${snapshot.error}');
        switch (snapshot.connectionState) {
          case ConnectionState.waiting: return LoadingIcon();
          default:
            return ListView(
              children: snapshot.data.documents.map((DocumentSnapshot document) {
                return ListTile(
                  title: getTileContent(document)
                );
              }).toList(),
            );
        }
      },
    );
  }
}