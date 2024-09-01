class ObjectiveModel {
  String? status;
  int? statusCode;
  Objective? objective;

  ObjectiveModel({this.status, this.statusCode, this.objective});

  ObjectiveModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusCode = json['statusCode'];
    objective = json['objective'] != null
        ? Objective.fromJson(json['objective'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['statusCode'] = statusCode;
    if (objective != null) {
      data['objective'] = objective!.toJson();
    }
    return data;
  }
}

class Objective {
  String? id;
  String? userdetail;
  String? details;

  Objective({this.id, this.userdetail, this.details});

  Objective.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    userdetail = json['userdetail'];
    details = json['details'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['userdetail'] = userdetail;
    data['details'] = details;
    return data;
  }
}
