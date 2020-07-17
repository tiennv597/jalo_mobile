import 'package:shinro_int2/models/game/info_user.dart';

class InfoRoom {
  String nameRoom;
  String id;
  String password;
  String level;
  String type;
  String quantity;
  String time;
  String idOwner;
  List<User> users;

  InfoRoom(
      {this.id,
      this.password,
      this.level,
      this.type,
      this.quantity,
      this.time,
      this.idOwner,
      this.users});
}
