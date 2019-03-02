import 'package:raid_list/models/user.dart';
import 'package:raid_list/controllers/raid_controller.dart';

class Raid {
  String id;
  String groupId;
  String location;
  String boss;
  List<String> members;

  Raid({this.id, this.groupId, this.location, this.boss, this.members}){
    if(this.members == null){
      this.members = [];
    }
  }

  factory Raid.fromMap(Map<String, dynamic> raid){
    return Raid(
      id: raid['id'],
      groupId: raid['groupId'],
      boss: raid['boss'],
      location: raid['location'],
      members: List.from(raid['members'], growable: true)
    );
  }

  Map<String, dynamic> toMap(){
    final map = Map<String, dynamic>();
    map.putIfAbsent('id', () => id);
    map.putIfAbsent('groupId', () => groupId);
    map.putIfAbsent('boss', () => boss);
    map.putIfAbsent('location', () => location);
    map.putIfAbsent('members', () => members);
    return map;
  }

  bool addMember(User newMember){
    if(!members.contains(newMember.username)){
      members.add(newMember.username);
      RaidController.update(this);
      return true;
    }
    return false;
  }

  bool removeMember(User oldMember){
    if(members.contains(oldMember.username)){
      members.remove(oldMember.username);
      RaidController.update(this);
      return true;
    }
    return false;
  }
}