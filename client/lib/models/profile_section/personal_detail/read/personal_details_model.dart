import 'dart:convert';

PersonalDetailsModel profileDetailsModel(String str) =>
    PersonalDetailsModel.fromJson(json.decode(str));

class PersonalDetailsModel {
  String? status;
  int? statusCode;
  List<Userdetails>? userdetails;

  PersonalDetailsModel({this.status, this.statusCode, this.userdetails});

  PersonalDetailsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusCode = json['statusCode'];
    if (json['userdetails'] != null) {
      userdetails = <Userdetails>[];
      json['userdetails'].forEach((v) {
        userdetails!.add(Userdetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['statusCode'] = statusCode;
    if (userdetails != null) {
      data['userdetails'] = userdetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Userdetails {
  String? id;
  String? user;
  String? fullname;
  String? address;
  String? email;
  String? contact;
  String? image;
  List<String>? socials;

  Userdetails(
      {this.id,
      this.user,
      this.fullname,
      this.address,
      this.email,
      this.contact,
      this.image,
      this.socials});

  Userdetails.fromJson(Map<String, dynamic> json) {
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
