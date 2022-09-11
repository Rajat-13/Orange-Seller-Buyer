class sellerModelList{
  List<sellerModel>? data;

  sellerModelList({this.data});

  sellerModelList.fromSnapshot(Map<String,dynamic> snap){
    if (snap['data'] != null) {
      data = <sellerModel>[];
      snap['data'].forEach((v) {
        data!.add(new sellerModel.fromJson(v));
      });
    }
  }


}

class sellerModel {
  String? id;
  String? name;
  String? email;
  String? mobile;
  String? password;
  String? type;
  String? image;
  String? desc;

  sellerModel(
      {this.id, this.name, this.email, this.mobile, this.password, this.type, this.image, this.desc});

  sellerModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    mobile = json['mobile'];
    password = json['password'];
    type = json['type'];
    image = json['image'];
    desc = json['desc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['mobile'] = this.mobile;
    data['password'] = this.password;
    data['type'] = this.type;
    data['image'] = this.image;
    data['desc'] = this.desc;
    return data;
  }
}