class EducationsModel {
  String? status;
  int? statusCode;
  List<Educations>? educations;

  EducationsModel({this.status, this.statusCode, this.educations});

  EducationsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusCode = json['statusCode'];
    if (json['educations'] != null) {
      educations = <Educations>[];
      json['educations'].forEach((v) {
        educations!.add(Educations.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['statusCode'] = statusCode;
    if (educations != null) {
      data['educations'] = educations!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Educations {
  String? id;
  String? userdetail;
  String? course;
  String? university;
  String? gpa;
  DateTime? startDate;
  DateTime? endDate;

  Educations(
      {this.id,
      this.userdetail,
      this.course,
      this.university,
      this.gpa,
      this.startDate,
      this.endDate});

  Educations.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    userdetail = json['userdetail'];
    course = json['course'];
    university = json['university'];
    gpa = json['gpa'];
    startDate =
        json['start_date'] != null ? DateTime.parse(json['start_date']) : null;
    endDate =
        json['end_date'] != null ? DateTime.parse(json['end_date']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['userdetail'] = userdetail;
    data['course'] = course;
    data['university'] = university;
    data['gpa'] = gpa;
    data['start_date'] = startDate?.toIso8601String();
    data['end_date'] = endDate?.toIso8601String();
    return data;
  }
}
