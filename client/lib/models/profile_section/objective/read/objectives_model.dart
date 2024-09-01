class ObjectivesModel {
  String? status;
  int? statusCode;
  List<Objectives>? objectives;

  ObjectivesModel({this.status, this.statusCode, this.objectives});

  ObjectivesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusCode = json['statusCode'];
    if (json['objectives'] != null) {
      objectives = <Objectives>[];
      json['objectives'].forEach((v) {
        objectives!.add(Objectives.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['statusCode'] = statusCode;
    if (objectives != null) {
      data['objectives'] = objectives!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Objectives {
  String? id;
  String? userdetail;
  String? details;

  Objectives({this.id, this.userdetail, this.details});

  Objectives.fromJson(Map<String, dynamic> json) {
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
