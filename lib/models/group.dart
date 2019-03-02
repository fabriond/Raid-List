import 'package:raid_list/models/user.dart';
import 'package:raid_list/controllers/group_controller.dart';

class Group {
  String id;
  String name;
  String description;
  List<String> members;

  Group({this.id, this.name, this.description, this.members}){
    if(this.members == null){
      this.members = [];
    }
  }

  factory Group.fromMap(Map<String, dynamic> group){
    return Group(
      id: group['id'],
      name: group['name'],
      description: group['description'],
      members: List.from(group['members'], growable: true)
    );
  }

  Map<String, dynamic> toMap(){
    final map = Map<String, dynamic>();
    map.putIfAbsent('id', () => this.id);
    map.putIfAbsent('name', () => name);
    map.putIfAbsent('description', () => description);
    map.putIfAbsent('members', () => members);
    return map;
  }

  bool addMember(User newMember){
    if(!members.contains(newMember.username)){
      members.add(newMember.username);
      GroupController.update(this);
      return true;
    }
    return false;
  }
}