class SkillsModel {
  String? status;
  int? statusCode;
  List<Skills>? skills;

  SkillsModel({this.status, this.statusCode, this.skills});

  SkillsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusCode = json['statusCode'];
    if (json['skills'] != null) {
      skills = <Skills>[];
      json['skills'].forEach((v) {
        skills!.add(Skills.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['statusCode'] = statusCode;
    if (skills != null) {
      data['skills'] = skills!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Skills {
  String? id;
  String? userdetail;
  String? skillName;
  String? skillPercentage;

  Skills({this.id, this.userdetail, this.skillName, this.skillPercentage});

  Skills.fromJson(Map<String, dynamic> json) {
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
