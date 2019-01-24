import 'package:flutter/material.dart';
import 'package:raid_list/widgets/group_list.dart';
import 'package:raid_list/screens/group_edit_screen.dart';

class GroupsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Raid Groups'),
      ),
      body: Center(
        child: GroupList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context, 
          MaterialPageRoute(builder: (context) => GroupEditScreen())
        ),
        tooltip: 'Create Group',
        child: Icon(Icons.add),
      ),
    );
  }
}