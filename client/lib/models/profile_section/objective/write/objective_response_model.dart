import 'dart:convert';

ObjectiveResponseModel objectiveResponseModel(String str) =>
    ObjectiveResponseModel.fromJson(json.decode(str));

class ObjectiveResponseModel {
  String? status;
  int? statusCode;
  Objective? objective;

  ObjectiveResponseModel({this.status, this.statusCode, this.objective});

  ObjectiveResponseModel.fromJson(Map<String, dynamic> json) {
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
  String? userdetail;
  String? details;
  String? id;
  int? v;

  Objective({
    this.userdetail,
    this.details,
    this.id,
    this.v,
  });

  Objective.fromJson(Map<String, dynamic> json) {
    userdetail = json['userdetail'];
    details = json['details'];
    id = json['_id'];
    v = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userdetail'] = userdetail;
    data['details'] = details;
    data['_id'] = id;
    data['__v'] = v;

    return data;
  }
}
