import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:raid_list/screens/group_edit_screen.dart';
import 'package:raid_list/models/user.dart';
import 'package:raid_list/models/group.dart';

class GroupList extends StatelessWidget {

  final User user;

  GroupList(this.user);

  void saveGroup(Group group){
    final groupsRef = Firestore.instance.collection('groups');
    final ref = groupsRef.document(group.id);
    ref.setData(group.toMap(), merge: true);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('groups').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError)
          return Text('Error: ${snapshot.error}');
        switch (snapshot.connectionState) {
          case ConnectionState.waiting: return Text('Loading...');
          default:
            return ListView(
              children: snapshot.data.documents.map((DocumentSnapshot document) {
                return ListTile(
                  title: Text(document['location']),
                  subtitle: Text(document['boss']),
                  onTap: () {
                    final group = Group.fromMap(document.data);
                    if(group.addMember(user)){
                      saveGroup(group);
                    } else{
                      //mostrar detalhes do grupo
                    }
                  },
                  onLongPress: () { 
                    final group = Group.fromMap(document.data);
                    Navigator.push(
                      context, 
                      MaterialPageRoute(builder: (context) => GroupEditScreen(user, group: group))
                    );
                  }
                );
              }).toList(),
            );
        }
      },
    );
  }
}