class InfoRoom {
  String idRoom='';
  String idOwner;
  String nameNoom;
  String password;
  String level;
  String quantity;
  String time="10";
  String type;
  List<Users> users;

  InfoRoom(
      {this.idRoom,
      this.idOwner,
      this.nameNoom,
      this.password,
      this.level,
      this.quantity,
      this.time,
      this.type,
      this.users});

  InfoRoom.fromJson(Map<String, dynamic> json) {
    idRoom = json['id_room'];
    idOwner = json['id_owner'];
    nameNoom = json['name_noom'];
    password = json['password'];
    level = json['level'];
    quantity = json['quantity'];
    time = json['time'];
    type = json['type'];
    if (json['users'] != null) {
      users = new List<Users>();
      json['users'].forEach((v) {
        users.add(new Users.fromJson(v));
      });
    }
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
    if (this.users != null) {
      data['users'] = this.users.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Users {
  String id;
  String fullName;
  String gender;
  String profileUrl;

  Users({this.id, this.fullName, this.gender, this.profileUrl});

  Users.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['fullName'];
    gender = json['gender'];
    profileUrl = json['profileUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['fullName'] = this.fullName;
    data['gender'] = this.gender;
    data['profileUrl'] = this.profileUrl;
    return data;
  }
}