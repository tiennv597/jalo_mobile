class RpMessage {
  String event;
  Data data;

  RpMessage({this.event, this.data});

  RpMessage.fromJson(Map<String, dynamic> json) {
    event = json['event'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['event'] = this.event;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  String userId;
  String name;
  String message;
  String sender;

  Data({this.userId, this.name, this.message, this.sender});

  Data.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    name = json['name'];
    message = json['message'];
    sender = json['sender'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['name'] = this.name;
    data['message'] = this.message;
    data['sender'] = this.sender;
    return data;
  }
}