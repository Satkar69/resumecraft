class ExperienceRequestModel {
  String? userdetail;
  String? companyName;
  String? jobTitle;
  DateTime? startDate;
  DateTime? endDate;
  String? details;

  ExperienceRequestModel({
    this.userdetail,
    this.companyName,
    this.jobTitle,
    this.startDate,
    this.endDate,
    this.details,
  });

  // Create an instance from JSON
  ExperienceRequestModel.fromJson(Map<String, dynamic> json) {
    userdetail = json['userdetail'];
    companyName = json['company_name'];
    jobTitle = json['job_title'];
    startDate =
        json['start_date'] != null ? DateTime.parse(json['start_date']) : null;
    endDate =
        json['end_date'] != null ? DateTime.parse(json['end_date']) : null;
    details = json['details'];
  }

  // Convert the instance to JSON
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userdetail'] = userdetail;
    data['company_name'] = companyName;
    data['job_title'] = jobTitle;
    data['start_date'] = startDate?.toIso8601String();
    data['end_date'] = endDate?.toIso8601String();
    data['details'] = details;

    return data;
  }
}
