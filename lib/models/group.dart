class Group{
  String id;
  String name;
  String description;
  int memberCount;

  Group({this.id, this.name, this.description, this.memberCount});

  factory Group.fromMap(Map<String, dynamic> group){
    return Group(
      id: group['id'],
      name: group['name'],
      description: group['description'],
      memberCount: group['memberCount']
    );
  }

  Map<String, dynamic> toMap(){
    final map = Map<String, dynamic>();
    map.putIfAbsent('id', () => id);
    map.putIfAbsent('name', () => name);
    map.putIfAbsent('description', () => description);
    map.putIfAbsent('memberCount', () => memberCount);
    return map;
  }
}