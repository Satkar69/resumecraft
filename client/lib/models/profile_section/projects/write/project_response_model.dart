import 'dart:convert';

ProjectResponseModel projectResponseModel(String str) =>
    ProjectResponseModel.fromJson(json.decode(str));

class ProjectResponseModel {
  String? status;
  int? statusCode;
  Project? project;

  ProjectResponseModel({this.status, this.statusCode, this.project});

  ProjectResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusCode = json['statusCode'];
    project =
        json['project'] != null ? Project.fromJson(json['project']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['statusCode'] = statusCode;
    if (project != null) {
      data['project'] = project!.toJson();
    }
    return data;
  }
}

class Project {
  String? userdetail;
  String? projectTitle;
  String? projectDesc;
  List<String>? links;
  String? id;
  int? v;

  Project({
    this.userdetail,
    this.projectTitle,
    this.projectDesc,
    this.links,
    this.id,
    this.v,
  });

  Project.fromJson(Map<String, dynamic> json) {
    userdetail = json['userdetail'];
    projectTitle = json['project_title'];
    projectDesc = json['project_desc'];

    if (json['links'] != null) {
      links = List<String>.from(json['links']);
    }

    id = json['_id'];
    v = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userdetail'] = userdetail;
    data['project_title'] = projectTitle;
    data['project_desc'] = projectDesc;

    if (links != null) {
      data['links'] = links;
    }

    data['_id'] = id;
    data['__v'] = v;
    return data;
  }
}
