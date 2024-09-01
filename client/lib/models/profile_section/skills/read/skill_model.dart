class SkillModel {
  String? status;
  int? statusCode;
  Skill? skill;

  SkillModel({this.status, this.statusCode, this.skill});

  SkillModel.fromJson(Map<String, dynamic> json) {
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
  String? id;
  String? userdetail;
  String? skillName;
  String? skillPercentage;

  Skill({
    this.id,
    this.userdetail,
    this.skillName,
    this.skillPercentage,
  });

  Skill.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    userdetail = json['userdetail'];
    skillName = json['skill_name'];
    skillPercentage = json['skill_percentage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['userdetail'] = userdetail;
    data['skill_name'] = skillName;
    data['skill_percentage'] = skillPercentage;
    return data;
  }
}
