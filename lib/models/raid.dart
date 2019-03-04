class Raid {
  String id;
  String groupId;
  String location;
  String boss;

  Raid({this.id, this.groupId, this.location, this.boss});

  factory Raid.fromMap(Map<String, dynamic> raid){
    return Raid(
      id: raid['id'],
      groupId: raid['groupId'],
      boss: raid['boss'],
      location: raid['location'],
    );
  }

  Map<String, dynamic> toMap(){
    final map = Map<String, dynamic>();
    map.putIfAbsent('id', () => id);
    map.putIfAbsent('groupId', () => groupId);
    map.putIfAbsent('boss', () => boss);
    map.putIfAbsent('location', () => location);
    return map;
  }
}