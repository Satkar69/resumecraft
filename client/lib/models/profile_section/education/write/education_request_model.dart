class EducationRequestModel {
  String? userdetail;
  String? course;
  String? university;
  String? gpa;
  DateTime? startDate;
  DateTime? endDate;

  EducationRequestModel({
    this.userdetail,
    this.course,
    this.university,
    this.gpa,
    this.startDate,
    this.endDate,
  });

  // Create an instance from JSON
  EducationRequestModel.fromJson(Map<String, dynamic> json) {
    userdetail = json['userdetail'];
    course = json['course'];
    university = json['university'];
    gpa = json['gpa'];
    startDate =
        json['start_date'] != null ? DateTime.parse(json['start_date']) : null;
    endDate =
        json['end_date'] != null ? DateTime.parse(json['end_date']) : null;
  }

  // Convert the instance to JSON
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userdetail'] = userdetail;
    data['course'] = course;
    data['university'] = university;
    data['gpa'] = gpa;
    data['start_date'] = startDate?.toIso8601String();
    data['end_date'] = endDate?.toIso8601String();

    return data;
  }
}
