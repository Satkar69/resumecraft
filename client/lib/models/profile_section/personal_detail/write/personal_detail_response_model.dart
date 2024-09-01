import 'dart:convert';

PersonalDetailResponseModel personalDetailResponseModel(String str) =>
    PersonalDetailResponseModel.fromJson(json.decode(str));

class PersonalDetailResponseModel {
  String? status;
  int? statusCode;
  Userdetail? userdetail;

  PersonalDetailResponseModel({this.status, this.statusCode, this.userdetail});

  PersonalDetailResponseModel.fromJson(Map<String, dynamic> json) {
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
  String? user;
  String? fullname;
  String? address;
  String? email;
  String? contact;
  String? image;
  List<String>? socials;
  String? id;
  int? v;

  Userdetail({
    this.user,
    this.fullname,
    this.address,
    this.email,
    this.contact,
    this.image,
    this.socials,
    this.id,
    this.v,
  });

  Userdetail.fromJson(Map<String, dynamic> json) {
    user = json['user'];
    fullname = json['fullname'];
    address = json['address'];
    email = json['email'];
    contact = json['contact'];
    image = json['image'];

    if (json['socials'] != null) {
      socials = List<String>.from(json['socials']);
    }

    id = json['_id'];
    v = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user'] = user;
    data['fullname'] = fullname;
    data['address'] = address;
    data['email'] = email;
    data['contact'] = contact;
    data['image'] = image;

    if (socials != null) {
      data['socials'] = socials;
    }

    data['_id'] = id;
    data['__v'] = v;
    return data;
  }
}
