import 'dart:convert';

SkillResponseModel skillResponseModel(String str) =>
    SkillResponseModel.fromJson(json.decode(str));

class SkillResponseModel {
  String? status;
  int? statusCode;
  Skill? skill;

  SkillResponseModel({this.status, this.statusCode, this.skill});

  SkillResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusCode = json['statusCode'];
    skill = json['skill'] != null ? Skill.fromJson(json['skill']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['statusCode'] = statusCode;
    if (skill != null) {
      data['skill'] = skill!.toJson();
    }
    return data;
  }
}

class Skill {
  String? userdetail;
  String? skillName;
  String? skillPercentage;
  String? id;
  int? v;

  Skill({
    this.userdetail,
    this.skillName,
    this.skillPercentage,
    this.id,
    this.v,
  });

  Skill.fromJson(Map<String, dynamic> json) {
    userdetail = json['userdetail'];
    skillName = json['skill_name'];
    skillPercentage = json['skill_percentage'];
    id = json['_id'];
    v = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userdetail'] = userdetail;
    data['skill_name'] = skillName;
    data['skill_percentage'] = skillPercentage;
    data['_id'] = id;
    data['__v'] = v;

    return data;
  }
}
