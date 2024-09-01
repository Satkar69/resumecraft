class ObjectiveRequestModel {
  String? userdetail;
  String? details;

  ObjectiveRequestModel({
    this.userdetail,
    this.details,
  });

  // Create an instance from JSON
  ObjectiveRequestModel.fromJson(Map<String, dynamic> json) {
    userdetail = json['userdetail'];
    details = json['details'];
  }

  // Convert the instance to JSON
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userdetail'] = userdetail;
    data['details'] = details;

    return data;
  }
}
