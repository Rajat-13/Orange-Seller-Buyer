class userModel {
  String? id;
  String? name;
  String? email;
  String? mobile;
  String? password;
  String? type;

  userModel(
      {this.id, this.name, this.email, this.mobile, this.password, this.type});

  userModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    mobile = json['mobile'];
    password = json['password'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['mobile'] = this.mobile;
    data['password'] = this.password;
    data['type'] = this.type;
    return data;
  }
}