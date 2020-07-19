import 'package:shinro_int2/models/game/info.dart';

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
  Info info;

  RoomsCw({this.info});

  RoomsCw.fromJson(Map<String, dynamic> json) {
    info = json['info'] != null ? new Info.fromJson(json['info']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.info != null) {
      data['info'] = this.info.toJson();
    }
    return data;
  }
}

class RoomsVc {
  Info info;

  RoomsVc({this.info});

  RoomsVc.fromJson(Map<String, dynamic> json) {
    info = json['info'] != null ? new Info.fromJson(json['info']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.info != null) {
      data['info'] = this.info.toJson();
    }
    return data;
  }
}
