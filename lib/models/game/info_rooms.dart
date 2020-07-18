import 'package:shinro_int2/models/game/info_room.dart';

class Rooms {
  List<InfoRoom> infoRoom;

  Rooms({this.infoRoom});

  Rooms.fromJson(Map<String, dynamic> json) {
    if (json['InfoRoom'] != null) {
      infoRoom = new List<InfoRoom>();
      json['InfoRoom'].forEach((v) {
        infoRoom.add(new InfoRoom.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.infoRoom != null) {
      data['InfoRoom'] = this.infoRoom.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
