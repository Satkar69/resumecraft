import 'dart:convert';

ExperienceResponseModel experienceResponseModel(String str) =>
    ExperienceResponseModel.fromJson(json.decode(str));

class ExperienceResponseModel {
  String? status;
  int? statusCode;
  Experience? experience;

  ExperienceResponseModel({this.status, this.statusCode, this.experience});

  ExperienceResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusCode = json['statusCode'];
    experience = json['experience'] != null
        ? Experience.fromJson(json['experience'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['statusCode'] = statusCode;
    if (experience != null) {
      data['education'] = experience!.toJson();
    }
    return data;
  }
}

class Experience {
  String? userdetail;
  String? companyName;
  String? jobTitle;
  DateTime? startDate;
  DateTime? endDate;
  String? details;
  String? id;
  int? v;

  Experience({
    this.userdetail,
    this.companyName,
    this.jobTitle,
    this.startDate,
    this.endDate,
    this.details,
    this.id,
    this.v,
  });

  Experience.fromJson(Map<String, dynamic> json) {
    userdetail = json['userdetail'];
    companyName = json['company_name'];
    jobTitle = json['job_title'];
    startDate =
        json['start_date'] != null ? DateTime.parse(json['start_date']) : null;
    endDate =
        json['end_date'] != null ? DateTime.parse(json['end_date']) : null;
    details = json['details'];
    id = json['_id'];
    v = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userdetail'] = userdetail;
    data['company-name'] = companyName;
    data['job_title'] = jobTitle;
    data['start_date'] = startDate?.toIso8601String();
    data['end_date'] = endDate?.toIso8601String();
    data['details'] = details;
    data['_id'] = id;
    data['__v'] = v;

    return data;
  }
}
