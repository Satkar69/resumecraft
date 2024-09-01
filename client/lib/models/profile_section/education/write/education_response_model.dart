import 'dart:convert';

EducationResponseModel educationResponseModel(String str) =>
    EducationResponseModel.fromJson(json.decode(str));

class EducationResponseModel {
  String? status;
  int? statusCode;
  Education? education;

  EducationResponseModel({this.status, this.statusCode, this.education});

  EducationResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusCode = json['statusCode'];
    education = json['education'] != null
        ? Education.fromJson(json['education'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['statusCode'] = statusCode;
    if (education != null) {
      data['education'] = education!.toJson();
    }
    return data;
  }
}

class Education {
  String? userdetail;
  String? course;
  String? university;
  String? gpa;
  DateTime? startDate;
  DateTime? endDate;
  String? id;
  int? v;

  Education({
    this.userdetail,
    this.course,
    this.university,
    this.gpa,
    this.startDate,
    this.endDate,
    this.id,
    this.v,
  });

  Education.fromJson(Map<String, dynamic> json) {
    userdetail = json['userdetail'];
    course = json['course'];
    university = json['university'];
    gpa = json['gpa'];
    startDate =
        json['start_date'] != null ? DateTime.parse(json['start_date']) : null;
    endDate =
        json['end_date'] != null ? DateTime.parse(json['end_date']) : null;
    id = json['_id'];
    v = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userdetail'] = userdetail;
    data['course'] = course;
    data['university'] = university;
    data['gpa'] = gpa;
    data['start_date'] = startDate?.toIso8601String();
    data['end_date'] = endDate?.toIso8601String();
    data['_id'] = id;
    data['__v'] = v;
    return data;
  }
}
