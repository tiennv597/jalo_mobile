class Info {
  String idRoom;
  String idOwner;
  String nameNoom;
  String password;
  String level;
  String quantity;
  String time;
  String type;

  Info(
      {this.idRoom,
      this.idOwner,
      this.nameNoom,
      this.password,
      this.level,
      this.quantity,
      this.time,
      this.type});

  Info.fromJson(Map<String, dynamic> json) {
    idRoom = json['id_room'];
    idOwner = json['id_owner'];
    nameNoom = json['name_noom'];
    password = json['password'];
    level = json['level'];
    quantity = json['quantity'];
    time = json['time'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_room'] = this.idRoom;
    data['id_owner'] = this.idOwner;
    data['name_noom'] = this.nameNoom;
    data['password'] = this.password;
    data['level'] = this.level;
    data['quantity'] = this.quantity;
    data['time'] = this.time;
    data['type'] = this.type;
    return data;
  }
}