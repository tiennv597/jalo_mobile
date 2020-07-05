class Join {
  String event;
  String groupName;
  String name;

  Join(this.event, this.groupName, this.name);

  Join.fromJson(Map<String, dynamic> json) {
    event = json['event'];
    groupName = json['groupName'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['event'] = this.event;
    data['groupName'] = this.groupName;
    data['name'] = this.name;
    return data;
  }
}
