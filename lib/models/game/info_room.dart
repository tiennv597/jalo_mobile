import 'package:shinro_int2/models/game/info_user.dart';
import 'package:shinro_int2/models/game/info.dart';

class InfoRoom {
  Info info;
  User users;

  InfoRoom({this.info, this.users});

  InfoRoom.fromJson(Map<String, dynamic> json) {
    info = json['info'] != null ? new Info.fromJson(json['info']) : null;
    users = json['users'] != null ? new User.fromJson(json['users']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.info != null) {
      data['info'] = this.info.toJson();
    }
    if (this.users != null) {
      data['users'] = this.users.toJson();
    }
    return data;
  }
}



