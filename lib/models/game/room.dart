class Room {
  String idRoom;
  bool owner;

  Room({this.idRoom, this.owner});

  Room.fromJson(Map<String, dynamic> json) {
    idRoom = json['id_room'];
    owner = json['owner'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_room'] = this.idRoom;
    data['owner'] = this.owner;
    return data;
  }
}
