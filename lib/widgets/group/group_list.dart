import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:raid_list/widgets/group/group_form.dart';
import 'package:raid_list/models/user.dart';
import 'package:raid_list/models/group.dart';
import 'package:raid_list/screens/group_screen.dart';
import 'package:raid_list/widgets/loading_icon.dart';

class GroupList extends StatelessWidget {

  final User user;

  GroupList(this.user);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('groups').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError)
          return Text('Error: ${snapshot.error}');
        switch (snapshot.connectionState) {
          case ConnectionState.waiting: return LoadingIcon();
          default:
            return ListView(
              children: snapshot.data.documents.map((DocumentSnapshot document) {
                final group = Group.fromMap(document.data);
                if(user.groups.contains(group.id)){
                  return ListTile(
                    title: Text(group.name), //TODO: decide wether to center this text horizontally
                    //subtitle: Center(child: Text(group.description)),
                    trailing: IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        showDialog(
                          context: context, 
                          builder: (context) {
                            return GroupForm(user, group: group);
                          }
                        );
                      },
                    ),
                    onTap: () {
                      Navigator.push(
                        context, 
                        MaterialPageRoute(builder: (context) => GroupScreen(user, group))
                      );
                    },
                  );
                }
              }).where((tile) => tile != null).toList(),
            );
        }
      },
    );
  }
}