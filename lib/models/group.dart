import 'package:raid_list/models/user.dart';

class Group {
  String id;
  String boss;
  String location;
  List<String> members;

  Group({this.id, this.boss, this.location, this.members}){
    if(this.members == null){
      this.members = [];
    }
  }

  factory Group.fromMap(Map<String, dynamic> group){
    return Group(
      id: group['id'], 
      boss: group['boss'], 
      location: group['location'], 
      members: List.from(group['members'], growable: true)
    );
  }

  Map<String, dynamic> toMap(){
    final map = Map<String, dynamic>();
    map.putIfAbsent('id', () => this.id);
    map.putIfAbsent('boss', () => boss);
    map.putIfAbsent('location', () => location);
    map.putIfAbsent('members', () => members);
    return map;
  }

  bool addMember(User newMember){
    if(!members.contains(newMember.username)){
      members.add(newMember.username);
      return true;
    }
    return false;
  }
}