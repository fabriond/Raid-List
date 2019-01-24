import 'package:flutter/material.dart';
import 'package:raid_list/widgets/group_form.dart';

class GroupEditScreen extends StatelessWidget {
  final Map<String, String> group;

  GroupEditScreen({this.group});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Raid Groups'),
      ),
      body: GroupForm(group: this.group ?? Map<String, String>())
    );
  }
}