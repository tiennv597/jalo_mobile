class Message {
  String event;
  String data;

  Message(this.event, this.data);

  Message.fromJson(Map<String, dynamic> json) {
    event = json['event'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['event'] = this.event;
    data['data'] = this.data;
    return data;
  }
}