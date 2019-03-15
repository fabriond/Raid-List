class Raid {
  String id;
  String groupId;
  String location;
  DateTime time;
  String boss;
  int memberCount;

  Raid({this.id, this.groupId, this.location, this.time, this.boss, this.memberCount});

  factory Raid.fromMap(Map<String, dynamic> raid){
    return Raid(
      id: raid['id'],
      groupId: raid['groupId'],
      boss: raid['boss'],
      location: raid['location'],
      time: raid['time'],
      memberCount: raid['memberCount'],
    );
  }

  Map<String, dynamic> toMap(){
    final map = Map<String, dynamic>();
    map.putIfAbsent('id', () => id);
    map.putIfAbsent('groupId', () => groupId);
    map.putIfAbsent('boss', () => boss);
    map.putIfAbsent('location', () => location);
    map.putIfAbsent('time', () => time);
    map.putIfAbsent('memberCount', () => memberCount);
    return map;
  }
}