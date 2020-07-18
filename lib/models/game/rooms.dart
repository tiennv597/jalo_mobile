import 'package:shinro_int2/models/game/info_user.dart';
class ListRooms {
  List<RoomsCw> roomsCw;
  List<RoomsVc> roomsVc;

  ListRooms({this.roomsCw, this.roomsVc});

  ListRooms.fromJson(Map<String, dynamic> json) {
    if (json['rooms_cw'] != null) {
      roomsCw = new List<RoomsCw>();
      json['rooms_cw'].forEach((v) {
        roomsCw.add(new RoomsCw.fromJson(v));
      });
    }
    if (json['rooms_vc'] != null) {
      roomsVc = new List<RoomsVc>();
      json['rooms_vc'].forEach((v) {
        roomsVc.add(new RoomsVc.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.roomsCw != null) {
      data['rooms_cw'] = this.roomsCw.map((v) => v.toJson()).toList();
    }
    if (this.roomsVc != null) {
      data['rooms_vc'] = this.roomsVc.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RoomsCw {
  String idRoom;
  String idOwner;
  String nameNoom;
  String password;
  String level;
  String quantity;
  String type;
  List<User> users;

  RoomsCw(
      {this.idRoom,
      this.idOwner,
      this.nameNoom,
      this.password,
      this.level,
      this.quantity,
      this.type,
      this.users});

  RoomsCw.fromJson(Map<String, dynamic> json) {
    idRoom = json['id_room'];
    idOwner = json['id_owner'];
    nameNoom = json['name_noom'];
    password = json['password'];
    level = json['level'];
    quantity = json['quantity'];
    type = json['type'];
    if (json['users'] != null) {
      users = new List<User>();
      json['users'].forEach((v) {
        users.add(new User.fromJson(v));
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
    data['type'] = this.type;
    if (this.users != null) {
      data['users'] = this.users.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RoomsVc {
  String idRoom;
  String idOwner;
  String nameNoom;
  String password;
  String level;
  String quantity;
  String type;
  List<User> users;

  RoomsVc(
      {this.idRoom,
      this.idOwner,
      this.nameNoom,
      this.password,
      this.level,
      this.quantity,
      this.type,
      this.users});

  RoomsVc.fromJson(Map<String, dynamic> json) {
    idRoom = json['id_room'];
    idOwner = json['id_owner'];
    nameNoom = json['name_noom'];
    password = json['password'];
    level = json['level'];
    quantity = json['quantity'];
    type = json['type'];
    if (json['users'] != null) {
      users = new List<User>();
      json['users'].forEach((v) {
        users.add(new User.fromJson(v));
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
    data['type'] = this.type;
    if (this.users != null) {
      data['users'] = this.users.map((v) => v.toJson()).toList();
    }
    return data;
  }
}


// class Users {
//   String id;
//   String fullName;
//   String gender;
//   String profileUrl;

//   Users({this.id, this.fullName, this.gender, this.profileUrl});

//   Users.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     fullName = json['fullName'];
//     gender = json['gender'];
//     profileUrl = json['profileUrl'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['fullName'] = this.fullName;
//     data['gender'] = this.gender;
//     data['profileUrl'] = this.profileUrl;
//     return data;
//   }
// }