class ExperienceModel {
  String? status;
  int? statusCode;
  Experience? experience;

  ExperienceModel({this.status, this.statusCode, this.experience});

  ExperienceModel.fromJson(Map<String, dynamic> json) {
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
      data['experience'] = experience!.toJson();
    }
    return data;
  }
}

class Experience {
  String? id;
  String? userdetail;
  String? companyName;
  String? jobTitle;
  DateTime? startDate;
  DateTime? endDate;
  String? details;

  Experience({
    this.id,
    this.userdetail,
    this.companyName,
    this.jobTitle,
    this.startDate,
    this.endDate,
    this.details,
  });

  Experience.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    userdetail = json['userdetail'];
    companyName = json['company_name'];
    jobTitle = json['job_title'];
    details = json['details'];
    startDate =
        json['start_date'] != null ? DateTime.parse(json['start_date']) : null;
    endDate =
        json['end_date'] != null ? DateTime.parse(json['end_date']) : null;
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
