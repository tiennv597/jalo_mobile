class Rooms {
  List<String> idRoomCw;
  List<String> idRoomVc;
  List<String> idRoomGr;

  Rooms({this.idRoomCw, this.idRoomVc, this.idRoomGr});

  Rooms.fromJson(Map<String, dynamic> json) {
    idRoomCw = json['id_room_cw'].cast<String>();
    idRoomVc = json['id_room_vc'].cast<String>();
    idRoomGr = json['id_room_gr'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_room_cw'] = this.idRoomCw;
    data['id_room_vc'] = this.idRoomVc;
    data['id_room_gr'] = this.idRoomGr;
    return data;
  }
}
