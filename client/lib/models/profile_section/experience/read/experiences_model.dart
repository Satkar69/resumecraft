class ExperiencesModel {
  String? status;
  int? statusCode;
  List<Experiences>? experiences;

  ExperiencesModel({this.status, this.statusCode, this.experiences});

  ExperiencesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusCode = json['statusCode'];
    if (json['experiences'] != null) {
      experiences = <Experiences>[];
      json['experiences'].forEach((v) {
        experiences!.add(Experiences.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['statusCode'] = statusCode;
    if (experiences != null) {
      data['experiences'] = experiences!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Experiences {
  String? id;
  String? userdetail;
  String? companyName;
  String? jobTitle;
  DateTime? startDate;
  DateTime? endDate;
  String? details;

  Experiences(
      {this.id,
      this.userdetail,
      this.companyName,
      this.jobTitle,
      this.startDate,
      this.endDate,
      this.details});

  Experiences.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    userdetail = json['userdetail'];
    companyName = json['company_name'];
    jobTitle = json['job_title'];
    startDate =
        json['start_date'] != null ? DateTime.parse(json['start_date']) : null;
    endDate =
        json['end_date'] != null ? DateTime.parse(json['end_date']) : null;
    details = json['details'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['userdetail'] = userdetail;
    data['company_name'] = companyName;
    data['job_title'] = jobTitle;
    data['start_date'] = startDate?.toIso8601String();
    data['end_date'] = endDate?.toIso8601String();
    data['details'] = details;
    return data;
  }
}
