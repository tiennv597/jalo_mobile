class Resources {
  bool resources;

  Resources({this.resources});

  Resources.fromJson(Map<String, dynamic> json) {
    resources = json['resources'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['resources'] = this.resources;
    return data;
  }
}