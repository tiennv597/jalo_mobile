class UserInfo {
  String id;
  String fullName;
  String gender;
  String profileUrl;

  UserInfo({this.id, this.fullName, this.gender, this.profileUrl});

  UserInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['fullName'];
    gender = json['gender'];
    profileUrl = json['profileUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['fullName'] = this.fullName;
    data['gender'] = this.gender;
    data['profileUrl'] = this.profileUrl;
    return data;
  }
}
