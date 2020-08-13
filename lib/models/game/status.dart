class Status {
  String userId;
  String userName;
  int marks;

  Status({this.userId, this.userName, this.marks});

  Status.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    userName = json['userName'];
    marks = json['marks'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['userName'] = this.userName;
    data['marks'] = this.marks;
    return data;
  }
}