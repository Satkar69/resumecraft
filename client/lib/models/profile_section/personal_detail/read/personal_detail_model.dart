class PersonalDetailModel {
  String? status;
  int? statusCode;
  Userdetail? userdetail;

  PersonalDetailModel({this.status, this.statusCode, this.userdetail});

  PersonalDetailModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusCode = json['statusCode'];
    userdetail = json['userdetail'] != null
        ? Userdetail.fromJson(json['userdetail'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['statusCode'] = statusCode;
    if (userdetail != null) {
      data['userdetail'] = userdetail!.toJson();
    }
    return data;
  }
}

class Userdetail {
  String? id;
  String? user;
  String? fullname;
  String? address;
  String? email;
  String? contact;
  String? image;
  List<String>? socials;

  Userdetail(
      {this.id,
      this.user,
      this.fullname,
      this.address,
      this.email,
      this.contact,
      this.image,
      this.socials});

  Userdetail.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    user = json['user'];
    fullname = json['fullname'];
    address = json['address'];
    email = json['email'];
    contact = json['contact'];
    image = json['image'];
    if (json['socials'] != null) {
      socials = List<String>.from(json['socials']);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['user'] = user;
    data['fullname'] = fullname;
    data['address'] = address;
    data['email'] = email;
    data['contact'] = contact;
    data['image'] = image;
    if (socials != null) {
      data['socials'] = socials;
    }
    return data;
  }
}
