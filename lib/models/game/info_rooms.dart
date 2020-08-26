import 'package:shinro_int2/models/game/info.dart';
import 'package:shinro_int2/models/game/info_user.dart';

class InfoRooms {
  Info info;
  List<UserInfo> allUser;

  InfoRooms({this.info, this.allUser});

  InfoRooms.fromJson(Map<String, dynamic> json) {
    info = json['info'] != null ? new Info.fromJson(json['info']) : null;
    if (json['all_user'] != null) {
      allUser = new List<UserInfo>();
      json['all_user'].forEach((v) {
        allUser.add(new UserInfo.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.info != null) {
      data['info'] = this.info.toJson();
    }
    if (this.allUser != null) {
      data['all_user'] = this.allUser.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
