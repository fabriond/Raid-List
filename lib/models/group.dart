class Group{
  String id;
  String name;
  String description;
  bool auxFlag; //Workaround to update user's GroupList when the user joins a new group

  Group({this.id, this.name, this.description, this.auxFlag});

  factory Group.fromMap(Map<String, dynamic> group){
    return Group(
      id: group['id'],
      name: group['name'],
      description: group['description'],
      auxFlag: group['auxFlag']
    );
  }

  Map<String, dynamic> toMap(){
    final map = Map<String, dynamic>();
    map.putIfAbsent('id', () => id);
    map.putIfAbsent('name', () => name);
    map.putIfAbsent('description', () => description);
    map.putIfAbsent('auxFlag', () => auxFlag);
    return map;
  }
}