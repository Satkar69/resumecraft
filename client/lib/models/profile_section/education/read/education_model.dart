class EducationModel {
  String? status;
  int? statusCode;
  Education? education;

  EducationModel({this.status, this.statusCode, this.education});

  EducationModel.fromJson(Map<String, dynamic> json) {
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
  String? id;
  String? userdetail;
  String? course;
  String? university;
  String? gpa;
  DateTime? startDate;
  DateTime? endDate;

  Education({
    this.id,
    this.userdetail,
    this.course,
    this.university,
    this.gpa,
    this.startDate,
    this.endDate,
  });

  Education.fromJson(Map<String, dynamic> json) {
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
