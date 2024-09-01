class SkillRequestModel {
  String? userdetail;
  String? skillName;
  String? skillPercentage;

  SkillRequestModel({
    this.userdetail,
    this.skillName,
    this.skillPercentage,
  });

  // Create an instance from JSON
  SkillRequestModel.fromJson(Map<String, dynamic> json) {
    userdetail = json['userdetail'];
    skillName = json['skill_name'];
    skillPercentage = json['skill_percentage'];
  }

  // Convert the instance to JSON
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userdetail'] = userdetail;
    data['skill_name'] = skillName;
    data['skill_percentage'] = skillPercentage;

    return data;
  }
}
