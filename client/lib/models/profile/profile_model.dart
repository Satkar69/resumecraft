import 'dart:convert';

ProfileModel profileModel(String str) =>
    ProfileModel.fromJson(json.decode(str));

class ProfileModel {
  User? user;

  ProfileModel({this.user});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class User {
  String? id;
  String? username;
  String? email;
  String? createdAt;
  String? updatedAt;
  List<String>? resume;

  User(
      {this.id,
      this.username,
      this.email,
      this.createdAt,
      this.updatedAt,
      this.resume});

  User.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    username = json['username'];
    email = json['email'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['resume'] != null) {
      resume = List<String>.from(json['resume']);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['username'] = username;
    data['email'] = email;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (resume != null) {
      data['resume'] = resume;
    }
    return data;
  }
}
