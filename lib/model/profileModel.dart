class profileModel {
  String? images;
  String? desc;

  profileModel({this.images, this.desc});

  profileModel.fromJson(Map<String, dynamic> json) {
    images = json['img'];
    desc = json['desc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['img'] = this.images;
    data['desc'] = this.desc;
    return data;
  }
}